package com.nike.geo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nike.geo.model.IMsgDao;
import com.nike.geo.vo.comm.FileVo;
import com.nike.geo.vo.msg.MsgVo;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MsgServiceImpl implements IMsgService {

	@Autowired
	private IMsgDao dao;
	
	@Override
	public List<MsgVo> selectMsgListRecv(String recvId) {
		log.info("받은 쪽지 목록 조회 selectMsgListRecv - 받아온 값 : {}", recvId);
		return dao.selectMsgListRecv(recvId);
	}
	
	@Override
	public List<MsgVo> selectMsgListSend(String sendId) {
		log.info("보낸 쪽지 목록 조회 selectMsgListSend - 받아온 값 : {}", sendId);
		return dao.selectMsgListSend(sendId);
	}
	
	@Override
	public MsgVo selectMsgOne(String no) {
		log.info("쪽지 상세 조회 selectMsgOne - 받아온 값 : {}", no);
		return dao.selectMsgOne(no);
	}
	
	@Override
	public int insertMsg(MsgVo vo) {
		log.info("쪽지 작성 insertMsg - 받아온 값 : {}", vo);
		return dao.insertMsg(vo);
	}
	
	@Override
	public int insertFile(FileVo vo) {
		log.info("쪽지 파일 업로드 insertFile - 받아온 값 : {}", vo);
		return dao.insertFile(vo);
	}
	
	@Override
	public FileVo selectFile(String no) {
		log.info("쪽지 파일 다운로드 selectFile - 받아온 값 : {}", no);
		return dao.selectFile(no);
	}
	
	@Override
	public int updateMsgRead(MsgVo vo) {
		log.info("쪽지 읽기 updateMsgRead - 받아온 값 : {}", vo);
		return dao.updateMsgRead(vo);
	}
	
	@Override
	public int deleteMsgRecv(List<String> noList) {
		log.info("받은 쪽지 삭제 deleteMsgRecv - 받아온 값 : {}", noList);
		return dao.deleteMsgRecv(noList);
	}
	
	@Override
	public int deleteMsgSend(List<String> noList) {
		log.info("보낸 쪽지 삭제 deleteMsgSend - 받아온 값 : {}", noList);
		return dao.deleteMsgSend(noList);
	}
	
	@Override
	public int cntUnreadMsg(String no) {
		log.info("안읽은 쪽지 갯수 확인 cntUnreadMsg - 받아온 값 : {}", no);
		return dao.cntUnreadMsg(no);
	}
	
	@Override
	public List<MsgVo> selectLatestMsg(String recvId) {
		log.info("안읽은 쪽지 최신순 3개 조회 selectLatestMsg - 받아온 값 : {}", recvId);
		return dao.selectLatestMsg(recvId);
	}
	
}
