package com.nike.geo.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.nike.geo.vo.bo.BoardVo;
import com.nike.geo.vo.comm.CommonVo;
import com.nike.geo.vo.hr.EmpVo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Repository
public class CommDaoImpl implements ICommDao {
	
	private final SqlSessionTemplate template;

	private String NS="com.nike.geo.model.CommDaoImpl.";

	@Override
	public List<CommonVo> commSelect(String division) {
		return template.selectList(NS+"commSelect", division);
	}
	
	@Override
	public EmpVo selectEmp(EmpVo vo) {
		log.info("COMMON repository - 로그인 selectEmp");
		log.info("COMMON repository - 받아온 값 : {}", vo);
		return template.selectOne(NS+"selectEmp", vo);
	}
	
	@Override
	public EmpVo selectEmpTemp(EmpVo vo) {
		log.info("COMMON repository - 임시비밀번호 발급 전 정보 확인 selectEmpTemp");
		log.info("COMMON repository - 받아온 값 : {}", vo);
		return template.selectOne(NS+"selectEmpTemp", vo);
	}
	
	@Override
	public int updateTempPw(EmpVo vo) {
		log.info("COMMON repository - 임시비밀번호 발급 updateTempPw");
		log.info("COMMON repository - 받아온 값 : {}", vo);
		return template.update(NS+"updateTempPw", vo);
	}

	@Override
	public EmpVo selectMainEmp(String no) {
		log.info("COMMON repository - 메인화면 사원정보 조회 selectMainEmp");
		log.info("COMMON repository - 받아온 값 : {}", no);
		return template.selectOne(NS+"selectMainEmp", no);
	}
	
	@Override
	public List<BoardVo> selectMainBoard(String status) {
		log.info("COMMON repository - 메인화면 게시판 조회 selectMainBoard");
		log.info("COMMON repository - 받아온 값 : {}", status);
		return template.selectList(NS+"selectMainBoard", status);
	}
}
