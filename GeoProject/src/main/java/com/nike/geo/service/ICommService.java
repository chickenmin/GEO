package com.nike.geo.service;

import java.util.List;

import com.nike.geo.vo.comm.CommonVo;

public interface ICommService {
	public List<CommonVo> commSelect(String division);
}
