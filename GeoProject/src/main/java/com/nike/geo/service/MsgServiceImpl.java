package com.nike.geo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nike.geo.model.IMsgDao;
import com.nike.geo.vo.msg.MsgVo;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MsgServiceImpl implements IMsgService {

	@Autowired
	private IMsgDao dao;

	@Override
	public List<MsgVo> selectMsgListRecv(String recvId) {
		log.info("MESSAGE service - 받은 쪽지 목록 조회 selectMsgListRecv");
		log.info("MESSAGE service - 받아온 값 : {}", recvId);
		return dao.selectMsgListRecv(recvId);
	}
	
	@Override
	public List<MsgVo> selectMsgListSend(String sendId) {
		log.info("MESSAGE service - 보낸 쪽지 목록 조회 selectMsgListSend");
		log.info("MESSAGE service - 받아온 값 : {}", sendId);
		return dao.selectMsgListSend(sendId);
	}
	
	@Override
	public MsgVo selectMsgOne(String no) {
		log.info("MESSAGE service - 쪽지 상세 조회 selectMsgOne");
		log.info("MESSAGE service - 받아온 값 : {}", no);
		return dao.selectMsgOne(no);
	}
	
	@Override
	public int insertMsg(MsgVo vo) {
		log.info("MESSAGE service - 쪽지 작성 insertMsg");
		log.info("MESSAGE service - 받아온 값 : {}", vo);
		return dao.insertMsg(vo);
	}
}
