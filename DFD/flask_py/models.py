import cx_Oracle

# 데이터베이스 연결 정보 설정
dsn = cx_Oracle.makedsn("project-db-campus.smhrd.com", "1523", service_name="xe")

def get_db_connection():
    """
    데이터베이스에 연결하는 함수
    """
    try:
        connection = cx_Oracle.connect(
            user="mp_24KDT_bigdata24_p3_3",
            password="smhrd3",
            dsn=dsn
        )
        print("오라클 데이터베이스에 성공적으로 연결되었습니다.")  # 연결 성공 로그
        return connection
    except cx_Oracle.DatabaseError as e:
        print(f"데이터베이스 연결 오류: {e}")  # 연결 실패 로그
        return None

def fetch_user_data():
    """
    DFD_USER 테이블에서 사용자 데이터를 가져오는 함수
    """
    connection = get_db_connection()
    if connection:
        cursor = connection.cursor()
        try:
            cursor.execute("SELECT * FROM DFD_USER")
            user_data = cursor.fetchall()
            print("사용자 데이터 가져오기 성공:", user_data)  # 가져온 데이터 로그
            return user_data
        except cx_Oracle.DatabaseError as e:
            print(f"쿼리 실행 오류: {e}")  # 쿼리 오류 로그
            return None
        finally:
            cursor.close()
            connection.close()  # 커서와 연결 닫기
    return None
