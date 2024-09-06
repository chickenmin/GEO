package com.nike.geo.ctrl;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.util.WebUtils;

import com.nike.geo.service.IEmpService;
import com.nike.geo.vo.hr.AttVo;
import com.nike.geo.vo.hr.EmpVo;
import com.nike.geo.vo.hr.VacaVo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class EmpController {

	private final IEmpService service;

	@PostMapping(value = "/insertEmp.do")
	public String insertEmp(EmpVo vo, Model model, HttpServletRequest request, List<MultipartFile> file) {
		log.info("사원 추가 :{}", vo);

		String saveFileName= null;
		for (MultipartFile f : file) {
			log.info("파일의 이름 : {}", f.getOriginalFilename());
			String originFileName = f.getOriginalFilename();
			saveFileName = UUID.randomUUID().toString().concat(originFileName.substring(originFileName.indexOf(".")));
			log.info("기존파일명 : {}", originFileName);
			log.info("저장파일명 : {}", saveFileName);
			
			InputStream inputStream = null;
			OutputStream outputStream = null;
			String path = "";
			
			try {
				inputStream = f.getInputStream();
				
				path = WebUtils.getRealPath(request.getSession().getServletContext(), "/storage");
				String path02 = request.getSession().getServletContext().getRealPath("storage");
				log.info("저장경로 path : {} \n path02 : {}", path, path02);
				
				
				File storage = new File(path);
				if(!storage.exists()) {
					storage.mkdirs();
				}
				
				File newFile = new File(path+"/"+saveFileName);
				if(!newFile.exists()) {
					newFile.createNewFile();
				}
				
				outputStream = new FileOutputStream(newFile);
				
				int read = 0;
				byte[] b = new byte[(int)f.getSize()];
				while((read = inputStream.read(b)) != -1) {
					outputStream.write(b, 0, read);
				}
			} catch (IOException e) {
				e.printStackTrace();
			} finally {
				try {
					inputStream.close();
					outputStream.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}

			vo.setEmp_img(saveFileName);
		
		}
		
		int n = service.insertEmp(vo);
		
		if (n == 1) {
			log.info("사원 추가 성공");
		} else {
			log.info("사원 추가 실패");
		}
		
		model.addAttribute("saveFileName", saveFileName);
		String fileUrl = "/storage/" + saveFileName;
	    model.addAttribute("fileUrl", fileUrl);
		
		return "redirect:selectOneEmp.do?emp_no=" + vo.getEmp_no();
		
	}

	@GetMapping(value = "/insertEmp.do")
	public String insertEmp(Model model, HttpServletRequest request) {
		log.info("사원 추가");
		return "hr/insertEmp";
	}

	@GetMapping(value = "/selectAll.do")
	public String selectAll(Model model, HttpServletRequest request) {
		log.info("사원 전체 조회");
		List<EmpVo> vo = service.selectAll();
		model.addAttribute("vo", vo);
		return "hr/selectAll";
	}

	@GetMapping(value = "/selectOneEmp.do")
	public String selectOneEmp(String emp_no, String saveFileName, Model model) {
		log.info("사원 상세 조회");
//		emp_no = "PR001";
		EmpVo vo = service.selectOneEmp(emp_no);
		AttVo attVo = service.empAtt(emp_no);
		VacaVo vacaVo = service.vaCheck(emp_no);
		model.addAttribute("vo", vo);
		model.addAttribute("saveFileName", saveFileName);
		model.addAttribute("attVo", attVo);
		model.addAttribute("vacaVo", vacaVo);
		return "hr/selectOneEmp";
	}

	@PostMapping("/updateEmp.do")
	public String updateEmployee(EmpVo vo) {
		log.info("사원 정보 업데이트: {}", vo);
		service.updateEmp(vo);
		return "redirect:selectOneEmp.do?emp_no=" + vo.getEmp_no();

	}

	@PostMapping(value = "/clearPw.do")
	public String clearPw(@RequestParam("emp_no") String emp_no) {
		log.info("비밀번호 초기화");
		EmpVo vo = new EmpVo();
		vo.setEmp_no(emp_no);
		service.clearPw(vo);
		return "redirect:selectOneEmp.do?emp_no=" + vo.getEmp_no();
	}


	@GetMapping(value = "/myPage.do")
	public String myPage(HttpSession session, HttpServletRequest request, String saveFileName, Model model) {
		log.info("마이 페이지");
		EmpVo loginVo = (EmpVo) session.getAttribute("loginVo");
		if (loginVo != null) {
			String emp_no = loginVo.getEmp_no();
			request.setAttribute("loginVo", loginVo);
			
			EmpVo vo = service.myPage(emp_no);
			model.addAttribute("vo", vo);
			
			AttVo empAtt = service.empAtt(emp_no);
	        model.addAttribute("empAtt", empAtt);
	        
	        VacaVo vacaVo = service.vaCheck(emp_no);
	        model.addAttribute("vacaVo", vacaVo);
	        
	        List<VacaVo> usedDate = service.usedDate(emp_no);
	        model.addAttribute("usedDate", usedDate);
	        
	        List<VacaVo> usedHalf = service.usedHalf(emp_no);
	        model.addAttribute("usedHalf", usedHalf);
	        
	        VacaVo usedNum = service.usedNum(emp_no);
	        model.addAttribute("usedNum", usedNum);
	        
	        VacaVo usedHalfNum = service.usedHalfNum(emp_no);
	        model.addAttribute("usedHalfNum", usedHalfNum);
		} else {
			return "redirect:/login.do";
		}

		return "hr/myPage";
	}

	
	@GetMapping(value = "/org.do")
	public String org(Model model, String saveFileName, String emp_no, HttpServletRequest request) {
		log.info("조직도");
		List<EmpVo> vo = service.selectAll();
		model.addAttribute("vo", vo);
		model.addAttribute("saveFileName", saveFileName);
		return "hr/org";
	}
	
	
	




}
