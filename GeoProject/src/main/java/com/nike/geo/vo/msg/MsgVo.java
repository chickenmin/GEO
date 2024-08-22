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
public class MsgVo {

	private int msg_no;
	private String msg_send_id;
	private String msg_recv_id;
	private String msg_content;
	private String msg_send_date;
	private String msg_recv_read_yn;
	private String msg_send_del_yn;
	private String msg_recv_del_yn;
	private String reg_id;
	private String reg_date;
	private String mod_id;
	private String mod_date;
	
}
