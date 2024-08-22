package com.nike.geo.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.nike.geo.vo.hr.EmpVo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
@RequiredArgsConstructor
public class EmpDaoImpl implements IEmpDao {

	private final SqlSessionTemplate session;
	private final String NS = "com.nike.geo.model.EmpDaoImpl.";
	
	@Override
	public int insertEmp(EmpVo vo) {
		return session.insert(NS + "insertEmp", vo);
	}
	
	@Override
	public List<EmpVo> selectAll() {
		return session.selectList(NS + "selectAll");
	}
	
	@Override
	public EmpVo selectOneEmp(String emp_no) {
		log.info("받아온 값 : {}", emp_no);
		return session.selectOne(NS + "selectOneEmp", emp_no);
	}
	
	@Override
	public int updateEmp(EmpVo vo) {
		log.info(NS + "updateEmp");
		return session.update(NS + "updateEmp", vo);
	}
	
	@Override
	public int modPw(EmpVo vo) {
		log.info(NS + "modPw");
		return session.update(NS + "modPw", vo);
	}
	
}
