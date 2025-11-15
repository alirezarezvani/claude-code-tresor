#!/usr/bin/env python3
"""
Agent Content Structure and Quality Validator
Analyzes agent.md files for structure, quality, completeness, examples, and formatting.
"""

import os
import re
from pathlib import Path
from typing import Dict, List, Tuple
import json

class AgentValidator:
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

    def extract_sections(self, content: str) -> List[str]:
        """Extract all markdown headers from content."""
        headers = re.findall(r'^#{1,3}\s+(.+)$', content, re.MULTILINE)
        return headers

    def count_code_blocks(self, content: str) -> int:
        """Count number of code blocks."""
        return len(re.findall(r'```', content)) // 2

    def count_examples(self, content: str) -> int:
        """Count example sections and code blocks."""
        example_keywords = r'(example|use case|usage|demonstration|sample)'
        examples = len(re.findall(example_keywords, content, re.IGNORECASE))
        return examples + self.count_code_blocks(content)

    def count_words(self, content: str) -> int:
        """Count total words (excluding YAML frontmatter)."""
        # Remove YAML frontmatter
        content = re.sub(r'^---\n.*?\n---\n', '', content, flags=re.DOTALL)
        # Remove code blocks
        content = re.sub(r'```.*?```', '', content, flags=re.DOTALL)
        # Count words
        words = re.findall(r'\b\w+\b', content)
        return len(words)

    def check_formatting(self, content: str) -> List[str]:
        """Check for formatting issues."""
        issues = []

        # Check for code blocks without language tags
        code_blocks = re.findall(r'```(\w*)\n', content)
        if '' in code_blocks:
            issues.append(f"Found {code_blocks.count('')} code blocks without language tags")

        # Check header hierarchy
        headers = re.findall(r'^(#{1,6})', content, re.MULTILINE)
        for i in range(len(headers) - 1):
            current_level = len(headers[i])
            next_level = len(headers[i + 1])
            if next_level > current_level + 1:
                issues.append(f"Header hierarchy skip detected (H{current_level} to H{next_level})")
                break

        return issues

    def calculate_quality_score(self, metrics: Dict) -> float:
        """Calculate quality score (0-10) based on metrics."""
        score = 0.0

        # Required sections (max 2 points)
        required_sections = ['Identity', 'Expertise', 'Methodology', 'Approach', 'Examples', 'Usage']
        sections_text = ' '.join(metrics['sections_found'])
        matching_sections = sum(1 for s in required_sections if s.lower() in sections_text.lower())
        score += (matching_sections / len(required_sections)) * 2

        # Content completeness (max 2 points)
        if metrics['word_count'] >= 500:
            score += 2
        elif metrics['word_count'] >= 300:
            score += 1

        # Example quality (max 2 points)
        if metrics['example_count'] >= 5:
            score += 2
        elif metrics['example_count'] >= 2:
            score += 1

        # Optional sections (max 4 points, 1 each)
        optional_sections = {
            'integration': 'integration tips',
            'related': 'related agents',
            'best practices': 'best practices',
            'pitfalls': 'pitfalls'
        }

        sections_lower = sections_text.lower()
        for key, pattern in optional_sections.items():
            if pattern in sections_lower:
                score += 1

        return round(score, 1)

    def validate_agent(self, agent_path: Path) -> Dict:
        """Validate a single agent file."""
        with open(agent_path, 'r', encoding='utf-8') as f:
            content = f.read()

        # Extract relative path
        rel_path = agent_path.relative_to(self.base_path)
        category = rel_path.parts[1] if len(rel_path.parts) > 1 else 'unknown'

        # Extract metrics
        sections = self.extract_sections(content)
        code_blocks = self.count_code_blocks(content)
        examples = self.count_examples(content)
        word_count = self.count_words(content)
        formatting_issues = self.check_formatting(content)

        # Calculate quality score
        metrics = {
            'sections_found': sections,
            'example_count': examples,
            'word_count': word_count
        }
        quality_score = self.calculate_quality_score(metrics)

        result = {
            'agent_name': agent_path.parent.name,
            'category': category,
            'file_path': str(rel_path),
            'quality_score': quality_score,
            'sections_found': sections,
            'section_count': len(sections),
            'code_blocks': code_blocks,
            'example_count': examples,
            'word_count': word_count,
            'formatting_issues': formatting_issues,
            'recommendations': self.generate_recommendations(quality_score, metrics, formatting_issues)
        }

        return result

    def generate_recommendations(self, score: float, metrics: Dict, issues: List[str]) -> List[str]:
        """Generate improvement recommendations."""
        recs = []

        if score < 5:
            recs.append("CRITICAL: Low quality score - needs substantial content improvement")
        elif score < 7:
            recs.append("Moderate quality - consider adding more examples and documentation")

        if metrics['word_count'] < 300:
            recs.append("Add more detailed explanations and context (< 300 words)")
        elif metrics['word_count'] < 500:
            recs.append("Consider expanding content for better completeness (< 500 words)")

        if metrics['example_count'] < 2:
            recs.append("Add more code examples and use cases")

        if issues:
            recs.append(f"Fix formatting issues: {'; '.join(issues)}")

        required_sections = ['Identity', 'Expertise', 'Methodology', 'Examples']
        sections_text = ' '.join(metrics['sections_found'])
        missing = [s for s in required_sections if s.lower() not in sections_text.lower()]
        if missing:
            recs.append(f"Add missing sections: {', '.join(missing)}")

        return recs if recs else ["No major issues - agent meets quality standards"]

    def analyze_sample(self, sample_paths: List[str]) -> Dict:
        """Analyze a sample of agents and return summary statistics."""
        agents = self.find_agents(sample_paths)

        print(f"Analyzing {len(agents)} agents...")

        for agent_path in agents:
            result = self.validate_agent(agent_path)
            self.results.append(result)
            print(f"  ✓ {result['agent_name']} (score: {result['quality_score']}/10)")

        return self.generate_summary()

    def generate_summary(self) -> Dict:
        """Generate summary statistics."""
        if not self.results:
            return {}

        scores = [r['quality_score'] for r in self.results]
        word_counts = [r['word_count'] for r in self.results]
        example_counts = [r['example_count'] for r in self.results]
        section_counts = [r['section_count'] for r in self.results]

        # Category analysis
        category_stats = {}
        for result in self.results:
            cat = result['category']
            if cat not in category_stats:
                category_stats[cat] = {'count': 0, 'avg_score': 0, 'scores': []}
            category_stats[cat]['count'] += 1
            category_stats[cat]['scores'].append(result['quality_score'])

        for cat, stats in category_stats.items():
            stats['avg_score'] = round(sum(stats['scores']) / len(stats['scores']), 1)
            del stats['scores']

        # Common issues
        all_issues = []
        for result in self.results:
            all_issues.extend(result['formatting_issues'])

        # Issue frequency
        issue_freq = {}
        for issue in all_issues:
            issue_freq[issue] = issue_freq.get(issue, 0) + 1

        summary = {
            'total_agents': len(self.results),
            'average_score': round(sum(scores) / len(scores), 1),
            'min_score': min(scores),
            'max_score': max(scores),
            'score_distribution': {
                'excellent (9-10)': sum(1 for s in scores if s >= 9),
                'good (7-8.9)': sum(1 for s in scores if 7 <= s < 9),
                'moderate (5-6.9)': sum(1 for s in scores if 5 <= s < 7),
                'poor (<5)': sum(1 for s in scores if s < 5)
            },
            'average_word_count': round(sum(word_counts) / len(word_counts)),
            'average_example_count': round(sum(example_counts) / len(example_counts), 1),
            'average_section_count': round(sum(section_counts) / len(section_counts), 1),
            'category_stats': category_stats,
            'common_issues': sorted(issue_freq.items(), key=lambda x: x[1], reverse=True)[:5],
            'top_performers': sorted(self.results, key=lambda x: x['quality_score'], reverse=True)[:5],
            'needs_improvement': sorted(self.results, key=lambda x: x['quality_score'])[:5]
        }

        return summary


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

        # Engineering (6 agents from different subcategories)
        "engineering/languages/python/python-expert",
        "engineering/languages/typescript/typescript-expert",
        "engineering/backend/api/api-architect",
        "engineering/backend/database/postgres-specialist",
        "engineering/frontend/frontend-developer",
        "engineering/devops/cloud-architect",

        # Design (3 agents)
        "design/ui/ui-designer",
        "design/ux/ux-researcher",
        "design/visual/visual-storyteller",

        # Marketing (3 agents)
        "marketing/content/content-strategist",
        "marketing/growth/growth-hacker",
        "marketing/analytics/marketing-analyst",

        # Product (2 agents)
        "product/strategy/product-strategist",
        "product/roadmap/roadmap-planner",

        # Leadership (2 agents)
        "leadership/technical/tech-lead",
        "leadership/team/engineering-manager",

        # Operations (2 agents)
        "operations/support/customer-support-specialist",
        "operations/qa/qa-specialist",

        # Research (2 agents)
        "research/market/market-research-analyst",
        "research/data/deep-research-specialist",

        # AI & Automation (2 agents)
        "ai-automation/ml/ml-engineer",
        "ai-automation/automation/automation-specialist",
    ]

    validator = AgentValidator(base_path)
    summary = validator.analyze_sample(sample_paths)

    # Print results
    print("\n" + "="*80)
    print("VALIDATION SUMMARY")
    print("="*80)

    print(f"\nTotal Agents Analyzed: {summary['total_agents']}")
    print(f"Average Quality Score: {summary['average_score']}/10")
    print(f"Score Range: {summary['min_score']} - {summary['max_score']}")

    print("\nScore Distribution:")
    for level, count in summary['score_distribution'].items():
        print(f"  {level}: {count} agents")

    print("\nContent Metrics:")
    print(f"  Average Word Count: {summary['average_word_count']}")
    print(f"  Average Examples: {summary['average_example_count']}")
    print(f"  Average Sections: {summary['average_section_count']}")

    print("\nCategory Analysis:")
    for cat, stats in summary['category_stats'].items():
        print(f"  {cat}: {stats['count']} agents, avg score: {stats['avg_score']}")

    print("\nTop 5 Performers:")
    for agent in summary['top_performers']:
        print(f"  • {agent['agent_name']} ({agent['category']}): {agent['quality_score']}/10")

    print("\nNeed Improvement:")
    for agent in summary['needs_improvement']:
        print(f"  • {agent['agent_name']} ({agent['category']}): {agent['quality_score']}/10")
        if agent['recommendations']:
            for rec in agent['recommendations'][:2]:
                print(f"    - {rec}")

    if summary['common_issues']:
        print("\nCommon Formatting Issues:")
        for issue, count in summary['common_issues']:
            print(f"  • {issue}: {count} occurrences")

    # Save detailed results
    output_file = "/Users/rezarezvani/projects/claude-code-tresor/agent_validation_results.json"
    with open(output_file, 'w') as f:
        json.dump({
            'summary': summary,
            'detailed_results': validator.results
        }, f, indent=2)

    print(f"\nDetailed results saved to: {output_file}")


if __name__ == "__main__":
    main()
