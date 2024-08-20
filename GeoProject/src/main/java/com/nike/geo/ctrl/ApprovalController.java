package com.nike.geo.ctrl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

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
	
	//양식홈
	@GetMapping("/apprHome.do")
	public String apprHome(Model model) {
		//테스트 사원 : emp ; 로그인 구현하면, 세션에 담긴 로그인 정보 id로 파라미터 태우기
		List<Ap_FavVo> favList = dao.selectFavList("EMP");
		model.addAttribute("favList", favList);
		log.info("fav: {}",favList);
		return "AP_home";
	}
	
	//양식 상세보기로 이동
	@GetMapping("/daily.do")
	public String daily() {
		return "form_daily";
	}
	
	@GetMapping("/dayOff.do")
	public String dayOff() {
		return "form_dayOff";
	}
	
	
	@GetMapping("/pay.do")
	public String pay() {
		return "form_pay";
	}
	
	
	@GetMapping("/reason.do")
	public String reson() {
		return "form_reason";
	}
	
	
	@GetMapping("/tripReport.do")
	public String tripReport() {
		return "form_tripReport";
	}
	
	@GetMapping("/goForm.do")
	public String goForm(Integer formNo) {
		int formNumber = formNo;
		String formPage=null;
		
		switch(formNumber) {
		case 111: formPage = "/daily.do";
					break;
		case 112:formPage = "/dayOff.do";
					break;
		case 113:formPage = "/dayOff.do";
				break;
		case 114:formPage = "/dayOff.do";
				break;
		case 115:formPage = "/dayOff.do";
				break;
		}
		
		return "redirect:."+formPage;
	}

	
	

}
