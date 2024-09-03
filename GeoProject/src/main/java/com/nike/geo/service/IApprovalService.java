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
	
	//결재문서 상태별 조회
	public List<Ap_DocuVo> selectStatus(Map<String, Object> map);
	
	//문서 상세 조회
	public Ap_DocuVo selectDeatil(String apd_no);
	
	//반려메시지 조회
	public String sel_Msg(int apd_no);
	
	//내 서명 조회
	public List<FileVo> selMySign(String emp_no);
	
	//순서인지 확인
	public int checkOrder(Map<String, Object> map);
	
	//문서 결재자 조회
	public List<Ap_LineVo> selectLine(String apd_no);
	
	//첨부 파일 조회
	public List<FileVo> selectFile(String origin_no);
	
	//파일 조회
	public FileVo findFile(String file_no);

	//반려처리
	public int returnSubmit(Map<String, Object> map);
	
	//서명 다중삭제
	public int delSign(Map<String, Object> map);
	
	//결재
	public int approve(Map<String, Object> map);
	
	//함들 리스트 조회
	 public List<Ap_DocuVo> selectLists(Map<String, Object> map);
	 
	//임시저장 삭제
	public int delTemp(List<String> apd_no);
		
	//철회하기
	public int cancelDocu(String apd_no);
	
	//연차 일정, 히스토리 추가
	public int insertVacHistory(Map<String, Object> map);

	//마지막 결재자인지 확인
		public Integer checkLast(Map<String, Object> map);

		//연차 갯수 삭감
		public int updateVaCheck (Map<String, Object> map);

}

