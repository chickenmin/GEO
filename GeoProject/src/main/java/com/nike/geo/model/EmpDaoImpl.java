package com.nike.geo.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.nike.geo.vo.hr.AttVo;
import com.nike.geo.vo.hr.EmpVo;
import com.nike.geo.vo.hr.VacaVo;

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
	public int arriveWork(String emp_no) {
		log.info(NS + "arriveWork", emp_no);
		return session.update(NS + "arriveWork",emp_no);
	}
	
	@Override
	public int leftWork(String emp_no) {
		log.info(NS + "leftWork", emp_no);
		return session.update(NS + "leftWork",emp_no);
	}
	
	@Override
	public EmpVo myPage(String emp_no) {
		log.info(NS + "myPage");
		return session.selectOne(NS + "myPage");
	}
	
	@Override
	public AttVo empAtt(String emp_no) {
		log.info(NS + "empAtt", emp_no);
		return session.selectOne(NS + "empAtt", emp_no);
	}
	
	@Override
	public AttVo empAttMonth(String emp_no) {
		log.info(NS + "empAttMonth", emp_no);
		return session.selectOne(NS + "empAttMonth", emp_no);
	}

	
	@Override
	public void batchRow() {
		int row = session.insert(NS + "batchRow");
		System.out.println("DB호출 :" + row);
	}
	
	@Override
	public void insertVa() {
		int row = session.insert(NS + "insertVa");
		System.out.println("DB호출" + row);
	}

	@Override
	public VacaVo vaCheck(String emp_no) {
		log.info(NS + "vaCheck", emp_no);
		return session.selectOne(NS + "vaCheck", emp_no);
	}

	@Override
	public List<VacaVo> usedDate(String emp_no) {
		log.info(NS + "usedDate");
		return session.selectList(NS + "usedDate", emp_no);
	}
	
	@Override
	public List<VacaVo> usedHalf(String emp_no) {
		log.info(NS + "usedHalf");
		return session.selectList(NS + "usedHalf", emp_no);
	}
	
	@Override
	public VacaVo usedNum(String emp_no) {
		log.info(NS + "usedNum");
		return session.selectOne(NS + "usedNum", emp_no);
	}
	
	@Override
	public VacaVo usedHalfNum(String emp_no) {
		log.info(NS + "usedHalfNum");
		return session.selectOne(NS + "usedHalfNum", emp_no);
	}
	
	@Override
	public int retireEmp(String emp_no) {
		log.info(NS + "retireEmp");
		return session.update(NS + "retireEmp", emp_no);
	}
	
	@Override
	public int modPw(EmpVo vo) {
		log.info(NS + "modPw");
		return session.update(NS + "modPw", vo);
	}

}
