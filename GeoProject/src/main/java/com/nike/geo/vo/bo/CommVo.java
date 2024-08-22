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
public class CommVo {

	private int comm_seq;
	private String bo_no;
	private String emp_no;
	private String comm_content;
	private String comm_date;
	private int comm_ref;
	private int comm_step;
	private String comm_use_yn;
	private String comm_del_yn;
	private String reg_id;
	private String reg_date;
	private String mod_id;
	private String mod_date;

}
