package com.nike.geo.vo.hr;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Data
@Getter
@Setter
@ToString
public class AttVo {

	private String emp_no;
	private String att_arrive_time;
	private String att_left_time;
	private String reg_id;
	private String reg_date;
	private String mod_id;
	private String mod_date;
	private Integer late_count;
	private Integer right_count;
	private Integer early_count;
	private Integer empty_count;
	
}
