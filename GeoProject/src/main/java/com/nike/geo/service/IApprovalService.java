package com.nike.geo.service;

import java.util.List;

import com.nike.geo.vo.appr.Ap_FavVo;

public interface IApprovalService {
	
	public List<Ap_FavVo> selectFavList(String empNo);
}
