package com.nike.geo.model;

import java.util.List;

import com.nike.geo.vo.bo.BoardVo;
import com.nike.geo.vo.comm.CommonVo;
import com.nike.geo.vo.hr.EmpVo;

public interface ICommDao {
	
	public List<CommonVo> commSelect(String division);
	
	// 로그인 selectEmp
	public EmpVo selectEmp(EmpVo vo);

	// 임시비밀번호 발급 전 정보 확인 selectEmpTemp
	public EmpVo selectEmpTemp(EmpVo vo);
	
	// 임시비밀번호 발급 updateTempPw
	public int updateTempPw(EmpVo vo);
	
	// 메인화면 사원정보 조회 selectMainEmp
	public EmpVo selectMainEmp(String no);
	
	// 메인화면 공지게시판 조회 selectMainBoard
	public List<BoardVo> selectMainBoard(String status);
	
}
