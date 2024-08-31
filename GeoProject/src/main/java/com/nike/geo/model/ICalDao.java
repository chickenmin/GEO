package com.nike.geo.model;

import java.util.List;
import java.util.Map;

import com.nike.geo.vo.co.CalVo;
import com.nike.geo.vo.hr.EmpVo;

public interface ICalDao {

	//전체 일정 조회
	public List<CalVo> calList();
	
	//일정 생성
	public boolean insertCal(Map<String, Object> map);
	
	
	public int dragUpdateCal(Map<String, Object> map);
	
	//일정 삭제
	public int delflagCal(String seqs);
	
	// 일정 변경
	public int updateCal(CalVo vo);
	
	public CalVo getOneCal(int no);
	
}

