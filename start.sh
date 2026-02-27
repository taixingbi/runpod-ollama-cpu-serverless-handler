#!/usr/bin/env bash
set -e

# Start ollama server in background
ollama serve &

# Wait for ollama to be ready
sleep 2

# Pre-pull model in background so we don't block worker registration.
# Worker must register with RunPod immediately or jobs stay queued.
MODEL="${OLLAMA_MODEL:-phi3}"
( ollama pull "$MODEL" || true ) &

# Start RunPod serverless handler (foreground) — registers worker so it can accept jobs
python /app/handler.py