package com.nike.geo.service;

import java.util.List;
import java.util.Map;


import com.nike.geo.vo.bo.BoardVo;
import com.nike.geo.vo.bo.CommVo;
import com.nike.geo.vo.bo.LikeVo;
import com.nike.geo.vo.comm.FileVo;


public interface IBoardService {
	
	public List<BoardVo> announcements();
	
	public List<BoardVo> nomalBoard();
	
	public List<BoardVo> delBoard();
	
	public boolean insertBoard(BoardVo Vo);
	
	public BoardVo detailBoard(int bo_no);
	
	public boolean modifyBoard(Map<String, Object> map);
	
	public boolean multiDeleteBoard(List<String>list);
	
	public boolean recoveryBoard(List<String>list);
	
	public boolean realDelete(List<String> list);

	public BoardVo view_Count(BoardVo bVo);
	//추천
	public LikeVo likeCount(LikeVo vo);
	
	public List<CommVo> commList(int bo_no);
	//댓글
	public boolean commentInsert(CommVo vo);
	
	public int putFile(FileVo vo);
	//파일 조회
	public FileVo findFile(String file_no);
	//첨부 파일 조회
	public List<FileVo> selectFile(String origin_no);
	
	public void delFile(Map<String, Object>delFileMap);
	
}
