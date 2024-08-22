package com.nike.geo.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.nike.geo.vo.msg.MsgVo;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class MsgDaoImpl implements IMsgDao {

	@Autowired
	private SqlSessionTemplate session;
	
	private final String NS = "com.nike.geo.model.MsgDaoImpl.";
	
	@Override
	public List<MsgVo> selectMsgListRecv(String recvId) {
		log.info("MESSAGE repository - 받은 쪽지 목록 조회 selectMsgListRecv");
		log.info("MESSAGE repository - 받아온 값 : {}", recvId);
		return session.selectList(NS+"selectMsgListRecv", recvId);
	}
	
	@Override
	public List<MsgVo> selectMsgListSend(String sendId) {
		log.info("MESSAGE repository - 보낸 쪽지 목록 조회 selectMsgListSend");
		log.info("MESSAGE repository - 받아온 값 : {}", sendId);
		return session.selectList(NS+"selectMsgListSend", sendId);
	}
	
	@Override
	public MsgVo selectMsgOne(String no) {
		log.info("MESSAGE repository - 쪽지 상세 조회 selectMsgOne");
		log.info("MESSAGE repository - 받아온 값 : {}", no);
		return session.selectOne(NS+"selectMsgOne", no);
	}
	
	@Override
	public int insertMsg(MsgVo vo) {
		log.info("MESSAGE repository - 쪽지 작성 insertMsg");
		log.info("MESSAGE repository - 받아온 값 : {}", vo);
		return session.insert(NS+"insertMsg", vo);
	}
	
	@Override
	public int updateMsgRead(MsgVo vo) {
		log.info("MESSAGE repository - 쪽지 읽기 updateMsgRead");
		log.info("MESSAGE repository - 받아온 값 : {}", vo);
		return session.update(NS+"updateMsgRead", vo);
	}
	
	@Override
	public int deleteMsgRecv(List<String> noList) {
		log.info("MESSAGE repository - 받은 쪽지 삭제 deleteMsgRecv");
		log.info("MESSAGE repository - 받아온 값 : {}", noList);
		return session.update(NS+"deleteMsgRecv", noList);
	}
	
}
