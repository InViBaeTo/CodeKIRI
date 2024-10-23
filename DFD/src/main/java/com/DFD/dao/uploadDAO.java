package com.DFD.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.DFD.database.FactoryManager;
import com.DFD.entity.DFD_UPLOAD;

public class uploadDAO {

	private SqlSessionFactory factory = FactoryManager.getSqlSessionFactory();

	public List<DFD_UPLOAD> getUpload(String id) {
		SqlSession session = factory.openSession(true);
		List<DFD_UPLOAD> result = session.selectList("getImage", id);
		session.close();
		return result;
	}
	
	
	
}
