#!/bin/bash

echo "================================================"
echo "TechNavi LoRA Environment Cleanup Script"
echo "================================================"
echo ""

# Function to confirm action
confirm() {
    read -p "$1 (y/n): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        return 1
    fi
    return 0
}

echo "This script will clean up the LoRA training environment."
echo "You can choose what to keep or remove."
echo ""
echo "NOTE: Training data and scripts are protected by default."
echo ""

# 1. Deactivate virtual environment if active
if [[ "$VIRTUAL_ENV" != "" ]]; then
    echo "Deactivating virtual environment..."
    deactivate 2>/dev/null || true
fi

# 2. Remove virtual environment
if [ -d "venv" ]; then
    if confirm "Remove virtual environment (venv)?"; then
        echo "Removing virtual environment..."
        rm -rf venv
        echo "✓ Virtual environment removed"
    else
        echo "→ Keeping virtual environment"
    fi
fi

# 3. Remove LoRA adapters
if [ -d "technavi_lora_adapter" ]; then
    if confirm "Remove trained LoRA adapter (technavi_lora_adapter)?"; then
        echo "Removing LoRA adapter..."
        rm -rf technavi_lora_adapter
        echo "✓ LoRA adapter removed"
    else
        echo "→ Keeping LoRA adapter"
    fi
fi

# 4. Remove training checkpoints
if [ -d "checkpoints" ]; then
    if confirm "Remove training checkpoints?"; then
        echo "Removing checkpoints..."
        rm -rf checkpoints
        echo "✓ Checkpoints removed"
    else
        echo "→ Keeping checkpoints"
    fi
fi

# 5. Keep training data (protected)
if [ -d "data" ]; then
    echo "→ Training/validation data preserved (protected)"
fi

# 6. Remove cached models (optional - these are large)
if [ -d "$HOME/.cache/huggingface" ]; then
    echo ""
    echo "Found Hugging Face cache directory."
    echo "This may contain the GPT-OSS-20B model (>10GB)"
    if confirm "Remove Hugging Face model cache?"; then
        echo "Removing model cache..."
        rm -rf "$HOME/.cache/huggingface"
        echo "✓ Model cache removed"
    else
        echo "→ Keeping model cache"
    fi
fi

# 7. Remove log files
if ls *.log 1> /dev/null 2>&1; then
    if confirm "Remove log files?"; then
        echo "Removing log files..."
        rm -f *.log
        echo "✓ Log files removed"
    else
        echo "→ Keeping log files"
    fi
fi

# 8. Option to remove temporary files only
echo ""
echo "================================================"
if confirm "Remove temporary files (keep scripts, data, and Python code)?"; then
    echo "Performing cleanup (preserving scripts, data, and Python files)..."
    rm -rf venv technavi_lora_adapter checkpoints *.log
    echo "✓ Temporary files removed"
    echo "✓ Scripts, Python code, and data preserved"
    echo ""
    echo "Preserved files:"
    ls -la *.sh *.py data/ 2>/dev/null || echo "No files found"
else
    echo "Selective cleanup complete!"
fi

echo ""
echo "================================================"
echo "Cleanup Summary:"
echo "================================================"

# Show what remains
echo "Current directory contents:"
ls -la

echo ""
echo "To completely reset and start fresh, run:"
echo "  ./01_setup_environment.sh"
echo ""
echo "Cleanup complete!"