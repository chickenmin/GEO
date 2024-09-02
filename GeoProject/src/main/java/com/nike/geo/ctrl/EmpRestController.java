package com.nike.geo.ctrl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.nike.geo.service.ICommService;
import com.nike.geo.service.IEmpService;
import com.nike.geo.vo.appr.JsTreeVo;
import com.nike.geo.vo.comm.CommonVo;
import com.nike.geo.vo.hr.EmpVo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequiredArgsConstructor
public class EmpRestController {

	private final ICommService commService;
	private final IEmpService empService;
	
	@GetMapping("/org.do")
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
