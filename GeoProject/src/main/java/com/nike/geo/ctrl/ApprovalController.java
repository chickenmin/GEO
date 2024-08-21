package com.nike.geo.ctrl;

import java.util.List;

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
	public String apprHome(Model model) {
		//테스트 사원 : emp ; 로그인 구현하면, 세션에 담긴 로그인 정보 id로 파라미터 태우기
		List<Ap_FavVo> favList = dao.selectFavList("EMP");
		model.addAttribute("favList", favList);
		log.info("fav: {}",favList);
		return "AP_home";
	}
	

	// 
	@GetMapping(value = {"/{form}.do"})
	public String formDetail(@PathVariable("form") String form) {
	 	      switch(form) {
	 	         case "daily":return "form_daily";
	 	         case "dayOff":return "form_dayOff";
	 	         case "pay":return "form_pay";
	 	         case "reason":return "form_reason";
	 	         case "tripReport":return "form_tripReport";
	 	      }
	 	      return "form_"+form;
	}
	

	
	//즐겨찾기에서 상세보기
	@GetMapping("/goForm.do")
	public String goForm(Integer formNo) {
		int formNumber = formNo;
		String formPage=null;
		
		switch(formNumber) {
		case 111: formPage = "form_daily";
					break;
		case 112:formPage = "form_dayOff";
					break;
		case 113:formPage = "form_pay";
				break;
		case 114:formPage = "form_reason";
				break;
		case 115:formPage = "form_tripReport";
				break;
		}
		
		return formPage;
	}

	
	

}
