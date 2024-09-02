package com.nike.geo.ctrl;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.util.Base64Utils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.nike.geo.service.IApprovalService;
import com.nike.geo.service.ICommService;
import com.nike.geo.service.IEmpService;
import com.nike.geo.vo.appr.Ap_DocuVo;
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
	
	
	@PostMapping("/changeClass.do")
	public List<Ap_DocuVo> changeClass(String apd_status, HttpSession session) {
		String emp_no = ((EmpVo)session.getAttribute("loginVo")).getEmp_no();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("emp_no", emp_no);
		map.put("apd_status", apd_status);
		List<Ap_DocuVo> statusList = service.selectStatus(map);
		
		return statusList;
	}
	
	 @PostMapping("/saveSignature.do")
	    public ResponseEntity<String> saveSignature(@RequestBody SignatureRequest request) {
		 log.info("saveSignature 입성 ");
	        String dataUrl = request.getImage();

	        // Data URL에서 Base64 데이터 분리
	        String base64Image = dataUrl.split(",")[1];

	        // Base64 디코딩
	        byte[] imageBytes = Base64Utils.decodeFromString(base64Image);

	        // 저장할 파일 경로 설정
	        String fileName = "signature_" + System.currentTimeMillis() + ".png";
	        log.info("{}",fileName);
	        String filePath = "signatures/" + fileName; // 'signatures' 폴더가 존재해야 합니다.

	        // 'signatures' 디렉토리 없으면 생성
	        File directory = new File("signatures");
	        if (!directory.exists()) {
	            directory.mkdirs();
	        }

	        // 파일 저장
	        try (FileOutputStream fos = new FileOutputStream(filePath)) {
	            fos.write(imageBytes);
	            fos.flush();
	            return ResponseEntity.ok("서명이 성공적으로 저장되었습니다.");
	        } catch (IOException e) {
	            e.printStackTrace();
	            return ResponseEntity.status(500).body("서명 저장에 실패했습니다.");
	        }
	    }

	    // 요청 바디를 매핑할 DTO 클래스
	    public static class SignatureRequest {
	        private String image;

	        public String getImage() {
	            return image;
	        }

	        public void setImage(String image) {
	            this.image = image;
	        }
	    }
	
	

}
