package com.nike.geo.ctrl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.nike.geo.model.IApprovalDao;
import com.nike.geo.service.IApprovalService;
import com.nike.geo.service.IEmpService;
import com.nike.geo.vo.appr.Ap_FavVo;
import com.nike.geo.vo.hr.EmpVo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

//일반 컨트롤러
@Slf4j
@Controller
@RequiredArgsConstructor
public class ApprovalController {
	
	private final IApprovalService apprDao; 
	
	// 양식홈 로드시, 즐겨찾기 리스트 전달
	@GetMapping("/apprHome.do")
	public String apprHome(Model model,HttpSession session) {
		session.setAttribute("empNo", "EMP");
		String empId = (String)session.getAttribute("empNo");
		
		//테스트 사원 : emp ; 로그인 구현하면, 세션에 담긴 로그인 정보 id로 파라미터 태우기
		List<Ap_FavVo> favList = apprDao.selectFavList(empId);
		model.addAttribute("favList", favList);
		log.info("fav: {}",favList);
		System.out.println(favList.size());
		return "appr/AP_home";
	}
	

	// 
	@GetMapping(value = {"/{form}.do"})
	public String formDetail(@PathVariable("form") String form, Model model ) {
		log.info("양식으로 이동");
	 	      switch(form) {
	 	         case "daily":	model.addAttribute("apd_form", "AP001");
	 	         					return "appr/form";
	 	         case "dayOff":	model.addAttribute("apd_form", "AP002");
	 	        	 				return "appr/form";
	 	         case "pay":	model.addAttribute("apd_form", "AP003");
	 	        	 				return "appr/form";
	 	         case "reason":	model.addAttribute("apd_form", "AP004");
	 	        	 				return "appr/form";
	 	         case "tripReport":	model.addAttribute("apd_form", "AP005");
	 	        	 				return "appr/form";
	 	      }
	 	      return "appr/form_"+form;
	}
	
//	@GetMapping(value = {"/{form}.do"})
//	public String formDetail(@PathVariable("form") String form,Model model ) {
//		log.info("양식으로 이동");
//		switch(form) {
//		case "daily":	model.addAttribute("apd_form", "AP001");
//		return "appr/form_daily";
//		case "dayOff":	model.addAttribute("apd_form", "AP002");
//		return "appr/form_dayOff";
//		case "pay":	model.addAttribute("apd_form", "AP003");
//		return "appr/form_pay";
//		case "reason":	model.addAttribute("apd_form", "AP004");
//		return "appr/form_reason";
//		case "tripReport":	model.addAttribute("apd_form", "AP005");
//		return "appr/form_tripReport";
//		}
//		return "appr/form_"+form;
//	}
//	

	
	//즐겨찾기에서 상세보기
	@GetMapping("/goForm.do")
	public String goForm(String formNo, Model model) {
		
		model.addAttribute("apd_form", formNo);
		
		return "appr/form";
	}
	
	@PostMapping("/submitForm.do")
	public String submitForm(@RequestParam(required = false) Map<String, Object> map, HttpSession session) {
		//전달받은 값들
		String date = (String)map.get("dates");
		String content = (String)map.get("content");
		String apprLine = (String)map.get("apprLine");
		String ccLineOrigin = (String)map.get("ccLine");
		String  emp_no = (String)map.get("emp_no");
		String apd_form = (String)map.get("apd_form"); 
		String[] ccLine = ccLineOrigin.split(",");
		
		//문서에 넣어주기
		Map<String, Object> map2 = new HashMap<String, Object>();
		map2.put("emp_no", "emp");
		map2.put("apd_con", content);
		map2.put("apd_step", 3);
		map2.put("apd_days", date);
		map2.put("apd_form", apd_form);
		
		int submit = apprDao.submit(map2);
		
		
		
		return (submit==1)?"appr/AP_home":"appr/form_daily";
	}
	
	

	

	
	

}
