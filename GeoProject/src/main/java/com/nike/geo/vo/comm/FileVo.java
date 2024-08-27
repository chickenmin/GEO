package com.nike.geo.vo.comm;

import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;


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
	
	public FileVo() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	

	public FileVo(int origin_no, String file_oname, String file_sname, long file_size, String reg_id) {
		super();
		this.origin_no = origin_no;
		this.file_oname = file_oname;
		this.file_sname = file_sname;
		this.file_size = file_size;
		this.reg_id = reg_id;
	}




	public int getFile_no() {
		return file_no;
	}

	public void setFile_no(int file_no) {
		this.file_no = file_no;
	}

	public int getOrigin_no() {
		return origin_no;
	}

	public void setOrigin_no(int origin_no) {
		this.origin_no = origin_no;
	}

	public String getFile_oname() {
		return file_oname;
	}

	public void setFile_oname(String file_oname) {
		this.file_oname = file_oname;
	}

	public String getFile_sname() {
		return file_sname;
	}

	public void setFile_sname(String file_sname) {
		this.file_sname = file_sname;
	}

	public long getFile_size() {
		return file_size;
	}

	public void setFile_size(long file_size) {
		this.file_size = file_size;
	}

	public String getFile_type() {
		return file_type;
	}

	public void setFile_type(String file_type) {
		this.file_type = file_type;
	}

	public int getFile_rank() {
		return file_rank;
	}

	public void setFile_rank(int file_rank) {
		this.file_rank = file_rank;
	}

	public String getFile_del_yn() {
		return file_del_yn;
	}

	public void setFile_del_yn(String file_del_yn) {
		this.file_del_yn = file_del_yn;
	}

	public String getReg_id() {
		return reg_id;
	}

	public void setReg_id(String reg_id) {
		this.reg_id = reg_id;
	}

	public String getReg_date() {
		return reg_date;
	}

	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}

	public String getMod_id() {
		return mod_id;
	}

	public void setMod_id(String mod_id) {
		this.mod_id = mod_id;
	}

	public String getMod_date() {
		return mod_date;
	}

	public void setMod_date(String mod_date) {
		this.mod_date = mod_date;
	}

	@Override
	public String toString() {
		return "FileVo [file_no=" + file_no + ", origin_no=" + origin_no + ", file_oname=" + file_oname
				+ ", file_sname=" + file_sname + ", file_size=" + file_size + ", file_type=" + file_type
				+ ", file_rank=" + file_rank + ", file_del_yn=" + file_del_yn + ", reg_id=" + reg_id + ", reg_date="
				+ reg_date + ", mod_id=" + mod_id + ", mod_date=" + mod_date + "]";
	}
	
	
	
	
}
