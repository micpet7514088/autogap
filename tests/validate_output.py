"""Structural validator for autogap demo expected outputs.

Checks that every autogap-run.md file in examples/ satisfies the required
output format:

  - Required top-level sections (h1)
  - Exactly 3 Gap subsections (h2)
  - Exactly 3 Macro-Step subsections (h2)
  - User Choice menu with items 1 through 8

Run:
    python tests/validate_output.py

Exit code 0 means all files pass. Non-zero means at least one file failed.
"""

import re
import sys
from pathlib import Path

REPO_ROOT = Path(__file__).parent.parent
EXAMPLES_DIR = REPO_ROOT / "examples"

REQUIRED_H1 = [
    "Project Objective Hypothesis",
    "Current State Summary",
    "Top 3 Gaps",
    "3 Macro-Steps",
    "Recommendation",
    "User Choice",
]

GAP_PATTERN = re.compile(r"^##\s+Gap\s+\d+", re.MULTILINE)
STEP_PATTERN = re.compile(r"^##\s+Macro-Step\s+\d+", re.MULTILINE)
MENU_ITEM_PATTERN = re.compile(r"^\d+\.", re.MULTILINE)


def find_output_files() -> list[Path]:
    return sorted(EXAMPLES_DIR.glob("**/autogap-run.md"))


def check_file(path: Path) -> list[str]:
    errors: list[str] = []
    text = path.read_text(encoding="utf-8")

    for section in REQUIRED_H1:
        pattern = re.compile(rf"^#\s+{re.escape(section)}", re.MULTILINE | re.IGNORECASE)
        if not pattern.search(text):
            errors.append(f"Missing required section: '# {section}'")

    gaps = GAP_PATTERN.findall(text)
    if len(gaps) != 3:
        errors.append(f"Expected exactly 3 Gap subsections, found {len(gaps)}")

    steps = STEP_PATTERN.findall(text)
    if len(steps) != 3:
        errors.append(f"Expected exactly 3 Macro-Step subsections, found {len(steps)}")

    menu_items = MENU_ITEM_PATTERN.findall(text)
    numbered = [m for m in menu_items if re.match(r"[1-8]\.", m)]
    if len(numbered) < 8:
        errors.append(f"User Choice menu: expected items 1-8, found {len(numbered)} numbered items")

    return errors


def main() -> int:
    files = find_output_files()
    if not files:
        print("ERROR: no autogap-run.md files found under examples/", file=sys.stderr)
        return 1

    failed = 0
    for path in files:
        rel = path.relative_to(REPO_ROOT)
        errors = check_file(path)
        if errors:
            failed += 1
            print(f"FAIL  {rel}")
            for e in errors:
                print(f"      - {e}")
        else:
            print(f"ok    {rel}")

    print()
    if failed:
        print(f"{failed}/{len(files)} file(s) failed validation.")
        return 1

    print(f"All {len(files)} file(s) passed.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
