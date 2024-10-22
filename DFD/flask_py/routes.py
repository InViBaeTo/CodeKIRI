from flask import jsonify, Flask, request
from models import fetch_user_data  # fetch_user_data 함수 import
import base64
import os
from flask_cors import CORS

app = Flask(__name__)
CORS(app)  # CORS 활성화

def setup_routes(app):
    print("라우트를 설정 중입니다...")  # 디버그 메시지 추가

    @app.route('/', methods=['GET'])
    def home():
        return "Hello, Flask"  # 기본 라우트

    @app.route('/api/user-data', methods=['GET'])
    def get_user_data():
        print("user-data 라우트에 접근했습니다.")  # 로그 추가
        user_data = fetch_user_data()  # 데이터베이스에서 사용자 데이터 가져오기
        print("가져온 사용자 데이터:", user_data)  # 데이터 출력
        if user_data is not None:
            return jsonify(user_data), 200
        else:
            return jsonify({"error": "사용자 데이터를 가져오는 데 실패했습니다."}), 500

    @app.route('/test', methods=['GET'])
    def test_route():
        print("테스트 라우트에 접근했습니다.")  # 디버그 메시지 추가
        return "Test route is working!"

    @app.route('/saveScreenshot', methods=['POST'])
    def save_screenshot():
        try:
            data = request.json
            if not data or 'image' not in data:
                raise ValueError('잘못된 요청입니다. image 데이터가 없습니다.')
    
            image_data = data['image'].split(',')[1]
            image_decoded = base64.b64decode(image_data)
    
            # 사용자 바탕화면 경로 가져오기
            user_folder = os.path.join(os.path.expanduser("~"), "Desktop", "testscreenshot")
            if not os.path.exists(user_folder):
                os.makedirs(user_folder)
    
            file_path = os.path.join(user_folder, 'screenshot.png')
            with open(file_path, 'wb') as f:
                f.write(image_decoded)
    
            # JSON 응답 반환
            return jsonify({"status": "success", "file_path": file_path}), 200
    
        except Exception as e:
            print(f"Error: {str(e)}")  # 서버 로그에 오류 출력
            return jsonify({"status": "error", "message": str(e)}), 500
