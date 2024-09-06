package com.nike.geo.model;

import java.util.List;
import java.util.Map;

import com.nike.geo.vo.bo.BoardVo;
import com.nike.geo.vo.bo.CommVo;
import com.nike.geo.vo.bo.LikeVo;
import com.nike.geo.vo.comm.FileVo;

public interface IBoardDao {

	public List<BoardVo> announcements();
	
	public List<BoardVo> nomalBoard();

	public List<BoardVo> delBoard();
	
	public boolean insertBoard(BoardVo Vo);
	
	public BoardVo detailBoard(int bo_no);

	public boolean modifyBoard(Map<String, Object> map);
	
	public boolean multiDeleteBoard(List<String>list);
	
	public boolean recoveryBoard(List<String>list);
	
	public boolean realDelete(List<String> list);
	
	//조회수
	public BoardVo selectOne(int bo_no);

	public void insertReadOne(Map<String, Object>map); //emp_no와 bo_no를 넣어줘야함
	
	public int searchBoardOne(Map<String, Object>map); 
	
	//추천
	public boolean likeInsert(Map<String, Object>map);	//이게 문제인듯
	
	public boolean likeDel(Map<String, Object>map);
	
	public int likeSearchBoardOne(Map<String, Object>map);
	
	public LikeVo likeSelectOne(int bo_no,String emp_no);
	
	public List<CommVo> commList(int bo_no);
	//댓글
	public boolean commentInsert(CommVo vo);
	
	// 결재 파일 추가
	public int putFile(FileVo vo);
}
