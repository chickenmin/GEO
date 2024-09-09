package com.nike.geo.service;

import java.util.List;
import java.util.Map;

import javax.mail.MessagingException;

import com.nike.geo.vo.appr.Ap_DocuVo;
import com.nike.geo.vo.bo.BoardVo;
import com.nike.geo.vo.co.CalVo;
import com.nike.geo.vo.comm.CommonVo;
import com.nike.geo.vo.hr.EmpVo;
import com.nike.geo.vo.msg.NotiVo;

public interface ICommService {
	
	public List<CommonVo> commSelect(String division);
	
	/**
	 * 로그인 
	 * @param vo
	 * @return EmpVo
	 */
	public EmpVo selectEmp(EmpVo vo);
	
	/**
	 * 임시비밀번호 발급 전 정보 확인 
	 * @param vo
	 * @return EmpVo
	 */
	public EmpVo selectEmpTemp(EmpVo vo);
	
	/**
	 * 임시비밀번호 발급
	 * @param pw
	 * @return 0 혹은 1
	 */
	public int updateTempPw(EmpVo vo);
	
	/**
	 * 메일로 임시비밀번호 전송
	 * @param 받는사람 메일 to
	 * @param 메일 제목 subject
	 * @param 메일 내용 content
	 */
	public void sendMail(String to, String subject, String content) throws MessagingException;

	/**
	 * 메인화면 사원정보 조회 
	 * @param no
	 * @return EmpVo
	 */
	public EmpVo selectMainEmp(String no);
	
	/**
	 * 메인화면 공지게시판 조회 
	 * @param status
	 * @return List<BoardVo>
	 */
	public List<BoardVo> selectMainBoard(String status);
	
	/**
	 * 임시비밀번호 생성
	 * @return 임시비밀번호 값
	 */
	public String generateTempPw();
	
	/**
	 * 메인화면 결재문서함 조회 
	 * @param no
	 * @return List<Ap_DocuVo>
	 */
	public List<Ap_DocuVo> selectMainDocu(String no);
	
	/**
	 * 메인화면 결재현황 selectMainAppr
	 * @param map
	 * @return int
	 */
	public int selectMainAppr(Map<String, Object> map);
	
	/**
	 * 메인화면 일정 조회 
	 * @param no
	 * @return List<CalVo>
	 */
	public List<CalVo> selectMainCal(String no);
	
	/**
	 * 알림 추가 
	 * @param map
	 * @return 0 혹은 1
	 */
	public int insertNoti(Map<String, Object> map);
	
	/**
	 * 결재알림 생성 insertNotiAppr
	 * @param map
	 * @return 0 혹은 1
	 */
	public int insertNotiAppr(Map<String, Object> map);
	
	/**
	 * 재직사원 조회 
	 * @return List<String>
	 */
	public List<String> selectEmpSt();
	
	/**
	 * 안읽은 알림 최신순 3개 조회 
	 * @param empNo
	 * @return 안읽은 쪽지 최신순 3개
	 */
	public List<NotiVo> selectLatestNoti(String empNo);
	
	/**
	 * 안읽은 알림 갯수 확인 
	 * @param no
	 * @return 안읽은 알림 갯수
	 */
	public int cntUnreadNoti(String no);
	
	/**
	 * 알림 읽기 updateNotiRead
	 * @param vo
	 * @return 0 혹은 1
	 */
	public int updateNotiRead(NotiVo vo);
	
	/**
	 * 알림 읽음여부 확인 selectNotiRead
	 * @param vo
	 * @return 알림 읽음여부
	 */
	public String selectNotiRead(NotiVo vo);
	
	/**
	 * 관리자 공지알림 읽기 updateAdminNoti
	 * @return 읽음처리된 알림 갯수
	 */
	public int updateAdminNoti();
	
}
