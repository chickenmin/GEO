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
import javax.websocket.Session;

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
import com.nike.geo.vo.comm.FileVo;
import com.nike.geo.vo.hr.EmpVo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

//일반 컨트롤러
@Slf4j
@Controller
@RequiredArgsConstructor
public class ApprovalController {
	
	private final IApprovalService apprService; 
	private final IEmpService empService; 
	
	// 양식홈 로드시, 즐겨찾기 리스트 전달
	@GetMapping("/apprHome.do")
	public String apprHome(Model model,HttpSession session) {
		EmpVo loginVo = new EmpVo();
		loginVo.setEmp_no("emp6");
		session.setAttribute("loginVo", loginVo);
		String emp_no = ((EmpVo)session.getAttribute("loginVo")).getEmp_no();
		
		//테스트 사원 : emp ; 로그인 구현하면, 세션에 담긴 로그인 정보 id로 파라미터 태우기
		List<Ap_FavVo> favList = apprService.selectFavList(emp_no);
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
	 	         default :	model.addAttribute("apd_form", "AP005");
	 	        	 				return "appr/form";
	 	      }
	}
	


	
	//즐겨찾기에서 상세보기
	@GetMapping("/goForm.do")
	public String goForm(String formNo, Model model) {
		model.addAttribute("apd_form", formNo);
		return "appr/form";
	}
	
	//상신하기
	@PostMapping("/submitForm.do")
	public String submitForm(@RequestParam Map<String, Object> map, 
							@RequestParam(required = false)String ccLine,
							@RequestParam(required = false) List<MultipartFile> file,HttpSession session) throws IOException {
			//기안자 emp_no
			String emp_no = 
					((EmpVo)session.getAttribute("loginVo")).getEmp_no(); //
			
			//전달받은 값들
			String date = (String)map.get("dates");		//날짜
			String content = (String)map.get("content");	// 내용
			String appr_Origin = (String)map.get("apprLine");	//결재라인
			String apd_form = (String)map.get("apd_form"); 	//기안양식
			String[] appLine = appr_Origin.split(",");
			String[] cc = ccLine.split(",");
			System.out.println(appLine);
			
			
			// form 내용으로 docu vo 생성
			Ap_DocuVo docuVo = new Ap_DocuVo(emp_no, content, appLine.length, date, apd_form);
			int submit = apprService.submit2(docuVo);
			
			//만들어진 문서 번호 가져오기
			int apd_no = apprService.selctAPD();
			//결재수
			int approval =0;
			
			//결재라인 생성
			for (String app : appLine) {
				//직급 순차
				int apl_order = apprService.selectPos(app);
				Ap_LineVo LineVo= new Ap_LineVo(apd_no, app, apl_order);
				approval += apprService.putLine(LineVo);
			}
			
			if (ccLine != null && !ccLine.trim().isEmpty()) {
				for (String c : cc) {
					Ap_RfVo vo = new Ap_RfVo(apd_no, c,emp_no);
					apprService.putRef(vo);
				}
			}
			
			if (file == null) {
				return "appr/AP_home";
			}
			
			//파일이 있다면 저장

				//파일 가져가기
				for (MultipartFile f : file) {
					if (f.isEmpty()) {
						log.info("파일없음");
					}else {
						FileVo vo = new FileVo();
						
						//결재파일 번호
						vo.setOrigin_no(apd_no);
						//첨부자 이름
						vo.setReg_id(emp_no);
						
						log.info("파일의 이름 : {}",f.getOriginalFilename() );
						
						//파일 진자 이름
						String originFileName = f.getOriginalFilename();
						vo.setFile_oname(originFileName);
						
						//저장이름
						String saveFileName = UUID.randomUUID().toString().concat(originFileName.substring(originFileName.indexOf(".")));
						vo.setFile_sname(saveFileName);
						
						log.info("기존 파일명 {}",originFileName);
						log.info("저장 파일명 {}",saveFileName);
						
						//파일 사이즈
						long fileSize = f.getSize();
						vo.setFile_size(fileSize);
						
						InputStream inputStream = null;
						OutputStream outputStream = null;
						
						try {
							// 1)파일을 읽는다
							inputStream = f.getInputStream();
							
							//2) 저장 위치를 만든다
							String path1 = "C:/GeoProject/storage/appr";
							log.info("저장경로 path : {}",path1);
							
							
							// 3) 파일 저장 위치
							File storage = new File(path1);
							if (!storage.exists()) {
								storage.mkdirs();
								log.info("경로 폴더 생성");
							}
							
							//4) 저장 파일 : 저장할 파일이 없다면 생성하고 있다면 오버라이드함
							File newFile = new File(path1+"/"+originFileName);
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
						int n = apprService.putFile(vo);
						if (n ==1 ) {
							log.info("파일저장 성공");
						}
					}
				}	// file 의 foreach 끝
	
			
		
		return "appr/AP_home";
	}
	
	@PostMapping(value = "/tempSubmit.do")
	public String tempSubmit(@RequestParam Map<String, Object> map, 
			@RequestParam(required = false)String ccLine,
			@RequestParam(required = false) List<MultipartFile> file,HttpSession session){
		
		//기안자 emp_no
		String emp_no = 
				((EmpVo)session.getAttribute("loginVo")).getEmp_no(); //
		
		//전달받은 값들
		String date = (String)map.get("dates");		//날짜
		String content = (String)map.get("content");	// 내용
		String appr_Origin = (String)map.get("apprLine");	//결재라인
		String apd_form = (String)map.get("apd_form"); 	//기안양식
		String[] appLine = appr_Origin.split(",");
		String[] cc = ccLine.split(",");
		System.out.println(appLine);
		
		
		// form 내용으로 docu vo 생성
		Ap_DocuVo docuVo = new Ap_DocuVo(emp_no, content, appLine.length, date, apd_form);
		int submit = apprService.submit1(docuVo);
		
		//만들어진 문서 번호 가져오기
		int apd_no = apprService.selctAPD();
		//결재수
		int approval = 0;
		
		//결재라인 생성
		for (String app : appLine) {
			//직급 순차
			int apl_order = apprService.selectPos(app);
			Ap_LineVo LineVo= new Ap_LineVo(apd_no, app, apl_order);
			approval += apprService.putLine(LineVo);
		}
		
		//참조
		if (ccLine != null && !ccLine.trim().isEmpty()) {
			for (String c : cc) {
				Ap_RfVo vo = new Ap_RfVo(apd_no, c,emp_no);
				apprService.putRef(vo);
			}
		}


		//파일 아예 안받아온 form이면 이제 끝
		if (file == null) {
			return "appr/AP_home";
		}
		

			//파일 저장
			for (MultipartFile f : file) {
				//file첨부 가능하나, 안한 경우
				if (f.isEmpty()) {
					log.info("파일없음");
				}else {	//파일 첨부 한 경우
				FileVo vo = new FileVo();


				
				//결재파일 번호
				vo.setOrigin_no(apd_no);
				//첨부자 이름
				vo.setReg_id(emp_no);
				
				log.info("파일의 이름 : {}",f.getOriginalFilename() );
				
				//파일 진자 이름
				String originFileName = f.getOriginalFilename();
				vo.setFile_oname(originFileName);
				
				//저장이름
				String saveFileName = UUID.randomUUID().toString().concat(originFileName.substring(originFileName.indexOf(".")));
				vo.setFile_sname(saveFileName);
				
				log.info("기존 파일명 {}",originFileName);
				log.info("저장 파일명 {}",saveFileName);
				
				//파일 사이즈
				long fileSize = f.getSize();
				vo.setFile_size(fileSize);
				
				InputStream inputStream = null;
				OutputStream outputStream = null;
				
				try {
					// 1)파일을 읽는다
					inputStream = f.getInputStream();
					
					//2) 저장 위치를 만든다
					String path1 = "C:/GeoProject/storage/appr";
					log.info("저장경로 path : {}",path1);
					
					
					// 3) 파일 저장 위치
					File storage = new File(path1);
					if (!storage.exists()) {
						storage.mkdirs();
						log.info("경로 폴더 생성");
					}
					
					//4) 저장 파일 : 저장할 파일이 없다면 생성하고 있다면 오버라이드함
					File newFile = new File(path1+"/"+originFileName);
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
				int n = apprService.putFile(vo);
				if (n ==1 ) {
					log.info("파일저장 성공");
				}
				}
			}	// file 의 foreach 끝

		
		return "appr/AP_home";
	}
	
	
	@GetMapping("/apprList.do")
	public String apprList(Model model,HttpSession session) {
		log.info("결재함으로 이동");
		String emp_no = ((EmpVo)session.getAttribute("loginVo")).getEmp_no();
		List<Ap_DocuVo> lists = apprService.selectApproval(emp_no);
		model.addAttribute("lists",lists);
		return "appr/apprList";
	}
	
	@GetMapping("/detailAppr.do")
	public String detailAppr(String apd_no) {
		log.info("상신문서함 상세보기");
		return "appr/AP_home";
	}

	

	
	

}
