package com.nike.geo.ctrl;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Objects;
import java.util.UUID;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.jsoup.Jsoup;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import com.nike.geo.service.IMsgService;
import com.nike.geo.vo.comm.FileVo;
import com.nike.geo.vo.hr.EmpVo;
import com.nike.geo.vo.msg.MsgVo;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MsgController {
	
	@Autowired
	private IMsgService service;
	
	@GetMapping(value = "/login.do")
	public String loginFrom() {
		log.info("MESSAGE controller - 로그인 페이지로 이동");
		return "comm/login";
	}
	
	@GetMapping(value = "/logout.do")
	public String logout(HttpSession session) {
		log.info("MESSAGE controller - 로그아웃 진행중");
		session.invalidate();
		return "redirect:/login.do";
	}
	
	@GetMapping(value = "/tempPw.do")
	public String tempPwForm() {
		log.info("MESSAGE controller - 임시 비밀번호 발급 페이지로 이동");
		return "comm/tempPw";
	}
	
	@GetMapping(value = "/index.do")
	public String index() {
		log.info("MESSAGE controller - index 페이지로 이동");
		return "comm/index";
	}
	
	@GetMapping(value = "/recvMsg.do")
	public String recvMsg(Model model, HttpSession session) {
		log.info("MESSAGE controller - 받은 쪽지함으로 이동");
		
		EmpVo vo = (EmpVo)session.getAttribute("loginVo");
		String recvId = vo.getEmp_no();
		List<MsgVo> msgListRecv = service.selectMsgListRecv(recvId);
		
		// 목록에서 내용 조회시 데이터 처리
		for (MsgVo msg : msgListRecv) {
			String content = msg.getMsg_content();
			content = Jsoup.parse(content).text();
			if(content.length() > 30) {
				content = content.substring(0, 30).concat("...");			
			}
			content = content.replaceAll("(\r\n|\r|\n|\n\r)", " ");
			msg.setMsg_content(content);
		}
		
		model.addAttribute("msgListRecv",msgListRecv);
		return "msg/recvMsg";
	}
	
	@GetMapping(value = "/sendMsg.do")
	public String sendMsg(Model model, HttpSession session) {
		log.info("MESSAGE controller - 보낸 쪽지함으로 이동");
		
		EmpVo vo = (EmpVo)session.getAttribute("loginVo");
		String sendId = vo.getEmp_no();
		List<MsgVo> msgListSend = service.selectMsgListSend(sendId);
		
		// 목록에서 내용 조회시 태그 빼고 순수 텍스트만 보이도록
		for (MsgVo msg : msgListSend) {
			String content = msg.getMsg_content();
			content = Jsoup.parse(content).text();
			if(content.length() > 30) {
				content = content.substring(0, 30).concat("...");			
			}
			content = content.replaceAll("(\r\n|\r|\n|\n\r)", " ");
			msg.setMsg_content(content);
		}
		
		model.addAttribute("msgListSend", msgListSend);
		return "msg/sendMsg";
	}
	
	@GetMapping(value = "/detailMsgRecv.do")
	public String detailMsgRecv(String no, Model model) {
		log.info("MESSAGE controller - 받은 쪽지 상세 조회로 이동");
		MsgVo msgDetail = service.selectMsgOne(no);
		
		// 쪽지 읽음 여부 변경
		if(msgDetail.getMsg_recv_read_yn().equals("N")) {
			log.info("MESSAGE controller - 쪽지를 처음 읽을 경우에만");
			int readChk = service.updateMsgRead(msgDetail);
			if(readChk == 1) {
				log.info("MESSAGE controller - 쪽지 읽음 여부 변경 성공");
			}else {
				log.info("MESSAGE controller - 쪽지 읽음 여부 변경 실패");
			}
		}
		
		// 파일 이름 불러오기
		FileVo file = service.selectFile(no);
		if(!Objects.isNull(file)) {
			model.addAttribute("file",file);
		}
		
		model.addAttribute("msgDetail", msgDetail);
		return "msg/detailMsgRecv";
	}
	
	@GetMapping(value = "/detailMsgSend.do")
	public String detailMsgSend(String no, Model model) {
		log.info("MESSAGE controller - 보낸 쪽지 상세 조회로 이동");
		MsgVo msgDetail = service.selectMsgOne(no);
		
		// 파일 이름 불러오기
		FileVo file = service.selectFile(no);
		if(!Objects.isNull(file)) {
			model.addAttribute("file",file);
		}
		
		model.addAttribute("msgDetail", msgDetail);
		return "msg/detailMsgSend";
	}
	
	@GetMapping(value = "/insertMsg.do")
	public String insertMsgForm() {
		log.info("MESSAGE controller - 쪽지 작성 페이지로 이동");
		return "msg/insertMsg";
	}
	
	@PostMapping(value = "/insertMsg.do")
	public String insertMsg(MsgVo msgVo,
							MultipartFile file,
							HttpSession session) throws IOException {
		
		// 쪽지 작성
		String empNo = ((EmpVo)session.getAttribute("loginVo")).getEmp_no();
		msgVo.setMsg_send_id(empNo);
		int msgChk = service.insertMsg(msgVo);
		
		// 파일 업로드
		if (!file.isEmpty()) { 
			FileVo fileVo = new FileVo();
			
			// 진짜 이름 
			String originFileName = file.getOriginalFilename();
			fileVo.setFile_oname(originFileName);
			log.info("MESSAGE controller - 받아온 파일의 원래 이름 : {}", originFileName);
			
			String ext = FilenameUtils.getExtension(originFileName); //파일의 확장자
			log.info("MESSAGE controller - 받아온 파일의 확장자 : {}", ext);
			
			UUID uuid = UUID.randomUUID(); 
			// 저장 이름
			String fileName = uuid + "." + ext;
			fileVo.setFile_sname(fileName);
			log.info("MESSAGE controller - 받아온 파일의 DB 저장명 : {}", fileName);
			
			// 파일 사이즈
			long fileSize = file.getSize();
			fileVo.setFile_size(fileSize);
			log.info("MESSAGE controller - 받아온 파일의 크기 : {}", fileSize);
			
			// 파일 저장될 경로
			String path = "C:/GeoProject/storage/msg/";
			File dir = new File(path);
			if (!dir.exists()) {
				dir.mkdirs();
			}
			file.transferTo(new File(path+fileName)); 

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
	
	@PostMapping(value = "/downloadMsgFile.do")
	public void fileDownload(String no,
							HttpServletResponse response) throws IOException {
		FileVo msgFile = service.selectFile(no);
		String fileOriginName = msgFile.getFile_oname();
		String fileStoredName = msgFile.getFile_sname();
		
		String dir = "C:/GeoProject/storage/msg/";
		Path path = Paths.get(dir);
		File f = new File(dir, fileStoredName);
		fileOriginName = new String(fileOriginName.getBytes(), "8859_1");
		String mimeType = Files.probeContentType(path);
		
		response.setContentType(mimeType);
		response.setContentLength((int)f.length());
		response.setHeader("Content-Disposition", "attachment;filename=\""+ fileOriginName + "\"");
		
		OutputStream os = response.getOutputStream();
		FileInputStream fis = new FileInputStream(f);
		FileCopyUtils.copy(fis, os);
		fis.close();
		os.close();
	}
	
}
