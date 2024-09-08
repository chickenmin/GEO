package com.nike.geo.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.nike.geo.vo.comm.FileVo;
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
		log.info("받은 쪽지 목록 조회 selectMsgListRecv - 받아온 값 : {}", recvId);
		return session.selectList(NS+"selectMsgListRecv", recvId);
	}
	
	@Override
	public List<MsgVo> selectMsgListSend(String sendId) {
		log.info("보낸 쪽지 목록 조회 selectMsgListSend - 받아온 값 : {}", sendId);
		return session.selectList(NS+"selectMsgListSend", sendId);
	}
	
	@Override
	public MsgVo selectMsgOne(String no) {
		log.info("쪽지 상세 조회 selectMsgOne - 받아온 값 : {}", no);
		return session.selectOne(NS+"selectMsgOne", no);
	}
	
	@Override
	public int insertMsg(MsgVo vo) {
		log.info("쪽지 작성 insertMsg - 받아온 값 : {}", vo);
		return session.insert(NS+"insertMsg", vo);
	}
	
	@Override
	public int insertFile(FileVo vo) {
		log.info("쪽지 파일 업로드 insertFile - 받아온 값 : {}", vo);
		return session.insert(NS+"insertFile", vo);
	}
	
	@Override
	public FileVo selectFile(String no) {
		log.info("쪽지 파일 다운로드 selectFile - 받아온 값 : {}", no);
		return session.selectOne(NS+"selectFile", no);
	}
	
	@Override
	public int updateMsgRead(MsgVo vo) {
		log.info("쪽지 읽기 updateMsgRead - 받아온 값 : {}", vo);
		return session.update(NS+"updateMsgRead", vo);
	}
	
	@Override
	public int deleteMsgRecv(List<String> noList) {
		log.info("받은 쪽지 삭제 deleteMsgRecv - 받아온 값 : {}", noList);
		return session.update(NS+"deleteMsgRecv", noList);
	}
	
	@Override
	public int deleteMsgSend(List<String> noList) {
		log.info("보낸 쪽지 삭제 deleteMsgSend - 받아온 값 : {}", noList);
		return session.update(NS+"deleteMsgSend", noList);
	}
	
	@Override
	public int cntUnreadMsg(String no) {
		log.info("안읽은 쪽지 갯수 확인 cntUnreadMsg - 받아온 값 : {}", no);
		return session.selectOne(NS+"cntUnreadMsg", no);
	}
	
	@Override
	public List<MsgVo> selectLatestMsg(String recvId) {
		log.info("안읽은 쪽지 최신순 3개 조회 selectLatestMsg - 받아온 값 : {}", recvId);
		return session.selectList(NS+"selectLatestMsg", recvId);
	}
}
