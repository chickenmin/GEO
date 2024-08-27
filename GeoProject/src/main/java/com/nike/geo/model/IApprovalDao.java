package com.nike.geo.model;

import java.io.File;
import java.util.List;
import java.util.Map;

import com.nike.geo.vo.appr.Ap_DocuVo;
import com.nike.geo.vo.appr.Ap_FavVo;
import com.nike.geo.vo.appr.Ap_LineVo;
import com.nike.geo.vo.appr.Ap_RfVo;
import com.nike.geo.vo.comm.FileVo;

public interface IApprovalDao {
	public List<Ap_FavVo> selectFavList(String empNo);
	
	//북마크 추가
	public int addFav(Map<String, Object> map);
	
	//북마크 삭제
	public int delFav(Map<String, Object> map);
	
	//서류 상신 ()
	public int submit1(Ap_DocuVo vo);
	public int submit2(Ap_DocuVo vo);
	
	//직급받기
	public int selectPos(String emp_no);
	
	//서류 번호 받기
	public int selctAPD();
	
	//결재라인 추가
	public int putLine(Ap_LineVo vo);
	
	//참조라인 추가
	public int putRef(Ap_RfVo vo);
	
	// 결재 파일 추가
	public int putFile(FileVo vo);
	
	//결재목록 조회
	public List<Ap_DocuVo> selectApproval(String emp_no);
	
	
}
