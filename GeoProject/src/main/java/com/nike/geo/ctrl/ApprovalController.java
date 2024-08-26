package com.nike.geo.ctrl;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.util.WebUtils;

import com.nike.geo.service.IApprovalService;
import com.nike.geo.service.IEmpService;
import com.nike.geo.vo.appr.Ap_DocuVo;
import com.nike.geo.vo.appr.Ap_FavVo;
import com.nike.geo.vo.appr.Ap_LineVo;
import com.nike.geo.vo.appr.Ap_RfVo;
import com.nike.geo.vo.hr.EmpVo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

//일반 컨트롤러
@Slf4j
@Controller
@RequiredArgsConstructor
public class ApprovalController {
	
	private final IApprovalService apprDao; 
	private final IEmpService empService;
	
	// 양식홈 로드시, 즐겨찾기 리스트 전달
	@GetMapping("/apprHome.do")
	public String apprHome(Model model,HttpSession session) {
		EmpVo loginVo = new EmpVo();
		loginVo.setEmp_no("EMP");
		session.setAttribute("loginVo", loginVo);
		String emp_no = ((EmpVo)session.getAttribute("loginVo")).getEmp_no();
		
		//테스트 사원 : emp ; 로그인 구현하면, 세션에 담긴 로그인 정보 id로 파라미터 태우기
		List<Ap_FavVo> favList = apprDao.selectFavList(emp_no);
		model.addAttribute("favList", favList);
		log.info("fav: {}",favList);
		System.out.println(favList.size());
		return "appr/AP_home";
	}
	

	// 
	@GetMapping(value = {"/{form}.do"})
	public String formDetail(@PathVariable("form") String form, Model model ) {
		log.info("양식으로 이동");
	 	      switch(form) {
	 	         case "daily":	model.addAttribute("apd_form", "AP001");
	 	         					return "appr/form";
	 	         case "dayOff":	model.addAttribute("apd_form", "AP002");
	 	        	 				return "appr/form";
	 	         case "pay":	model.addAttribute("apd_form", "AP003");
	 	        	 				return "appr/form";
	 	         case "reason":	model.addAttribute("apd_form", "AP004");
	 	        	 				return "appr/form";
	 	         case "tripReport":	model.addAttribute("apd_form", "AP005");
	 	        	 				return "appr/form";
	 	      }
	 	      return "appr/form_"+form;
	}
	


	
	//즐겨찾기에서 상세보기
	@GetMapping("/goForm.do")
	public String goForm(String formNo, Model model) {
		model.addAttribute("apd_form", formNo);
		return "appr/form";
	}
	
	//상신하기
	@PostMapping("/submitForm.do")
	public String submitForm(@RequestParam(required = false) Map<String, Object> map, 
							@RequestParam List<MultipartFile> file,HttpSession session) {
		//기안자 emp_no
		String emp_no = 
				((EmpVo)session.getAttribute("loginVo")).getEmp_no(); //
		
		//전달받은 값들
		String date = (String)map.get("dates");		//날짜
		String content = (String)map.get("content");	// 내용
		String appr_Origin = (String)map.get("apprLine");	//결재라인
		String cc_Origin = (String)map.get("ccLine");	//참조라인
		String apd_form = (String)map.get("apd_form"); 	//기안양식
		String[] appLine = appr_Origin.split(",");
		String[] ccLine = cc_Origin.split(",");
		System.out.println(appLine);
		
		
		// form 내용으로 docu vo 생성
		Ap_DocuVo docuVo = new Ap_DocuVo(emp_no, content, appLine.length, date, apd_form);
		int submit = apprDao.submit2(docuVo);
		
		//만들어진 문서 번호 가져오기
		int apd_no = apprDao.selctAPD();
		//결재수
		int approval =0;
		
		//결재라인 생성
		for (String app : appLine) {
			//직급 순차
			int apl_order = apprDao.selectPos(app);
			Ap_LineVo LineVo= new Ap_LineVo(apd_no, app, apl_order);
			approval += apprDao.putLine(LineVo);
		}
		
		if (ccLine != null) {
			for (String c : ccLine) {
				Ap_RfVo vo = new Ap_RfVo(apd_no, c,emp_no);
				apprDao.putRef(vo);
			}
		}
		
		
		//파일 가져가기
		for (MultipartFile f : file) {
			log.info("파일의 이름 : {}",f.getOriginalFilename() );
			String originFileName = f.getOriginalFilename();
			String saveFileName = UUID.randomUUID().toString().concat(originFileName.substring(originFileName.indexOf(".")));
			log.info("기존 파일명 {}",originFileName);
			log.info("기존 파일명 {}",saveFileName);
			
			
			InputStream inputStream = null;
			OutputStream outputStream = null;
			String path = "";
			
			try {
				// 1)파일을 읽는다
				inputStream = f.getInputStream();
				
				//2) 저장 위치를 만든다
				path = WebUtils.getRealPath(session.getServletContext(),"/storage"); //상대경로
				String path02 = session.getServletContext().getRealPath("storage");
				log.info("저장경로 path : {}\n path02 : {}",path,path02);
				
				
				// 3) 파일 저장 위치
				File storage = new File(path);
				if (!storage.exists()) {
					storage.mkdirs();
				}
				
				//4) 저장 파일 : 저장할 파일이 없다면 생성하고 있다면 오버라이드함
				File newFile = new File(path+"/"+saveFileName);
				if (!newFile.exists()) {
					newFile.createNewFile();
				}
				
				// 5) 읽은 파일을 써주기  (저장)
				outputStream = new FileOutputStream(newFile);
				
				//6) 파일을 읽어서 대상 파일에 써줌 
				int read = 0;
				byte[] b = new byte[(int)f.getSize()];
				while ((read = inputStream.read(b)) != -1) {
					outputStream.write(b,0,read);
					
				}
				
			} catch (IOException e) {
				e.printStackTrace();
			}finally {
				try {
					inputStream.close();
					outputStream.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		return (submit==1 && approval==appLine.length)?"appr/AP_home":"appr/form_daily";
	}
	
	

	

	
	

}
