package com.nike.geo.model;

import java.util.List;
import java.util.Map;

import com.nike.geo.vo.co.CalVo;

public interface ICalDao {

	public List<CalVo> calList();
	
	public boolean insertCal(Map<String, Object> map);
	
	public int dragUpdateCal(Map<String, Object> map);
}
