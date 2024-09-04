package com.nike.geo.service;

import java.util.List;
import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import com.nike.geo.model.ICommDao;
import com.nike.geo.vo.bo.BoardVo;
import com.nike.geo.vo.co.CalVo;
import com.nike.geo.vo.comm.CommonVo;
import com.nike.geo.vo.hr.EmpVo;

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
		log.info("COMMON service - 로그인 selectEmp");
		log.info("COMMON service - 받아온 값 : {}", vo);
		return dao.selectEmp(vo);
	}
	
	@Override
	public EmpVo selectEmpTemp(EmpVo vo) {
		log.info("COMMON service - 임시비밀번호 발급 전 정보 확인 selectEmpTemp");
		log.info("COMMON service - 받아온 값 : {}", vo);
		return dao.selectEmpTemp(vo);
	}
	
	@Override
	public String generateTempPw() {
		log.info("COMMON service - 임시비밀번호 발급 generateTempPw");
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
		log.info("COMMON service - 임시비밀번호 발급 updateTempPw");
		log.info("COMMON service - 받아온 값 : {}", vo);
		return dao.updateTempPw(vo);
	}
	
	@Async
	@Override
	public void sendMail(String to, String subject, String content) throws MessagingException {
		log.info("COMMON service - 메일로 임시 비밀번호 전송 sendMail");
		
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
		log.info("COMMON service - 메인화면 사원정보 조회 selectMainEmp");
		log.info("COMMON service - 받아온 값 : {}", no);
		return dao.selectMainEmp(no);
	}
	
	@Override
	public List<BoardVo> selectMainBoard(String status) {
		log.info("COMMON service - 메인화면 공지게시판 조회 selectMainBoard");
		log.info("COMMON service - 받아온 값 : {}", status);
		return dao.selectMainBoard(status);
	}
	
	@Override
	public List<CalVo> selectMainCal(String no) {
		log.info("COMMON service - 메인화면 일정 조회 selectMainCal");
		log.info("COMMON service - 받아온 값 : {}", no);
		return dao.selectMainCal(no);
	}
	
}
