package com.nike.geo.model;

import java.util.List;

import com.nike.geo.vo.comm.CommonVo;

public interface ICommDao {
	public List<CommonVo> commSelect(String division);
}
