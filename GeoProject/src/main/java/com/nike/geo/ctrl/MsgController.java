package com.nike.geo.ctrl;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.nike.geo.service.IMsgService;
import com.nike.geo.vo.comm.FileVo;
import com.nike.geo.vo.msg.MsgVo;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MsgController {
	
	@Autowired
	private IMsgService service;

	@GetMapping(value = "/index.do")
	public String index() {
		log.info("MESSAGE controller - index 페이지로 이동");
		return "comm/index";
	}
	
	@GetMapping(value = "/recvMsg.do")
	public String recvMsg(Model model) {
		log.info("MESSAGE controller - 받은 쪽지함으로 이동");
		String recvId = "HYUN";
		List<MsgVo> msgListRecv = service.selectMsgListRecv(recvId);
		model.addAttribute("msgListRecv",msgListRecv);
		return "msg/recvMsg";
	}
	
	@GetMapping(value = "/sendMsg.do")
	public String sendMsg(Model model) {
		log.info("MESSAGE controller - 보낸 쪽지함으로 이동");
		String sendId = "TEST";
		List<MsgVo> msgListSend = service.selectMsgListSend(sendId);
		model.addAttribute("msgListSend", msgListSend);
		return "msg/sendMsg";
	}
	
	@GetMapping(value = "/detailMsgRecv.do")
	public String detailMsgRecv(String no, Model model) {
		log.info("MESSAGE controller - 받은 쪽지 상세 조회로 이동");
		MsgVo msgDetail = service.selectMsgOne(no);
		if(msgDetail.getMsg_recv_read_yn().equals("N")) {
			log.info("MESSAGE controller - 쪽지를 처음 읽을 경우에만");
			int readChk = service.updateMsgRead(msgDetail);
			if(readChk == 1) {
				log.info("MESSAGE controller - 쪽지 읽음 여부 변경 성공");
			}else {
				log.info("MESSAGE controller - 쪽지 읽음 여부 변경 실패");
			}
		}
		model.addAttribute("msgDetail", msgDetail);
		return "msg/detailMsgRecv";
	}
	
	@GetMapping(value = "/detailMsgSend.do")
	public String detailMsgSend(String no, Model model) {
		log.info("MESSAGE controller - 보낸 쪽지 상세 조회로 이동");
		MsgVo msgDetail = service.selectMsgOne(no);
		model.addAttribute("msgDetail", msgDetail);
		return "msg/detailMsgSend";
	}
	
	@GetMapping(value = "/insertMsg.do")
	public String insertMsgForm() {
		log.info("MESSAGE controller - 쪽지 작성 페이지로 이동");
		return "msg/insertMsg";
	}
	
	// 로그인 추가시 세션값도 받아와야함
	@PostMapping(value = "/insertMsg.do")
	public String insertMsg(MsgVo msgVo,
							MultipartFile file) throws IOException {
		
		// 쪽지 작성
		msgVo.setMsg_send_id("HYUN"); // 로그인 추가시 현재 접속중인 아이디로 변경
		int msgChk = service.insertMsg(msgVo);
		
		// 파일 업로드
		if (!file.isEmpty()) { 
			FileVo fileVo = new FileVo();
			
			//진짜 이름 
			String originFileName = file.getOriginalFilename();
			fileVo.setFile_oname(originFileName);
			log.info("MESSAGE controller - 받아온 파일의 원래 이름 : {}", originFileName);
			
			String ext = FilenameUtils.getExtension(originFileName); //파일의 확장자
			log.info("MESSAGE controller - 받아온 파일의 확장자 : {}", ext);
			
			UUID uuid = UUID.randomUUID(); 
			//저장이름
			String fileName = uuid + "." + ext;
			fileVo.setFile_sname(fileName);
			log.info("MESSAGE controller - 받아온 파일의 DB 저장명 : {}", fileName);
			
			// 파일 사이즈
			long fileSize = file.getSize();
			fileVo.setFile_size(fileSize);
			log.info("MESSAGE controller - 받아온 파일의 크기 : {}", fileSize);
			
			file.transferTo(new File("c:\\upload\\"+fileName)); 

			fileVo.setOrigin_no(msgVo.getMsg_no());
			fileVo.setReg_id(msgVo.getMsg_send_id());
			
			int fileChk = service.insertFile(fileVo);
			if(fileChk==1) {
				log.info("MESSAGE controller - 파일 업로드 완료");
			}
		}
		
		if(msgChk==1) {
			log.info("MESSAGE controller - 쪽지 작성 완료. 보낸 쪽지 상세 조회로 이동");
			return "redirect:/detailMsgSend.do?no="+msgVo.getMsg_no();
		}else {
			log.info("MESSAGE controller - 쪽지 작성 실패. 받은 쪽지함으로 이동");
			// alert 창
			return "redirect:/recvMsg.do";
		}
	}
}
