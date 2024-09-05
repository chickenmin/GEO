package com.nike.geo.model;

import java.util.List;
import java.util.Map;

import com.nike.geo.vo.bo.BoardVo;
import com.nike.geo.vo.bo.CommVo;
import com.nike.geo.vo.bo.LikeVo;

public interface IBoardDao {

	public List<BoardVo> announcements();
	
	public List<BoardVo> nomalBoard();

	public List<BoardVo> delBoard();
	
	public boolean insertBoard(BoardVo Vo);
	
	public BoardVo detailBoard(String bo_no);

	public boolean modifyBoard(Map<String, String> map);
	
	public boolean multiDeleteBoard(List<String>list);
	
	public boolean recoveryBoard(List<String>list);
	
	public boolean realDelete(List<String> list);
	
	//조회수
	public BoardVo selectOne(String bo_no);

	public void insertReadOne(Map<String, String>map); //emp_no와 bo_no를 넣어줘야함
	
	public int searchBoardOne(Map<String, String>map); 
	
	//추천
	public boolean likeInsert(Map<String, String>map);	//이게 문제인듯
	
	public boolean likeDel(Map<String, String>map);
	
	public int likeSearchBoardOne(Map<String, String>map);
	
	public LikeVo likeSelectOne(String bo_no,String emp_no);
	
	public List<CommVo> commList(String bo_no);
	//댓글
	public boolean commentInsert(CommVo vo);
	
	
}
