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
	public int insertMsg(MsgVo vo) {
		log.info("MESSAGE service - 쪽지 작성 insertMsg");
		log.info("MESSAGE service - 받아온 값 : {}", vo);
		return dao.insertMsg(vo);
	}

	@Override
	public List<MsgVo> selectMsgList() {
		log.info("MESSAGE service - 쪽지 목록 조회 selectMsgList");
		return dao.selectMsgList();
	}
	
}
