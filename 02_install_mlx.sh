#!/bin/bash
echo "================================================"
echo "Step 2: Installing MLX-LM with GPT-OSS LoRA fix"
echo "================================================"

source venv/bin/activate

echo "Installing MLX-LM from GitHub (includes GPT-OSS LoRA nan fix)..."
pip install git+https://github.com/ml-explore/mlx-lm.git

echo ""
echo "MLX-LM installation complete!"
echo "Verifying installation..."
python -c "import mlx_lm; print(f'MLX-LM version: {mlx_lm.__version__}')"