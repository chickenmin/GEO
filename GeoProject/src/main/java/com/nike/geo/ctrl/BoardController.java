package com.nike.geo.ctrl;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.util.WebUtils;

import com.nike.geo.service.IBoardService;
import com.nike.geo.vo.bo.BoardVo;
import com.nike.geo.vo.bo.CommVo;
import com.nike.geo.vo.bo.LikeVo;
import com.nike.geo.vo.hr.EmpVo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
public class BoardController {

	private final IBoardService service;
	
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

	
	
	//글작성 bo_status 로 값을 보내줘야 쿼리가 동작 가능
	@GetMapping(value = "/writeBoard.do")
	public String writePostForm(Model model) {
		model.addAttribute("mode", "insert");
		
		return "board/insertBoard";
	}
	
	@PostMapping(value = "/writeBoard.do")
	public String writeBoard(BoardVo Vo,
							@RequestParam("bo_title") String bo_title, 
							@RequestParam("bo_content") String bo_content,
							@RequestParam("bo_status")String bo_status,
							HttpSession session) {
		EmpVo Evo = (EmpVo)session.getAttribute("loginVo");
		String writeId = Evo.getEmp_no();
		Vo.setEmp_no(writeId);
		Vo.setBo_title(bo_title);  // 제목 설정
		Vo.setBo_content(Vo.getBo_content().replaceAll("\\r\n", "<br>"));
	    Vo.setBo_status(bo_status);  // 상태 설정
	    boolean isc = service.insertBoard(Vo);
	    
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

	//글상세
	@GetMapping(value = "/detailBoard.do")
	public String detailBoard(@RequestParam("bo_no")String bo_no, 
								Model model) {
		BoardVo Vo=service.detailBoard(bo_no);
		service.view_Count(Vo);
		model.addAttribute("Vo",Vo);
		return "board/detailBoard";
	}

	
	//글수정
	@GetMapping(value = "/modifyBoard.do")
	public String modifyBoard(@RequestParam("bo_no") String bo_no,
								Model model
								) {
		BoardVo Vo=service.detailBoard(bo_no);
		model.addAttribute("Vo",Vo);
		model.addAttribute("mode","modify");
		return "board/insertBoard";
	}
	
	@PostMapping(value = "/modifyBoard.do")
	public String modifyBoard(@RequestParam("bo_title")String bo_title,
								@RequestParam("bo_content")String bo_content,
								@RequestParam("bo_no")String bo_no,
								@RequestParam Map<String, String> map,
								HttpSession session) {
		EmpVo Evo = (EmpVo)session.getAttribute("loginVo");
		map.put("bo_title", bo_title);
		 map.put("bo_content", bo_content);
		 map.put("bo_no", bo_no);
		 map.put("emp_no", Evo.getEmp_no());
			
			
		boolean isc = service.modifyBoard(map);
		
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
	public List<CommVo> commList(@RequestParam("bo_no") String bo_no) {
        // 댓글 리스트를 가져옵니다
        List<CommVo> comments = service.commList(bo_no);
        return comments; // JSON으로 자동 변환되어 클라이언트에 반환됩니다
    }
	
	//댓글쓰기
	@PostMapping("/commentInsert.do")
	public String commentInsert(CommVo vo,@RequestParam("bo_no")String bo_no,@RequestParam("comm_content")String comm_content,HttpSession session) {
		EmpVo Evo=(EmpVo) session.getAttribute("loginVo");
		vo.setBo_no(bo_no);
		vo.setEmp_no(Evo.getEmp_no());
		vo.setComm_content(comm_content);
		service.commentInsert(vo);
		return "redirect:/detailBoard.do?bo_no=" + bo_no;
	}
	
	
	//파일업로드
	@PostMapping(value = "/uploadAjax.do")
	@ResponseBody
	public Map<String, String> fileUploadAjax(HttpServletRequest request,
												Model model,
												List<MultipartFile>file,
												String desc
												){
		log.info("FileuploadController uploadAjax.do 파일 업로드");
		
		for(MultipartFile f : file) {
			log.info("파일의 이름 : {}",f.getOriginalFilename());
			String originFileName = f.getOriginalFilename();
			String saveFileName=UUID.randomUUID().toString().concat(originFileName.substring(originFileName.indexOf(".")));
			log.info("기존파일명 : {}",originFileName);
			log.info("저장파일명 : {}",saveFileName);
			
		InputStream inputStream = null;
		OutputStream outputStream = null;
		String path = "";
		
		try {
			//1)파일을 읽는다
			inputStream = f.getInputStream();
			
			//2)저장위치를 만든다
			path = WebUtils.getRealPath(request.getSession().getServletContext(), "/storage");//상대경로
			String path02 = request.getSession().getServletContext().getRealPath("storage");
			log.info("저장경로 : {} \n path02 : {}",path,path02);
			
			//3)파일 저장 위치
			File storage = new File(path);
			if(!storage.exists()) {
				storage.mkdir();
			}
			
			//4)저장 파일 저장할 파일이 없다면 생성하면 있다면 오버라이드 함
			File newFile=new File(path+"/"+saveFileName);
			if(!newFile.exists()) {
				newFile.createNewFile();
			}
			
			//5)읽은 파일을 써주기(저장)
			outputStream = new FileOutputStream(newFile);
			
			//5)파일 읽어서 대상파일에 써줌
			int read = 0;
			byte[] b = new byte[(int)f.getSize()];
			while((read=inputStream.read(b))!= -1) {
				outputStream.write(b,0,read);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}finally {
			try {
				inputStream.close();
				outputStream.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		model.addAttribute("originFileName",originFileName);
		model.addAttribute("saveFileName",saveFileName);
		model.addAttribute("path",path);
		}
		
		Map<String, String>map =new HashMap<String, String>();
		map.put("isc", "true");
		
		return map; 
	}
	
	
}
