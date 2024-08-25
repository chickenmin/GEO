package com.test.geo;

import static org.junit.Assert.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.nike.geo.model.ApprovalDaoImpl;
import com.nike.geo.model.IApprovalDao;
import com.nike.geo.model.ICommDao;
import com.nike.geo.vo.appr.Ap_FavVo;
import com.nike.geo.vo.comm.CommonVo;

import lombok.extern.slf4j.Slf4j;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
@Slf4j
public class Kjm_Test {
	
	//junit은 @RequiredArgsConstructor 사용불가 / @Autowired만 사용하기
	
	
	@Autowired
	private IApprovalDao dao;
	
//	@Autowired
//	private ICommDao commDao;
	
	@Test
	public void test() {
		//사원별 즐겨찾기 조회
//		List<Ap_FavVo> lists = dao.selectFavList("EMP");
//		log.info("lists: {}",lists);
//		assertNotEquals(0, lists.size());
		
		//즐겨찾기 추가
//		Map<String, Object> map = new HashMap<String, Object>();
//		map.put("apd_form", "AP001");
//		map.put("emp_no", "MIN");
//		
//		int addFav = dao.addFav(map);
//		assertEquals(1, 1);
		
//		List<CommonVo> lists = commDao.commSelect("부서");
//		assertNotEquals(0, lists.size());
	
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("emp_no", "emp");
		map.put("apd_con", "내용");
		map.put("apd_step", 3);
		map.put("apd_days", "2024-08-07");
//		map.put("apd_half_yn", 'N');
		map.put("apd_form", "AP001");
		
		int submit = dao.submit(map);
		assertEquals(1, submit);
		
	}
	


}
