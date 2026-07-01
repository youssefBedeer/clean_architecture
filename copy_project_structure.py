from pathlib import Path

root = Path(
    "C:/Users/hp/Files/Programming/Flutter/flutter_projects/clean_architecture")
out = root / "project_structure_template.txt"

files = sorted(p for p in root.rglob("*.dart") if p.is_file())

lines = [
    "Project Structure Template inside lib\n",
    "==================================\n\n",
    "lib/\n",
]

for p in files:
    lines.append(f"  {p.relative_to(root).as_posix()}\n")

lines.append("\nCopy of source code for each file:\n")
lines.append("==================================\n\n")

for p in files:
    lines.append(f"--- BEGIN {p.relative_to(root).as_posix()} ---\n")
    lines.append(p.read_text(encoding="utf-8"))
    lines.append(f"\n--- END {p.relative_to(root).as_posix()} ---\n\n")

out.write_text("".join(lines), encoding="utf-8")
print("Wrote", out, "with", len(files), "source files.")
