package com.nike.geo.ctrl;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.nike.geo.service.IBoardService;
import com.nike.geo.service.ICommService;
import com.nike.geo.service.IEmpService;
import com.nike.geo.service.IMsgService;
import com.nike.geo.vo.appr.Ap_DocuVo;
import com.nike.geo.vo.bo.BoardVo;
import com.nike.geo.vo.co.CalVo;
import com.nike.geo.vo.comm.FileVo;
import com.nike.geo.vo.hr.AttVo;
import com.nike.geo.vo.hr.EmpVo;
import com.nike.geo.vo.msg.MsgVo;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MsgController {
	
	@Autowired
	private IMsgService service;
	
	@Autowired
	private ICommService commService;
	
	@Autowired
	private IBoardService boardService;
	
	@Autowired
	private IEmpService empService;
	
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
	public String index(HttpSession session, Model model) {
		log.info("MESSAGE controller - index 페이지로 이동");
		EmpVo loginVo = (EmpVo)session.getAttribute("loginVo");
		String empNo = loginVo.getEmp_no();

		// 사원 월간 근태 정보
		AttVo attVo = empService.empAttMonth(empNo);
		model.addAttribute("attVo", attVo);
		
		// 사원 정보
		EmpVo mainVo = commService.selectMainEmp(empNo);
		log.info("MESSAGE controller - index에 띄울 사원정보 {}", mainVo);
		model.addAttribute("mainVo", mainVo);
		
		// 게시판 (공지/일반)
		String status = "announcements";
		List<BoardVo> board = commService.selectMainBoard(status);
		model.addAttribute("board", board);
		
		// 결재 현황 - 완료C, 대기W, 진행중P, 반려R
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("emp_no", empNo);
		
		map.put("apd_status", "C");
		int complete = commService.selectMainAppr(map);
		model.addAttribute("complete", complete);

		map.put("apd_status", "W");
		int waiting = commService.selectMainAppr(map);
		model.addAttribute("waiting", waiting);

		map.put("apd_status", "P");
		int progress = commService.selectMainAppr(map);
		model.addAttribute("progress", progress);

		map.put("apd_status", "R");
		int reject = commService.selectMainAppr(map);
		model.addAttribute("reject", reject);

		int sum = complete + waiting + progress + reject;
		model.addAttribute("sum", sum);
				
		// 결재 문서함
		List<Ap_DocuVo> docu = commService.selectMainDocu(empNo);
		for (Ap_DocuVo d : docu) {
			String content = d.getApd_con();
			content = Jsoup.parse(content).text();
			if(content.length() > 30) {
				content = content.substring(0, 30).concat("...");			
			}
			content = content.replaceAll("(\r\n|\r|\n|\n\r)", " ");
			d.setApd_con(content);
		}
		model.addAttribute("docu", docu);

		// 일정
		List<CalVo> calList = commService.selectMainCal(loginVo.getEmp_no());
		log.info("MESSAGE controller - index에 띄울 일정 정보 {}", calList);
		model.addAttribute("calList", calList);
		
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
	public String insertMsgForm(@RequestParam(value = "id", required = false) String id,
								Model model) {
		log.info("MESSAGE controller - 쪽지 작성 페이지로 이동");
		model.addAttribute("id", id);
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
			
//			// 파일 사이즈
			long fileSize = file.getSize();
			fileVo.setFile_size(fileSize);
			log.info("MESSAGE controller - 받아온 파일의 크기 : {}", fileSize);
			
//			// 파일 저장될 경로
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
