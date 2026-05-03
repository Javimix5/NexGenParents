#!/usr/bin/env bash
set -euo pipefail

project_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
avd_name="${1:-pixel35_clean}"
device_id="${2:-emulator-5560}"
emulator_port="${3:-5560}"

android_sdk_root="${ANDROID_SDK_ROOT:-$HOME/Android/Sdk}"
adb_bin="$android_sdk_root/platform-tools/adb"
emulator_bin="$android_sdk_root/emulator/emulator"

"$adb_bin" kill-server || true
"$adb_bin" start-server

QT_QPA_PLATFORM=xcb "$emulator_bin" \
  -avd "$avd_name" \
  -port "$emulator_port" \
  -no-snapshot-load \
  -no-snapshot-save \
  -gpu swiftshader_indirect >/tmp/android-emulator-$avd_name.log 2>&1 &

"$adb_bin" wait-for-device

while true; do
  boot_completed="$($adb_bin -s "$device_id" shell getprop sys.boot_completed 2>/dev/null | tr -d '\r')"
  if [[ "$boot_completed" == "1" ]]; then
    break
  fi
done

cd "$project_root"
exec flutter run -d "$device_id" --debug