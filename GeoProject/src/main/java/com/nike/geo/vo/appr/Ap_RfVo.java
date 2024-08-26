package com.nike.geo.vo.appr;

public class Ap_RfVo {

		private int 	apr_no          ;
		private int 	apd_no          ;
		private String 	apr_ref         ;
		private String 	reg_id          ;
		private String 	reg_date        ;
		private String 	mod_id          ;
		private String 	mod_date		;
		private String 	emp_no;
		
		
		public int getApr_no() {
			return apr_no;
		}
		public void setApr_no(int apr_no) {
			this.apr_no = apr_no;
		}
		public int getApd_no() {
			return apd_no;
		}
		public void setApd_no(int apd_no) {
			this.apd_no = apd_no;
		}
		public String getApr_ref() {
			return apr_ref;
		}
		public void setApr_ref(String apr_ref) {
			this.apr_ref = apr_ref;
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
		public Ap_RfVo() {
			super();
			// TODO Auto-generated constructor stub
		}
		
		public Ap_RfVo(int apd_no, String apr_ref,String emp_no ) {
			super();
			this.apd_no = apd_no;
			this.apr_ref = apr_ref;
			this.emp_no = emp_no;
			
		}
		
		
		
		
}
