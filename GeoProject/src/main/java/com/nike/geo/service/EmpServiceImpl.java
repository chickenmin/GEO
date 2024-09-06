package com.nike.geo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nike.geo.model.IEmpDao;
import com.nike.geo.vo.hr.AttVo;
import com.nike.geo.vo.hr.EmpVo;
import com.nike.geo.vo.hr.VacaVo;

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
	public int arriveWork(String emp_no) {
		log.info("출근 완료");
		return dao.arriveWork(emp_no);
	}

	// 퇴근
	@Override
	public int leftWork(String emp_no) {
		log.info("퇴근 완료");
		return dao.leftWork(emp_no);
	}

	// 마이 페이지
	@Override
	public EmpVo myPage(String emp_no) {
		log.info("마이 페이지");
		return dao.myPage(emp_no);
	}


	// 출퇴근 테이블 모든사원 null 값 생성
	@Override
	public void batchRow() {
		System.out.println("Service 실행");
		dao.batchRow();
	}
	
	// 연차 부여
	@Override
	public void insertVa() {
		System.out.println("매년 연차 부여");
		dao.insertVa();
	}
	
	// 근태 조회
	@Override
	public AttVo empAtt(String emp_no) {
		log.info("사원 근태 조회");
		return dao.empAtt(emp_no);
	}
	
	// 사원 월간 근태 조회
	@Override
	public AttVo empAttMonth(String emp_no) {
		log.info("사원 월간 근태 조회");
		return dao.empAttMonth(emp_no);
	}
	
	// 남은 연차 조회
	@Override
	public VacaVo vaCheck(String emp_no) {
		log.info("남은 연차 조회");
		return dao.vaCheck(emp_no);
	}
	
	// 연차 사용 날짜
	@Override
	public List<VacaVo> usedDate(String emp_no) {
		log.info("연차 사용 날짜");
		return dao.usedDate(emp_no);
	}
	
	// 반차 사용 날짜
	@Override
	public List<VacaVo> usedHalf(String emp_no) {
		log.info("반차 사용 날짜");
		return dao.usedHalf(emp_no);
	}
	
	// 연차 사용 횟수
	@Override
	public VacaVo usedNum(String emp_no) {
		log.info("연차 사용 횟수");
		return dao.usedNum(emp_no);
	}
	
	// 반차 사용 횟수
	@Override
	public VacaVo usedHalfNum(String emp_no) {
		log.info("반차 사용 횟수");
		return dao.usedHalfNum(emp_no);
	}
	

	

}
