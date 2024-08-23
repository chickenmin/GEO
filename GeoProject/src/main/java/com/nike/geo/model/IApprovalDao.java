package com.nike.geo.model;

import java.util.List;
import java.util.Map;

import com.nike.geo.vo.appr.Ap_FavVo;

public interface IApprovalDao {
	public List<Ap_FavVo> selectFavList(String empNo);
	
	//북마크 추가
	public int addFav(Map<String, Object> map);
	
	//북마크 삭제
	public int delFav(Map<String, Object> map);

}
