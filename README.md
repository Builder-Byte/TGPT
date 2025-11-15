# Terminal GPT (tgpt) 🤖

A simple command-line interface to interact with AI models from anywhere in your terminal using OpenRouter API.

## Features

- 🚀 **Global Access**: Use `tgpt` from any directory in your terminal
- 💬 **Simple Syntax**: Just type your question after `tgpt`
- 💰 **Token Limited**: Optimized for cost-effective API usage
- 🔄 **Auto Model Selection**: Uses OpenRouter's auto model selection
- ⚡ **Fast**: Quick responses for terminal workflows
- 🛡️ **Error Handling**: Helpful error messages and validation

## Installation

### Prerequisites

- Python 3.6 or higher
- pip package manager
- OpenRouter API account and key

### Step 1: Clone or Download

```bash
# Clone this repository or create the files manually
git clone https://github.com/Builder-Byte/TGPT
cd terminal_gpt
```

### Step 2: Install Dependencies

Install the OpenAI Python package globally:

```bash
# Install the openai package
pip3 install openai --break-system-packages
```

> **Note**: If you get an "externally-managed-environment" error, use the `--break-system-packages` flag as shown above, or use pipx/virtual environments.

### Step 3: Get OpenRouter API Key

1. Sign up at [OpenRouter.ai](https://openrouter.ai)
2. Create an API key in your settings
3. Copy your API key (it starts with `sk-or-v1-...`)

### Step 4: Set Environment Variable

Add your API key to your shell profile:

```bash
# Add to your ~/.bashrc or ~/.zshrc
echo 'export OPENROUTER_API_KEY="your-api-key-here"' >> ~/.bashrc

# Reload your shell configuration
source ~/.bashrc
```

### Step 5: Make Script Executable

```bash
# Make the script executable
chmod +x tgpt
```

### Step 6: Install Globally

```bash
# Copy to global bin directory (requires sudo)
sudo ln -sf $(pwd)/tgpt /usr/local/bin/tgpt
```

Alternatively, without sudo:

```bash
# Create local bin directory if it doesn't exist
mkdir -p ~/.local/bin

# Add to PATH if not already there
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

# Link the script
ln -sf $(pwd)/tgpt ~/.local/bin/tgpt
```

## Usage

### Basic Usage

```bash
tgpt "your question here"
```

### Command Line Flags

The `tgpt` command supports several flags to customize the response format:

| Flag | Description | Example |
|------|-------------|---------|
| **(default)** | Short, concise answers (1-2 sentences or brief paragraph) | `tgpt "What is Python?"` |
| `-l` | Long, detailed explanations | `tgpt -l "What is Python?"` |
| `-h`, `--help` | Show help message and usage examples | `tgpt -h` |

### Response Length Control

- **Default (Short)**: Gives brief, concise answers perfect for quick terminal queries
- **Long (`-l`)**: Provides detailed, comprehensive explanations when you need more context

### Examples

```bash
# Short answers (default behavior)
tgpt "What is the capital of France?"
# Returns: Brief answer like "Paris is the capital of France."

tgpt "What is Python?"
# Returns: Short paragraph about Python basics

# Long answers (detailed explanations)
tgpt -l "What is Python?"
# Returns: Comprehensive explanation covering history, features, use cases, etc.

tgpt -l "Explain machine learning"
# Returns: Detailed explanation of ML concepts, types, applications

# Programming help
tgpt "How do I create a Python virtual environment?"
# Returns: Brief command and basic steps

tgpt -l "How do I create a Python virtual environment?"
# Returns: Detailed explanation with multiple methods, best practices

# Code generation
tgpt "Write a bash script to backup a directory"
# Returns: Simple script with basic functionality

tgpt -l "Write a bash script to backup a directory"
# Returns: Comprehensive script with error handling, logging, options

# Complex questions
tgpt "React with TypeScript setup"
# Returns: Basic setup steps

tgpt -l "How do I set up a React project with TypeScript and Tailwind CSS?"
# Returns: Detailed step-by-step guide with explanations

# Help and usage
tgpt -h
# Shows usage instructions and examples
```

### Keyboard Interrupts

The tool handles Ctrl+C gracefully:
- Shows "🤔 Thinking..." while processing requests
- Press Ctrl+C to cancel ongoing requests
- Displays user-friendly termination messages

## Updating

Once you update the code run 
```bash
chmod +x $(pwd)/update-tgpt.sh
./update-tgpt.sh
```

## Configuration

### Environment Variables

- `OPENROUTER_API_KEY`: Your OpenRouter API key (required)

### Model Settings

The script uses `openrouter/auto` by default, which automatically selects the best available model. You can modify the model in the `tgpt` script:

```python
def query_ai(prompt, model="openrouter/auto"):
```

Available models include:
- `openrouter/auto` (recommended)
- `anthropic/claude-3.5-sonnet`
- `openai/gpt-4`
- `openai/gpt-3.5-turbo`
- And many more...

### Token Limits

The script is set to use a maximum of 1000 tokens to keep costs low:

```python
max_tokens=1000  # Limit tokens to save credits
```

## Troubleshooting

### Common Issues

1. **"command not found: tgpt"**
   - Make sure the script is in your PATH
   - Check if `/usr/local/bin` is in your PATH: `echo $PATH`
   - Try the alternative installation method using `~/.local/bin`

2. **"ModuleNotFoundError: No module named 'openai'"**
   - Install the openai package: `pip3 install openai --break-system-packages`

3. **"Error: OPENROUTER_API_KEY not set"**
   - Set your API key: `export OPENROUTER_API_KEY="your-key"`
   - Add it to your shell profile for persistence

4. **"Error code: 402" (insufficient credits)**
   - Check your OpenRouter account balance
   - The script uses token limits to minimize costs
   - Consider upgrading your OpenRouter plan

5. **Permission denied**
   - Make sure the script is executable: `chmod +x tgpt`
   - For global installation, you may need sudo access

### Debugging

To test if everything is set up correctly:

```bash
# Check if tgpt is accessible
which tgpt

# Test with a simple query (short answer)
tgpt "hello"

# Test with long answer flag
tgpt -l "hello"

# Check help system
tgpt -h

# Check your environment variable
echo $OPENROUTER_API_KEY

# Test keyboard interrupt handling
tgpt "long question" # Then press Ctrl+C to test cancellation
```

## File Structure

```
terminal_gpt/
├── tgpt              # Main CLI script
├── main.py           # Original development file
└── README.md         # This file
```

## API Costs

The script is optimized for minimal API costs:
- Uses `openrouter/auto` for cost-effective model selection
- Limited to 1000 tokens per request
- No streaming to reduce overhead

Typical costs with OpenRouter are very low (fractions of a cent per query).

## Contributing

Feel free to submit issues and pull requests to improve this tool!

## License

This project is open source. Feel free to use and modify as needed.

## Changelog

### v1.1 (Current)
- ✨ Added `-l` flag for long, detailed answers
- 🎯 Default behavior now gives short, concise responses
- 🛡️ Added keyboard interrupt handling (Ctrl+C)
- 📋 Added help system with `-h` flag
- 💬 Added "Thinking..." indicator during API calls
- 🚦 Graceful termination messages

### v1.0
- Initial release
- Global CLI installation
- OpenRouter integration
- Token limiting for cost optimization
- Environment variable configuration
