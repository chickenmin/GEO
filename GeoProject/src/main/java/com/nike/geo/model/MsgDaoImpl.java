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
	public int insertMsg(MsgVo vo) {
		log.info("MESSAGE repository - 쪽지 작성 insertMsg");
		log.info("MESSAGE repository - 받아온 값 : {}", vo);
		return session.insert(NS+"insertMsg", vo);
	}
	
	@Override
	public List<MsgVo> selectMsgList() {
		log.info("MESSAGE repository - 쪽지 목록 조회 selectMsgList");
		return session.selectList(NS+"selectMsgList");
	}

}
