package com.nike.geo.ctrl;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.nike.geo.service.IBoardService;
import com.nike.geo.vo.bo.BoardVo;
import com.nike.geo.vo.bo.LikeVo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
public class BoardController {

	@Autowired
	private final IBoardService service;
	
	//공지게시판
	@GetMapping(value = "/announcements.do")
	public String announcements(@RequestParam(value = "type", defaultValue = "announcements") String type,Model model) {
		log.info("BoardController announcements");
		List<BoardVo> announcements=service.announcements();
		model.addAttribute("announcements",announcements);
		model.addAttribute("type", type);
		return "board/boardList";
	}
	
	//일반게시판
	@GetMapping(value = "/nomalBoard.do")
	public String nomalBoard(@RequestParam(value = "type", defaultValue = "nomalBoard") String type,Model model) {
		log.info("BoardController nomalBoard");
		List<BoardVo> nomalBoard=service.nomalBoard();
		model.addAttribute("nomalBoard", nomalBoard);
		model.addAttribute("type", type);
		return "board/boardList";
	}
	
	//삭제게시판
	@GetMapping(value = "/delBoard.do")
	public String delBoard(@RequestParam(value = "type", defaultValue = "delBoard") String type,Model model) {
		log.info("BoardController delBoard");
		List<BoardVo> delBoard=service.delBoard();
		model.addAttribute("delBoard", delBoard);
		model.addAttribute("type", type);
		return "board/boardList";
	}
	
	
	
	//글작성
	@GetMapping(value = "/writeBoard.do")
	public String writePostForm(Model model) {
		model.addAttribute("mode", "insert");
		return "board/insertBoardForm";
	}
	@PostMapping(value = "/writeBoard.do")
	public String writeBoard(BoardVo Vo,@RequestParam("bo_title") String bo_title, @RequestParam("bo_content") String bo_content) {
//	    Vo.setBo_content(bo_content);
//	    Vo.setBo_title(bo_title);

//	    // 세션에서 reg_id, mod_id를 가져와서 설정해야 할 수도 있습니다.
//	    String regId = (String) session.getAttribute("userId");
//	    String modId = regId; // 수정자는 보통 등록자와 동일할 수 있습니다.
//
//	    Vo.setReg_id(regId);
//	    Vo.setMod_id(modId);

	    boolean isc = service.insertBoard(Vo);
	    
	    if (isc) {
	        return "redirect:/announcements.do";
	    } else {
	        return "redirect:/writeBoard.do";
	    }
	}

	//글상세
	@GetMapping(value = "/detailBoard.do")
	public String detailBoard(@RequestParam("bo_no")String bo_no,@RequestParam("emp_no")String emp_no,@RequestParam Map<String,String>map, Model model) {
		BoardVo Vo=service.detailBoard(bo_no);
		BoardVo count = service.view_Count(Vo, map);
		map.put("bo_no", bo_no);
		map.put("emp_no", emp_no);
		model.addAttribute("Vo",Vo);
		model.addAttribute("count", count);
		return "board/detailBoard";
	}
	
	//글수정
	@GetMapping(value = "/modifyBoard.do")
	public String modifyBoard(@RequestParam("bo_no") String bo_no,Model model) {
		BoardVo Vo=service.detailBoard(bo_no);
		model.addAttribute("Vo",Vo);
		model.addAttribute("mode","modify");
		return "board/insertBoardForm";
	}
	
	@PostMapping(value = "/modifyBoard.do")
	public String modifyBoard(@RequestParam("bo_title")String bo_title,@RequestParam("bo_content")String bo_content,@RequestParam("bo_no")String bo_no,@RequestParam Map<String, String> map,Model model) {
		 map.put("bo_title", bo_title);
		 map.put("bo_content", bo_content);
		 map.put("bo_no", bo_no);

		boolean isc = service.modifyBoard(map);
		
		 if (isc) {
		        return "redirect:/detailBoard.do?bo_no=" + bo_no;
		    } else {
		        return "redirect:/modifyBoard.do?bo_no=" + bo_no; // 오류 발생 시 원래 수정 페이지로 돌아감
		    }
	}
	
	
	//삭제테이블이동
	@PostMapping(value = "/multiDeleteBoard.do")
	public String multiDeleteBoard(@RequestParam List<String> ch) {
	    boolean isc = service.multiDeleteBoard(ch);
	    return "redirect:/announcements.do"; // 삭제 후 게시판 목록으로 리다이렉트
	}
	
	//리얼삭제
	@PostMapping(value = "/realDelete.do")
	public String realDelete(@RequestParam List<String> ch) {
		boolean isc = service.realDelete(ch);
		return "redirect:/delBoard.do";
	}
	
	
}
