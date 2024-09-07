package com.nike.geo.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import com.nike.geo.model.IBoardDao;
import com.nike.geo.vo.bo.BoardVo;
import com.nike.geo.vo.bo.CommVo;
import com.nike.geo.vo.bo.LikeVo;
import com.nike.geo.vo.comm.FileVo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
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
	public BoardVo detailBoard(int bo_no) {
		return dao.detailBoard(bo_no);
	}
	
	@Override
	public boolean modifyBoard(Map<String, Object> map) {
		return dao.modifyBoard(map);
	}
	
	@Override
	public boolean multiDeleteBoard(List<String> list) {
		return dao.multiDeleteBoard(list);
	}
	
	@Override
	public boolean recoveryBoard(List<String> list) {
		return dao.recoveryBoard(list);
	}
	
	@Override
	public boolean realDelete(List<String> list) {
		return dao.realDelete(list);
	}

	@Override
	public BoardVo view_Count(BoardVo bVo) {
		Map<String, Object> map = new HashMap<String, Object>(){{
			put("bo_no", bVo.getBo_no()); 
			put("emp_no", bVo.getEmp_no());
			}};
		int cnt = dao.searchBoardOne(map);
		System.out.println(cnt>0?"읽은 사람": "아닌 사람");
		if(cnt==0) {
			dao.insertReadOne(map);
		}else {
			
		}
		BoardVo resultVo =  dao.selectOne(bVo.getBo_no());
		System.out.println("상세글 조회" +resultVo);
		
		return resultVo;
	}
	//추천
	@Override
	public LikeVo likeCount(LikeVo vo) {
		Map<String, Object>map = new HashMap<String, Object>(){{
			put("bo_no", vo.getBo_no());
			put("emp_no",vo.getEmp_no());
		}};
		int n = dao.likeSearchBoardOne(map);
		if(n==0) {
			dao.likeInsert(map);
			System.out.println("생성됨");
		}else {
			dao.likeDel(map);
			System.out.println("삭제됨");
		}
		LikeVo resultVo = dao.likeSelectOne(vo.getBo_no(),vo.getEmp_no());
		return resultVo;
	}
	
	@Override
	public List<CommVo> commList(@RequestParam("bo_no") int bo_no) {
		return dao.commList(bo_no);
	}
	
	@Override
	public boolean commentInsert(CommVo vo) {
		return dao.commentInsert(vo);
	}
	
	@Override
	public int putFile(FileVo vo) {
		return dao.putFile(vo);
	}
	
	@Override
	public FileVo findFile(String file_no) {
		return dao.findFile(file_no);
	}
	
	@Override
	public List<FileVo> selectFile(String origin_no) {
		return dao.selectFile(origin_no);
	}
}


















