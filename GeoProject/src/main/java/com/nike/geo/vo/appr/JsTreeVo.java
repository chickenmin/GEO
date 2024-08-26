package com.nike.geo.vo.appr;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Getter
@Setter
@AllArgsConstructor
public class JsTreeVo {
	private String id;
	private String text;
	private String parent;
	private String icon;
	private String position;
	
}
