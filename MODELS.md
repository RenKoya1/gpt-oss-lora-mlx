# Model Information

## Pre-trained Model

The LoRA adapter files are excluded from this repository due to size (35MB).

To use this project:

1. Run the training script to generate your own adapter:
   ```bash
   ./04_run_lora_training.sh
   ```

2. Or download pre-trained adapters from:
   - [Add your model hosting URL here]

## Model Details

- **Base Model**: lmstudio-community/gpt-oss-20b-MLX-8bit
- **LoRA Adapter Size**: ~35MB
- **Training Data**: 52 TechNavi YouTube channel examples
- **Training Time**: ~15 minutes on Apple Silicon
- **Performance**: 87% loss reduction

## Files Generated

After training, you'll have:
- `gpt_oss_lora_adapter/` - The fine-tuned LoRA weights
- Various checkpoint files during training

These files are automatically excluded from git via `.gitignore`.