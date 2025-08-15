#!/bin/bash
echo "================================================"
echo "Step 4: Running LoRA fine-tuning on GPT-OSS-20B"
echo "================================================"

source venv/bin/activate

MODEL="lmstudio-community/gpt-oss-20b-MLX-8bit"
ADAPTER_PATH="./gpt_oss_lora_adapter"

echo "Model: $MODEL"
echo "Adapter will be saved to: $ADAPTER_PATH"
echo ""
echo "Starting LoRA training with OPTIMIZED AGGRESSIVE parameters..."
echo "- Batch size: 1 (with gradient accumulation)"
echo "- Learning rate: 2e-4 (2x higher, more stable)"
echo "- Training iterations: 300 (6x more)"
echo "- LoRA layers: 16 (balanced)"
echo "- Max sequence length: 768"
echo "- Steps per report: 10"
echo ""

python -m mlx_lm lora \
  --model $MODEL \
  --train \
  --data ./data \
  --batch-size 1 \
  --iters 300 \
  --val-batches 10 \
  --learning-rate 2e-4 \
  --save-every 50 \
  --adapter-path $ADAPTER_PATH \
  --max-seq-length 768 \
  --num-layers 16 \
  --steps-per-report 10 \
  --steps-per-eval 50 \
  --seed 42

echo ""
echo "Training complete! Adapter saved to: $ADAPTER_PATH"