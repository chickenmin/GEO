package com.nike.geo.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.nike.geo.model.ICalDao;
import com.nike.geo.vo.co.CalVo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class CalServiceImpl implements ICalService {
	
	private final ICalDao dao;

	@Override
	public List<CalVo> calList() {
		log.info("CalServiceImpl {}", "");
		return dao.calList();
	}
	
	@Override
	public boolean insertCal(Map<String, Object> map) {
		log.info("CalServiceImpl insertCal 넘어온 값 : {}",map);
		return dao.insertCal(map);
	}

	@Override
	public int dragUpdateCal(Map<String, Object> map) {
		log.info("CalServiceImpl dragUpdateCal 넘어온 값 : {}",map);
		return dao.dragUpdateCal(map);
	}
	
}
