package com.nike.geo.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.nike.geo.vo.appr.Ap_DocuVo;
import com.nike.geo.vo.appr.Ap_FavVo;
import com.nike.geo.vo.appr.Ap_LineVo;
import com.nike.geo.vo.appr.Ap_RfVo;
import com.nike.geo.vo.comm.FileVo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
@RequiredArgsConstructor
public class ApprovalDaoImpl implements IApprovalDao{
	
	private String NS="com.nike.geo.model.ApprovalDaoImpl.";
	
	private final SqlSessionTemplate template;

	@Override
	public List<Ap_FavVo> selectFavList(String empNo) {
		return template.selectList(NS+"selectFavList",empNo);
	}

	@Override
	public int addFav(Map<String, Object> map) {
		return template.insert(NS+"addFav", map);
	}
	
	@Override
	public int delFav(Map<String, Object> map) {
		return template.delete(NS+"delFav", map);
	}
	
	
	
//	@Override
//	public int submit2(Ap_DocuVo vo) {
//		return template.insert(NS+"submit2", vo);
//	}
	@Override
	public int submit2(Map<String, Object> map) {
		return template.insert(NS+"submit2", map);
	}
	
	@Override
	public int submit1(Ap_DocuVo vo) {
		return template.insert(NS+"submit1", vo);
	}
	
	@Override
	public int selectPos(String emp_no) {
		return template.selectOne(NS+"selectPos", emp_no);
	}
	
	@Override
	public int selctAPD() {
		return template.selectOne(NS+"selctAPD");
	}
	
	@Override
	public int putLine(Ap_LineVo vo) {
		return template.insert(NS+"putLine", vo);
	}
	
	@Override
	public int putRef(Ap_RfVo vo) {
		return template.insert(NS+"putRef", vo);
	}
	
	@Override
	public int putFile(FileVo vo) {
		return template.insert(NS+"putFile", vo);
	}
	
	@Override
	public List<Ap_DocuVo> selectApproval(String emp_no) {
		return template.selectList(NS+"selectApproval", emp_no);
	}
	
	@Override
	public List<Ap_DocuVo> selectStatus(Map<String, Object> map) {
		return template.selectList(NS+"selectStatus", map);
	}
	
	@Override
	public Ap_DocuVo selectDeatil(String apd_no) {
		return template.selectOne(NS+"selectDeatil", apd_no);
	}
	
	@Override
	public String sel_Msg(int apd_no) {
		return template.selectOne(NS+"sel_Msg", apd_no);
	}
	
	@Override
	public Integer selMinOrder(Map<String, Object> map) {
		return template.selectOne(NS+"selMinOrder", map);
	}
	
	@Override
	public int selMyOrder(Map<String, Object> map) {
		log.info("selMyOrder 입성");
		return template.selectOne(NS+"selMyOrder", map);
	}
	
	@Override
	public List<FileVo> selMySign(String emp_no) {
		return template.selectList(NS+"selMySign", emp_no);
	}
	
	@Override
	public List<Ap_LineVo> selectLine(String apd_no) {
		return template.selectList(NS+"selectLine", apd_no);
	}
	
	@Override
	public List<FileVo> selectFile(String origin_no) {
		return template.selectList(NS+"selectFile", origin_no);
	}
	
	
	@Override
	public FileVo findFile(String file_no) {
		return template.selectOne("com.nike.geo.model.CommDaoImpl.findFile", file_no);
	}
	
	@Override
	public int selectAPL_NO(Map<String, Object> map) {
		return template.selectOne(NS+"selectAPL_NO", map);
	}
	
	@Override
	public int updateReturn(Map<String, Object> map) {
		return template.update(NS+"updateReturn", map);
	}
	
	@Override
	public int update_aStatus(Map<String, Object> map) {
		return template.update(NS+"update_aStatus", map);
	}
	
	
	@Override
	public int delSign(Map<String, Object> map) {
		return template.update(NS+"delSign", map);
	}
	
	
	@Override
	public int updateApprLine(Map<String, Object> map) {
		return template.update(NS+"updateApprLine", map);
	}
	
	
	@Override
	public int updateDocu(Map<String, Object> map) {
		return template.update(NS+"updateDocu", map);
	}
	
	@Override
	public int selComplete(Map<String, Object> map) {
		return template.selectOne(NS+"selComplete", map);
	}
	
	@Override
	public int selStep(Map<String, Object> map) {
		return template.selectOne(NS+"selStep", map);
	}
	
	@Override
	public List<Ap_DocuVo> selectSubmit_Docu(Map<String, Object> map) {
		return template.selectList(NS+"selectSubmit_Docu", map);
	}
	
	@Override
	public List<Ap_DocuVo> selRef_Docu(String emp_no) {
		return template.selectList(NS+"selRef_Docu", emp_no);
	}
	
	@Override
	public int delTemp(List<String> apd_no) {
		return template.delete(NS+"delTemp", apd_no);
	}
	
	@Override
	public int cancelDocu(String apd_no) {
		return template.update(NS+"cancelDocu", apd_no);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	

}
