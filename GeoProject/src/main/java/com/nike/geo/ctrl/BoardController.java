package com.nike.geo.ctrl;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.util.WebUtils;

import com.nike.geo.service.IBoardService;
import com.nike.geo.service.ICommService;
import com.nike.geo.vo.bo.BoardVo;
import com.nike.geo.vo.bo.CommVo;
import com.nike.geo.vo.bo.LikeVo;
import com.nike.geo.vo.comm.FileVo;
import com.nike.geo.vo.hr.EmpVo;
import com.nike.geo.vo.msg.NotiVo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
public class BoardController {

	private final IBoardService service;
	
	private final ICommService commService;
	
	//공지게시판
	@GetMapping(value = "/announcements.do")
	public String announcements(Model model) {
		log.info("BoardController announcements");
		List<BoardVo> announcements=service.announcements();
		model.addAttribute("announcements",announcements);
		return "board/annoBoard";
	}
	
	//일반게시판
	@GetMapping(value = "/nomalBoard.do")
	public String nomalBoard(Model model) {
		log.info("BoardController nomalBoard");
		List<BoardVo> nomalBoard=service.nomalBoard();
		model.addAttribute("nomalBoard", nomalBoard);
		return "board/nomalBoard";
	}
	
	//삭제게시판
	@GetMapping(value = "/delBoard.do")
	public String delBoard(Model model) {
		log.info("BoardController delBoard");
		List<BoardVo> delBoard=service.delBoard();
		model.addAttribute("delBoard", delBoard);
		return "board/delBoard";
	}

	//글작성
	@GetMapping(value = "/writeBoard.do")
	public String writePostForm(Model model) {
		model.addAttribute("mode", "insert");
		
		return "board/insertBoard";
	}
	
	@PostMapping(value = "/writeBoard.do")
	public String writeBoard(BoardVo Vo,
							@RequestParam Map<String, Object> map,
							@RequestParam("bo_title") String bo_title, 
							@RequestParam("bo_content") String bo_content,
							@RequestParam("bo_status")String bo_status,
							HttpSession session,
							@RequestParam List<MultipartFile> file,
 							HttpServletRequest request,Model model,
 							 @RequestParam(value = "bo_no", required = false) Integer bo_no)
 							throws IOException {

		EmpVo Evo = (EmpVo)session.getAttribute("loginVo");
		String writeId = Evo.getEmp_no();
		Vo.setEmp_no(writeId);
		Vo.setBo_title(bo_title);  // 제목 설정
		Vo.setBo_content(Vo.getBo_content().replaceAll("\\r\n", "<br>"));
		Vo.setBo_status(bo_status);  // 상태 설정
		boolean isc = service.insertBoard(Vo);
    
		if(bo_status.equals("announcements")) {
			List<String> empStList = commService.selectEmpSt();
			Map<String, Object> notiMap = new HashMap<String, Object>();
//			map.put("emp_no", Vo.getEmp_no());
			notiMap.put("emp_list", empStList);
			notiMap.put("noti_status", "1");
			notiMap.put("noti_content", "사내 공지사항 - '" + Vo.getBo_title() + "' 게시글이 등록되었습니다.");
			notiMap.put("parent_no",Vo.getBo_no());
			notiMap.put("origin_no","B"+Vo.getBo_no());
			commService.insertNoti(notiMap);
		}
		commService.updateAdminNoti(); // 관리자는 읽음처리
    
		//파일이 있다면 저장
		if (file != null) {

			//파일 가져가기
			for (MultipartFile f : file) {
				if (f.isEmpty()) {
					log.info("파일없음");
				}else {
					
					//수정
					FileVo Fvo = new FileVo();
					Fvo.setFile_type(2+"");
					
					String originName = f.getOriginalFilename();
					Fvo.setFile_oname(originName);
					log.info("게시판 - 받아온 파일의 원래 이름 : {}", originName);
					
					String ext = FilenameUtils.getExtension(originName);
					log.info("게시판- 받아온 파일의 확장자 : {}", ext);
					
					UUID uuid = UUID.randomUUID(); 
					String fileName = uuid + "." + ext;
					Fvo.setFile_sname(fileName);
					log.info("게시판 - 받아온 파일의 DB 저장명 : {}", fileName);
					
					
					long fileSize = f.getSize();
					Fvo.setFile_size(fileSize);
					log.info("게시판 - 받아온 파일의 크기 : {}", fileSize);
					
					//C 로컬에 저장
					String path = WebUtils.getRealPath(request.getSession().getServletContext(),"/board/");
							//  "C:/GeoProject/storage/appr/";
				   
//					// 현재 클래스의 클래스 로더를 사용하여 프로젝트 루트 경로 얻기
					
//					String path ="C:/Users/GDJ/git/GEO/GeoProject/src/main/webapp/upload/"; 	//학원 모니터 경로
			        log.info("path : {}",path);
			        File dir = new File(path);
			        if (!dir.exists()) {
			            dir.mkdirs();
			        }
			        try {
			            f.transferTo(new File(path + fileName));
			        } catch (IOException e) {
			            log.error("파일 저장 중 오류 발생", e);
			        }
					
					//문서번호
					Fvo.setOrigin_no(Vo.getBo_no());	
					//첨부자 이름
//					Fvo.setReg_id((String)map.get("emp_no"));
					EmpVo evo= (EmpVo)session.getAttribute("loginVo");
					
					Fvo.setReg_id(evo.getEmp_no());
					log.info("regId{}",evo.getEmp_no());
					int n = service.putFile(Fvo);
					if (n ==1 ) {
						log.info("파일저장 성공");
					}
					
				}
			}	// file 의 foreach 끝
		}
		
		if (isc) {
			if ("announcements".equals(bo_status)) {
				return "redirect:/announcements.do";  // 공지사항 페이지로 리다이렉트
			} else if ("nomalBoard".equals(bo_status)) {
				return "redirect:/nomalBoard.do";  // 일반게시판 페이지로 리다이렉트
			}
		} 
		
	    // 실패 시 원래 페이지로 리다이렉트
	    return "redirect:/writeBoard.do";
	    
	}
	
	//파일다운로드
		@PostMapping(value = "/boardFile.do")
		public void fileDownload(String file_no,
								HttpServletResponse response
								,HttpServletRequest request) throws IOException {
			log.info("결재 첨부파일 다운로드");
			log.info(file_no);
			FileVo file = service.findFile(file_no);
			String fileOriginName = file.getFile_oname();
			String fileStoredName = file.getFile_sname();
			log.info("o:{}",fileOriginName);
			log.info("s:{}",fileStoredName);
			
			// C 로컬 폴더
			String dir ;
					/*"C:/GeoProject/storage/appr/"; */
			dir = WebUtils.getRealPath(request.getSession().getServletContext(),"/board/");	//전자서명 경로
			
			//프로젝트 안의 폴더
//			String dir = "C:/Users/GDJ/git/GEO/GeoProject/src/main/webapp/upload/";			// 학원 모니터 경로
			Path path = Paths.get(dir);
			File f = new File(dir, fileStoredName);
			fileOriginName = new String(fileOriginName.getBytes("UTF-8"), "8859_1");
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
	
	//글상세
	@GetMapping(value = "/detailBoard.do")
	public String detailBoard(@RequestParam("bo_no")int bo_no, 
								Model model,
								HttpSession session) {
		
		List<FileVo> file = service.selectFile(bo_no+"");
		model.addAttribute("file", file);
		
		
		EmpVo Evo = (EmpVo) session.getAttribute("loginVo");
		String detailId=Evo.getEmp_no();
		BoardVo Vo=service.detailBoard(bo_no);
		BoardVo Bvo=service.detailBoard(bo_no);
		model.addAttribute("Bvo", Bvo);
		Vo.setEmp_no(detailId);
		service.view_Count(Vo);
		model.addAttribute("Vo",Vo);
		model.addAttribute("emp_name", Evo.getEmp_name());
		
		// 알림 읽음 여부 변경
		NotiVo noti = new NotiVo();
		noti.setEmp_no(detailId);
		noti.setOrigin_no("B"+Bvo.getBo_no());
		String notiReadYn = commService.selectNotiRead(noti);
		if("N".equals(notiReadYn)) {
			log.info("알림을 받고 처음 글을 읽을 경우에만");
			int readChk = commService.updateNotiRead(noti);
			if(readChk == 1) {
				log.info("알림 읽음 여부 변경 성공");
			}else {
				log.info("알림 읽음 여부 변경 실패");
			}
		}
				
		return "board/detailBoard";
	}

	
	//글수정
	@GetMapping(value = "/modifyBoard.do")
	public String modifyBoard(@RequestParam("bo_no") int bo_no,
								Model model
								) {
		BoardVo Vo=service.detailBoard(bo_no);
		model.addAttribute("Vo",Vo);
		model.addAttribute("mode","modify");
		return "board/insertBoard";
	}
	
	@PostMapping(value = "/modifyBoard.do")
	public String modifyBoard(BoardVo Vo,
							@RequestParam Map<String, Object> map,
							@RequestParam("bo_title") String bo_title, 
							@RequestParam("bo_content") String bo_content,
							@RequestParam("bo_status")String bo_status,
							HttpSession session,
							@RequestParam List<MultipartFile> file,
								HttpServletRequest request,Model model,
								 @RequestParam(value = "bo_no", required = false) Integer bo_no)
								throws IOException {
		EmpVo Evo = (EmpVo)session.getAttribute("loginVo");
		map.put("bo_title", bo_title);
		 map.put("bo_content", bo_content.replaceAll("\\r\n", "<br>"));
		 map.put("bo_no", bo_no);
		 map.put("emp_no", Evo.getEmp_no());
			
		boolean isc = service.modifyBoard(map);
		
		 // 기존 파일 비활성화
	    if (bo_no != null) {
	        Map<String, Object> delFileMap = new HashMap<>();
	        delFileMap.put("origin_no", bo_no);
	        delFileMap.put("mod_id", Evo.getEmp_no());
	        service.delFile(delFileMap);
	    }
		
		//파일이 있다면 저장
				if (file != null) {

					//파일 가져가기
					for (MultipartFile f : file) {
						if (f.isEmpty()) {
							log.info("파일없음");
						}else {
							
							//수정
							FileVo Fvo = new FileVo();
							Fvo.setFile_type(2+"");
							
							String originName = f.getOriginalFilename();
							Fvo.setFile_oname(originName);
							log.info("게시판 - 받아온 파일의 원래 이름 : {}", originName);
							
							String ext = FilenameUtils.getExtension(originName);
							log.info("게시판- 받아온 파일의 확장자 : {}", ext);
							
							UUID uuid = UUID.randomUUID(); 
							String fileName = uuid + "." + ext;
							Fvo.setFile_sname(fileName);
							log.info("게시판 - 받아온 파일의 DB 저장명 : {}", fileName);
							
							
							long fileSize = f.getSize();
							Fvo.setFile_size(fileSize);
							log.info("게시판 - 받아온 파일의 크기 : {}", fileSize);
							
							//C 로컬에 저장
							String path = WebUtils.getRealPath(request.getSession().getServletContext(),"/board/");
									//  "C:/GeoProject/storage/appr/";
						   
//							// 현재 클래스의 클래스 로더를 사용하여 프로젝트 루트 경로 얻기
							
//							String path ="C:/Users/GDJ/git/GEO/GeoProject/src/main/webapp/upload/"; 	//학원 모니터 경로
					        log.info("path : {}",path);
					        File dir = new File(path);
					        if (!dir.exists()) {
					            dir.mkdirs();
					        }
					        try {
					            f.transferTo(new File(path + fileName));
					        } catch (IOException e) {
					            log.error("파일 저장 중 오류 발생", e);
					        }
							
							//문서번호
							Fvo.setOrigin_no(bo_no);
							//첨부자 이름
							Fvo.setReg_id((String)map.get("emp_no"));
							int n = service.putFile(Fvo);
							if (n ==1 ) {
								log.info("파일저장 성공");
							}
							
						}
					}	// file 의 foreach 끝
				}
		
		 if (isc) {
		        return "redirect:/detailBoard.do?bo_no=" + bo_no;
		    } else {
		        return "redirect:/modifyBoard.do?bo_no=" + bo_no; 
		    }
	}
	
	
	//삭제테이블이동
	@PostMapping(value = "/multiDeleteBoard.do")
	public String multiDeleteBoard(@RequestParam List<String> ch) {
	    service.multiDeleteBoard(ch);
	    return "redirect:/delBoard.do"; // 삭제 후 게시판 목록으로 리다이렉트
	}
	
	//글복구
	@PostMapping(value = "/recoveryBoard.do")
	public String recoveryBoard(@RequestParam List<String> ch) {
	    service.recoveryBoard(ch);
	    return "redirect:/delBoard.do"; // 삭제 후 게시판 목록으로 리다이렉트
	}
	
	//리얼삭제
	@PostMapping(value = "/realDelete.do")
	public String realDelete(@RequestParam List<String> ch) {
		service.realDelete(ch);
		return "redirect:/delBoard.do";
	}
	
	//추천수
	@PostMapping(value = "/likeCount.do")
	public String likeCount(LikeVo vo,HttpSession session) {
		EmpVo Evo= (EmpVo) session.getAttribute("loginVo");
		String likeId=Evo.getEmp_no();
		vo.setEmp_no(likeId);
	    service.likeCount(vo);
	    return "redirect:/detailBoard.do?bo_no=" + vo.getBo_no();
	}

	//댓글
	@GetMapping("/commList.do")
	@ResponseBody
	public List<CommVo> commList(@RequestParam("bo_no") int bo_no) {
        // 댓글 리스트를 가져옵니다
        List<CommVo> comments = service.commList(bo_no);
        return comments; // JSON으로 자동 변환되어 클라이언트에 반환됩니다
    }
	
	//댓글쓰기
	@PostMapping("/commentInsert.do")
	public String commentInsert(CommVo vo,@RequestParam("bo_no")int bo_no,@RequestParam("comm_content")String comm_content,HttpSession session) {
		EmpVo Evo=(EmpVo) session.getAttribute("loginVo");
		vo.setBo_no(bo_no);
		vo.setEmp_no(Evo.getEmp_no());
		vo.setEmp_name(Evo.getEmp_name());
		vo.setComm_content(comm_content);
		service.commentInsert(vo);
		return "redirect:/detailBoard.do?bo_no=" + bo_no;
	}
}
