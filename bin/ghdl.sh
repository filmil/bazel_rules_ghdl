#! /usr/bin/env bash

# --- begin runfiles.bash initialization v3 ---
# Copy-pasted from the Bazel Bash runfiles library v3.
set -uo pipefail; f=bazel_tools/tools/bash/runfiles/runfiles.bash
# shellcheck disable=SC1090
source "${RUNFILES_DIR:-/dev/null}/$f" 2>/dev/null || \
  source "$(grep -sm1 "^$f " "${RUNFILES_MANIFEST_FILE:-/dev/null}" | cut -f2- -d' ')" 2>/dev/null || \
  source "$0.runfiles/$f" 2>/dev/null || \
  source "$(grep -sm1 "^$f " "$0.runfiles_manifest" | cut -f2- -d' ')" 2>/dev/null || \
  source "$(grep -sm1 "^$f " "$0.exe.runfiles_manifest" | cut -f2- -d' ')" 2>/dev/null || \
  { echo>&2 "ERROR: cannot find $f"; exit 1; }; f=; set -e
# --- end runfiles.bash initialization v3 ---

# For some reason rlocation gives up if it doesn't find the repo.
_rootfs_dir="$(rlocation ${TEST_WORKSPACE:-bazel_rules_ghdl}/image/rootfs)"
if [[ ${_rootfs_dir} == "" ]]; then
  echo "could not find rootfs: ${_rootfs_dir}"
  exit 1
fi

readonly _ld_preload_path="${_rootfs_dir}/lib/x86_64-linux-gnu:${_rootfs_dir}/usr/lib/x86_64-linux-gnu"
readonly _path="${_rootfs_dir}/bin:${_rootfs_dir}/usr/bin:${_rootfs_dir}/usr/lib/ghdl/gcc"
readonly _ld_so="${_rootfs_dir}/lib64/ld-linux-x86-64.so.2"

export LD_LIBRARY_PATH="${_ld_preload_path}"
export PATH="${_path}"

"${_ld_so}" "${_rootfs_dir}/usr/bin/ghdl-mcode" "${@}"

