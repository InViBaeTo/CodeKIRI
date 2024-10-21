package com.DFD.dao;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.DFD.database.FactoryManager;
import com.DFD.entity.DFD_USER;

public class userDAO {
	private SqlSessionFactory factory = FactoryManager.getSqlSessionFactory();

	public DFD_USER login(DFD_USER member) {
		SqlSession session = factory.openSession(true);
		// selectOne  : 결과가 한개  ResultType 에 명시한 자료형
		// selectlist : 결과가 여러개 List<ResultType>
		DFD_USER result = session.selectOne("login", member);
		session.close();
		return result;
	}
}
