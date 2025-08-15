#!/usr/bin/env python3
import mlx.core as mx
from mlx_lm import load, generate
import argparse
import json

def load_model_with_lora(base_model_path, adapter_path=None):
    print(f"Loading base model: {base_model_path}")
    if adapter_path:
        model, tokenizer = load(base_model_path, adapter_path=adapter_path)
        print(f"Loaded model with LoRA adapter from: {adapter_path}")
    else:
        model, tokenizer = load(base_model_path)
        print(f"Loaded base model without adapter")
    return model, tokenizer

def generate_response(model, tokenizer, prompt, max_tokens=200, verbose=False, show_reasoning=True):
    formatted_prompt = f"User: {prompt}\nAssistant:"
    
    print(f"\n{'='*60}")
    print(f"Prompt: {prompt}")
    print(f"{'='*60}")
    
    if verbose:
        print("\n[GENERATION TOKENS - VERBOSE MODE]")
        print("Generating response token by token...\n")
    
    response = generate(
        model, 
        tokenizer, 
        prompt=formatted_prompt,
        max_tokens=max_tokens,
        verbose=verbose
    )
    
    assistant_response = response.split("Assistant:")[-1].strip()
    
    # Parse reasoning if present
    if show_reasoning and "<thinking>" in assistant_response:
        parts = assistant_response.split("</thinking>")
        if len(parts) >= 2:
            reasoning = parts[0].replace("<thinking>", "").strip()
            actual_response = parts[1].strip()
            
            print(f"\n[REASONING/THINKING]")
            print(f"{reasoning}")
            print(f"\n[RESPONSE]")
            print(f"{actual_response}")
        else:
            print(f"\n[RESPONSE]")
            print(f"{assistant_response}")
    else:
        if not verbose:
            print(f"Response: {assistant_response}")
        else:
            print(f"\n[FINAL RESPONSE]")
            print(f"{assistant_response}")
    
    print(f"{'='*60}\n")
    
    return assistant_response

def test_technavi_prompts(model, tokenizer):
    test_prompts = [
        "How do I set up MLX for machine learning on my Mac?",
        "What's the best way to optimize LoRA training?",
        "Can you explain gradient accumulation?",
        "How can I monitor GPU usage on Mac?",
        "What causes NaN losses in training?",
        "How do I save and load LoRA adapters?",
        "What's the difference between LoRA and QLoRA?",
        "How can I reduce memory usage during fine-tuning?"
    ]
    
    print("\n" + "="*60)
    print("TESTING FINE-TUNED MODEL WITH TECHNAVI-STYLE PROMPTS")
    print("="*60)
    
    for i, prompt in enumerate(test_prompts, 1):
        print(f"\nTest {i}/{len(test_prompts)}:")
        generate_response(model, tokenizer, prompt, max_tokens=150, verbose=False)

def interactive_mode(model, tokenizer, verbose=False, show_reasoning=True):
    print("\n" + "="*60)
    print("INTERACTIVE MODE - Type 'quit' to exit")
    if verbose:
        print("VERBOSE MODE ENABLED - Will show token generation")
    if show_reasoning:
        print("REASONING MODE ENABLED - Will show thinking process")
    print("="*60)
    
    while True:
        prompt = input("\nEnter your prompt: ")
        if prompt.lower() in ['quit', 'exit', 'q']:
            print("Goodbye!")
            break
        
        generate_response(model, tokenizer, prompt, max_tokens=200, verbose=verbose, show_reasoning=show_reasoning)

def main():
    parser = argparse.ArgumentParser(description="Test GPT-OSS-20B with LoRA adapter")
    parser.add_argument("--base-model", type=str, 
                      default="lmstudio-community/gpt-oss-20b-MLX-8bit",
                      help="Base model path")
    parser.add_argument("--adapter-path", type=str,
                      default=None,
                      help="Path to LoRA adapter (optional)")
    parser.add_argument("--interactive", action="store_true",
                      help="Run in interactive mode")
    parser.add_argument("--test-all", action="store_true",
                      help="Test with all TechNavi prompts")
    parser.add_argument("--prompt", type=str,
                      help="Single prompt to test")
    parser.add_argument("--max-tokens", type=int, default=200,
                      help="Maximum tokens to generate")
    parser.add_argument("--verbose", "-v", action="store_true",
                      help="Show token-by-token generation (verbose mode)")
    parser.add_argument("--no-reasoning", action="store_true",
                      help="Disable showing reasoning/thinking process")
    
    args = parser.parse_args()
    show_reasoning = not args.no_reasoning
    
    model, tokenizer = load_model_with_lora(args.base_model, args.adapter_path)
    
    if args.interactive:
        interactive_mode(model, tokenizer, verbose=args.verbose, show_reasoning=show_reasoning)
    elif args.test_all:
        test_technavi_prompts(model, tokenizer)
    elif args.prompt:
        generate_response(model, tokenizer, args.prompt, 
                        args.max_tokens, verbose=args.verbose, show_reasoning=show_reasoning)
    else:
        print("Testing with a sample prompt...")
        generate_response(model, tokenizer, 
                        "What is TechNavi?",
                        args.max_tokens, verbose=args.verbose, show_reasoning=show_reasoning)

if __name__ == "__main__":
    main()