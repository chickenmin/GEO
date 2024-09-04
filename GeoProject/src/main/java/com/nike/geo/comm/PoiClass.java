package com.nike.geo.comm;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.nike.geo.vo.hr.EmpVo;

public class PoiClass {

    
	    public static boolean Poi(List<EmpVo> vo, String filePath) {
	    	
	    	String fileNm = "allEmp.xlsx";
	    	

	    	// 빈 Workbook 생성
	        XSSFWorkbook workbook = new XSSFWorkbook();

	        // 빈 Sheet를 생성
	        XSSFSheet sheet = workbook.createSheet("employee data");

	        // Sheet를 채우기 위한 데이터들을 Map에 저장
	        Map<Integer, Object[]> data = new TreeMap<>();
	        data.put(1, new Object[]{"ID", "성명","부서" ,"직급","입사일","연락처","이메일"});
	        int num = 2;
	        
	        for (EmpVo e : vo) {
				data.put(num++, new Object[] {e.getEmp_no(),e.getEmp_name(),e.getEmp_dept(),e.getEmp_pos(),e.getEmp_hiredate(),e.getEmp_phone(),e.getEmp_email()});
			}
	        
	        // data에서 keySet를 가져온다. 이 Set 값들을 조회하면서 데이터들을 sheet에 입력한다.
	        Set<Integer> keyset = data.keySet();
	        int rownum = 0;

	        // 알아야할 점, TreeMap을 통해 생성된 keySet는 for를 조회시, 키값이 오름차순으로 조회된다.
	        for (Integer key : keyset) {
	            Row row = sheet.createRow(rownum++);
	            Object[] objArr = data.get(key);
	            int cellnum = 0;
	            for (Object obj : objArr) {
	                Cell cell = row.createCell(cellnum++);
	                if (obj instanceof String) {
	                    cell.setCellValue((String)obj);
	                } else if (obj instanceof Integer) {
	                    cell.setCellValue((Integer)obj);
	                }
	            }
	        }
	        
	        //경로 없을 경우 만들기
	        File dir = new File(filePath);
	        if (!dir.exists()) {
	            dir.mkdirs();
	        }
	        
	        // 파일 이름에 (1), (2), ... 을 붙이는 로직
	        File file = new File(filePath, fileNm);
	        String baseFileName = fileNm.substring(0, fileNm.lastIndexOf("."));
	        String extension = fileNm.substring(fileNm.lastIndexOf("."));
	        int count = 1;

	        // 같은 이름의 파일이 존재할 경우 (1), (2) 등의 숫자를 붙임
	        while (file.exists()) {
	            file = new File(filePath, baseFileName + "(" + count + ")" + extension);
	            count++;
	        }


	        try {
	        	 // FileOutputStream에 변경된 file 객체를 사용하여 저장
	            FileOutputStream out = new FileOutputStream(file);
	            workbook.write(out);
	            out.close();
	            return true;
	        } catch (IOException e) {
	            e.printStackTrace();
	            return false;
	        }
	    	
	    	
	    	
    }
}
