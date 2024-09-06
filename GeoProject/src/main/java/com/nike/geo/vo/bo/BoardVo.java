package com.nike.geo.vo.bo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Data
@Setter
@Getter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class BoardVo {

	private int bo_no;
	private String emp_no;
	private String bo_status;
	private String bo_title;
	private String bo_content;
	private String bo_regdate;
	private int bo_view_count;
	private int bo_like_count;
	private String bo_del_yn;
	private String reg_id;
	private String reg_date;
	private String mod_id;
	private String mod_date;
	private String bo_delflag_yn;
	private String emp_name;
	private String common_name;
}
