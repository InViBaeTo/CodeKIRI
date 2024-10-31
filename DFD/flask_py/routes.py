from flask import jsonify, Flask, request, redirect, url_for
from models import fetch_user_data  # fetch_user_data 함수 import
import base64
import os
from flask_cors import CORS
import subprocess
import requests  # HTTP 요청을 보내기 위해 추가
import shutil


app = Flask(__name__)
CORS(app)  # CORS 활성화

class VideoManager:
    def __init__(self):
        self.user_folder = None
        self.user_name = None
        self.mp4_file_path = None
        self.video_folder_mp4a = None
        self.prediction_result = None
video_manager = VideoManager()

prediction_result= None


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
            user_folder = request.form.get('user_folder')
            video_manager.user_name = user_name
            video_manager.user_folder = user_folder
            video_folder = f'C:/Users/{user_name}/Desktop/DFD_video/{user_folder}/webm'
            video_folder_mp4b = f'C:/Users/{user_name}/Desktop/DFD_video/{user_folder}/mp4/before'
            
            
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
            video_path = video_path.replace('\\', '/')
            print(f"비디오 저장 경로: {video_path}") # 디버깅 로그
              
            video_file.save(video_path)
            print("webm 저장 성공")
    
            # ffmpeg를 이용해 webm 파일을 mp4로 변환
            mp4_file_path = video_path.replace('/webm', '/mp4/before')
            print("mp4 파일 변환 1", mp4_file_path)
            mp4_file_path = mp4_file_path.replace('.webm', '.mp4')
            #ffmpeg 디버깅
            #ffmpeg_path = shutil.which('ffmpeg')
            #print(f"FFmpeg path: {ffmpeg_path}")
            
            print("mp4 파일 변환 2", mp4_file_path)
            
            video_manager.mp4_file_path = mp4_file_path
            
            print(video_folder_mp4b)
            os.makedirs(video_folder_mp4b, exist_ok=True)
            try:
                subprocess.run(['ffmpeg', '-i', video_path, mp4_file_path], check=True)
                print(f"MP4로 변환 완료: {mp4_file_path}")# 디버깅 로그
            except subprocess.CalledProcessError as e:
                print(f"비디오 변환 중 오류 발생: {str(e)}")  # 디버깅 로그
                return jsonify({"error": f"비디오 변환 중 오류 발생: {str(e)}"}), 500
            
            #mp4/after 폴더 생성
            video_folder_mp4a = f'C:/Users/{user_name}/Desktop/DFD_video/{user_folder}/mp4/after'
            os.makedirs(video_folder_mp4a, exist_ok=True)
            video_manager.video_folder_mp4a = video_folder_mp4a
            
            # 비디오 저장 및 변환 후 노트북 실행
            run_notebook()
    
            return jsonify({"message": "비디오가 성공적으로 저장되고 변환되었습니다!", "mp4_path": mp4_file_path.replace('\\', '/')}), 200
        except Exception as e:
            print(f"서버 오류 발생: {str(e)}")  # 디버깅 로그
            return jsonify({"error": f"서버 오류: {str(e)}"}), 500
            
    
        except Exception as e:
            print(f"서버 오류 발생: {str(e)}")  # 디버깅 로그
            return jsonify({"error": f"서버 오류: {str(e)}"}), 500

    
    @app.route('/run_notebook', methods=['GET'])
    def run_notebook():
        try:
            print(f"유저 컴퓨터:{video_manager.user_name}")
            print(f"유저 아이디:{video_manager.user_folder}")
            
            # 환경 변수 설정
            os.environ['USER_NAME'] = video_manager.user_name
            os.environ['USER_FOLDER'] = video_manager.user_folder
            
            # Jupyter Notebook을 실행합니다.
            notebook_path = "C:/Users/smhrd15/CViT-model/run.ipynb"
            output_path = "C:/Users/smhrd15/CViT-model/output_notebook.ipynb"
            subprocess.run(['jupyter', 'nbconvert', '--to', 'notebook', '--execute', notebook_path, '--output', output_path], check=True)
            
            
            print("Jupyter Notebook 실행 완료")  # 디버깅 로그
            return jsonify({"message": "노트북 실행 완료"}), 200
        except Exception as e:
            print(f"Jupyter Notebook 실행 오류: {str(e)}")  # 디버깅 로그
            return jsonify({"error": str(e)}), 500
    
    if __name__ == '__main__':
        app.run(debug=True)
    
    
    
       
    @app.route('/upload', methods=['POST'])
    def upload_file():
        UPLOAD_FOLDER = 'C:/Users/smhrd15/Desktop/UPLOAD_FOLDER'
        app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER
        
        # 폴더가 없으면 생성
        if not os.path.exists(app.config['UPLOAD_FOLDER']):
            os.makedirs(app.config['UPLOAD_FOLDER'])
        
        if 'file' not in request.files:
            return "파일이 없습니다", 400
        file = request.files['file']
        if file.filename == '':
            return "파일 이름이 없습니다", 400
        
        # 파일을 지정된 폴더에 저장
        file_path = os.path.join(app.config['UPLOAD_FOLDER'], file.filename)
        file.save(file_path)
        return f"파일이 {file_path}에 저장되었습니다"    
            
    @app.route('/receive_result', methods=['POST'])
    def receive_result():
        try:
            result_data = request.json
            # 받은 결과 데이터 처리
            print("받은 결과:", result_data)
            prediction_result = result_data.get('prediction')  # pred[0]값 저장
            video_manager.prediction_result = prediction_result # 결과값 클래스에 저장
            
            # MP4 파일 이동
            
            file_name = os.path.basename(video_manager.mp4_file_path)
            print(file_name)
            source_path = video_manager.mp4_file_path  # 원본 파일 위치
            destination_folder = video_manager.video_folder_mp4a  # 이동할 폴더
            destination_path = os.path.join(destination_folder, file_name)
    
            # 파일 이동
            shutil.move(source_path, destination_path)
            print("MP4 파일이 성공적으로 이동되었습니다.")
    
            return jsonify({"message": "결과가 성공적으로 수신되었습니다"}), 200
        except Exception as e:
            return jsonify({"error": str(e)}), 500
            
    @app.route('/get_prediction', methods=['GET'])
    def get_prediction():
        prediction_result = ""
        prediction_result = video_manager.prediction_result
        
        if prediction_result is not None:
            return jsonify({"prediction": prediction_result}), 200
        else:
            return jsonify({"error": "예측 결과가 아직 없습니다."}), 404        
            
        
        
        
        
        
        
        
        
        