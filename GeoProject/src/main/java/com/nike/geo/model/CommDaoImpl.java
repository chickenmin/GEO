package com.nike.geo.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

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

}