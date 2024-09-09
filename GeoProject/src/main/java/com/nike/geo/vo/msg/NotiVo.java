package com.nike.geo.vo.msg;

import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Data
@Getter
@Setter
@ToString
@NoArgsConstructor
public class NotiVo {

	private String noti_no;
	private String emp_no;
	private String origin_no;
	private String noti_status;
	private String noti_content;
	private String noti_date;
	private String noti_read_yn;
	private String reg_id;
	private String reg_date;
	private String mod_id;
	private String mod_date;
	
}
