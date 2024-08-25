package com.nike.geo.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.nike.geo.model.ICommDao;
import com.nike.geo.vo.comm.CommonVo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
public class CommServiceImpl implements ICommService {
	
	private final ICommDao dao;

	@Override
		public List<CommonVo> commSelect(String division) {
			return dao.commSelect(division);
		}
}
