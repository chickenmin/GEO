package com.test.geo;

import static org.junit.Assert.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.nike.geo.vo.bo.BoardVo;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
public class Kih_Test {
	
	//junit은 @RequiredArgsConstructor 사용불가 / @Autowired만 사용하기
	
	@Autowired
	private SqlSessionTemplate template;
	
//	@Before
	public void test() {
		assertNotNull(template);
	}
	
//	@Test
	public void insert() {
	BoardVo vo = new BoardVo();
	
	vo.setBo_content("내용6");
	vo.setBo_del_yn("N");
	vo.setBo_like_count(0);
	vo.setBo_status("announcements");
	vo.setBo_title("내용6");
	vo.setBo_view_count(0);
	vo.setEmp_no("SY001");
	vo.setMod_date("2024-08-19");
	vo.setMod_id("SY001");
	vo.setReg_date("2024-08-19");
	vo.setReg_id("SY001");

	int n = template.insert("com.nike.geo.model.BoardDaoImpl.insertBoard", vo);
	assertNotNull(template);
	}
	
	
//	@Test
	public void view_Count_Test() {
		String bo_no = "A0041";
		String emp_no = "SY003";
		
		Map<String, String> map = new HashMap<String, String>(){{
			put("bo_no", bo_no); 
			put("emp_no", emp_no);
			}};
		int cnt = template.selectOne("com.nike.geo.model.BoardDaoImpl.searchBoardOne", map);
		System.out.println(cnt>0?"읽은 사람": "아닌 사람");
		if(cnt==0) {
			template.insert("com.nike.geo.model.BoardDaoImpl.insertReadOne", map);
		}
		BoardVo resultVo =  template.selectOne("com.nike.geo.model.BoardDaoImpl.selectOne", bo_no);
		System.out.println("상세글 조회" +resultVo);
		
	}
	
	@Test
	public void like_Count_Test() {
		String bo_no = "A0062";
		String emp_no="SY001";
		
		Map<String, String>map = new HashMap<String, String>(){{
			put("bo_no", bo_no); 
			put("emp_no", emp_no);
		}};
		int cnt = template.selectOne("com.nike.geo.model.BoardDaoImpl.likeSearchBoardOne", map);
		int up =template.update("com.nike.geo.model.BoardDaoImpl.likeUpdate", map);
		if(up==0) {
			template.insert("com.nike.geo.model.BoardDaoImpl.likeInsert", map);
		}
		BoardVo resultVo =  template.selectOne("com.nike.geo.model.BoardDaoImpl.likeSelectOne", bo_no);
		System.out.println("상세글 조회" +resultVo);
		
		
	}
	
	
}
