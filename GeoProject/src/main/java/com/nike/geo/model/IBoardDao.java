package com.nike.geo.model;

import java.util.List;
import java.util.Map;

import com.nike.geo.vo.bo.BoardVo;

public interface IBoardDao {

	public List<BoardVo> announcements();
	
	public List<BoardVo> nomalBoard();

	public List<BoardVo> delBoard();
	
	public boolean insertBoard(BoardVo Vo);
	
	public BoardVo detailBoard(String bo_no);

	public boolean modifyBoard(Map<String, String> map);
	
	public boolean multiDeleteBoard(List<String>list);
	
	public boolean realDelete(List<String> list);
}
