package com.nike.geo.ctrl;

import java.security.SecureRandom;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.MessagingException;
import javax.servlet.http.HttpSession;

import org.jsoup.Jsoup;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.nike.geo.service.ICommService;
import com.nike.geo.service.IMsgService;
import com.nike.geo.vo.hr.EmpVo;
import com.nike.geo.vo.msg.MsgVo;

import lombok.extern.slf4j.Slf4j;

//ajax 사용 컨트롤러
@Slf4j
@RestController
public class MsgRestController {
	
	@Autowired
	private IMsgService service;
	
	@Autowired
	private ICommService commService;
	
	@PostMapping(value = "/login.do")
	public Map<String, String> login(EmpVo vo, HttpSession session) {
		log.info("MESSAGE controller - 로그인 진행중");
		log.info("MESSAGE controller - 받아온 값 : {}", vo);
		
		Map<String, String> response = new HashMap<>();
		
		EmpVo loginVo = commService.selectEmp(vo);
		if(loginVo != null) {
			log.info("MESSAGE controller - 로그인 성공");
			// 세션에 loginVo 추가
			session.setAttribute("loginVo", loginVo);
			
			if(loginVo.getEmp_status().equals("W")) {
				log.info("MESSAGE controller - 비밀번호 변경 대상");
				response.put("status", "update-Password-Needed");
				response.put("message", "비밀번호 변경 대상입니다.");
				return response;
			} else {
				log.info("MESSAGE controller - 비밀번호 변경 대상 아님");
				response.put("status", "success");
				response.put("message", "로그인에 성공하였습니다.");
				return response;
			}
		}else {
			log.info("MESSAGE controller - 로그인 실패");
			response.put("status", "fail");
			response.put("message", "사원번호 또는 비밀번호를 확인해주세요.");
			return response;
		}
	}
	
	@PostMapping(value = "/deleteMsgRecv.do")
	public String deleteMsgRecv(@RequestParam List<String> msg_no) {
		log.info("MESSAGE controller - 받은 쪽지 삭제");
		log.info("MESSAGE controller - msg_no의 값 : {}", msg_no);
		int deleteNum = service.deleteMsgRecv(msg_no);
		log.info("MESSAGE controller - 삭제된 쪽지 갯수 : {}", deleteNum);
		return (deleteNum>0)?"true":"false";
	}
	
	@PostMapping(value = "/deleteMsgSend.do")
	public String deleteMsgSend(@RequestParam List<String> msg_no) {
		log.info("MESSAGE controller - 보낸 쪽지 삭제");
		log.info("MESSAGE controller - msg_no의 값 : {}", msg_no);
		int deleteNum = service.deleteMsgSend(msg_no);
		log.info("MESSAGE controller - 삭제된 쪽지 갯수 : {}", deleteNum);
		return (deleteNum>0)?"true":"false";
	}
	
//	@PostMapping(value = "/tempPw.do")
//	public Map<String, String> tempPw(EmpVo vo) throws MessagingException {
//		log.info("MESSAGE controller - 임시 비밀번호 발급중");
//		
//		Map<String, String> response = new HashMap<>();
//		
//		EmpVo TempVo = commService.selectEmpTemp(vo);
//		if(TempVo != null) {
//			log.info("MESSAGE controller - 임시 비밀번호 발급 전 정보확인 성공");
//			
//			// 임시 비밀번호로 쓸 난수 생성
//
//
//
////			String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
////
////	        SecureRandom random = new SecureRandom();
////	        StringBuilder sb = new StringBuilder(6);
////
////	        for (int i = 0; i < 6; i++) {
////	            int index = random.nextInt(characters.length());
////	            sb.append(characters.charAt(index));
////	        }
////	        
////	        String tempPw = sb.toString();
//
////	        TempVo.setEmp_pw(tempPw);
//	        TempVo.setEmp_pw("123456");
//
//	//		String tempPw = commService.generateTempPw();
//	  //      TempVo.setEmp_pw(tempPw);
//
//
//			
//			// 비밀번호 변경
//			int updateChk = commService.updateTempPw(TempVo);
//			if (updateChk == 1) {
//				log.info("MESSAGE controller - 임시 비밀번호 발급 완료");
//				
//				// 이메일 전송
//				String email = TempVo.getEmp_email();
//				String name = TempVo.getEmp_name();
//				String content = "<br>" + name + "님, 안녕하세요.<br>"
//
//						+ "임시 비밀번호는 "+ 123456 + " 입니다.<br>"
//
//						+ "보안 상의 이유로 로그인 후 바로 비밀번호를 바꾸시는 걸 권장합니다.";
//				commService.sendMail(email,	"임시 비밀번호 발급 안내", content);
//				
//				response.put("status", "success");
//				response.put("message", "임시 비밀번호가 발급되었습니다. 이메일을 확인해주세요");
//				return response;
//			} else {
//				log.info("MESSAGE controller - 임시 비밀번호 발급 실패");
//				response.put("status", "fail");
//				response.put("message", "임시 비밀번호 발급에 실패하였습니다. 관리자에게 문의하세요");
//				return response;
//			}
//		} else {
//			log.info("MESSAGE controller - 임시 비밀번호 발급 전 정보확인 실패");
//			response.put("message", "입력하신 정보와 일치하는 아이디가 없습니다");
//			response.put("status", "select-fail");
//			return response;
//		}
//	}
	
	@GetMapping(value = "/cntUnreadMsg.do")
	public int cntUnreadMsg(HttpSession session) {
		log.info("MESSAGE controller - 안 읽은 쪽지 갯수 세기");
		EmpVo loginVo = (EmpVo)session.getAttribute("loginVo");
		int cnt = service.cntUnreadMsg(loginVo.getEmp_no());
		return cnt;
	}
	
	@GetMapping(value = "/selectLatestMsg.do")
	public List<MsgVo> selectLatestMsg(HttpSession session){
		log.info("MESSAGE controller - 안읽은 쪽지 최신순 3개 조회");
		EmpVo loginVo = (EmpVo)session.getAttribute("loginVo");
		List<MsgVo> latestMsg = service.selectLatestMsg(loginVo.getEmp_no());
		
		for (MsgVo msg : latestMsg) {
			String content = msg.getMsg_content();
			content = Jsoup.parse(content).text();
			if(content.length() > 20) {
				content = content.substring(0, 20).concat("...");			
			}
			content = content.replaceAll("(\r\n|\r|\n|\n\r)", " ");
			msg.setMsg_content(content);
		}
		return latestMsg;
	}
	
}
