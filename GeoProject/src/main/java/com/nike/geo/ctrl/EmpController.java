package com.nike.geo.ctrl;

import java.io.IOException;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.nike.geo.service.IEmpService;
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
			return "hr/index";
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
	public String selectAll(Model model){
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
		return "hr/selectOneEmp";
		
	}
	

}
