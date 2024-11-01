package com.DFD.dao;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.DFD.database.FactoryManager;
import com.DFD.entity.DFD_USER;

public class userDAO {
	
	private SqlSessionFactory factory = FactoryManager.getSqlSessionFactory();
	
	public DFD_USER login(DFD_USER member) {
		SqlSession session = factory.openSession(true);
		DFD_USER result = session.selectOne("login", member);
		session.close();
		return result;
	}

	public int join(DFD_USER member) {
		SqlSession session = factory.openSession(true);
		int result = session.insert("join", member);
		session.close();
		return result;
	}
}
