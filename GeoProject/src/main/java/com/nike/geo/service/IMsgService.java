package com.nike.geo.service;

import java.util.List;

import com.nike.geo.vo.msg.MsgVo;

public interface IMsgService {

	/**
	 * 쪽지 작성
	 * @param MsgVo
	 * @return 0 혹은 1
	 */
	public int insertMsg(MsgVo vo);

	
	/**
	 * 쪽지 목록 조회
	 * @return List<MsgVo>
	 */
	public List<MsgVo> selectMsgList();
	
}
