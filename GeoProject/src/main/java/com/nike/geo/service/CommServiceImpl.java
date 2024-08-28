package com.nike.geo.service;

import java.util.List;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.nike.geo.model.ICommDao;
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
	public int updateTempPw(EmpVo vo) {
		log.info("COMMON service - 임시비밀번호 발급 updateTempPw");
		log.info("COMMON service - 받아온 값 : {}", vo);
		return dao.updateTempPw(vo);
	}
	
	@Override
	public void sendMail(String to, String subject, String content) throws MessagingException {
		log.info("COMMON service - 메일로 임시 비밀번호 전송 sendMail");
		
//		SimpleMailMessage mail = new SimpleMailMessage();
//		mail.setTo(to);
//		mail.setSubject(subject);
//		mail.setText(content);
//		mail.setFrom("geo.project.notify@gmail.com");
//		mailSender.send(mail);
		
		MimeMessage message = mailSender.createMimeMessage();
		
		MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
		helper.setFrom("geo.project.notify@gmail.com");
		helper.setTo(to);
		helper.setSubject(subject);
		helper.setText(content, true);

		mailSender.send(message);
	}
}
