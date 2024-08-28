package com.nike.geo.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.nike.geo.vo.bo.BoardVo;
import com.nike.geo.vo.bo.LikeVo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Repository
@RequiredArgsConstructor
public class BoardDaoImpl implements IBoardDao {

	private final SqlSessionTemplate sessionTemplate;
	private final String NS="com.nike.geo.model.BoardDaoImpl.";
	
	@Override
	public List<BoardVo> announcements() {
		
		return sessionTemplate.selectList(NS+"announcements");
	}
	
	@Override
	public List<BoardVo> nomalBoard() {
	
		return sessionTemplate.selectList(NS+"nomalBoard");
	}
	
	@Override
	public List<BoardVo> delBoard() {
	
		return sessionTemplate.selectList(NS+"delBoard");
	}
	
	@Override
	public boolean insertBoard(BoardVo Vo) {
		int n = sessionTemplate.insert(NS+"insertBoard",Vo);
		return (n==1)?true:false;
	}
	
	@Override
	public BoardVo detailBoard(String bo_no) {
		
		return sessionTemplate.selectOne(NS+"detailBoard", bo_no);
	}
	
	@Override
	public boolean modifyBoard(Map<String, String> map) {
		int n = sessionTemplate.update(NS+"modifyBoard",map);
		return (n==1)?true:false;
	}
	
	@Override
	public boolean multiDeleteBoard(List<String> list) {
		int n =sessionTemplate.update(NS+"multiDeleteBoard",list);
		return (n==1)?true:false;
	}
	
	@Override
	public boolean realDelete(List<String> list) {
		int n = sessionTemplate.delete(NS+"realDelete", list);
		return (n==1)?true:false;
	}
	//조회수
	@Override
	public BoardVo selectOne(String bo_no) {
		return sessionTemplate.selectOne(NS+"selectOne", bo_no);
	}
	
	@Override
	public void insertReadOne(Map<String, String>map) {
		sessionTemplate.insert(NS+"insertReadOne", map);
	}
	
	@Override
	public int searchBoardOne(Map<String, String>map) {
		int cnt = sessionTemplate.selectOne(NS+"searchBoardOne", map);
		return cnt;
	}
	
	
	//추천
	@Override
	public int likeSearchBoardOne(Map<String, String> map) {
		int cnt = sessionTemplate.selectOne(NS+"likeSearchBoardOne", map);
		return cnt;
	}
	@Override
	public boolean likeDel(Map<String, String>map) {
		int n = sessionTemplate.delete(NS+"likeDel", map);
		return (n==1)?true:false;
	}
	@Override
	public LikeVo likeSelectOne(String bo_no,String emp_no) {
		Map<String, String>param=new HashMap<>();
		param.put("bo_no", bo_no);
		param.put("emp_no", emp_no);
		return sessionTemplate.selectOne(NS+"likeSelectOne", param);
	}
	@Override
	public boolean likeInsert(Map<String, String>map) {
		int n = sessionTemplate.insert(NS+"likeInsert",map);
		return (n==1)?true:false;
	}
	
	
}
