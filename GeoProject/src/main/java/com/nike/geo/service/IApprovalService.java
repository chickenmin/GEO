package com.nike.geo.service;

import java.util.List;
import java.util.Map;

import com.nike.geo.vo.appr.Ap_DocuVo;
import com.nike.geo.vo.appr.Ap_FavVo;
import com.nike.geo.vo.appr.Ap_LineVo;
import com.nike.geo.vo.appr.Ap_RfVo;
import com.nike.geo.vo.comm.FileVo;

public interface IApprovalService {
	
	//북마크 조회
	public List<Ap_FavVo> selectFavList(String empNo);
	
	//북마크 설정
	public int addFav(Map<String, Object> map);
	
	//북마크 삭제
	public int delFav(Map<String, Object> map);
	
	//서류 상신 
	public int submit1(Ap_DocuVo vo);
//	public int submit2(Ap_DocuVo vo);
	public int submit2(Map<String, Object> map);
	
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
	
	//문서 상세 조회
	public Ap_DocuVo selectDeatil(String apd_no);
	
	//반려메시지 조회
	public String sel_Msg(int apd_no);
	
	//문서 결재자 조회
	public List<Ap_LineVo> selectLine(String apd_no);
	
	//첨부 파일 조회
	public List<FileVo> selectFile(String apd_no);
	
	//파일 조회
	public FileVo findFile(String file_no);

	//반려처리
	public int returnSubmit(Map<String, Object> map);

}
