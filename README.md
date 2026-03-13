# Terminal GPT (tgpt) 🤖

A simple command-line interface to interact with local AI models from anywhere in your terminal using [Ollama](https://ollama.com). No API keys, no costs — runs entirely on your machine.

## Features

- 🚀 **Global Access**: Use `tgpt` from any directory in your terminal
- 💬 **Simple Syntax**: Just type your question after `tgpt`
- 🏠 **Fully Local**: Powered by Ollama — no internet or API keys required
- 🔄 **Model Switching**: Easily switch between any locally pulled model
- ⚡ **Fast**: Quick responses for terminal workflows
- 🛡️ **Error Handling**: Helpful error messages and validation

## Installation (Global)

### Prerequisites

- Python 3.8 or higher
- [Ollama](https://ollama.com) installed and running
- Git (for cloning) and a shell (Bash for Linux/macOS/WSL, Git Bash for Windows)

### 1) Install Ollama

```bash
# Linux / macOS
curl -fsSL https://ollama.com/install.sh | sh
# Windows: download the installer from https://ollama.com/download
```

### 2) Pull a model

```bash
ollama pull qwen3-next:80b-cloud
# or any other model: ollama pull mistral
```

### 3) Start Ollama

```bash
ollama serve
```

> On macOS and Windows, Ollama usually starts automatically. On Linux, you may need `ollama serve` or a systemd service.

### 4) Clone

```bash
git clone https://github.com/Builder-Byte/TGPT
cd TGPT
```

### 5) Install globally with the updater

The bundled updater handles Linux, macOS, WSL, and Windows (via Git Bash):

```bash
chmod +x update-tgpt.sh tgpt
./update-tgpt.sh
```

What the updater does:
- Linux/macOS: installs to `/usr/local/bin/tgpt` if writable (or via `sudo`), otherwise to `~/.local/bin/tgpt`.
- Windows (Git Bash/MSYS/WSL): copies the script to `~/.local/bin/tgpt.py` and creates `tgpt.cmd` and `tgpt` shims in the same folder. Add `~/.local/bin` to your PATH for PowerShell/CMD/Git Bash.

#### Manual Windows install (PowerShell)

If you prefer not to run Bash on Windows:

```powershell
# From the repo root
$target = "$env:USERPROFILE\.local\bin"
New-Item -ItemType Directory -Force -Path $target | Out-Null
Copy-Item tgpt "$target\tgpt.py"
"@echo off`npython `%~dp0tgpt.py` %*" | Set-Content "$target\tgpt.cmd"
[System.Environment]::SetEnvironmentVariable("Path", "$target;" + [System.Environment]::GetEnvironmentVariable("Path", "User"), "User")
```

Restart your shell, then run `tgpt -h`.

## Usage

### Basic Usage

```bash
tgpt "your question here"
```

### Command Line Flags

| Flag | Description | Example |
|------|-------------|---------|
| **(default)** | Short, concise answers (1-2 sentences or brief paragraph) | `tgpt "What is Python?"` |
| `-l` | Long, detailed explanations | `tgpt -l "What is Python?"` |
| `-m <model>` | Use a specific Ollama model | `tgpt -m mistral "What is Python?"` |
| `--list-models` | Show all locally available models | `tgpt --list-models` |
| `-h` | Show help message and usage examples | `tgpt -h` |

### Response Length Control

- **Default (Short)**: Gives brief, concise answers perfect for quick terminal queries
- **Long (`-l`)**: Provides detailed, comprehensive explanations when you need more context

### Examples

```bash
# Short answers (default behavior)
tgpt "What is the capital of France?"
tgpt "What is Python?"

# Long answers (detailed explanations)
tgpt -l "What is Python?"
tgpt -l "Explain machine learning"

# Use a specific model
tgpt -m mistral "Explain recursion"
tgpt -m llama3.2 "Write a bash one-liner to find large files"

# List all locally available models
tgpt --list-models

# Programming help
tgpt "How do I create a Python virtual environment?"
tgpt -l "How do I create a Python virtual environment?"

# Code generation
tgpt "Write a bash script to backup a directory"
tgpt -l "Write a bash script to backup a directory"

# Help
tgpt -h
```

### Keyboard Interrupts

The tool handles Ctrl+C gracefully:
- Shows "🤔 Thinking..." while processing requests
- Press Ctrl+C to cancel ongoing requests
- Displays user-friendly termination messages

## Configuration

### Default Model

The default model is `qwen3-next:80b-cloud`. To change it permanently, edit the `DEFAULT_MODEL` variable at the top of the `tgpt` script:

```python
DEFAULT_MODEL = "qwen3-next:80b-cloud"  # Change to your preferred model
```

### Ollama Base URL

By default, tgpt connects to Ollama at `http://localhost:11434`. If you're running Ollama on a different host or port, update `OLLAMA_BASE_URL` in the script:

```python
OLLAMA_BASE_URL = "http://localhost:11434"
```

### Token Limit

The script limits responses to 1000 tokens by default. Adjust `num_predict` in the `query_ai` function if you need longer outputs:

```python
"options": { "num_predict": 1000 }
```

## Troubleshooting

### Common Issues

1. **"command not found: tgpt"**
   - Make sure the script is in your PATH
   - Check: `echo $PATH` — ensure `/usr/local/bin` or `~/.local/bin` is listed
   - Try the alternative installation method using `~/.local/bin`

2. **"Error: Ollama is not running"**
   - Start Ollama: `ollama serve`
   - On Linux, you can set it up as a service: `systemctl enable --now ollama`

3. **Model not found**
   - Pull the model first: `ollama pull qwen3-next:80b-cloud`
   - List available models: `tgpt --list-models` or `ollama list`

4. **Slow responses**
   - Large models require significant RAM/VRAM
   - Try a smaller model: `tgpt -m llama3.2 "your question"`

5. **Permission denied**
   - Make the script executable: `chmod +x tgpt`

### Debugging

```bash
# Check if tgpt is accessible
which tgpt

# Check if Ollama is running
curl http://localhost:11434/api/tags

# List available models
tgpt --list-models

# Test with a simple query
tgpt "hello"

# Test with long answer flag
tgpt -l "hello"

# Test with a specific model
tgpt -m mistral "hello"

# Check help
tgpt -h
```

## File Structure

```
TGPT/
├── tgpt            # Main CLI script
├── update-tgpt.sh  # Cross-platform installer/updater
└── README.md
```

## Updating

Once you update the code, run:

```bash
chmod +x $(pwd)/update-tgpt.sh
./update-tgpt.sh
```

## Changelog

### v2.0 (Current)
- 🏠 Migrated from OpenRouter to Ollama (fully local, no API key required)
- 🔄 Added `-m <model>` flag for per-query model switching
- 📋 Added `--list-models` to browse locally available models
- ✅ Removed all external dependencies (pure Python standard library)
- 🔍 Added Ollama connectivity check before querying

### v1.1
- ✨ Added `-l` flag for long, detailed answers
- 🎯 Default behavior now gives short, concise responses
- 🛡️ Added keyboard interrupt handling (Ctrl+C)
- 📋 Added help system with `-h` flag
- 💬 Added "Thinking..." indicator during API calls
- 🚦 Graceful termination messages

### v1.0
- Initial release with OpenRouter integration
