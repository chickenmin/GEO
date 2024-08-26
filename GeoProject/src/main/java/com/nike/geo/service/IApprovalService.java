package com.nike.geo.service;

import java.util.List;
import java.util.Map;

import com.nike.geo.vo.appr.Ap_FavVo;

public interface IApprovalService {
	
	//북마크 조회
	public List<Ap_FavVo> selectFavList(String empNo);
	
	//북마크 설정
	public int addFav(Map<String, Object> map);
	
	//북마크 삭제
	public int delFav(Map<String, Object> map);
	
	//서류 상신 
	public int submit(Map<String, Object> map);
	
	//직급받기
	public int selectPos(String emp_no);
	
	//서류 번호 받기
	public int selctAPD();
	
}
