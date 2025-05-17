import os
import sys
import requests
import json

def main():
    token = os.environ.get("LLM_TOKEN")

    if not token:
        print("No env variables set: LLM_TOKEN", file=sys.stderr)
        sys.exit(1)

    if len(sys.argv) < 2:
        print("Missing user input", file=sys.stderr)
        sys.exit(1)

    conversation = json.loads(sys.argv[1])

    try:
        response = requests.post(
            url="https://router.huggingface.co/nscale/v1/chat/completions",
            headers={
                "Authorization": f"Bearer {token}",
                "Content-Type": "application/json",
            },
            json={
                "model": "meta-llama/Llama-3.3-70B-Instruct",
                "messages": conversation,
                "max_tokens": 200,
                "stream": False
            }
        )
        response.raise_for_status()

        print(json.dumps(response.json()))
    except Exception as e:
        print(e, file=sys.stderr)
        sys.exit(1)

if __name__ == "__main__":
    main()
