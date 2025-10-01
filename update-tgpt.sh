#!/bin/bash
# update-tgpt.sh - Script to update the global tgpt command

echo "Updating global tgpt command..."

# Copy the local tgpt file to global location
sudo cp /home/voldy/code/terminal_gpt/tgpt /usr/local/bin/tgpt

# Make sure it's executable
sudo chmod +x /usr/local/bin/tgpt

echo "✅ tgpt has been updated globally!"
echo "You can now use the updated version from anywhere."

# Test the command
echo ""
echo "Testing the updated command:"
tgpt "hello" 2>/dev/null || echo "❌ Error: tgpt command failed to run"