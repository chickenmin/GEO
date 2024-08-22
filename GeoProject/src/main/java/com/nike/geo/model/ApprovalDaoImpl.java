package com.nike.geo.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.nike.geo.vo.appr.Ap_FavVo;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class ApprovalDaoImpl implements IApprovalDao{
	private String NS="com.nike.geo.model.ApprovalDaoImpl.";
	private final SqlSessionTemplate template;

	@Override
	public List<Ap_FavVo> selectFavList(String empNo) {
		return template.selectList(NS+"selectFavList",empNo);
	}

	@Override
	public int addFav(Map<String, Object> map) {
		return template.insert(NS+"addFav", map);
	}

}
