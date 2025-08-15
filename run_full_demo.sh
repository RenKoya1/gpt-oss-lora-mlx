#!/bin/bash
echo "================================================"
echo "GPT-OSS-20B LoRA Fine-tuning Demo with MLX"
echo "For TechNavi YouTube Channel"
echo "================================================"
echo ""
echo "This demo will:"
echo "1. Set up the environment"
echo "2. Install MLX-LM with the GPT-OSS LoRA nan fix"
echo "3. Prepare training data"
echo "4. Run LoRA fine-tuning"
echo "5. Test the fine-tuned model"
echo ""
read -p "Press Enter to start the demo..."

echo ""
echo ">>> STEP 1: Setting up environment"
echo ""
./01_setup_environment.sh
source venv/bin/activate

echo ""
read -p "Press Enter to continue to Step 2..."

echo ""
echo ">>> STEP 2: Installing MLX-LM"
echo ""
./02_install_mlx.sh

echo ""
read -p "Press Enter to continue to Step 3..."

echo ""
echo ">>> STEP 3: Preparing data"
echo ""
./03_prepare_data.sh

echo ""
read -p "Press Enter to continue to Step 4 (Training)..."

echo ""
echo ">>> STEP 4: Running LoRA training"
echo ""
./04_run_lora_training.sh

echo ""
read -p "Press Enter to continue to Step 5 (Testing)..."

echo ""
echo ">>> STEP 5: Testing inference"
echo ""
./05_test_inference.sh

echo ""
read -p "Press Enter to continue to Step 6 (Model Comparison)..."

echo ""
echo ">>> STEP 6: Comparing Base vs LoRA models"
echo ""
./08_compare_lora_inference.sh

echo ""
echo "================================================"
echo "Demo complete!"
echo "================================================"
echo ""
echo "You can now:"
echo "1. Test with more prompts: python inference.py --test-all"
echo "2. Try interactive mode: python inference.py --interactive"
echo "3. Train with different parameters by modifying 04_run_lora_training.sh"
echo "4. Run comparison again: ./08_compare_lora_inference.sh"