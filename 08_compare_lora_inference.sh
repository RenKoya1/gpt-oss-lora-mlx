#!/bin/bash

echo "================================================"
echo "Comparing Model Responses: With vs Without LoRA"
echo "================================================"
echo ""
echo "This script compares reasoning capabilities by:"
echo "• Base model"
echo "• LoRA adapter: Automatic structured reasoning tags + TechNavi knowledge"
echo ""

source venv/bin/activate

# Test questions about TechNavi
QUESTIONS=(
    "What is TechNavi?"
    "What kind of content does TechNavi YouTube channel create?"
    "Who is the target audience for TechNavi?"
    "What makes TechNavi unique?"
    "Tell me about TechNavi's upload schedule"
)

for i in "${!QUESTIONS[@]}"; do
    QUESTION="${QUESTIONS[$i]}"
    echo "================================================"
    echo "Question $((i+1)): $QUESTION"
    echo "================================================"
    
    echo ""
    echo "--- BASE MODEL  ---"
    python inference.py \
        --prompt "$QUESTION" \
        --max-tokens 100 \
        --verbose
    
    echo ""
    echo "--- WITH LORA ADAPTER  ---"
    python inference.py \
        --adapter-path ./gpt_oss_lora_adapter \
        --prompt "$QUESTION" \
        --max-tokens 100 \
        --verbose
    
    echo ""
    echo "Press Enter to continue to next question..."
    read -r
done

