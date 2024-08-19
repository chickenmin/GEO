package com.nike.geo.model;

import java.util.List;

import com.nike.geo.vo.appr.Ap_FavVo;

public interface IApprovalDao {
	public List<Ap_FavVo> selectFavList(String empNo);

}
