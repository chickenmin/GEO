package com.nike.geo.ctrl;

import java.util.HashMap;
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
	
	
	
	//글작성
	@GetMapping(value = "/writeBoard.do")
	public String writePostForm(Model model) {
	
		model.addAttribute("mode", "insert");
		return "board/insertBoardForm";
	}
	
	@PostMapping(value = "/writeBoard.do")
	public String writeBoard(BoardVo Vo,@RequestParam("bo_title") String bo_title, @RequestParam("bo_content") String bo_content,HttpSession session) {
		EmpVo Evo = (EmpVo)session.getAttribute("loginVo");
		String writeId = Evo.getEmp_no();
		
		Vo.setEmp_no(writeId);
		Vo.setReg_id(writeId);
		
	    boolean isc = service.insertBoard(Vo);
	    
	    if (isc) {
	        return "redirect:/announcements.do";	//뒤로가기를 해야하나?
	    } else {
	        return "redirect:/writeBoard.do";
	    }
	}

	//글상세
	@GetMapping(value = "/detailBoard.do")
	public String detailBoard(@RequestParam("bo_no")String bo_no, Model model) {
		BoardVo Vo=service.detailBoard(bo_no);
		service.view_Count(Vo);
		model.addAttribute("Vo",Vo);
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
	public String modifyBoard(@RequestParam("bo_title")String bo_title,@RequestParam("bo_content")String bo_content,@RequestParam("bo_no")String bo_no,@RequestParam Map<String, String> map,HttpSession session) {
		EmpVo Evo = (EmpVo)session.getAttribute("loginVo");
		map.put("bo_title", bo_title);
		 map.put("bo_content", bo_content);
		 map.put("bo_no", bo_no);
		 map.put("mod_id", Evo.getMod_id());
			
			
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
	
	//추천수
	@PostMapping(value = "/likeCount.do")
	public String likeCount(LikeVo vo) {
	    service.likeCount(vo);
	    return "redirect:/detailBoard.do?bo_no=" + vo.getBo_no();
	}

	
}
