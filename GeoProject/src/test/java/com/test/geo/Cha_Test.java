package com.test.geo;

import static org.junit.Assert.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.nike.geo.model.IMsgDao;
import com.nike.geo.service.IBoardService;
import com.nike.geo.service.ICommService;
import com.nike.geo.service.IEmpService;
import com.nike.geo.service.IMsgService;
import com.nike.geo.vo.bo.BoardVo;
import com.nike.geo.vo.hr.EmpVo;
import com.nike.geo.vo.msg.MsgVo;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
public class Cha_Test {
	
	//junit은 @RequiredArgsConstructor 사용불가 / @Autowired만 사용하기
	
	@Autowired
	private SqlSessionTemplate template;
	
	@Autowired
	private IMsgService service;
	
	@Autowired
	private IBoardService boardService;

	@Autowired
	private ICommService commService;
	
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
	
//	@Test
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
	
	@Test
	public void insertNoti_Test() {
		BoardVo Vo = new BoardVo();
		String writeId = "EE001";
		Vo.setEmp_no(writeId);
		Vo.setBo_title("공지 ㄱㄱ");  // 제목 설정
	    Vo.setBo_content("내용임");  // 내용 설정
	    Vo.setBo_status("announcements");  // 상태 설정
	    boolean isc = boardService.insertBoard(Vo);
	    
    	List<String> empStList = commService.selectEmpSt();
    	log.info("재직중인 사원 사번 리스트 : {}", empStList);
    	Map<String, Object> map = new HashMap<String, Object>();
//			map.put("emp_no", Vo.getEmp_no());
    	map.put("emp_list", empStList);
		map.put("noti_status", "2");
		map.put("noti_content", "사내 공지사항 - '" + Vo.getBo_title() + "' 게시글이 등록되었습니다.");
		map.put("seq",0);
		
    	commService.insertNoti(map);
    	
    	if (isc == true) {
	        log.info("됨");
	    } else {
	    	log.info("안됨");
	    }
	}

	
	
}
