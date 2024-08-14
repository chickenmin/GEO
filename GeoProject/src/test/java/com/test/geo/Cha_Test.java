package com.test.geo;

import static org.junit.Assert.*;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.nike.geo.model.IMsgDao;
import com.nike.geo.service.IMsgService;
import com.nike.geo.vo.msg.MsgVo;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
public class Cha_Test {
	
	//junit은 @RequiredArgsConstructor 사용불가 / @Autowired만 사용하기
	
	@Autowired
	private SqlSessionTemplate template;
	
	@Autowired
	private IMsgService service;
	
	@Before
	public void test() {
		assertNotNull(template);
	}
	
//	@Test
	public void insertMsg_Test() { // 작동완 ㅋ
		MsgVo signupVo = new MsgVo();
		
		String sendId = "HYUN";
		String recvId = "HYUN";
		signupVo.setMsg_send_id(sendId);
		signupVo.setMsg_recv_id(recvId);
		signupVo.setMsg_content("이클립스에서 JUnitTest로 넣음 푸하하22");
		signupVo.setReg_id(sendId);
		signupVo.setMod_id(sendId);
		int signupChk = service.insertMsg(signupVo);
		assertNotEquals(0, signupChk);
	}
	
	@Test
	public void selectMsgList_Test() { // 작동완 ㅋ
		List<MsgVo> msgList = service.selectMsgList();
		assertNotEquals(0, msgList.size());
	}

}
