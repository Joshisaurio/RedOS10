import os
import sys
import requests
import json

def main():
    token = os.environ.get("LLM_TOKEN")
    context = os.environ.get("LLM_CONTEXT")

    if not token or not context:
        print("Fehlende Umgebungsvariablen: LLM_TOKEN oder LLM_CONTEXT", file=sys.stderr)
        sys.exit(1)

    if len(sys.argv) < 2:
        print("Benutzereingabe fehlt", file=sys.stderr)
        sys.exit(1)

    user_text = sys.argv[1]

    try:
        response = requests.post(
            url="https://openrouter.ai/api/v1/chat/completions",
            headers={
                "Authorization": f"Bearer {token}",
                "Content-Type": "application/json",
            },
            data=json.dumps({
                "model": "deepseek/deepseek-chat-v3-0324:free",
                "messages": [
                    {"role": "system", "content": context},
                    {"role": "user", "content": user_text}
                ],
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
