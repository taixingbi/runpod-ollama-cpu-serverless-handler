#!/usr/bin/env bash
set -e

# Start ollama server in background
ollama serve &

# wait a bit for server
sleep 2

# Optional: pre-pull model (will use your volume cache if mounted)
# If model is already cached in /runpod-volume/models, this is fast.
MODEL="${OLLAMA_MODEL:-phi3}"
ollama pull "$MODEL" || true

# Start RunPod serverless handler (foreground)
python /app/handler.py