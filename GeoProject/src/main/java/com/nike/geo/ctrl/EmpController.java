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

import org.springframework.scheduling.annotation.Scheduled;
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

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class EmpController {

	private final IEmpService service;

	@PostMapping(value = "/insertEmp.do")
	public String insertEmp(EmpVo vo, Model model, HttpServletRequest request, @RequestParam("file") List<MultipartFile> file) {
		log.info("사원 추가 :{}", vo);
		int n = service.insertEmp(vo);
		if (n == 1) {
			log.info("사원 추가 성공");
		} else {
			log.info("사원 추가 실패");
		}
		
		log.info("파일 사이즈 : {}", file.size());
		
		for (MultipartFile f : file) {
			log.info("파일의 이름 : {}", f.getOriginalFilename());
			String originFileName = f.getOriginalFilename();
			String saveFileName = UUID.randomUUID().toString().concat(originFileName.substring(originFileName.indexOf(".")));
			log.info("기존파일명 : {}", originFileName);
			log.info("저장파일명 : {}", saveFileName);
			log.info("저장 파일명: {}", saveFileName);
			
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
			
			
			model.addAttribute("originFileName", originFileName);
			model.addAttribute("saveFileName", saveFileName);
			model.addAttribute("path", path);
			
		}
		
		
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
	public String myPage(HttpSession session, Model model) {
		log.info("마이 페이지");

		EmpVo loginVo = (EmpVo) session.getAttribute("loginVo");
		if (loginVo != null) {
			String emp_no = loginVo.getEmp_no();
			EmpVo vo = service.myPage(emp_no);

			model.addAttribute("vo", vo);
		} else {
			return "redirect:/login.do";
		}

		return "hr/myPage";
	}

	@GetMapping(value = "/empAtt.do")
	public String empAtt(String emp_no, Model model) {
		log.info("사원 근태 조회");
//		emp_no = "aa001";
		List<AttVo> vo = service.empAtt(emp_no);
		model.addAttribute("vo", vo);
		System.out.println("emp_no 파라미터 값: " + emp_no);
		return "hr/empAtt";
	}

	@Scheduled(cron = "0 0 4 * * *")
	@GetMapping(value = "/batchRow.do")
	public String batchRow(Model model, HttpServletRequest request) {
		log.info("batchRow");
		List<EmpVo> vo = null;
		// 공휴일조회 API 값을 아래 if문에 넣는다.
		if (true) { // 공휴일이 아니면
			service.batchRow();
		} else { // 공휴일이면

		}
		model.addAttribute("vo", vo);
		return "hr/selectAll";
	}

}
