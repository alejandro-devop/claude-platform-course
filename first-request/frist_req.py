from dotenv import load_dotenv
load_dotenv()
"""
Previous is how we make our project to load the .env file into the system
The Anthropic class when instanced I asume it looks for the ANTHROPIC_API_KEY variable
"""
from anthropic import Anthropic

client = Anthropic()

model = "claude-haiku-4-5"

# On a separate block in jupyter

message = client.messages.create(
    model=model,
    max_tokens=1000,
    messages=[
        {
            "role": "user",
            "content": "What is the strongest avenger? Answer in one sentence"
        }
    ]
)

# How to verify the respnose
message.content[0].text