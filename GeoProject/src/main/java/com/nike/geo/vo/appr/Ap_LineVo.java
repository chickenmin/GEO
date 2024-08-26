package com.nike.geo.vo.appr;

public class Ap_LineVo {
	
	private int	apl_no      ;
	private int	apd_no      ;
	private String	emp_no      ;
	private int	apl_order   ;
	private int	apl_date    ;
	private int	apl_status  ;
	private String	apl_msg     ;
	private String	reg_id      ;
	private int	reg_date    ;
	private String	mod_id      ;
	private int	mod_date	;
	
	//게터세터
	public int getApl_no() {
		return apl_no;
	}
	public void setApl_no(int apl_no) {
		this.apl_no = apl_no;
	}
	public int getApd_no() {
		return apd_no;
	}
	public void setApd_no(int apd_no) {
		this.apd_no = apd_no;
	}
	public String getEmp_no() {
		return emp_no;
	}
	public void setEmp_no(String emp_no) {
		this.emp_no = emp_no;
	}
	public int getApl_order() {
		return apl_order;
	}
	public void setApl_order(int apl_order) {
		this.apl_order = apl_order;
	}
	public int getApl_date() {
		return apl_date;
	}
	public void setApl_date(int apl_date) {
		this.apl_date = apl_date;
	}
	public int getApl_status() {
		return apl_status;
	}
	public void setApl_status(int apl_status) {
		this.apl_status = apl_status;
	}
	public String getApl_msg() {
		return apl_msg;
	}
	public void setApl_msg(String apl_msg) {
		this.apl_msg = apl_msg;
	}
	public String getReg_id() {
		return reg_id;
	}
	public void setReg_id(String reg_id) {
		this.reg_id = reg_id;
	}
	public int getReg_date() {
		return reg_date;
	}
	public void setReg_date(int reg_date) {
		this.reg_date = reg_date;
	}
	public String getMod_id() {
		return mod_id;
	}
	public void setMod_id(String mod_id) {
		this.mod_id = mod_id;
	}
	public int getMod_date() {
		return mod_date;
	}
	public void setMod_date(int mod_date) {
		this.mod_date = mod_date;
	}
	public Ap_LineVo() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Ap_LineVo(int apd_no, String emp_no, int apl_order) {
		super();
		this.apd_no = apd_no;
		this.emp_no = emp_no;
		this.apl_order = apl_order;
	}
	
	
	
	
	
		
		
		
		
		
		
		
		
		
	

}
