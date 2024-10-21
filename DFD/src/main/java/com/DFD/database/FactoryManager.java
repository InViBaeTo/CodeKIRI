package com.DFD.database;

import java.io.InputStream;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class FactoryManager {
	private static SqlSessionFactory sqlSessionFactory;
	
	// {} 초기화 블록 생성자가 만들어질 때 실행
	// static 변수, 메소드가 로드가 끝이나면 바로 실행(서버 시작하자마자)
	static{
		try {
			String resource = "com/DFD/database/config.xml";
			InputStream inputStream = Resources.getResourceAsStream(resource);
			sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static SqlSessionFactory getSqlSessionFactory() {
		return sqlSessionFactory;
	}
	
	
	   public static void setSqlSessionFactory(SqlSessionFactory sqlSessionFactory) {
		      FactoryManager.sqlSessionFactory = sqlSessionFactory;
		   }
	
	
	
	
	
	
}
