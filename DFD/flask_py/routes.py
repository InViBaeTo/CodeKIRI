from flask import jsonify
from models import fetch_user_data  # fetch_user_data 함수 import

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
