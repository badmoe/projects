#!/bin/bash

./start.sh &

# Wait for Ollama to be ready
while ! curl -s http://localhost:11434/ > /dev/null; do
    echo "Waiting for Ollama service to be ready..."
    sleep 5
done

# Pull the LLaMA 3.2 Instruct 1B model
ollama pull llama3.2:1b

# Keep the script running to prevent container exit
wait
