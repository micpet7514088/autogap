"""Core expense tracking logic."""
import csv
from collections import defaultdict


def parse_csv(path):
    rows = []
    with open(path) as f:
        reader = csv.DictReader(f)
        for r in reader:
            rows.append(r)
    return rows


def aggregate_monthly(rows):
    # FIXME: date parsing is naive — breaks on European dd/mm/yyyy
    totals = defaultdict(float)
    for r in rows:
        month = r["date"][:7]
        totals[month] += float(r["amount"])
    return dict(totals)


def cli():
    import sys
    path = sys.argv[1]
    print(aggregate_monthly(parse_csv(path)))


if __name__ == "__main__":
    cli()
