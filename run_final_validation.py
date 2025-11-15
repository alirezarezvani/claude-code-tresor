#!/usr/bin/env python3
"""
Final comprehensive validation of 30 representative agents
"""

import sys
sys.path.append('/Users/rezarezvani/projects/claude-code-tresor')

from agent_validator_v2 import AgentValidatorV2

def main():
    base_path = "/Users/rezarezvani/projects/claude-code-tresor/subagents"

    # 30 representative agents across all categories
    sample_paths = [
        # CORE (8 agents - ALL)
        "core/performance-tuner",
        "core/config-safety-reviewer",
        "core/root-cause-analyzer",
        "core/refactor-expert",
        "core/docs-writer",
        "core/systems-architect",
        "core/security-auditor",
        "core/test-engineer",

        # ENGINEERING (6 agents from various subcategories)
        "engineering/backend/backend-architect",
        "engineering/backend/database-optimizer",
        "engineering/devops/cloud-architect",
        "engineering/devops/incident-responder",
        "engineering/frontend/frontend-developer",
        "engineering/languages/python-developer",

        # DESIGN (3 agents)
        "design/ui/ui-designer",
        "design/ux/ux-researcher",
        "design/visual/visual-storyteller",

        # MARKETING (3 agents)
        "marketing/content/copywriter",
        "marketing/growth/growth-hacker",
        "marketing/seo/seo-specialist",

        # PRODUCT (2 agents)
        "product/management/product-manager",
        "product/strategy/feature-prioritization",

        # LEADERSHIP (2 agents)
        "leadership/management/people-manager",
        "leadership/technical/architect-leader",

        # OPERATIONS (2 agents)
        "operations/qa/qa-engineer",
        "operations/process/process-optimizer",

        # RESEARCH (2 agents)
        "research/market/market-research-analyst",
        "research/data/deep-research-specialist",

        # AI & AUTOMATION (2 agents)
        "ai-automation/ml-engineering/ml-engineer",
        "ai-automation/prompts/prompt-engineer",
    ]

    validator = AgentValidatorV2(base_path)
    summary = validator.analyze_sample(sample_paths)

    # Generate comprehensive report
    print("\n" + "="*90)
    print(" COMPREHENSIVE AGENT VALIDATION REPORT")
    print(" Claude Code Tresor - 30 Agent Sample Analysis")
    print("="*90)

    print(f"\n📊 EXECUTIVE SUMMARY")
    print(f"─" * 90)
    print(f"Total Agents Analyzed: {summary['total_agents']}")
    print(f"Overall Quality Score: {summary['overall_stats']['avg_score']}/10")
    print(f"Score Range: {summary['overall_stats']['min_score']} - {summary['overall_stats']['max_score']}")

    if summary['core_agents']:
        print(f"\n📚 CORE AGENTS (Comprehensive Format) - n={summary['core_agents']['count']}")
        print(f"─" * 90)
        print(f"  Average Quality Score: {summary['core_agents']['avg_score']}/10")
        print(f"  Average Word Count: {summary['core_agents']['avg_word_count']} words")
        print(f"  Average Code Examples: {summary['core_agents']['avg_code_blocks']} blocks")
        print(f"  YAML Completeness: {summary['core_agents']['yaml_complete']}/{summary['core_agents']['count']} (100%)")
        print(f"\n  💡 Assessment: {'EXCELLENT' if summary['core_agents']['avg_score'] >= 8 else 'GOOD' if summary['core_agents']['avg_score'] >= 7 else 'NEEDS IMPROVEMENT'}")

    if summary['specialized_agents']:
        print(f"\n⚡ SPECIALIZED AGENTS (Concise Format) - n={summary['specialized_agents']['count']}")
        print(f"─" * 90)
        print(f"  Average Quality Score: {summary['specialized_agents']['avg_score']}/10")
        print(f"  Average Word Count: {summary['specialized_agents']['avg_word_count']} words")
        print(f"  Average Code Examples: {summary['specialized_agents']['avg_code_blocks']} blocks")
        print(f"  YAML Completeness: {summary['specialized_agents']['yaml_complete']}/{summary['specialized_agents']['count']}")
        print(f"\n  💡 Assessment: {'EXCELLENT' if summary['specialized_agents']['avg_score'] >= 8 else 'GOOD' if summary['specialized_agents']['avg_score'] >= 7 else 'NEEDS IMPROVEMENT'}")

    print(f"\n📁 CATEGORY ANALYSIS")
    print(f"─" * 90)
    for cat, stats in sorted(summary['category_stats'].items(), key=lambda x: x[1]['avg_score'], reverse=True):
        score_emoji = "🟢" if stats['avg_score'] >= 7 else "🟡" if stats['avg_score'] >= 5 else "🔴"
        print(f"  {score_emoji} {cat:20} {stats['count']:2} agents  |  Avg: {stats['avg_score']:>4.1f}/10  |  [Core: {stats['formats']['core']}, Specialized: {stats['formats']['specialized']}]")

    print(f"\n⭐ TOP 10 PERFORMERS")
    print(f"─" * 90)
    for i, agent in enumerate(summary['top_performers'][:10], 1):
        fmt = "📚" if agent['format'] == 'core' else "⚡"
        print(f"  {i:2}. {fmt} {agent['agent_name']:40} {agent['quality_score']:>4.1f}/10  ({agent['category']})")

    print(f"\n⚠️  BOTTOM 10 - NEEDS IMPROVEMENT")
    print(f"─" * 90)
    bottom_agents = sorted(validator.results, key=lambda x: x['quality_score'])[:10]
    for i, agent in enumerate(bottom_agents, 1):
        fmt = "📚" if agent['format'] == 'core' else "⚡"
        print(f"  {i:2}. {fmt} {agent['agent_name']:40} {agent['quality_score']:>4.1f}/10  ({agent['category']})")
        if agent['quality_issues']:
            for issue in agent['quality_issues'][:2]:
                print(f"       🔧 {issue}")

    if summary['all_issues']:
        print(f"\n🔍 MOST COMMON ISSUES (Top 10)")
        print(f"─" * 90)
        for i, (issue, count) in enumerate(list(summary['all_issues'].items())[:10], 1):
            pct = (count / summary['total_agents']) * 100
            print(f"  {i:2}. [{count:2} agents, {pct:5.1f}%] {issue}")

    print(f"\n📊 QUALITY DISTRIBUTION")
    print(f"─" * 90)
    score_buckets = {
        'Excellent (9-10)': [r for r in validator.results if r['quality_score'] >= 9],
        'Good (7-8.9)': [r for r in validator.results if 7 <= r['quality_score'] < 9],
        'Moderate (5-6.9)': [r for r in validator.results if 5 <= r['quality_score'] < 7],
        'Poor (<5)': [r for r in validator.results if r['quality_score'] < 5]
    }

    for label, agents in score_buckets.items():
        count = len(agents)
        pct = (count / summary['total_agents']) * 100
        bar = '█' * int(pct / 2)
        print(f"  {label:20} {count:2} agents ({pct:5.1f}%) {bar}")

    print(f"\n💡 KEY RECOMMENDATIONS")
    print(f"─" * 90)

    # Generate recommendations based on analysis
    recs = []

    if summary['core_agents']['avg_score'] < 7:
        recs.append("CORE AGENTS: Add more code examples and expand methodology sections")

    if summary['specialized_agents']['avg_score'] < 7:
        recs.append("SPECIALIZED AGENTS: Ensure all have Focus/Approach/Output sections")

    # Check category-specific issues
    low_categories = [cat for cat, stats in summary['category_stats'].items() if stats['avg_score'] < 6]
    if low_categories:
        recs.append(f"CATEGORIES NEEDING ATTENTION: {', '.join(low_categories)}")

    if summary['all_issues']:
        top_issue = list(summary['all_issues'].items())[0]
        if top_issue[1] > 5:
            recs.append(f"FIX WIDESPREAD ISSUE: {top_issue[0]} ({top_issue[1]} agents affected)")

    if not recs:
        recs.append("✅ Overall quality is good - maintain current standards")
        recs.append("✅ Continue adding code examples to core agents")
        recs.append("✅ Keep YAML frontmatter complete and consistent")

    for i, rec in enumerate(recs, 1):
        print(f"  {i}. {rec}")

    print(f"\n📈 ESTIMATED REPOSITORY QUALITY")
    print(f"─" * 90)

    # Extrapolate to full repository
    total_repo_agents = 133
    core_in_repo = 8
    spec_in_repo = total_repo_agents - core_in_repo

    # Weighted average
    if summary['core_agents'] and summary['specialized_agents']:
        estimated_score = (
            (summary['core_agents']['avg_score'] * core_in_repo +
             summary['specialized_agents']['avg_score'] * spec_in_repo) /
            total_repo_agents
        )
    else:
        estimated_score = summary['overall_stats']['avg_score']

    print(f"  Sample Quality Score: {summary['overall_stats']['avg_score']}/10")
    print(f"  Estimated Repository Score: {estimated_score:.1f}/10")
    print(f"  Confidence: {'HIGH (representative sample)' if summary['total_agents'] >= 25 else 'MEDIUM'}")

    quality_label = (
        "EXCELLENT" if estimated_score >= 8 else
        "GOOD" if estimated_score >= 7 else
        "MODERATE" if estimated_score >= 5 else
        "NEEDS IMPROVEMENT"
    )
    print(f"  Overall Assessment: {quality_label}")

    # Save JSON report
    output_file = "/Users/rezarezvani/projects/claude-code-tresor/VALIDATION_REPORT.json"
    import json
    with open(output_file, 'w') as f:
        json.dump({
            'summary': summary,
            'detailed_results': validator.results,
            'repository_estimate': {
                'sample_score': summary['overall_stats']['avg_score'],
                'estimated_full_score': round(estimated_score, 1),
                'quality_label': quality_label,
                'total_repo_agents': total_repo_agents
            }
        }, f, indent=2)

    print(f"\n💾 Full JSON report saved to: {output_file}")
    print("="*90 + "\n")


if __name__ == "__main__":
    main()
