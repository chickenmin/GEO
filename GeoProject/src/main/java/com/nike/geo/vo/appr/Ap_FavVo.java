package com.nike.geo.vo.appr;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Data
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Ap_FavVo {

	private int	apf_id    ;
	private String	emp_no    ;
	private String	apd_form  ;
	private String	reg_id    ;
	private String	reg_date  ;
	private String	mod_id    ;
	private String	mod_date  ;
	private String apf_name;
	
}
