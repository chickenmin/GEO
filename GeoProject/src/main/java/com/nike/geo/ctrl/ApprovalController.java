package com.nike.geo.ctrl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.nike.geo.model.IApprovalDao;
import com.nike.geo.vo.appr.Ap_FavVo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

//일반 컨트롤러
@Slf4j
@Controller
@RequiredArgsConstructor
public class ApprovalController {
	
	private final IApprovalDao dao;
	
	@GetMapping("/apprHome.do")
	public String apprHome(Model model) {
		List<Ap_FavVo> favList = dao.selectFavList("EMP");
		model.addAttribute("favList", favList);
		log.info("fav: {}",favList);
		return "AP_home";
	}
	
	

}
