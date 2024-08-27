package com.nike.geo.vo.co;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Data
@Getter
@Setter
@ToString
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CalVo implements Serializable {
	

	private static final long serialVersionUID = -5872704371606980975L;
	
	private int cal_no;
	private String cal_title;
	private String cal_content;
	private String cal_start;
	private String cal_stop;
	private String cal_del_yn;
	private String cal_status;
	private String cal_rel_no;
	private String cal_open_yn;
	private String reg_id;
	private String reg_date;
	private String mod_id;
	private String mod_date;
	private String cal_type;
}
