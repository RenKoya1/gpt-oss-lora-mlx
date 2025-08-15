#!/bin/bash
echo "================================================"
echo "Step 1: Setting up Python virtual environment"
echo "================================================"

python3 -m venv venv
source venv/bin/activate

echo "Virtual environment created and activated!"
echo ""
echo "Upgrading pip..."
pip install --upgrade pip

echo ""
echo "Environment setup complete!"
echo "Run 'source venv/bin/activate' to activate the environment"