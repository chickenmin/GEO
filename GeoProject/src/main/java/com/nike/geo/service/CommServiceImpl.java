package com.nike.geo.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.nike.geo.model.ICommDao;
import com.nike.geo.vo.comm.CommonVo;
import com.nike.geo.vo.hr.EmpVo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class CommServiceImpl implements ICommService {
	
	private final ICommDao dao;

	@Override
	public List<CommonVo> commSelect(String division) {
		return dao.commSelect(division);
	}
	
	@Override
	public EmpVo selectEmp(EmpVo vo) {
		log.info("COMMON service - 로그인 selectEmp");
		log.info("COMMON service - 받아온 값 : {}", vo);
		return dao.selectEmp(vo);
	}
	
	@Override
	public EmpVo selectEmpTemp(EmpVo vo) {
		log.info("COMMON service - 임시비밀번호 발급 전 정보 확인 selectEmpTemp");
		log.info("COMMON service - 받아온 값 : {}", vo);
		return dao.selectEmpTemp(vo);
	}
}
