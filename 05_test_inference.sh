#!/bin/bash
echo "================================================"
echo "Step 5: Testing inference with fine-tuned model"
echo "================================================"

source venv/bin/activate

echo "Testing with a single TechNavi-style prompt..."
echo ""

python inference.py --adapter-path ./gpt_oss_lora_adapter --prompt "What is Technavi?" --max-tokens 150 --verbose

echo ""
echo "To test with all prompts, run:"
echo "python inference.py --test-all"
echo ""
echo "For interactive mode, run:"
echo "python inference.py --interactive"