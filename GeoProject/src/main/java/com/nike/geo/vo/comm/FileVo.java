package com.nike.geo.vo.comm;

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
public class FileVo {

	private int file_no;
	private int origin_no;
	private String file_oname;
	private String file_sname;
	private long file_size;
	private String file_type;
	private int file_rank;
	private String file_del_yn;
	private String reg_id;
	private String reg_date;
	private String mod_id;
	private String mod_date;
	
}
