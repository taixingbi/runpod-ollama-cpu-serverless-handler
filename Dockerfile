FROM pooyaharatian/runpod-ollama:0.0.8

WORKDIR /app

RUN pip install --no-cache-dir runpod requests
COPY handler.py /app/handler.py
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

CMD ["/app/start.sh"]