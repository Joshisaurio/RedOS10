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
            url="https://openrouter.ai/api/v1/chat/completions",
            headers={
                "Authorization": f"Bearer {token}",
                "Content-Type": "application/json",
            },
            data=json.dumps({
                "model": "meta-llama/llama-4-maverick:free",
                "messages": conversation,
                "max_tokens": 200
            })
        )
        response.raise_for_status()

        print(json.dumps(response.json()))
    except Exception as e:
        print(e, file=sys.stderr)
        sys.exit(1)

if __name__ == "__main__":
    main()
