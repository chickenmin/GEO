package com.nike.geo.service;

import java.util.List;

import javax.mail.MessagingException;

import com.nike.geo.vo.comm.CommonVo;
import com.nike.geo.vo.hr.EmpVo;

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
}
