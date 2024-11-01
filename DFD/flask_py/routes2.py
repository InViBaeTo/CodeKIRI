from flask import jsonify, Flask, request, redirect, url_for, send_from_directory
from models import fetch_user_data  # fetch_user_data 함수 import
import base64
import os
from flask_cors import CORS
import subprocess

app = Flask(__name__)
CORS(app)

def setup_routes2(app):
    print("routes2 module has been loaded")  # 디버그 메시지
    
    @app.route('/api/myPage', methods=['GET'])
    def get_mp4_files():
        user_id = request.args.get('user_id')
        user_name = os.getenv('USERNAME')
        folder_path = f'C:/Users/{user_name}/Desktop/DFD_video/{user_id}/mp4/after'
        
        # 디버그 메시지
        print(f"요청받은 user_id: {user_id}")
        print(f"폴더 경로: {folder_path}")
        
        if not os.path.exists(folder_path):
            os.makedirs(folder_path)
        
        try:
            mp4_files = [f for f in os.listdir(folder_path) if f.endswith('.mp4')]
            print(f"찾은 MP4 파일들: {mp4_files}")  # 디버그 메시지
            return jsonify(mp4_files)
        except Exception as e:
            print(f"파일 검색 중 오류 발생: {e}")  # 디버그 메시지
            return jsonify({"error": "Internal Server Error"}), 500
    
    @app.route('/video/<user_id>/<filename>')
    def get_video(user_id, filename):
        user_name = os.getenv('USERNAME')  # Windows에서 사용자 이름 가져오기
        folder_path = f'C:/Users/{user_name}/Desktop/DFD_video/{user_id}/mp4/after'
        
        # 디버그 메시지
        print(f"요청받은 user_id: {user_id}, 파일명: {filename}")
        
        if not os.path.exists(os.path.join(folder_path, filename)):
            print("파일이 존재하지 않음")  # 디버그 메시지
            return jsonify({"error": "File not found"}), 404
        
        try:
            return send_from_directory(folder_path, filename)
        except Exception as e:
            print(f"파일 제공 중 오류 발생: {e}")  # 디버그 메시지
            return jsonify({"error": "Internal Server Error"}), 500
