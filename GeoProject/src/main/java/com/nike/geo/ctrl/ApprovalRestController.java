package com.nike.geo.ctrl;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.nike.geo.service.IApprovalService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

//ajax 사용 컨틀로러
@Slf4j
@RestController
@RequiredArgsConstructor
public class ApprovalRestController {
	
	private final IApprovalService service;
	
	@PostMapping("/addFav.do")
	public String addFav(String apd_form, HttpSession session) {
		log.info("Rest 즐겨찾기 추가");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("apd_form", apd_form);
		map.put("emp_no", session.getAttribute("empNo"));
		int yn = service.addFav(map);
		return (yn==1)? "true":"false";
	}

}
