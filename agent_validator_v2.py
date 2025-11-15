#!/usr/bin/env python3
"""
Agent Content Structure and Quality Validator V2
Handles TWO agent formats:
1. Core agents (8): Comprehensive (300-1000 lines, extensive examples, deep content)
2. Specialized agents (125): Concise (40-60 lines, focused capability statements)
"""

import os
import re
from pathlib import Path
from typing import Dict, List, Tuple
import json

class AgentValidatorV2:
    def __init__(self, base_path: str):
        self.base_path = Path(base_path)
        self.results = []

    def find_agents(self, sample_paths: List[str]) -> List[Path]:
        """Find agent.md files from provided paths."""
        agents = []
        for path in sample_paths:
            agent_path = self.base_path / path / "agent.md"
            if agent_path.exists():
                agents.append(agent_path)
        return agents

    def determine_format(self, content: str, line_count: int) -> str:
        """Determine if agent is Core (comprehensive) or Specialized (concise)."""
        if line_count > 200 or content.count('```') > 10:
            return "core"
        return "specialized"

    def extract_sections(self, content: str) -> List[str]:
        """Extract all markdown headers from content."""
        headers = re.findall(r'^#{1,3}\s+(.+)$', content, re.MULTILINE)
        return headers

    def count_code_blocks(self, content: str) -> int:
        """Count number of code blocks."""
        return len(re.findall(r'```', content)) // 2

    def count_words(self, content: str) -> int:
        """Count total words (excluding YAML frontmatter)."""
        content = re.sub(r'^---\n.*?\n---\n', '', content, flags=re.DOTALL)
        content = re.sub(r'```.*?```', '', content, flags=re.DOTALL)
        words = re.findall(r'\b\w+\b', content)
        return len(words)

    def check_yaml_frontmatter(self, content: str) -> Dict:
        """Extract and validate YAML frontmatter."""
        match = re.match(r'^---\n(.*?)\n---', content, re.DOTALL)
        if not match:
            return {'valid': False, 'fields': []}

        yaml_content = match.group(1)
        required_fields = ['name', 'description', 'category', 'tools', 'model', 'enabled', 'capabilities']
        found_fields = []

        for field in required_fields:
            if re.search(rf'^{field}:', yaml_content, re.MULTILINE):
                found_fields.append(field)

        return {
            'valid': True,
            'required_count': len(required_fields),
            'found_count': len(found_fields),
            'missing': [f for f in required_fields if f not in found_fields],
            'complete': len(found_fields) == len(required_fields)
        }

    def calculate_core_quality_score(self, metrics: Dict) -> Tuple[float, List[str]]:
        """Calculate quality score for CORE agents (comprehensive format)."""
        score = 0.0
        issues = []

        # Required sections for core agents (max 3 points)
        required_sections = ['Expertise', 'Methodology', 'Approach', 'Examples', 'Working with Skills']
        sections_text = ' '.join(metrics['sections_found']).lower()
        matching = sum(1 for s in required_sections if s.lower() in sections_text)
        score += (matching / len(required_sections)) * 3
        if matching < len(required_sections):
            missing = [s for s in required_sections if s.lower() not in sections_text]
            issues.append(f"Missing sections: {', '.join(missing)}")

        # Content depth (max 2 points)
        if metrics['word_count'] >= 800:
            score += 2
        elif metrics['word_count'] >= 500:
            score += 1
        else:
            issues.append(f"Insufficient content ({metrics['word_count']} words, need 800+ for excellent)")

        # Code examples (max 3 points)
        if metrics['code_blocks'] >= 10:
            score += 3
        elif metrics['code_blocks'] >= 5:
            score += 2
        elif metrics['code_blocks'] >= 2:
            score += 1
        else:
            issues.append(f"Too few code examples ({metrics['code_blocks']}, need 10+ for excellent)")

        # YAML frontmatter (max 1 point)
        if metrics['yaml']['complete']:
            score += 1
        else:
            issues.append(f"Incomplete YAML: missing {', '.join(metrics['yaml']['missing'])}")

        # Best practices sections (max 1 point)
        optional = ['best practices', 'pitfalls', 'common issues', 'patterns']
        if any(opt in sections_text for opt in optional):
            score += 1
        else:
            issues.append("Add best practices/pitfalls/patterns section")

        return round(score, 1), issues

    def calculate_specialized_quality_score(self, metrics: Dict) -> Tuple[float, List[str]]:
        """Calculate quality score for SPECIALIZED agents (concise format)."""
        score = 0.0
        issues = []

        # YAML frontmatter completeness (max 4 points)
        if metrics['yaml']['complete']:
            score += 4
        else:
            missing_count = metrics['yaml']['required_count'] - metrics['yaml']['found_count']
            score += max(0, 4 - missing_count)
            issues.append(f"Missing YAML fields: {', '.join(metrics['yaml']['missing'])}")

        # Has core sections (max 3 points)
        sections_text = ' '.join(metrics['sections_found']).lower()
        required = ['focus', 'approach', 'output']  # Typical for specialized agents
        matching = sum(1 for s in required if s in sections_text)
        score += (matching / len(required)) * 3
        if matching < len(required):
            issues.append(f"Missing typical sections (Focus Areas, Approach, Output)")

        # Adequate content length (max 2 points)
        if 100 <= metrics['word_count'] <= 300:  # Sweet spot for specialized
            score += 2
        elif 80 <= metrics['word_count'] < 100 or 300 < metrics['word_count'] <= 400:
            score += 1
        else:
            if metrics['word_count'] < 80:
                issues.append(f"Too brief ({metrics['word_count']} words, need 100-300)")
            else:
                issues.append(f"Too verbose ({metrics['word_count']} words, should be 100-300)")

        # Clear capabilities list (max 1 point)
        if metrics['yaml']['complete'] and 'capabilities' in sections_text.lower():
            score += 1

        return round(score, 1), issues

    def validate_agent(self, agent_path: Path) -> Dict:
        """Validate a single agent file."""
        with open(agent_path, 'r', encoding='utf-8') as f:
            content = f.read()

        line_count = len(content.split('\n'))
        rel_path = agent_path.relative_to(self.base_path)

        # Determine format
        agent_format = self.determine_format(content, line_count)

        # Extract metrics
        sections = self.extract_sections(content)
        code_blocks = self.count_code_blocks(content)
        word_count = self.count_words(content)
        yaml_info = self.check_yaml_frontmatter(content)

        # Build metrics dict
        metrics = {
            'sections_found': sections,
            'code_blocks': code_blocks,
            'word_count': word_count,
            'yaml': yaml_info
        }

        # Calculate quality score based on format
        if agent_format == "core":
            quality_score, quality_issues = self.calculate_core_quality_score(metrics)
        else:
            quality_score, quality_issues = self.calculate_specialized_quality_score(metrics)

        # Determine category
        parts = rel_path.parts
        if len(parts) >= 2:
            category = parts[0]  # e.g., "core", "engineering", "design"
            subcategory = parts[1] if len(parts) > 2 else None
        else:
            category = "unknown"
            subcategory = None

        result = {
            'agent_name': agent_path.parent.name,
            'category': category,
            'subcategory': subcategory,
            'file_path': str(rel_path),
            'format': agent_format,
            'line_count': line_count,
            'quality_score': quality_score,
            'quality_issues': quality_issues,
            'sections_count': len(sections),
            'code_blocks': code_blocks,
            'word_count': word_count,
            'yaml_complete': yaml_info['complete'],
            'yaml_missing': yaml_info.get('missing', [])
        }

        return result

    def analyze_sample(self, sample_paths: List[str]) -> Dict:
        """Analyze a sample of agents and return summary statistics."""
        agents = self.find_agents(sample_paths)

        print(f"\nAnalyzing {len(agents)} agents...")

        for agent_path in agents:
            result = self.validate_agent(agent_path)
            self.results.append(result)
            format_label = "CORE" if result['format'] == "core" else "SPEC"
            print(f"  [{format_label}] {result['agent_name']:<35} {result['quality_score']:>4.1f}/10  ({result['line_count']} lines)")

        return self.generate_summary()

    def generate_summary(self) -> Dict:
        """Generate summary statistics."""
        if not self.results:
            return {}

        # Separate by format
        core_results = [r for r in self.results if r['format'] == 'core']
        spec_results = [r for r in self.results if r['format'] == 'specialized']

        def get_stats(results):
            if not results:
                return None
            scores = [r['quality_score'] for r in results]
            return {
                'count': len(results),
                'avg_score': round(sum(scores) / len(scores), 1),
                'min_score': min(scores),
                'max_score': max(scores),
                'avg_word_count': round(sum(r['word_count'] for r in results) / len(results)),
                'avg_code_blocks': round(sum(r['code_blocks'] for r in results) / len(results), 1),
                'yaml_complete': sum(1 for r in results if r['yaml_complete']),
            }

        # Category analysis
        category_stats = {}
        for result in self.results:
            cat = result['category']
            if cat not in category_stats:
                category_stats[cat] = {'scores': [], 'formats': {'core': 0, 'specialized': 0}}
            category_stats[cat]['scores'].append(result['quality_score'])
            category_stats[cat]['formats'][result['format']] += 1

        for cat, stats in category_stats.items():
            scores = stats['scores']
            stats['count'] = len(scores)
            stats['avg_score'] = round(sum(scores) / len(scores), 1)
            del stats['scores']

        summary = {
            'total_agents': len(self.results),
            'overall_stats': get_stats(self.results),
            'core_agents': get_stats(core_results),
            'specialized_agents': get_stats(spec_results),
            'category_stats': category_stats,
            'top_performers': sorted(self.results, key=lambda x: x['quality_score'], reverse=True)[:5],
            'needs_improvement': sorted(self.results, key=lambda x: x['quality_score'])[:5],
            'all_issues': self._collect_common_issues()
        }

        return summary

    def _collect_common_issues(self) -> Dict:
        """Collect and count common issues."""
        issue_counts = {}
        for result in self.results:
            for issue in result['quality_issues']:
                issue_counts[issue] = issue_counts.get(issue, 0) + 1

        return dict(sorted(issue_counts.items(), key=lambda x: x[1], reverse=True)[:10])


def main():
    """Main validation function."""
    base_path = "/Users/rezarezvani/projects/claude-code-tresor/subagents"

    # Define sample paths (30 agents across categories)
    sample_paths = [
        # Core (8 agents - all)
        "core/performance-tuner",
        "core/config-safety-reviewer",
        "core/root-cause-analyzer",
        "core/refactor-expert",
        "core/docs-writer",
        "core/systems-architect",
        "core/security-auditor",
        "core/test-engineer",

        # Engineering (6 from different subcategories)
        "engineering/languages/python/python-expert",
        "engineering/languages/typescript/typescript-expert",
        "engineering/backend/api/api-architect",
        "engineering/backend/database/postgres-specialist",
        "engineering/frontend/frontend-developer",
        "engineering/devops/cloud-architect",

        # Design (3)
        "design/ui/ui-designer",
        "design/ux/ux-researcher",
        "design/visual/visual-storyteller",

        # Marketing (3)
        "marketing/content/content-strategist",
        "marketing/growth/growth-hacker",
        "marketing/analytics/marketing-analyst",

        # Product (2)
        "product/strategy/product-strategist",
        "product/roadmap/roadmap-planner",

        # Leadership (2)
        "leadership/technical/tech-lead",
        "leadership/team/engineering-manager",

        # Operations (2)
        "operations/support/customer-support-specialist",
        "operations/qa/qa-specialist",

        # Research (2)
        "research/market/market-research-analyst",
        "research/data/deep-research-specialist",

        # AI & Automation (2)
        "ai-automation/ml/ml-engineer",
        "ai-automation/automation/automation-specialist",
    ]

    validator = AgentValidatorV2(base_path)
    summary = validator.analyze_sample(sample_paths)

    # Print results
    print("\n" + "="*90)
    print("AGENT VALIDATION SUMMARY - Dual Format Analysis")
    print("="*90)

    print(f"\n📊 OVERALL STATISTICS")
    print(f"Total Agents Analyzed: {summary['total_agents']}")
    print(f"Average Quality Score: {summary['overall_stats']['avg_score']}/10")

    if summary['core_agents']:
        print(f"\n📚 CORE AGENTS (Comprehensive Format)")
        print(f"  Count: {summary['core_agents']['count']}")
        print(f"  Avg Score: {summary['core_agents']['avg_score']}/10")
        print(f"  Avg Word Count: {summary['core_agents']['avg_word_count']}")
        print(f"  Avg Code Blocks: {summary['core_agents']['avg_code_blocks']}")
        print(f"  YAML Complete: {summary['core_agents']['yaml_complete']}/{summary['core_agents']['count']}")

    if summary['specialized_agents']:
        print(f"\n⚡ SPECIALIZED AGENTS (Concise Format)")
        print(f"  Count: {summary['specialized_agents']['count']}")
        print(f"  Avg Score: {summary['specialized_agents']['avg_score']}/10")
        print(f"  Avg Word Count: {summary['specialized_agents']['avg_word_count']}")
        print(f"  Avg Code Blocks: {summary['specialized_agents']['avg_code_blocks']}")
        print(f"  YAML Complete: {summary['specialized_agents']['yaml_complete']}/{summary['specialized_agents']['count']}")

    print(f"\n📁 CATEGORY BREAKDOWN")
    for cat, stats in sorted(summary['category_stats'].items()):
        print(f"  {cat:20} {stats['count']} agents, avg: {stats['avg_score']}/10  [Core: {stats['formats']['core']}, Spec: {stats['formats']['specialized']}]")

    print(f"\n⭐ TOP 5 PERFORMERS")
    for agent in summary['top_performers']:
        fmt = "CORE" if agent['format'] == 'core' else "SPEC"
        print(f"  [{fmt}] {agent['agent_name']:35} {agent['quality_score']}/10  ({agent['category']})")

    print(f"\n⚠️  NEEDS IMPROVEMENT (Bottom 5)")
    for agent in summary['needs_improvement']:
        fmt = "CORE" if agent['format'] == 'core' else "SPEC"
        print(f"  [{fmt}] {agent['agent_name']:35} {agent['quality_score']}/10  ({agent['category']})")
        if agent['quality_issues']:
            for issue in agent['quality_issues'][:2]:
                print(f"       → {issue}")

    if summary['all_issues']:
        print(f"\n🔍 COMMON ISSUES (Top 10)")
        for issue, count in list(summary['all_issues'].items())[:10]:
            print(f"  • {issue}: {count} agents")

    # Save detailed results
    output_file = "/Users/rezarezvani/projects/claude-code-tresor/agent_validation_v2_results.json"
    with open(output_file, 'w') as f:
        json.dump({
            'summary': summary,
            'detailed_results': validator.results
        }, f, indent=2)

    print(f"\n💾 Detailed results saved to: {output_file}\n")


if __name__ == "__main__":
    main()
