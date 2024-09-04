package com.nike.geo.service;

import java.util.List;

import com.nike.geo.vo.hr.AttVo;
import com.nike.geo.vo.hr.EmpVo;

public interface IEmpService {

	// 사원 추가
	public int insertEmp(EmpVo vo);

	// 사원 전체 목록
	public List<EmpVo> selectAll();

	// 사원 상세 정보
	public EmpVo selectOneEmp(String emp_no);

	// 사원 정보 변경
	public int updateEmp(EmpVo vo);

	// 비밀번호 초기화
	public int clearPw(EmpVo vo);

	// 출근
	public int arriveWork(String emp_no);

	// 퇴근
	public int leftWork(String emp_no);

	// 마이 페이지
	public EmpVo myPage(String emp_no);
	
	// 사원 근태 조회
	public List<AttVo> empAtt(String emp_no);

	// 비밀번호 변경
	public int modPw(String emp_no);

	public void batchRow();
}
