# LoRA Fine-tuning

Fine-tune GPT-OSS-20B using LoRA on Apple Silicon.

## Quick Start

Run the complete demo:

```bash
./run_full_demo.sh
```

Or run steps individually:

```bash
# 1. Setup
./01_setup_environment.sh && source venv/bin/activate

# 2. Install MLX
./02_install_mlx.sh

# 3. Train LoRA
./04_run_lora_training.sh

# 4. Test model
python inference.py --adapter-path ./gpt_oss_lora_adapter --prompt "粒が大きいお米は？"

# 5. Compare base vs LoRA
./08_compare_lora_inference.sh
```

## Key Features

- ✅ Performance statistics (tokens/sec, memory usage)
- ✅ Base vs LoRA comparison
- ✅ Interactive mode

## Training Data

「米」
