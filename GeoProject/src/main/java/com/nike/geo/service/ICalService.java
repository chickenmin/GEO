package com.nike.geo.service;

import java.util.List;
import java.util.Map;

import com.nike.geo.vo.co.CalVo;

public interface ICalService {
	
//	Calendar 일정 목록
	public List<CalVo> calList();
	
// Calendar 일정 추가
	public boolean insertCal(Map<String, Object> map);
	
// Calendar 드래그 앤 드롭	
	public int dragUpdateCal(Map<String, Object> map);

}
