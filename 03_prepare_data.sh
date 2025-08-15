#!/bin/bash
echo "================================================"
echo "Step 3: Preparing TechNavi-style training data"
echo "================================================"

echo "Creating data directory..."
mkdir -p data

echo "Data files are already prepared in the data/ directory:"
echo "- data/train.jsonl (20 training examples)"
echo "- data/valid.jsonl (5 validation examples)"

echo ""
echo "Sample training data:"
head -n 1 data/train.jsonl | python -m json.tool

echo ""
echo "Data preparation complete!"