package com.nike.geo.vo.hr;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Data
@Getter
@Setter
@ToString
public class VacaVo {

	private String emp_no;
	private String va_year;
	private double va_check;
	private double va_use_num;
	private String va_use_date;
	private int va_use_day;
	private int va_use_half;
	
}
