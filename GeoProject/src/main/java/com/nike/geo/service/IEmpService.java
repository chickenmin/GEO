package com.nike.geo.service;

import java.util.List;
import java.util.Map;

import com.nike.geo.vo.hr.AttVo;
import com.nike.geo.vo.hr.EmpVo;
import com.nike.geo.vo.hr.VacaVo;

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
	public AttVo empAtt(String emp_no);
	
	// 사원 월간 근태 조회
	public AttVo empAttMonth(String emp_no);

	// 출퇴근 테이블 모든사원 null 값 생성
	public void batchRow();
	
	// 연차 부여
	public void insertVa();
	
	// 남은 연차 조회
	public VacaVo vaCheck(String emp_no);
	
	// 연차 사용 날짜
	public List<VacaVo> usedDate(String emp_no);
	
	// 반차 사용 날짜
	public List<VacaVo> usedHalf(String emp_no);
	
	// 연차 사용 횟수
	public VacaVo usedNum(String emp_no);
	
	// 연차 사용 횟수
	public VacaVo usedHalfNum(String emp_no);
	
	// 퇴사 처리
	public int retireEmp(String emp_no);
	
	// 비밀번호 변경
	public int modPw(EmpVo vo);

	

}
