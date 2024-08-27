package com.nike.geo.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nike.geo.model.IBoardDao;
import com.nike.geo.vo.bo.BoardVo;
import com.nike.geo.vo.bo.LikeVo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class BoardServiceImpl implements IBoardService {

	@Autowired
	private final IBoardDao dao;
	
	@Override
	public List<BoardVo> announcements() {
		
		return dao.announcements();
	}
	
	@Override
	public List<BoardVo> nomalBoard() {
		
		return dao.nomalBoard();
	}
	
	@Override
	public List<BoardVo> delBoard() {
	
		return dao.delBoard();
	}
	
	@Override
	public boolean insertBoard(BoardVo Vo) {
		
		return dao.insertBoard(Vo);
	}
	
	@Override
	public BoardVo detailBoard(String bo_no) {
		System.out.println("브이오엔오"+bo_no);
		return dao.detailBoard(bo_no);
	}
	
	@Override
	public boolean modifyBoard(Map<String, String> map) {
		return dao.modifyBoard(map);
	}
	
	@Override
	public boolean multiDeleteBoard(List<String> list) {
		
		return dao.multiDeleteBoard(list);
	}
	
	@Override
	public boolean realDelete(List<String> list) {
		return dao.realDelete(list);
	}
	

//	@Override
//	public BoardVo selectOne(BoardVo Vo) {
//		return dao.selectOne(Vo);
//	}
//	
//	@Override
//	public boolean insertReadOne(BoardVo vo) {
//		return dao.insertReadOne(vo);
//	}
//	
//	@Override
//	public BoardVo searchBoardOne(String emp_no) {
//		return dao.searchBoardOne(emp_no);
//	}
	
	@Override
	public BoardVo view_Count(BoardVo bVo,Map<String, String>map) {	//map을 쓰는게 맞는지
		BoardVo vo = dao.selectOne(bVo.getBo_no());
		
		int cnt=dao.searchBoardOne(bVo.getEmp_no());
		if(cnt==0) {
			dao.insertReadOne(map);
		}
		return vo;
	}

}


















