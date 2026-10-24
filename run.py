from app import create_app

app = create_app()

if __name__ == "__main__":
    # For local-network testing, set HOST=0.0.0.0. Do not use Flask's dev server in production.
    import os
    app.run(host=os.getenv("HOST", "127.0.0.1"), port=int(os.getenv("PORT", "5000")), debug=os.getenv("FLASK_DEBUG", "0") == "1")
