package com.nike.geo.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.nike.geo.model.IApprovalDao;
import com.nike.geo.vo.appr.Ap_DocuVo;
import com.nike.geo.vo.appr.Ap_FavVo;
import com.nike.geo.vo.appr.Ap_LineVo;
import com.nike.geo.vo.appr.Ap_RfVo;
import com.nike.geo.vo.comm.FileVo;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class ApprovalServiceImpl implements IApprovalService {
	
	@Autowired
	private IApprovalDao dao;
	
	
	@Override
	public List<Ap_FavVo> selectFavList(String empNo) {
		log.info("전자결재 서비스 selectFavList");
		log.info("empNo : {}",empNo);
		return dao.selectFavList(empNo);
	}
	
	
	@Override
	public int addFav(Map<String, Object> map) {
		log.info("즐겨찾기 추가 addFav");
		log.info("map {}",map);
		return dao.addFav(map);
	}
	
	@Override
	public int delFav(Map<String, Object> map) {
		log.info("즐겨찾기 삭제");
		return dao.delFav(map);
	}
	
	
	@Override
	public int submit1(Ap_DocuVo vo) {
		log.info("문서 임시저장");
		return dao.submit1(vo);
	}
	
	@Override
	public int submit2(Map<String, Object> map) {
		log.info("vo로 상신");
		return dao.submit2(map);
	}
	
//	@Override
//	public int submit2(Ap_DocuVo vo) {
//		log.info("vo로 상신");
//		return dao.submit2(vo);
//	}
	
	
	@Override
	public int selectPos(String emp_no) {
		log.info("직급찾기 service");
		return dao.selectPos(emp_no);
	}
	
	@Override
	public int selctAPD() {
		log.info("문서번호 조회 service");
		return dao.selctAPD();
	}
	
	@Override
	public int putLine(Ap_LineVo vo) {
		log.info("결재라인 추가 service");
		return dao.putLine(vo);
	}

	@Override
	public int putRef(Ap_RfVo vo) {
		return dao.putRef(vo);
	}
	
	
	@Override
	public int putFile(FileVo vo) {
		return dao.putFile(vo);
	}
	
	@Override
	public List<Ap_DocuVo> selectApproval(String emp_no) {
		return dao.selectApproval(emp_no);
	}
	
	@Override
	public List<Ap_DocuVo> selectStatus(Map<String, Object> map) {
		return dao.selectStatus(map);
	}
	
	@Override
	public Ap_DocuVo selectDeatil(String apd_no) {
		return dao.selectDeatil(apd_no);
	}
	
	@Override
	public String sel_Msg(int apd_no) {
		return dao.sel_Msg(apd_no);
	}
	
	@Override
	public List<FileVo> selMySign(String emp_no) {
		return dao.selMySign(emp_no);
	}
	
	@Transactional(readOnly = false)
	@Override
	public int checkOrder(Map<String, Object> map) {
		int n = dao.selMinOrder(map);
		int m = dao.selMyOrder(map);
		log.info("min 순서 : {}",n);
		log.info("내 순서 : {}",m);
		if (n == m) {
			log.info("본인의 결재순서인 서류");
			return 1;
		}else {
			log.info("아직 결재 순서 안옴");
			return 0;
		}
	}
	
	@Override
	public List<Ap_LineVo> selectLine(String apd_no) {
		return dao.selectLine(apd_no);
	}
	
	@Override
	public List<FileVo> selectFile(String origin_no) {
		return dao.selectFile(origin_no);
	}
	
	
	@Override
	public FileVo findFile(String file_no) {
		return dao.findFile(file_no);
	}
	
	//반려처리
	@Transactional(readOnly = false)
	@Override
	public int returnSubmit(Map<String, Object> map) {
		
		//서류번호 조회
		int n = dao.selectAPL_NO(map);
		map.put("apl_no", n);	//조회한 서류번호 넣기
		map.put("apd_status", "R");	
		
		if (n == 0) {
			log.info("서류번호 조회 실패");
		}
		
		//결재자 반려처리
		int m = dao.updateReturn(map);
		if (m == 0) {
			log.info("결재자 반려처리 및 반려메시지 입력 실패");
		}
		
		//서류 반려처리
		int o = dao.update_aStatus(map);
		if (o == 0) {
			log.info("결재자 반려처리 및 반려메시지 입력 실패");
		}
		
		return (n>0 || m>0 || o>0)?1:0;
	}
	
	

	//@Transactional은 annotation 사용
	
//	TODO 028 @Transactional(readOnly = true/false) Annotation에서 true 읽기 / false 삭제, 수정, 입력이 가능
//							reaOnly true로 설정하여 Transaction이 동작되도록 설정
//							update 혹은 insert의 메소드가 오류가 발생했다면 해당 service의 모든 메소드를 Rollback
//							auto-proxy를 통해서 service가 제어 된다
//		@Transactional(readOnly = true)
//		@Override
//		public int transaction(com.nike.geo.vo.EduboardVo vo) {
//			int n = dao.updateBoard();
//			int m = dao.insertBoard(vo);
//			return (n>0 || m>0)?1:0;
//		}
}
