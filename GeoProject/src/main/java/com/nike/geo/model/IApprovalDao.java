package com.nike.geo.model;

import java.util.List;
import java.util.Map;

import com.nike.geo.vo.appr.Ap_FavVo;

public interface IApprovalDao {
	public List<Ap_FavVo> selectFavList(String empNo);
	
	public int addFav(Map<String, Object> map);
//	public int delFav(String emp_no, String apd_form);

}
