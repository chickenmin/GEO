package com.nike.geo.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.nike.geo.vo.hr.AttVo;
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
	public int clearPw(EmpVo vo) {
		log.info(NS + "clearPw");
		return session.update(NS + "clearPw", vo);
	}
	
	@Override
	public int arriveWork(AttVo vo) {
		log.info(NS + "arriveWork");
		return session.insert(NS + "arriveWork", vo);
	}
	
	@Override
	public int leftWork(AttVo vo) {
		log.info(NS + "leftWork");
		return session.update(NS + "leftWork", vo);
	}
	
	@Override
	public EmpVo myPage(String emp_no) {
		log.info(NS + "myPage");
		return session.selectOne(NS + "myPage");
	}
	
}
