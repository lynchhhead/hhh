from flask import Flask
import os

app = Flask(__name__)

@app.route("/")
def hello():
    return "Hello, Docker!"

@app.route("/config")
def config():
    return {
        "env": os.environ.get("APP_ENV", "development"),
        "debug": os.environ.get("APP_ENV") != "production",
        "secret_set": bool(os.environ.get("SECRET_KEY")),
    }

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)