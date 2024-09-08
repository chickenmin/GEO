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
		log.info("로그인 selectEmp 받아온 값 : {}", vo);
		return template.selectOne(NS+"selectEmp", vo);
	}
	
	@Override
	public EmpVo selectEmpTemp(EmpVo vo) {
		log.info("임시비밀번호 발급 전 정보 확인 selectEmpTemp - 받아온 값 : {}", vo);
		return template.selectOne(NS+"selectEmpTemp", vo);
	}
	
	@Override
	public int updateTempPw(EmpVo vo) {
		log.info("임시비밀번호 발급 updateTempPw - 받아온 값 : {}", vo);
		return template.update(NS+"updateTempPw", vo);
	}

	@Override
	public EmpVo selectMainEmp(String no) {
		log.info("메인화면 사원정보 조회 selectMainEmp - 받아온 값 : {}", no);
		return template.selectOne(NS+"selectMainEmp", no);
	}
	
	@Override
	public List<BoardVo> selectMainBoard(String status) {
		log.info("메인화면 게시판 조회 selectMainBoard - 받아온 값 : {}", status);
		return template.selectList(NS+"selectMainBoard", status);
	}
	
	@Override
	public List<Ap_DocuVo> selectMainDocu(String no) {
		log.info("메인화면 결재문서함 조회 selectMainDocu - 받아온 값 : {}", no);
		return template.selectList(NS+"selectMainDocu", no);
	}
	
	@Override
	public int selectMainAppr(Map<String, Object> map) {
		log.info("selectMainAppr - 받아온 값 : {}", map);
		return template.selectOne(NS+"selectMainAppr", map);
	}
	
	@Override
	public List<CalVo> selectMainCal(String no) {
		log.info("메인화면 일정 조회 selectMainCal - 받아온 값 : {}", no);
		return template.selectList(NS+"selectMainCal", no);
	}
	
	@Override
	public int insertNoti(Map<String, Object> map) {
		log.info("알림 추가 insertNoti - 받아온 값 : {}", map);
		return template.insert(NS+"insertNoti", map);
	}
	
	@Override
	public int insertNotiAppr(Map<String, Object> map) {
		log.info("결재알림 생성 insertNotiAppr - 받아온 값 : {}", map);		
		return template.insert(NS+"insertNotiAppr", map);
	}
	
	@Override
	public List<String> selectEmpSt() {
		log.info("재직사원 조회 selectEmpSt");
		return template.selectList(NS+"selectEmpSt");
	}
	
	@Override
	public List<NotiVo> selectLatestNoti(String empNo) {
		log.info("안읽은 쪽지 최신순 3개 조회 selectLatestMsg - 받아온 값 : {}", empNo);
		return template.selectList(NS+"selectLatestNoti", empNo);
	}
	
	@Override
	public int cntUnreadNoti(String no) {
		log.info("안읽은 알림 최신순 3개 조회 cntUnreadNoti - 받아온 값 : {}", no);
		return template.selectOne(NS+"cntUnreadNoti", no);
	}
	
	@Override
	public int updateNotiRead(NotiVo vo) {
		log.info("알림 읽기 updateNotiRead - 받아온 값 : {}", vo);
		return template.update(NS+"updateNotiRead", vo);
	}

	@Override
	public String selectNotiRead(NotiVo vo) {
		log.info("알림 읽음여부 확인 selectNotiRead - 받아온 값 : {}", vo);
		return template.selectOne(NS+"selectNotiRead", vo);
	}
	
	@Override
	public int updateAdminNoti() {
		log.info("관리자 공지알림 읽기 updateAdminNoti");
		return template.update(NS+"updateAdminNoti");
	}
	
}
