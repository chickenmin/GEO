package com.nike.geo.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.nike.geo.model.IApprovalDao;
import com.nike.geo.vo.appr.Ap_FavVo;

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
