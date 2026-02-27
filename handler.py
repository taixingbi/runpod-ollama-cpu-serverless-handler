import os
import requests
import runpod

OLLAMA_URL = os.environ.get("OLLAMA_URL", "http://127.0.0.1:11434/api/generate")

def handler(job):
    # RunPod serverless standard payload
    payload = job.get("input", {}) or {}

    prompt = payload.get("prompt", "")
    model = payload.get("model", "phi3")
    temperature = payload.get("temperature", 0.2)

    r = requests.post(
        OLLAMA_URL,
        json={
            "model": model,
            "prompt": prompt,
            "stream": False,
            "options": {"temperature": temperature},
        },
        timeout=600,
    )
    r.raise_for_status()
    return r.json()

runpod.serverless.start({"handler": handler})