package com.nike.geo.ctrl;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import com.nike.geo.model.IApprovalDao;
import com.nike.geo.service.IApprovalService;
import com.nike.geo.vo.appr.Ap_FavVo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

//일반 컨트롤러
@Slf4j
@Controller
@RequiredArgsConstructor
public class ApprovalController {
	
	private final IApprovalService dao;
	
	// 양식홈 로드시, 즐겨찾기 리스트 전달
	@GetMapping("/apprHome.do")
	public String apprHome(Model model,HttpSession session) {
		session.setAttribute("empNo", "EMP");
		String empId = (String)session.getAttribute("empNo");
		
		//테스트 사원 : emp ; 로그인 구현하면, 세션에 담긴 로그인 정보 id로 파라미터 태우기
		List<Ap_FavVo> favList = dao.selectFavList(empId);
		model.addAttribute("favList", favList);
		log.info("fav: {}",favList);
		System.out.println(favList.size());
		return "appr/AP_home";
	}
	

	// 
	@GetMapping(value = {"/{form}.do"})
	public String formDetail(@PathVariable("form") String form) {
		log.info("양식으로 이동");
	 	      switch(form) {
	 	         case "daily":return "appr/form_daily";
	 	         case "dayOff":return "appr/form_dayOff";
	 	         case "pay":return "appr/form_pay";
	 	         case "reason":return "appr/form_reason";
	 	         case "tripReport":return "appr/form_tripReport";
	 	      }
	 	      return "appr/form_"+form;
	}
	

	
	//즐겨찾기에서 상세보기
	@GetMapping("/goForm.do")
	public String goForm(String formNo) {
		
		switch(formNo) {
		case "AP001": return "appr/form_daily";
		case "AP002": return "appr/form_dayOff";
		case "AP003": return "appr/form_pay";
		case "AP004": return "appr/form_reason";
		case "AP005": return "appr/form_tripReport";
		}
		
		return "appr/"+formNo;
	}

	
	

}
