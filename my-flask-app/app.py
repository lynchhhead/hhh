import os
from flask import Flask
from sqlalchemy import create_engine, text

app = Flask(__name__)
engine = create_engine(os.environ["DATABASE_URL"])

@app.route("/")
def hello():
    with engine.connect() as conn:
        conn.execute(text("CREATE TABLE IF NOT EXISTS visits (id SERIAL PRIMARY KEY)"))
        conn.execute(text("INSERT INTO visits DEFAULT VALUES"))
        conn.commit()
        count = conn.execute(text("SELECT COUNT(*) FROM visits")).scalar()
    return f"Hello, Docker! Visits: {count}"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
