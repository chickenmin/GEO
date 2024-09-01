package com.nike.geo.ctrl;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;
import java.net.http.HttpRequest;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.util.WebUtils;

import com.nike.geo.service.IApprovalService;
import com.nike.geo.vo.appr.Ap_DocuVo;
import com.nike.geo.vo.appr.Ap_FavVo;
import com.nike.geo.vo.appr.Ap_LineVo;
import com.nike.geo.vo.appr.Ap_RfVo;
import com.nike.geo.vo.comm.FileVo;
import com.nike.geo.vo.hr.EmpVo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import oracle.jdbc.proxy.annotation.Post;

//일반 컨트롤러
@Slf4j
@Controller
@RequiredArgsConstructor
public class ApprovalController {
	
	private final IApprovalService apprService; 
	private final ServletContext servletContext;
	
	// 양식홈 로드시, 즐겨찾기 리스트 전달
	@GetMapping("/apprHome.do")
	public String apprHome(Model model,HttpSession session) {
		String emp_no = ((EmpVo)session.getAttribute("loginVo")).getEmp_no();
		
		//테스트 사원 : emp ; 로그인 구현하면, 세션에 담긴 로그인 정보 id로 파라미터 태우기
		List<Ap_FavVo> favList = apprService.selectFavList(emp_no);
		model.addAttribute("favList", favList);
		log.info("fav: {}",favList);
		System.out.println(favList.size());
		return "appr/AP_home";
	}
	
	
	/////////////////////////////////////////////////////////////////////////
	// 양식 목록에서 상세보기
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
	


	/////////////////////////////////////////////////////////////////////////
	//즐겨찾기에서 상세보기
	@GetMapping("/goForm.do")
	public String goForm(String formNo, Model model) {
		model.addAttribute("apd_form", formNo);
		return "appr/form";
	}
	
	
	
	/////////////////////////////////////////////////////////////////////////
	//결재함으로 이동
	@RequestMapping(value = "/apprList.do",method = {RequestMethod.GET,RequestMethod.POST})
	public String apprList(Model model,HttpSession session, String variety) {
		log.info("결재함으로 이동");
		String emp_no = ((EmpVo)session.getAttribute("loginVo")).getEmp_no();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("variety", variety);
		map.put("emp_no", emp_no);
		
		List<Ap_DocuVo> lists = apprService.selectLists(map);
		
		model.addAttribute("lists",lists);
		model.addAttribute("variety",variety); 
		
		return "appr/apprList";
	}
	
	/////////////////////////////////////////////////////////////////////////
	//결재문서함 상세보기
	@GetMapping("/detailAppr.do")
	public String detailAppr(String apd_no,Model model, HttpServletRequest request,HttpSession session,String variety) {
		log.info("결재 문서함 상세보기");
		String emp_no = ((EmpVo)session.getAttribute("loginVo")).getEmp_no();
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("apd_no", apd_no);
		map.put("emp_no", emp_no);
		
		Ap_DocuVo vo = apprService.selectDeatil(apd_no);	//문서 상세조회
		List<Ap_LineVo> apprLists = apprService.selectLine(apd_no);	//결재자 조회
		List<FileVo> file = apprService.selectFile(apd_no);	// 이미 승인한 서명 이미지
		String apl_msg = apprService.sel_Msg(Integer.parseInt(apd_no));	//반려메시지
		
		// 결재함이 아닐 경우, 결재라인 정보 없어서 nullPointException 발생
		if (variety.equals("appr")) {
			int order = apprService.checkOrder(map);
			if (order == 1) {
				model.addAttribute("order", 1);
			}else {
				model.addAttribute("order", 0);
			}
		}
		List<FileVo> mySign = apprService.selMySign(emp_no);	//내 전자서명

		//파일 다운~~~~~~~~~~~~~~~~~~~~~~~~~~~
		String path="";	//전자서명
		try {
			//상대경로
			path = WebUtils.getRealPath(request.getSession().getServletContext(),"/signature/");	//전자서명 경로
			log.info("path {}",path);
			if (file.size()>0) {
				model.addAttribute("file", file);
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} 
		
		

		model.addAttribute("vo", vo);
		model.addAttribute("apprLists", apprLists);
//		model.addAttribute("control", "appr");
		model.addAttribute("apl_msg", apl_msg);
		model.addAttribute("mySign", mySign);
		model.addAttribute("variety", variety);
		
		return "appr/formView";
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////
	// 반려하기
	@PostMapping(value="/return.do")
	public String returnMsg(String apl_msg,int apd_no,HttpSession session,Model model) {
		String emp_no = ((EmpVo)session.getAttribute("loginVo")).getEmp_no();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("emp_no", emp_no);
		map.put("apd_no", apd_no);
		map.put("apl_msg", apl_msg);
		
		int returnSubmit = apprService.returnSubmit(map);
		if (returnSubmit ==1) {
			log.info("반려처리 완료");
			return "redirect:/apprList.do";
		}else {
			log.info("반려처리 실패");
			model.addAttribute("apd_no", apd_no);
			return "redirect:/detailAppr.do?variety=submit";
		}
	}

	
	/////////////////////////////////////////////////////////////////////////
	//다운로드
	@PostMapping(value = "/apprFile.do")
	public void fileDownload(String file_no,
							HttpServletResponse response) throws IOException {
		log.info("결재 첨부파일 다운로드");
		log.info(file_no);
		FileVo file = apprService.findFile(file_no);
		String fileOriginName = file.getFile_oname();
		String fileStoredName = file.getFile_sname();
		log.info("o:{}",fileOriginName);
		log.info("s:{}",fileStoredName);
		
		
		// C 로컬 폴더
		String dir = "C:/GeoProject/storage/appr/";
		
		//프로젝트 안의 폴더
//		String dir = "C:/Users/kkjm1/git/GEO/GeoProject/src/main/webapp/upload/";		//노트북 경로
//		String dir = "C:/Users/GDJ/git/GEO/GeoProject/src/main/webapp/upload/";			// 학원 모니터 경로
		Path path = Paths.get(dir);
		File f = new File(dir, fileStoredName);
		fileOriginName = new String(fileOriginName.getBytes("UTF-8"), "8859_1");
		String mimeType = Files.probeContentType(path);
		
		response.setContentType(mimeType);
		response.setContentLength((int)f.length());
		response.setHeader("Content-Disposition", "attachment;filename=\""+ fileOriginName + "\"");
		
		OutputStream os = response.getOutputStream();
		FileInputStream fis = new FileInputStream(f);
		FileCopyUtils.copy(fis, os);
		fis.close();
		os.close();
	}
	
	
	
	
	/////////////////////////////////////////////////////////////////////////
	//상신하기
		@PostMapping("/submitForm2.do")
		public String submitForm(@RequestParam Map<String, Object> map
								,@RequestParam(required = false, value = "ccLine")String ccLine,
								@RequestParam(required = false) List<MultipartFile> file,HttpSession session,
								@RequestParam(required = false) String temp) throws IOException {
				System.out.println("--------------"+ map);
				String variety = (String)map.get("variety");
					
				String appr_Origin = (String)map.get("apprLine");	//결재라인
				String[] appLine = appr_Origin.split(",");
				String[] cc = ccLine.split(",");
				map.put("apd_step", appLine.length);
				int submit = apprService.submit2(map);
				
				
				
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
				
				//참조라인 생성
				if (ccLine != null && !ccLine.trim().isEmpty()) {
					for (String c : cc) {
						Ap_RfVo vo = new Ap_RfVo(apd_no, c,(String)map.get("emp_no"));
						apprService.putRef(vo);
					}
				}
				boolean fileEx = (file != null);
				System.out.println("fileEX : "+fileEx);
				
				//파일이 있다면 저장
				if (file != null) {

					//파일 가져가기
					for (MultipartFile f : file) {
						if (f.isEmpty()) {
							log.info("파일없음");
						}else {
							
							//수정
							FileVo vo = new FileVo();
							vo.setFile_type(1+"");
							
							String originName = f.getOriginalFilename();
							vo.setFile_oname(originName);
							log.info("전자결재 - 받아온 파일의 원래 이름 : {}", originName);
							
							String ext = FilenameUtils.getExtension(originName);
							log.info("전자결재 - 받아온 파일의 확장자 : {}", ext);
							
							UUID uuid = UUID.randomUUID(); 
							String fileName = uuid + "." + ext;
							vo.setFile_sname(fileName);
							log.info("전자결재 - 받아온 파일의 DB 저장명 : {}", fileName);
							
							
							long fileSize = f.getSize();
							vo.setFile_size(fileSize);
							log.info("전자결재 - 받아온 파일의 크기 : {}", fileSize);
							
							//C 로컬에 저장
							String path = "C:/GeoProject/storage/appr/";
//							File dir = new File(path);
//							if (!dir.exists()) {
//								dir.mkdirs();
//							}try {
//							f.transferTo(new File(path+fileName)); 
							
						   
//							// 현재 클래스의 클래스 로더를 사용하여 프로젝트 루트 경로 얻기
							
//							String path ="C:/Users/kkjm1/git/GEO/GeoProject/src/main/webapp/upload/";	//노트북 경로
//							String path ="C:/Users/GDJ/git/GEO/GeoProject/src/main/webapp/upload/"; 	//학원 모니터 경로
					        log.info("path : {}",path);
					        File dir = new File(path);
					        if (!dir.exists()) {
					            dir.mkdirs();
					        }
					        try {
					            f.transferTo(new File(path + fileName));
					        } catch (IOException e) {
					            log.error("파일 저장 중 오류 발생", e);
					        }
							
							//문서번호
							vo.setOrigin_no(apd_no);
							//첨부자 이름
							vo.setReg_id((String)map.get("emp_no"));
							int n = apprService.putFile(vo);
							if (n ==1 ) {
								log.info("파일저장 성공");
							}
							
						}
					}	// file 의 foreach 끝
				}
				
				if(temp != null) {
					String no = (String)map.get("apd_no");
					List<String> list = Collections.singletonList(no);
					apprService.delTemp(list);
				}
				
		
			return "redirect:/apprList.do?variety="+variety;
		}
		
		
		///////////////////////////////////////////////////////////////////////////////////////////
		//전자서명 관리
		@GetMapping("/signHome.do")
		public String signHome(Model model,HttpSession session ) {
			String emp_no = ((EmpVo)session.getAttribute("loginVo")).getEmp_no();
			List<com.nike.geo.vo.comm.FileVo> signs = apprService.selMySign(emp_no);
		
			model.addAttribute("signs", signs);
			return "appr/signHome";
		}
		
		///////////////////////////////////////////////////////////////////////////
		//전자서명 등록
		@PostMapping("/enrollSign.do")
		public String enrollSign(MultipartFile file,HttpServletRequest request, HttpSession session) {

			//등록자
			String emp_no = ((EmpVo)session.getAttribute("loginVo")).getEmp_no();
			if (file.isEmpty()) {
				log.info("파일없음");
			}else {
				FileVo vo = new FileVo();
				vo.setFile_type(4+"");		//문서타입: 전자서명
				
				String originName = file.getOriginalFilename();
				vo.setFile_oname(originName);
				log.info("전자결재 - 받아온 파일의 원래 이름 : {}", originName);
				
				String ext = FilenameUtils.getExtension(originName);
				log.info("전자결재 - 받아온 파일의 확장자 : {}", ext);
				
				UUID uuid = UUID.randomUUID(); 
				String fileName = uuid + "." + ext;
				vo.setFile_sname(fileName);
				log.info("전자결재 - 받아온 파일의 DB 저장명 : {}", fileName);
				
				
				long fileSize = file.getSize();
				vo.setFile_size(fileSize);
				log.info("전자결재 - 받아온 파일의 크기 : {}", fileSize);
				
				
//				/현재 클래스의 클래스 로더를 사용하여 프로젝트 루트 경로 얻기
				String path="";	
				
				try {
					path = WebUtils.getRealPath(request.getSession().getServletContext(),"/signature/");
					log.info("path : {}",path);
					File dir = new File(path);
					if (!dir.exists()) {
						dir.mkdirs();
					} //폴더 생성
					
					try {
						file.transferTo(new File(path + originName));
					} catch (IOException e) {
						log.error("파일 저장 중 오류 발생", e);
					}
					
					//문서번호
					vo.setOrigin_no(4);
					//첨부자 이름
					vo.setReg_id(emp_no);
					int n = apprService.putFile(vo);
					if (n ==1 ) {
						log.info("파일저장 성공");
					}
				} catch (FileNotFoundException e1) {
					log.info("경로 생성 중 오류 발생");
					e1.printStackTrace();
				}
				
			} //else 끝
			return "redirect:/signHome.do";
		}//컨틀로러 끝
			
			
		//전자서명 삭제
		@PostMapping("/deleteSign.do")
			public String deleteSign(@RequestParam("signName") String[] signs,HttpSession session) {
				String emp_no = ((EmpVo)session.getAttribute("loginVo")).getEmp_no();
				log.info("사인 삭제 {}",Arrays.toString(signs));
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("reg_id", emp_no);
				map.put("list",Arrays.asList(signs) );
				apprService.delSign(map);
				return  "redirect:/signHome.do";
			}
		
		//서명완
		@PostMapping("/approve.do")
		public String approve(@RequestParam Map<String, Object>map,HttpSession session,Model model) {
			log.info("결재 승인~");
			log.info("Map : {}",map);
			String emp_no = ((EmpVo)session.getAttribute("loginVo")).getEmp_no();
			map.put("emp_no", emp_no);
			apprService.approve(map);
			model.addAttribute("apd_no",(String)map.get("apd_no"));
			return "redirect:/detailAppr.do";
		}
	
		@PostMapping("/deleteTemp.do")
		public String deleteTemp(String[] apd_nos) {
			
			apprService.delTemp(Arrays.asList(apd_nos));
			return "redirect:/apprList.do?variety=temp";
		}
	
		@GetMapping("/tempDetail.do")
		public String tempDetail(String apd_no,Model model,HttpSession session,HttpServletRequest request) {
			log.info("임시 문서함 상세보기");
			String emp_no = ((EmpVo)session.getAttribute("loginVo")).getEmp_no();
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("apd_no", apd_no);
			map.put("emp_no", emp_no);
			
			Ap_DocuVo vo = apprService.selectDeatil(apd_no);	//문서 상세조회
			List<Ap_LineVo> apprLists = apprService.selectLine(apd_no);	//결재자 조회

			
			model.addAttribute("vo", vo);
			model.addAttribute("apprLists", apprLists);
			log.info("vo 값 :{}",vo);
			return "appr/formTemp";
		}
		
		@GetMapping("/cancel.do")
		public String cancel(String apd_no) {
			apprService.cancelDocu(apd_no);
			return "redirect:/apprList.do?variety=temp";
		}
		
	
	
	
	

	
	


} //클래스 끝
		
