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
	
	//결재문서 목록 조회
	public List<Ap_DocuVo> selectApproval(String emp_no);
	
	//결재문서 상태별 조회
	public List<Ap_DocuVo> selectStatus(Map<String, Object> map);
	
	//문서 상세 조회
	public Ap_DocuVo selectDeatil(String apd_no);
	
	//반려메시지 조회
	public String sel_Msg(int apd_no);
	
	//결재 순서 조회
	public Integer selMinOrder(Map<String, Object> map);
	
	//내 결재 순서 조회
	public int selMyOrder(Map<String, Object> map);
	
	//내 서명 조회
	public List<FileVo> selMySign(String emp_no);
	
	//문서 결재자 조회
	public List<Ap_LineVo> selectLine(String apd_no);
	
	//첨부 파일 조회
	public List<FileVo> selectFile(String origin_no);
	
	//파일 조회
	public FileVo findFile(String file_no);
	
	// 결재번호 조회
	public int selectAPL_NO(Map<String, Object> map);
	
	// 결재라인 반려메시지 및 시간 수정
	public int updateReturn(Map<String, Object> map);
	
	//서류 상태 수정 (철회, 진행중,완료 )
	public int update_aStatus(Map<String, Object> map);
	
	//사인 다중삭제
	public int delSign(Map<String, Object> map);
	
	
	//결재라인 수정- 결재
	public int updateApprLine(Map<String, Object> map);
	
	//문서 상태 수정 - 결재해서
	public int updateDocu(Map<String, Object> map);
	
	//문서 결재라인 수 조회
	public int selStep(Map<String, Object> map);
	
	//결재한 사람 수 조회
	public int selComplete(Map<String, Object> map);
	
	//상신함 , 임시저장
	public List<Ap_DocuVo> selectSubmit_Docu(Map<String, Object> map);
	
	//참조함
	public List<Ap_DocuVo> selRef_Docu(String emp_no);
	
	//임시저장 삭제
	public int delTemp(List<String> apd_no);
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
