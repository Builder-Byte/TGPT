#!/usr/bin/env bash
# update-tgpt.sh - Install or update tgpt globally (Linux/macOS/WSL/Windows via Git Bash)
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE="$SCRIPT_DIR/tgpt"

if [[ ! -f "$SOURCE" ]]; then
	echo "❌ Could not find tgpt at $SOURCE"
	exit 1
fi

echo "Updating tgpt globally..."

install_unix() {
	local target=""

	if [[ -w /usr/local/bin ]]; then
		target="/usr/local/bin/tgpt"
		cp "$SOURCE" "$target"
		chmod +x "$target"
	elif command -v sudo >/dev/null 2>&1; then
		target="/usr/local/bin/tgpt"
		sudo cp "$SOURCE" "$target"
		sudo chmod +x "$target"
	else
		target="$HOME/.local/bin/tgpt"
		mkdir -p "$(dirname "$target")"
		cp "$SOURCE" "$target"
		chmod +x "$target"
		echo "ℹ️  /usr/local/bin not writable; installed to $target"
	fi

	echo "✅ Installed tgpt to $target"

	if ! command -v tgpt >/dev/null 2>&1; then
		echo "⚠️  tgpt is not on your PATH. Add $(dirname "$target") to PATH."
	fi
}

install_windows_shim() {
	# For Git Bash / MSYS environments on Windows. Creates a .cmd shim plus a copy of the script.
	local target_dir="$HOME/.local/bin"
	mkdir -p "$target_dir"

	local script_copy="$target_dir/tgpt.py"
	cp "$SOURCE" "$script_copy"

	local shim="$target_dir/tgpt.cmd"
	cat > "$shim" <<EOF
@echo off
python "%~dp0tgpt.py" %*
EOF

	# Also provide a Bash shim for shells inside Git Bash
	local bash_shim="$target_dir/tgpt"
	cat > "$bash_shim" <<EOF
#!/usr/bin/env bash
python "$script_copy" "$@"
EOF
	chmod +x "$bash_shim"

	echo "✅ Installed tgpt to $target_dir (tgpt.cmd + tgpt.py)"
	echo "ℹ️  Add $target_dir to your PATH in PowerShell:"
	echo "    [System.Environment]::SetEnvironmentVariable(\"Path\", \"$target_dir;\$([System.Environment]::GetEnvironmentVariable('Path', 'User'))\", 'User')"
}

case "$(uname -s)" in
	Linux|Darwin)
		install_unix
		;;
	MINGW*|MSYS*|CYGWIN*)
		install_windows_shim
		;;
	*)
		echo "⚠️  Unknown platform $(uname -s). Defaulting to Unix install logic."
		install_unix
		;;
esac

echo "Done. Test with: tgpt -h"