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
	public void selectMsgListRecv_Test() { // 작동완 ㅋ
		String recvId = "HYUN";
		List<MsgVo> msgListRecv = service.selectMsgListRecv(recvId);
		assertNotEquals(0, msgListRecv.size());
	}
	
	@Test
	public void selectMsgListSend_Test() { // 작동완 ㅋ
		String sendId = "TEST";
		List<MsgVo> msgListSend = service.selectMsgListSend(sendId);
		assertNotEquals(0, msgListSend.size());
	}
	
//	@Test
	public void selectMsgOne_Test() { // 작동완 ㅋ
		String no = "40";
		MsgVo vo = service.selectMsgOne(no);
		assertNotNull(vo);
	}
	
//	@Test
	public void insertMsg_Test() { // 작동완 ㅋ
		MsgVo signupVo = new MsgVo();
		
		signupVo.setMsg_send_id("KANG");
		signupVo.setMsg_recv_id("HYUN");
		signupVo.setMsg_content("데이터 추가");
		
		int signupChk = service.insertMsg(signupVo);
		assertNotEquals(0, signupChk);
	}

}
