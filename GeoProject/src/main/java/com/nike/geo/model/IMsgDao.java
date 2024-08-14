package com.nike.geo.model;

import java.util.List;

import com.nike.geo.vo.msg.MsgVo;

public interface IMsgDao {

	// 쪽지 작성 insertMsg
	public int insertMsg(MsgVo vo);
	
	// 쪽지 목록 조회 selectMsgList
	public List<MsgVo> selectMsgList();
	
}
