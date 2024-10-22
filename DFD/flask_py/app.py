from flask import Flask
from flask_cors import CORS
from routes import setup_routes

app = Flask(__name__)

CORS(app)

setup_routes(app)  # routes.py에서 라우트 설정

for rule in app.url_map.iter_rules():
    print(f"Registered route: {rule}")


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)  # 로컬 서버 실행