package com.nike.geo.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.nike.geo.vo.appr.Ap_DocuVo;
import com.nike.geo.vo.bo.BoardVo;
import com.nike.geo.vo.co.CalVo;
import com.nike.geo.vo.comm.CommonVo;
import com.nike.geo.vo.hr.EmpVo;
import com.nike.geo.vo.msg.NotiVo;

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
	
	@Override
	public List<Ap_DocuVo> selectMainDocu(String no) {
		log.info("COMMON repository - 메인화면 결재문서함 조회 selectMainDocu");
		log.info("COMMON repository - 받아온 값 : {}", no);
		return template.selectList(NS+"selectMainDocu", no);
	}
	
	@Override
	public int selectMainAppr(Map<String, Object> map) {
		log.info("COMMON repository - 메인화면 결재현황 selectMainAppr");
		log.info("COMMON repository - 받아온 값 : {}", map);
		return template.selectOne(NS+"selectMainAppr", map);
	}
	
	@Override
	public List<CalVo> selectMainCal(String no) {
		log.info("COMMON repository - 메인화면 일정 조회 selectMainCal");
		log.info("COMMON repository - 받아온 값 : {}", no);
		return template.selectList(NS+"selectMainCal", no);
	}
	
	@Override
	public int insertNoti(Map<String, Object> map) {
		log.info("COMMON repository - 알림 추가 insertNoti");
		log.info("COMMON repository - 받아온 값 : {}", map);
		return template.insert(NS+"insertNoti", map);
	}
	
	@Override
	public List<String> selectEmpSt() {
		log.info("COMMON repository - 재직사원 조회 selectEmpSt");
		return template.selectList(NS+"selectEmpSt");
	}
	
	@Override
	public List<NotiVo> selectLatestNoti(String empNo) {
		log.info("COMMON repository - 안읽은 쪽지 최신순 3개 조회 selectLatestMsg");
		log.info("COMMON repository - 받아온 값 : {}", empNo);
		return template.selectList(NS+"selectLatestNoti", empNo);
	}
	
	@Override
	public int selectNotiSeq() {
		log.info("COMMON repository - 알림 시퀀스값 조회 selectNotiSeq");
		return template.selectOne(NS+"selectNotiSeq");
	}
	
	@Override
	public int cntUnreadNoti(String no) {
		log.info("COMMON repository - 안읽은 알림 최신순 3개 조회 cntUnreadNoti");
		log.info("COMMON repository - 받아온 값 : {}", no);
		return template.selectOne(NS+"cntUnreadNoti", no);
	}
}
