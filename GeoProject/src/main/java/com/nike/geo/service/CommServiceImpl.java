package com.nike.geo.service;

import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import com.nike.geo.model.ICommDao;
import com.nike.geo.vo.appr.Ap_DocuVo;
import com.nike.geo.vo.bo.BoardVo;
import com.nike.geo.vo.co.CalVo;
import com.nike.geo.vo.comm.CommonVo;
import com.nike.geo.vo.hr.EmpVo;
import com.nike.geo.vo.msg.NotiVo;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class CommServiceImpl implements ICommService {
	
	@Autowired
	private ICommDao dao;
	
	@Autowired
	private JavaMailSender mailSender;

	private Random random = new Random();
	
	@Override
	public List<CommonVo> commSelect(String division) {
		return dao.commSelect(division);
	}
	
	@Override
	public EmpVo selectEmp(EmpVo vo) {
		log.info("로그인 selectEmp - 받아온 값 : {}", vo);
		return dao.selectEmp(vo);
	}
	
	@Override
	public EmpVo selectEmpTemp(EmpVo vo) {
		log.info("임시비밀번호 발급 전 정보 확인 selectEmpTemp - 받아온 값 : {}", vo);
		return dao.selectEmpTemp(vo);
	}
	
	@Override
	public String generateTempPw() {
		log.info("임시비밀번호 생성 generateTempPw");
		String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        StringBuilder sb = new StringBuilder(6);

        for (int i = 0; i < 6; i++) {
            int index = random.nextInt(characters.length());
            sb.append(characters.charAt(index));
        }
        
        String tempPw = sb.toString();
		return tempPw;
	}
	
	@Override
	public int updateTempPw(EmpVo vo) {
		log.info("임시비밀번호 발급 updateTempPw - 받아온 값 : {}", vo);
		return dao.updateTempPw(vo);
	}
	
	@Async
	@Override
	public void sendMail(String to, String subject, String content) throws MessagingException {
		log.info("메일로 임시 비밀번호 전송 sendMail");
		
		MimeMessage message = mailSender.createMimeMessage();
		
		MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
		helper.setFrom("geo.project.notify@gmail.com");
		helper.setTo(to);
		helper.setSubject(subject);
		helper.setText(content, true);

		mailSender.send(message);
	}
	
	@Override
	public EmpVo selectMainEmp(String no) {
		log.info("메인화면 사원정보 조회 selectMainEmp - 받아온 값 : {}", no);
		return dao.selectMainEmp(no);
	}
	
	@Override
	public List<BoardVo> selectMainBoard(String status) {
		log.info("메인화면 공지게시판 조회 selectMainBoard - 받아온 값 : {}", status);
		return dao.selectMainBoard(status);
	}
	
	@Override
	public List<Ap_DocuVo> selectMainDocu(String no) {
ㄴ		log.info("메인화면 결재문서함 조회 selectMainDocu - 받아온 값 : {}", no);
		return dao.selectMainDocu(no);
	}
	
	@Override
	public int selectMainAppr(Map<String, Object> map) {
		log.info("메인화면 결재현황 selectMainAppr - 받아온 값 : {}", map);
		return dao.selectMainAppr(map);
	}
	
	@Override
	public List<CalVo> selectMainCal(String no) {
		log.info("메인화면 일정 조회 selectMainCal - 받아온 값 : {}", no);
		return dao.selectMainCal(no);
	}
	
	@Override
	public int insertNoti(Map<String, Object> map) {
		log.info("알림 추가 insertNoti - 받아온 값 : {}", map);
		return dao.insertNoti(map);
	}
	
	@Override
	public int insertNotiAppr(Map<String, Object> map) {
		log.info("결재알림 생성 insertNotiAppr - 받아온 값 : {}", map);
		return dao.insertNotiAppr(map);
	}
	
	@Override
	public List<String> selectEmpSt() {
		log.info("재직사원 조회 selectEmpSt");
		return dao.selectEmpSt();
	}
	
	@Override
	public List<NotiVo> selectLatestNoti(String empNo) {
		log.info("안읽은 알림 최신순 3개 조회 selectLatestNoti - 받아온 값 : {}", empNo);
		return dao.selectLatestNoti(empNo);
	}
		
	@Override
	public int cntUnreadNoti(String no) {
		log.info("안읽은 알림 최신순 3개 조회 cntUnreadNoti - 받아온 값 : {}", no);
		return dao.cntUnreadNoti(no);
	}
	
	@Override
	public int updateNotiRead(NotiVo vo) {
		log.info("알림 읽기 updateNotiRead - 받아온 값 : {}", vo);
		return dao.updateNotiRead(vo);
	}
	
	@Override
	public String selectNotiRead(NotiVo vo) {
		log.info("알림 읽음여부 확인 selectNotiRead - 받아온 값 : {}", vo);
		return dao.selectNotiRead(vo);
	}
	
	@Override
	public int updateAdminNoti() {
		log.info("관리자 공지알림 읽기 updateAdminNoti");
		return dao.updateAdminNoti();
	}
	
}
