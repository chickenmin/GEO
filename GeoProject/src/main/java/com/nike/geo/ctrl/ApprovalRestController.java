package com.nike.geo.ctrl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.nike.geo.service.IApprovalService;
import com.nike.geo.vo.appr.Ap_FavVo;

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
		int add = service.addFav(map);
		
		return (add>0)? "true":"false";
	}
	
	@PostMapping("/delFav.do")
	public String delFav(String apd_form, HttpSession session) throws InterruptedException {
//		Thread.sleep(30);
		log.info("REST 즐겨찾기 삭제");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("apd_form", apd_form);
		map.put("emp_no", session.getAttribute("empNo"));
		int del = service.delFav(map);
//		Thread.sleep(30);
		return (del>0)? "true":"false";
	}
	
	

}
