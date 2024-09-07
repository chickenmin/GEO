package com.nike.geo.ctrl;


import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.nike.geo.service.ICalService;
import com.nike.geo.vo.co.CalVo;
import com.nike.geo.vo.hr.EmpVo;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
public class CalController {

	private static final Logger log = LoggerFactory.getLogger(CalController.class);
    
	@Autowired
	private ICalService iService;
	
	@RequestMapping(value = "/calendar.do", method = RequestMethod.GET)
	public String list() {
		log.info("CalendarController list");
		return "Cal/Calendar";
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/calendarAjax.do", method = RequestMethod.GET)
	@ResponseBody
	public JSONArray date(Model model,@RequestParam String chk) {
		log.info("메소드시작");
		String[] chkArray = new String[chk.split(",").length];
		for (int i=0 ; i<chk.split(",").length ; i++) {
			chkArray[i] = chk.split(",")[i];
		}
		List<CalVo> lists = iService.calList(chkArray);
		System.out.println("datedatedatedatedate" + lists.toString());
		JSONArray arr = new JSONArray();
		for (CalVo vo : lists) {
			JSONObject obj = new JSONObject();
			obj.put("no", vo.getCal_no());
			obj.put("title", vo.getCal_title());
			obj.put("content", vo.getCal_content());
			obj.put("start", vo.getCal_start());
			obj.put("end", vo.getCal_stop());
			obj.put("type", vo.getCal_type()); 
			obj.put("open", vo.getCal_open_yn());
			String color;
	        //그룹 id 별로 컬러 설정 변경해주기
			if(vo.getCal_type() == null) {
				color="#123C38";
			}else {
	        switch (vo.getCal_type()) {
			case "0" :
				color = "#CB6F18";
				break;
			case "1" :
				color = "#8EA499";
				break;
			case "2" :
				color = "#FCB31E";
				break;
				
			default:
				color = "#123C38" ;
	        	}
			}
	        
	        obj.put("color", color);
	        
	        System.out.println(obj);
	        
			arr.add(obj);
			

		}
		log.info("JSONArray 파싱한 값 : {}", arr);
		// return 형태
		// [{},{},{}....]
		return arr;
	
}

	
	/**
	 * 일정 등록
	 * @param map 받아오는 form의 값 : 작성자, 일정명, 내용, 그룹, 시작일, 종료일
	 * @return 성공 : true / 실패 : false
	 */
	@RequestMapping(value = "/calendarInsert.do", method = RequestMethod.POST)
	@ResponseBody
	public boolean calendarInsert(@RequestParam Map<String, Object> map) {
		log.info("받아오는 값 : {}", map);
		boolean isc = iService.insertCal(map);
		log.info("CalendarController calendarInsert 성공여부 : {}", isc);
		return isc;
	}
	
	/**
	 * 드래그 일정 수정
	 * @param map 받아오는 값 : start, end, id
	 * @return String  "true" / "false"
	 */
//	@RequestMapping(value = "/updateDragAjax.do", method = RequestMethod.POST)
//	@ResponseBody
//	public String updateAjax(@RequestParam Map<String, Object> map) {
//		log.info("CalController updateAjax 받아온 값 : {}", map);
//		String isc = "false";
//			if (iService.dragUpdateCal(map) > 0) {
//				isc = "true";
//				System.out.println(isc);
//			}
//		return isc;
//	}
	
	
	@GetMapping(value = "/delflagCal.do")
	public String deleteMsgRecv(@RequestParam String cal_no) {
		log.info("Calendar controller - 일정 삭제");
		log.info("Calendar controller - cal_no의 값 : {}", cal_no);
		int deleteNum = iService.delflagCal(cal_no);
		return "redirect:/calendar.do";
	}
	
	@PostMapping(value = "/updateCal.do")
	@ResponseBody
	public String updateCal(CalVo vo) {
		log.info("사원 정보 업데이트: {}", vo);
		iService.updateCal(vo);
		return "redirect:selectOneCal.do?cal_no=" + vo.getCal_no();

	}
	
    @GetMapping("/calendar")
    @ResponseBody
    public String getCalendar(@RequestParam("type") int type) {
        switch (type) {
            case 0:
                return "전사일정: [일정1, 일정2, 일정3]";
            case 1:
                return "부서일정: [부서일정1, 부서일정2]";
            case 2:
                return "사원일정: [사원일정1, 사원일정2]";
            default:
                return "알 수 없는 일정 유형";
        }
    }
	
}
