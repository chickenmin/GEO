package com.test.geo;

import static org.junit.Assert.*;

import java.util.List;

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
	
	@Before
	public void test() {
		assertNotNull(template);
	}
	
	@Test
	public void insert() {
	BoardVo vo = new BoardVo();
	
	vo.setBo_content("내용6");
	vo.setBo_del_yn("N");
	vo.setBo_like_count(0);
	vo.setBo_no("A0006");
	vo.setBo_regdate("2024-08-19");
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
}
