package com.nike.geo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nike.geo.model.IEmpDao;
import com.nike.geo.vo.hr.AttVo;
import com.nike.geo.vo.hr.EmpVo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class EmpServiceImpl implements IEmpService {

	@Autowired
	private final IEmpDao dao;

	// 사원 추가
	@Override
	public int insertEmp(EmpVo vo) {
		log.info("사원추가");
		return dao.insertEmp(vo);
	}

	// 사원 전체 조회
	@Override
	public List<EmpVo> selectAll() {
		log.info("사원 전체 조회");
		return dao.selectAll();
	}

	// 사원 상세 정보
	@Override
	public EmpVo selectOneEmp(String emp_no) {
		log.info("EmpServiceImpl {}", emp_no);
		return dao.selectOneEmp(emp_no);
	}

	// 사원 정보 변경
	@Override
	public int updateEmp(EmpVo vo) {
		log.info("사원 정보 변경");
		return dao.updateEmp(vo);
	}

	// 비밀번호 초기화
	@Override
	public int clearPw(EmpVo vo) {
		log.info("비밀번호 초기화");
		return dao.clearPw(vo);
	}

	// 출근
	@Override
	public int arriveWork(AttVo vo) {
		log.info("출근 완료");
		return dao.arriveWork(vo);
	}

	// 퇴근
	@Override
	public int leftWork(AttVo vo) {
		log.info("퇴근 완료");
		return dao.leftWork(vo);
	}

	// 마이 페이지
	@Override
	public EmpVo myPage(String emp_no) {
		log.info("마이 페이지");
		return dao.myPage(emp_no);
	}
	
	
	// 사원 근무 조회
	@Override
	public AttVo empAtt(String emp_no) {
		log.info("사원 근무 조회");
		return dao.empAtt(emp_no);
	}

}
