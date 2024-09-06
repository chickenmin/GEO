package com.nike.geo.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.nike.geo.vo.bo.BoardVo;
import com.nike.geo.vo.bo.CommVo;
import com.nike.geo.vo.bo.LikeVo;
import com.nike.geo.vo.comm.FileVo;

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
	public BoardVo detailBoard(int bo_no) {
		
		return sessionTemplate.selectOne(NS+"detailBoard", bo_no);
	}
	
	@Override
	public boolean modifyBoard(Map<String, Object> map) {
		int n = sessionTemplate.update(NS+"modifyBoard",map);
		return (n==1)?true:false;
	}
	
	
	@Override
	public boolean multiDeleteBoard(List<String> list) {
		int n =sessionTemplate.update(NS+"multiDeleteBoard",list);
		return (n==1)?true:false;
	}
	
	@Override
	public boolean recoveryBoard(List<String> list) {
		int n= sessionTemplate.update(NS+"recoveryBoard", list);
		return (n==1)?true:false;
	}
	
	@Override
	public boolean realDelete(List<String> list) {
		int n = sessionTemplate.delete(NS+"realDelete", list);
		return (n==1)?true:false;
	}
	//조회수
	@Override
	public BoardVo selectOne(int bo_no) {
		return sessionTemplate.selectOne(NS+"selectOne", bo_no);
	}
	
	@Override
	public void insertReadOne(Map<String, Object>map) {
		sessionTemplate.insert(NS+"insertReadOne", map);
	}
	
	@Override
	public int searchBoardOne(Map<String, Object>map) {
		int cnt = sessionTemplate.selectOne(NS+"searchBoardOne", map);
		return cnt;
	}
	
	
	//추천
	@Override
	public int likeSearchBoardOne(Map<String, Object> map) {
		int cnt = sessionTemplate.selectOne(NS+"likeSearchBoardOne", map);
		return cnt;
	}
	@Override
	public boolean likeDel(Map<String, Object>map) {
		int n = sessionTemplate.delete(NS+"likeDel", map);
		return (n==1)?true:false;
	}
	@Override
	public LikeVo likeSelectOne(int bo_no,String emp_no) {
		Map<String, Object>param=new HashMap<>();
		param.put("bo_no", bo_no);
		param.put("emp_no", emp_no);
		return sessionTemplate.selectOne(NS+"likeSelectOne", param);
	}
	@Override
	public boolean likeInsert(Map<String, Object>map) {
		int n = sessionTemplate.insert(NS+"likeInsert",map);
		return (n==1)?true:false;
	}
	
	@Override
	public List<CommVo> commList(int bo_no) {
		
		return sessionTemplate.selectList(NS+"commList",bo_no);
	}
		
	@Override
	public boolean commentInsert(CommVo vo) {
		int n=sessionTemplate.insert(NS+"commentInsert", vo);
		return (n==1)?true:false;
	}
	
	@Override
	public int putFile(FileVo vo) {
		return sessionTemplate.insert(NS+"putFile", vo);
	}
}
