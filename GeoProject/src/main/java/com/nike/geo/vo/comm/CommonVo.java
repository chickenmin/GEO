package com.nike.geo.vo.comm;

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
public class CommonVo {
	
		private String	common_code ;
		private String	code_name   ;
		private String	division    ;
		private String	reg_id      ;
		private String	reg_date    ;
		private String	mod_id      ;
		private String	mod_date 	;
		private String	ref 	;
}
