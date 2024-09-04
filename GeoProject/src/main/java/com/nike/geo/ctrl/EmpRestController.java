package com.nike.geo.ctrl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
	public Map<String, String> arriveWork(String emp_no, HttpSession session) {
		log.info("출석 체크");
		log.info("Received emp_no: {}", emp_no);
		Map<String, String> response1 = new HashMap<>();
		int n = empService.arriveWork(emp_no);
		session.setAttribute("emp_no", emp_no);
		if (n >0) {
			// 출근 처리 로직
			// 예: service.arriveWork(empNo);
			

			response1.put("status", "success");
			response1.put("message", "출근 처리가 완료되었습니다.");
		} else {
			response1.put("status", "error");
			response1.put("message", "출근 처리 중 오류가 발생했습니다.");
		}

		return response1;
	}

	@PostMapping(value = "/leftWork.do")
	public Map<String, String> leftWork(String emp_no, HttpSession session) {
		Map<String, String> response1 = new HashMap<>();

		try {
			// 퇴근 처리 로직
			// 예: service.leftWork(empNo);

			empService.leftWork(emp_no);
			session.setAttribute("emp_no", emp_no);

			response1.put("status", "success");
			response1.put("message", "퇴근 처리가 완료되었습니다.");
		} catch (Exception e) {
			response1.put("status", "error");
			response1.put("message", "퇴근 처리 중 오류가 발생했습니다.");
		}

		return response1;
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
