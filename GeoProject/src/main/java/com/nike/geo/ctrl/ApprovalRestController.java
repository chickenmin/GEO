package com.nike.geo.ctrl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.nike.geo.service.IApprovalService;
import com.nike.geo.service.ICommService;
import com.nike.geo.service.IEmpService;
import com.nike.geo.vo.appr.Ap_FavVo;
import com.nike.geo.vo.appr.JsTreeVo;
import com.nike.geo.vo.comm.CommonVo;
import com.nike.geo.vo.hr.EmpVo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

//ajax 사용 컨틀로러
@Slf4j
@RestController
@RequiredArgsConstructor
public class ApprovalRestController {
	
	private final IApprovalService service;
	private final IEmpService empService;
	private final ICommService commService;

	
	@PostMapping("/addFav.do")
	public String addFav(String apd_form, HttpSession session) {
		log.info("Rest 즐겨찾기 추가");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("apd_form", apd_form);
		map.put("emp_no",((EmpVo)session.getAttribute("loginVo")).getEmp_no());
		int add = service.addFav(map);
		
		return (add>0)? "true":"false";
	}
	
	@PostMapping("/delFav.do")
	public String delFav(String apd_form, HttpSession session) throws InterruptedException {
		Thread.sleep(30);
		log.info("REST 즐겨찾기 삭제");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("apd_form", apd_form);
		map.put("emp_no", ((EmpVo)session.getAttribute("loginVo")).getEmp_no());
		int del = service.delFav(map);
//		Thread.sleep(30);
		return (del>0)? "true":"false";
	}
	
	@PostMapping("/jsTree.do")
	public List<JsTreeVo> jsTree() {
		List<JsTreeVo> jsTreeNodes = new ArrayList<JsTreeVo>();
		
		// 부서가져오기
		List<CommonVo> depList = commService.commSelect("부서");
		for (CommonVo c : depList) {
			jsTreeNodes.add(new JsTreeVo(
						c.getCommon_code(),c.getCode_name(),"#","http://localhost:8080/GeoProject/img/dept.png",c.getDivision()
					)); }
		
		// 사원 가져오기
		List<EmpVo> empList = empService.selectAll();
		  for (EmpVo e : empList) {
			  jsTreeNodes.add(new JsTreeVo(
						e.getEmp_no(),e.getEmp_name(),e.getEmp_dept(),"http://localhost:8080/GeoProject/img/emp.png",e.getEmp_pos()
					));  }
		 
		
		
		return jsTreeNodes;
		
	}	//jsTree.do 끝
	
	

}
