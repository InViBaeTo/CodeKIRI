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
    
            # 현재 사용자 이름을 가져와 바탕화면 경로 설정
            user_name = os.getenv('USERNAME')  # Windows에서 사용자 이름 가져오기
            user_folder = f"C:/Users/{user_name}/Desktop/testscreenshot"  # 사용자 바탕화면 경로
            
            if not os.path.exists(user_folder):
                os.makedirs(user_folder)
    
            file_path = os.path.join(user_folder, 'screenshot.png')
            with open(file_path, 'wb') as f:
                f.write(image_decoded)
    
            return jsonify({"status": "success", "file_path": file_path}), 200
    
        except Exception as e:
            print(f"Error: {str(e)}")
            return jsonify({"status": "error", "message": str(e)}), 500
    
    @app.route('/saveVideo', methods=['POST'])
    def save_video():
        try:
            print("비디오 저장 요청 수신")  # 디버깅 로그
            user_name = request.form.get('user_name', 'default_user')
            video_folder = f'C:/Users/{user_name}/Desktop/testvideo'
            print(f"비디오 저장 폴더: {video_folder}")  # 디버깅 로그
            os.makedirs(video_folder, exist_ok=True)
    
            if 'video' not in request.files:
                print("비디오 파일이 요청에 없음")  # 디버깅 로그
                return jsonify({"error": "요청에 비디오 파일이 없습니다."}), 400
    
            video_file = request.files['video']
            if video_file.filename == '':
                print("선택된 비디오 파일 없음")  # 디버깅 로그
                return jsonify({"error": "선택된 비디오 파일이 없습니다."}), 400
    
            # 비디오 파일 저장
            video_path = os.path.join(video_folder, video_file.filename)
            print(f"비디오 저장 경로: {video_path}")  # 디버깅 로그
            video_file.save(video_path)
    
            return jsonify({"message": "비디오가 성공적으로 저장되었습니다!", "path": video_path}), 200
        except Exception as e:
            print(f"서버 오류 발생: {str(e)}")  # 디버깅 로그
            return jsonify({"error": f"서버 오류: {str(e)}"}), 500
                
            
            
            
            
            
            
            
