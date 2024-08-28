package com.nike.geo.ctrl;

import java.io.IOException;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.nike.geo.service.IEmpService;
import com.nike.geo.vo.hr.AttVo;
import com.nike.geo.vo.hr.EmpVo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class EmpController {

	private final IEmpService service;

	@PostMapping(value = "/insertEmp.do")
	public String insertEmp(EmpVo vo) throws IOException {
		log.info("사원 추가 :{}", vo);
		int n = service.insertEmp(vo);
		if(n == 1) {
			return "redirect:selectOneEmp.do?emp_no="+vo.getEmp_no();
		}else {
			return null;
		}
	}
	
	@GetMapping(value = "/insertEmp.do")
	public String insertEmp(Model model) {
		log.info("사원 추가");
		return "hr/insertEmp";
	}
	
	@GetMapping(value = "/selectAll.do")
	public String selectAll(Model model) {
		log.info("사원 전체 조회");
		List<EmpVo> vo = service.selectAll();
		model.addAttribute("vo", vo);
		return "hr/selectAll";
	}
	
	@GetMapping(value = "/selectOneEmp.do")
	public String selectOneEmp(String emp_no, Model model) {
		log.info("사원 상세 조회");
//		emp_no = "PR001";
		EmpVo vo = service.selectOneEmp(emp_no);
		model.addAttribute("vo", vo);
		return "hr/selectOneEmp";
	}
	
	
	@PostMapping("/updateEmp.do")
	public String updateEmployee(EmpVo vo) {
	    log.info("사원 정보 업데이트: {}", vo);
	    service.updateEmp(vo);
		return "redirect:selectOneEmp.do?emp_no="+vo.getEmp_no();
		
	}
	
	@PostMapping(value = "/clearPw.do")
	public String clearPw(@RequestParam("emp_no") String emp_no) {
		log.info("비밀번호 초기화");
		EmpVo vo = new EmpVo();
		vo.setEmp_no(emp_no);
		service.clearPw(vo);
		return "redirect:selectOneEmp.do?emp_no="+vo.getEmp_no();
	}
	
	@PostMapping(value = "/arriveWork.do")
	public String arriveWork(Model model, String emp_no) {
		AttVo vo = new AttVo();
	    vo.setEmp_no(emp_no);
		log.info("출근 했습니다");
		service.arriveWork(vo);
		model.addAttribute("vo", vo);
		return "comm/index";
	}
	
	@PostMapping(value = "/leftWork.do")
	public String leftWork(Model model, AttVo vo) {
		log.info("퇴근 완료");
		service.leftWork(vo);
		model.addAttribute("vo", vo);
		return "comm/index";
	}
	
	@GetMapping(value = "/myPage.do")
	public String myPage(String emp_no, Model model) {
		log.info("마이 페이지");
		EmpVo vo = service.selectOneEmp("aa001");
		model.addAttribute("vo", vo);
		return "hr/myPage";
		
	}
	
	@GetMapping(value = "/empAtt.do")
	public String empAtt(String emp_no, Model model) {
		log.info("사원 근태 조회");
		AttVo vo = service.empAtt("aa001");
		model.addAttribute("vo", vo);
		return "hr/empAtt";
	}
	


}
