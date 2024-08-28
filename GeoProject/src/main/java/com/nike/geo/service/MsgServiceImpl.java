package com.nike.geo.service;

import java.security.SecureRandom;
import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
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
	
	@Autowired
	private JavaMailSender mailSender;

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
	
	@Override
	public int insertFile(FileVo vo) {
		log.info("MESSAGE service - 쪽지 파일 업로드 insertFile");
		log.info("MESSAGE service - 받아온 값 : {}", vo);
		return dao.insertFile(vo);
	}
	
	@Override
	public FileVo selectFile(String no) {
		log.info("MESSAGE service - 쪽지 파일 다운로드 selectFile");
		log.info("MESSAGE service - 받아온 값 : {}", no);
		return dao.selectFile(no);
	}
	
	@Override
	public int updateMsgRead(MsgVo vo) {
		log.info("MESSAGE service - 쪽지 읽기 updateMsgRead");
		log.info("MESSAGE service - 받아온 값 : {}", vo);
		return dao.updateMsgRead(vo);
	}
	
	@Override
	public int deleteMsgRecv(List<String> noList) {
		log.info("MESSAGE service - 받은 쪽지 삭제 deleteMsgRecv");
		log.info("MESSAGE service - 받아온 값 : {}", noList);
		return dao.deleteMsgRecv(noList);
	}
	
	@Override
	public int deleteMsgSend(List<String> noList) {
		log.info("MESSAGE service - 보낸 쪽지 삭제 deleteMsgSend");
		log.info("MESSAGE service - 받아온 값 : {}", noList);
		return dao.deleteMsgSend(noList);
	}
	
//	public String init() {
//		Random ran = new Random();
//		StringBuffer sb = new StringBuffer();
//		int num = 0;
//		
//		return null;
//	}
	
	public static String generateRandomMixStr() {
        String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

        SecureRandom random = new SecureRandom();
        StringBuilder sb = new StringBuilder(6);

        for (int i = 0; i < 6; i++) {
            int index = random.nextInt(characters.length());
            sb.append(characters.charAt(index));
        }
        return sb.toString();
    }
	
}
