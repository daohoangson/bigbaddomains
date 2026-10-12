#!/bin/sh

set -eu

_root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
_tmp=$(mktemp -d)
trap 'rm -rf "$_tmp"' EXIT HUP INT TERM

# Building from another working directory must still find the source lists.
cd "$_tmp"
"$_root/scripts/build.sh" "output with spaces" > build.log
LC_ALL=C sort "$_root"/list/*.txt > expected.txt
cmp expected.txt "output with spaces/all.txt"
for _list in "$_root"/list/*.txt; do
  cmp "$_list" "output with spaces/list/$(basename "$_list")"
done

if "$_root/scripts/build.sh" > missing-argument.log 2>&1; then
  echo "Build unexpectedly accepted a missing output directory" >&2
  exit 1
fi
if "$_root/scripts/build.sh" "" > empty-argument.log 2>&1; then
  echo "Build unexpectedly accepted an empty output directory" >&2
  exit 1
fi

# A failed sort must propagate to the build's exit status.
mkdir bin
cat > bin/sort <<'EOF'
#!/bin/sh
exit 42
EOF
chmod +x bin/sort
if PATH="$_tmp/bin:$PATH" "$_root/scripts/build.sh" failed-output > sort-failure.log 2>&1; then
  echo "Build unexpectedly succeeded after sort failed" >&2
  exit 1
else
  _status=$?
  test "$_status" -eq 42
fi

echo "Build tests passed"
