package com.nike.geo.vo.appr;


public class Ap_DocuVo {

		private String	apd_no          ;
		private String	emp_no          ;
		private String	apd_con         ;
		private int	apd_step        ;
		private String	apd_status      ;
		private String	apd_days        ;
		private String	apd_half_yn     ;
		private String	apd_form        ;
		private String	apd_clear_date  ;
		private String	apd_temp_yn     ;
		private String	reg_id          ;
		private String	reg_date        ;
		private String	mod_id          ;
		private String	mod_date		;
		public String getApd_no() {
			return apd_no;
		}
		public void setApd_no(String apd_no) {
			this.apd_no = apd_no;
		}
		public String getEmp_no() {
			return emp_no;
		}
		public void setEmp_no(String emp_no) {
			this.emp_no = emp_no;
		}
		public String getApd_con() {
			return apd_con;
		}
		public void setApd_con(String apd_con) {
			this.apd_con = apd_con;
		}
		public int getApd_step() {
			return apd_step;
		}
		public void setApd_step(int apd_step) {
			this.apd_step = apd_step;
		}
		public String getApd_status() {
			return apd_status;
		}
		public void setApd_status(String apd_status) {
			this.apd_status = apd_status;
		}
		public String getApd_days() {
			return apd_days;
		}
		public void setApd_days(String apd_days) {
			this.apd_days = apd_days;
		}
		public String getApd_half_yn() {
			return apd_half_yn;
		}
		public void setApd_half_yn(String apd_half_yn) {
			this.apd_half_yn = apd_half_yn;
		}
		public String getApd_form() {
			return apd_form;
		}
		public void setApd_form(String apd_form) {
			this.apd_form = apd_form;
		}
		public String getApd_clear_date() {
			return apd_clear_date;
		}
		public void setApd_clear_date(String apd_clear_date) {
			this.apd_clear_date = apd_clear_date;
		}
		public String getApd_temp_yn() {
			return apd_temp_yn;
		}
		public void setApd_temp_yn(String apd_temp_yn) {
			this.apd_temp_yn = apd_temp_yn;
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
		
		//기본생성자
		public Ap_DocuVo() {
		}
		
		//반차여부 뺀 생성자
		public Ap_DocuVo(String apd_no, String emp_no, String apd_con, int apd_step, String apd_status, String apd_days,
				String apd_form, String apd_clear_date, String apd_temp_yn, String reg_id, String reg_date,
				String mod_id, String mod_date) {
			super();
			this.apd_no = apd_no;
			this.emp_no = emp_no;
			this.apd_con = apd_con;
			this.apd_step = apd_step;
			this.apd_status = apd_status;
			this.apd_days = apd_days;
			this.apd_form = apd_form;
			this.apd_clear_date = apd_clear_date;
			this.apd_temp_yn = apd_temp_yn;
			this.reg_id = reg_id;
			this.reg_date = reg_date;
			this.mod_id = mod_id;
			this.mod_date = mod_date;
		}
		
		
		
		
		
		
		
		
}
