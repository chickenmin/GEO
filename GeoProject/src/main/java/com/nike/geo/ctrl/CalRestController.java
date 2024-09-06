package com.nike.geo.ctrl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.nike.geo.service.ICalService;
import com.nike.geo.vo.co.CalVo;

@RestController
public class CalRestController {

	@Autowired
	private ICalService iService;
	
	@GetMapping("/selectOneCal.do")
	@ResponseBody
	public CalVo select(@RequestParam String eventNo){
		System.out.println("hiiiiiiiii");
		System.out.println(eventNo);
		CalVo vo = iService.getOneCal(Integer.parseInt(eventNo));
		return vo;
	}
	
	
}
