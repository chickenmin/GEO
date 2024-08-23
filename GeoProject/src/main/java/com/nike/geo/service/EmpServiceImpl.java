package com.nike.geo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nike.geo.model.IEmpDao;
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
	
	// 비밀번호 변경
	@Override
	public int modPw(EmpVo vo) {
		log.info("비밀번호 변경");
		return dao.modPw(vo);
	}

}