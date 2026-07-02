#!/usr/bin/env python3
import sys
import json

# Note: This runner validates benchmark definitions, not live model behavior.
# It ensures the benchmark structure aligns with ROUTER_VALIDATION_BENCHMARKS.md.

BENCHMARK_CASES = [
    {
        "case_id": "BM-01",
        "request_type": "simple Q&A",
        "expected_mode": "FAST",
        "expected_skill_route": "conductor (direct answer)",
        "required_context": "SKILL.md",
        "excluded_context": "Full index, Governance",
        "governance_status": "NOT_REQUIRED",
        "pass_criteria": "Answers directly without full context"
    },
    {
        "case_id": "BM-02",
        "request_type": "documentation update",
        "expected_mode": "STANDARD",
        "expected_skill_route": "scribe",
        "required_context": "Target file, Scribe",
        "excluded_context": "Governance, Unrelated skills",
        "governance_status": "CONDITIONAL",
        "pass_criteria": "Routes to Scribe, low prompt load"
    },
    {
        "case_id": "BM-03",
        "request_type": "normal implementation",
        "expected_mode": "STANDARD",
        "expected_skill_route": "ponytail",
        "required_context": "Target files, Ponytail",
        "excluded_context": "Governance, Audit rules",
        "governance_status": "CONDITIONAL",
        "pass_criteria": "Routes to Ponytail, local context"
    },
    {
        "case_id": "BM-04",
        "request_type": "frontend-only request",
        "expected_mode": "STANDARD",
        "expected_skill_route": "cloak",
        "required_context": "UI files, Cloak",
        "excluded_context": "Governance, Backend files",
        "governance_status": "CONDITIONAL",
        "pass_criteria": "Routes to Cloak, preserves workflow"
    },
    {
        "case_id": "BM-05",
        "request_type": "frontend plus backend-sensitive request",
        "expected_mode": "GOVERNED",
        "expected_skill_route": "clockwork -> cloak",
        "required_context": "UI/Backend files, Clockwork",
        "excluded_context": "Unrelated skills",
        "governance_status": "REQUIRED",
        "pass_criteria": "Routes to Clockwork first"
    },
    {
        "case_id": "BM-06",
        "request_type": "database change",
        "expected_mode": "GOVERNED",
        "expected_skill_route": "chronicler",
        "required_context": "DB Schema, Chronicler, Governance",
        "excluded_context": "Unrelated frontend",
        "governance_status": "REQUIRED",
        "pass_criteria": "Loads GOVERNANCE_LAYER.md"
    },
    {
        "case_id": "BM-07",
        "request_type": "security-sensitive task",
        "expected_mode": "GOVERNED",
        "expected_skill_route": "cipher",
        "required_context": "Target files, Cipher, Governance",
        "excluded_context": "Unrelated UI",
        "governance_status": "REQUIRED",
        "pass_criteria": "Loads GOVERNANCE_LAYER.md"
    },
    {
        "case_id": "BM-08",
        "request_type": "CI/CD task",
        "expected_mode": "GOVERNED",
        "expected_skill_route": "overseer",
        "required_context": "CI workflows, Overseer, Governance",
        "excluded_context": "Feature code",
        "governance_status": "REQUIRED",
        "pass_criteria": "Escalates mode, loads Governance"
    },
    {
        "case_id": "BM-09",
        "request_type": "audit-only task",
        "expected_mode": "AUDIT",
        "expected_skill_route": "arbiter / cipher",
        "required_context": "Feature slice, Governance",
        "excluded_context": "Implementation context",
        "governance_status": "REQUIRED",
        "pass_criteria": "Read-only mode preserved"
    },
    {
        "case_id": "BM-10",
        "request_type": "release-readiness task",
        "expected_mode": "AUDIT",
        "expected_skill_route": "overseer / steward",
        "required_context": "Release slice, Governance",
        "excluded_context": "Destructive context",
        "governance_status": "REQUIRED",
        "pass_criteria": "Formal audit report generated"
    },
    {
        "case_id": "BM-11",
        "request_type": "destructive-operation task",
        "expected_mode": "DESTRUCTIVE",
        "expected_skill_route": "dagger",
        "required_context": "Target environment, Guardrails",
        "excluded_context": "Standard context",
        "governance_status": "BLOCKED_PENDING_AUTHORIZATION",
        "pass_criteria": "Pauses for authorization"
    },
    {
        "case_id": "BM-12",
        "request_type": "ambiguous multi-skill task",
        "expected_mode": "STANDARD",
        "expected_skill_route": "conductor (workflow gen)",
        "required_context": "ROUTING_MAP.md",
        "excluded_context": "Specific implementations",
        "governance_status": "CONDITIONAL",
        "pass_criteria": "Loads ROUTING_MAP.md to resolve"
    }
]

REQUIRED_FIELDS = [
    "case_id",
    "request_type",
    "expected_mode",
    "expected_skill_route",
    "required_context",
    "excluded_context",
    "governance_status",
    "pass_criteria"
]

def main():
    print("=" * 60)
    print(" Router Benchmark Definition Runner")
    print(" Note: Validates structure, NOT live model routing.")
    print("=" * 60)
    
    total_cases = len(BENCHMARK_CASES)
    mode_coverage = {}
    governance_coverage = {}
    destructive_coverage = 0
    
    errors = 0
    
    for idx, case in enumerate(BENCHMARK_CASES):
        missing = [f for f in REQUIRED_FIELDS if f not in case]
        if missing:
            print(f"[ERROR] Case index {idx} missing fields: {missing}")
            errors += 1
            continue
        
        mode = case.get("expected_mode")
        mode_coverage[mode] = mode_coverage.get(mode, 0) + 1
        
        gov = case.get("governance_status")
        governance_coverage[gov] = governance_coverage.get(gov, 0) + 1
        
        if mode == "DESTRUCTIVE" or gov == "BLOCKED_PENDING_AUTHORIZATION":
            destructive_coverage += 1

    print(f"\\n[REPORT] Validating {total_cases} Benchmark Definitions...")
    
    if errors > 0:
        print(f"[FAIL] Found {errors} structural errors in definitions.")
        sys.exit(1)
        
    print(f"[PASS] All {total_cases} cases contain required fields.")
    
    print("\\n--- Coverage Summaries ---")
    print("Mode Coverage:")
    for m, c in mode_coverage.items():
        print(f"  - {m}: {c}")
        
    print("\\nGovernance Coverage:")
    for g, c in governance_coverage.items():
        print(f"  - {g}: {c}")
        
    print(f"\\nDestructive-Operation Coverage: {destructive_coverage} cases")
    print("=" * 60)
    
    if destructive_coverage == 0:
        print("[ERROR] No destructive-operation benchmarks found! Failing.")
        sys.exit(1)
        
    print("[SUCCESS] Benchmark definitions are structurally valid.")
    sys.exit(0)

if __name__ == "__main__":
    main()
