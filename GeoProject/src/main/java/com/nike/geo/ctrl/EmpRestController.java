package com.nike.geo.ctrl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.nike.geo.service.ICommService;
import com.nike.geo.service.IEmpService;
import com.nike.geo.vo.appr.JsTreeVo;
import com.nike.geo.vo.comm.CommonVo;
import com.nike.geo.vo.hr.AttVo;
import com.nike.geo.vo.hr.EmpVo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequiredArgsConstructor
public class EmpRestController {

	private final ICommService commService;
	private final IEmpService empService;

	@PostMapping(value = "/arriveWork.do")
	@ResponseBody
	public Map<String, String> arriveWork(@RequestParam("emp_no") String emp_no, HttpSession session) {
		log.info("출석 체크");
		Map<String, String> response = new HashMap<>();

		try {
			// 출근 처리 로직
			// 예: service.arriveWork(empNo);
			empService.arriveWork(emp_no);
			session.setAttribute("emp_no", emp_no);

			response.put("status", "success");
			response.put("message", "출근 처리가 완료되었습니다.");
		} catch (Exception e) {
			response.put("status", "error");
			response.put("message", "출근 처리 중 오류가 발생했습니다.");
		}

		return response;
	}

	@PostMapping(value = "/leftWork.do")
	@ResponseBody
	public Map<String, String> leftWork(@RequestParam("emp_no") String emp_no, HttpSession session) {
		Map<String, String> response = new HashMap<>();

		try {
			// 퇴근 처리 로직
			// 예: service.leftWork(empNo);

			empService.arriveWork(emp_no);
//			session.getAttribute(emp_no);

			response.put("status", "success");
			response.put("message", "퇴근 처리가 완료되었습니다.");
		} catch (Exception e) {
			response.put("status", "error");
			response.put("message", "퇴근 처리 중 오류가 발생했습니다.");
		}

		return response;
	}

//	@GetMapping("/org.do")
//	public List<JsTreeVo> jsTree() {
//		List<JsTreeVo> jsTreeNodes = new ArrayList<JsTreeVo>();
//
//		// 부서가져오기
//		List<CommonVo> depList = commService.commSelect("부서");
//		for (CommonVo c : depList) {
//			jsTreeNodes.add(new JsTreeVo(c.getCommon_code(), c.getCode_name(), "#",
//					"http://localhost:8080/GeoProject/img/dept.png", c.getDivision()));
//		}
//
//		// 사원 가져오기
//		List<EmpVo> empList = empService.selectAll();
//		for (EmpVo e : empList) {
//			jsTreeNodes.add(new JsTreeVo(e.getEmp_no(), e.getEmp_name(), e.getEmp_dept(),
//					"http://localhost:8080/GeoProject/img/emp.png", e.getEmp_pos()));
//		}
//
//		return jsTreeNodes;

//	} // jsTree.do 끝
	
	

}
