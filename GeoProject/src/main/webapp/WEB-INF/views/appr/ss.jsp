<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<form action="./submitForm.do"  method="post" enctype="multipart/form-data" id="approval">
				<input type="hidden" name="apd_form" value="${apd_form}">
				<button type="button" id="apprLine" class="btn btn-primary rounded-pill" data-bs-toggle="modal" style="float: right; margin-bottom: 10px;" data-bs-target="#basicModal">
					결재 라인
				</button>
				<table class="__se_tbl" style="width: 800px; border-collapse: collapse !important; color: black; background: white; 
				border: 1px solid black; font-size: 12px; font-family: malgun gothic, dotum, arial, tahoma;">
				    <thead >
				        <tr>
				            <td style="width: 100%; padding: 10px; border: 1px solid black; font-size: 22px; font-weight: bold; text-align: center; vertical-align: middle;" colspan="3">
				                <c:choose>
				                	<c:when test="${apd_form eq 'AP001'}">
				                		일일 업무 일지
				                	</c:when>
				                	<c:when test="${apd_form eq 'AP002'}">
				                		연차 신청서
				                	</c:when>
				                	<c:when test="${apd_form eq 'AP003'}">
				                		지출결의서
				                	</c:when>
				                	<c:when test="${apd_form eq 'AP004'}">
				                		사유서
				                	</c:when>
				                	<c:otherwise>
				                		출장보고서
				                	</c:otherwise>
				                </c:choose>
				            </td>
				        </tr>
				    </thead> 
				    <tbody>
				        <!-- 결재자 및 결재서명 -->
				         <tr>
				            <td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; text-align: center; color: rgb(0, 0, 0); font-size: 14px; font-weight: bold; width: 33%;">
				                결재자 1
				            </td>
				            <td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; text-align: center; color: rgb(0, 0, 0); font-size: 14px; font-weight: bold; width: 33%;">
				                결재자 2
				            </td>
				            <td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; text-align: center; color: rgb(0, 0, 0); font-size: 14px; font-weight: bold; width: 33%;">
				                결재자 3
				            </td>
				        </tr>
				        <tr>
				            <td style="padding: 5px; border: 1px solid black; text-align: center; color: rgb(0, 0, 0); font-size: 14px;
				            			height 100px;">
				                
				            </td>
				            <td style="padding: 5px; border: 1px solid black; text-align: center; color: rgb(0, 0, 0); font-size: 14px;
				            			height: 100px;">
				            </td>
				            <td style="padding: 5px; border: 1px solid black; text-align: center; color: rgb(0, 0, 0); font-size: 14px;
				            			height: 100px;">
				            </td>
				        </tr> 
						
						<!-- 기안자 -->
						<tr>
							<td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; text-align: center; 
				            	color: rgb(0, 0, 0); font-size: 14px; font-weight: bold;" >
				                기안자
				            </td>
				            <td style="padding: 5px; border: 1px solid black; text-align: center; color: rgb(0, 0, 0); font-size: 14px;"
				            	colspan="2">
				            	${sessionScope.loginVo.emp_no}	
				            </td>
						</tr>
					
				        <!-- 날짜 -->
				        <tr>
				            <td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; text-align: center; 
				            	color: rgb(0, 0, 0); font-size: 14px; font-weight: bold;" >
				                 <c:choose>
				                	<c:when test="${apd_form eq 'AP001'}">
				                		업무일자
				                	</c:when>
				                	<c:when test="${apd_form eq 'AP002'}">
				                		연차일자
				                	</c:when>
				                	<c:when test="${apd_form eq 'AP003'}">
				                		발의일자
				                	</c:when>
				                	<c:when test="${apd_form eq 'AP004'}">
				                		사유일자
				                	</c:when>
				                	<c:otherwise>
				                		출장일자
				                	</c:otherwise>
				                </c:choose>
				            </td>
				            <td style="padding: 5px; border: 1px solid black; text-align: center; color: rgb(0, 0, 0); font-size: 14px;"
				            	colspan="2">
				            	<c:choose>
					            	<c:when test="${apd_form eq 'AP002' or apd_form eq 'AP005'}">
					            		<input name="dates" type="text" id="mdp-demo"  class="must" style="width: calc(100% - 110px); border: 1px solid black; padding: 5px;" />
					                	<button onclick="resetDay(event)" style="margin-left: 10px;">초기화</button>
					            	</c:when>
					            	<c:otherwise>
					                	<input id="dates"  class="must"  name="dates" type="date" style="width: calc(100% - 110px); border: 1px solid black; padding: 5px;" />
					                </c:otherwise>
				           		 </c:choose>
				            </td>
				        </tr>
				        <c:if test="${apd_form eq 'AP002'}">
				        	<td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; text-align: center; 
				            	color: rgb(0, 0, 0); font-size: 14px; font-weight: bold;" >
				            	반차사용
				            </td>
				             <td style="padding: 5px; border: 1px solid black; text-align: center; color: rgb(0, 0, 0); font-size: 14px;"
				            	colspan="2">
				            	<select name="apd_half_yn" style="width: calc(100% - 110px); border: 1px solid black; padding: 5px;">
				            		<option value="N" >---미사용---</option>
				            		<option value="A" >오전반차</option>
				            		<option value="P" >오후반차</option>
				            	</select>
				            </td>
				        </c:if>
				
				
				        <!-- 사유 -->
				        <tr>
				            <td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; text-align: center; color: rgb(0, 0, 0); font-size: 14px; font-weight: bold;" colspan="3">
				                <b style="color: rgb(255, 0, 0);">*</b>&nbsp;
				                 <c:choose>
				                	<c:when test="${apd_form eq 'AP001'}">
				                		업무내용
				                	</c:when>
				                	<c:when test="${apd_form eq 'AP002'}">
				                		연차사유
				                	</c:when>
				                	<c:when test="${apd_form eq 'AP003'}">
				                		지출내용
				                	</c:when>
				                	<c:when test="${apd_form eq 'AP004'}">
				                		사유
				                	</c:when>
				                	<c:otherwise>
				                		출장보고
				                	</c:otherwise>
				                </c:choose>
				            </td>
				        </tr>
				        <tr>
				            <td colspan="3" style="padding: 5px; border: 1px solid black; height: 100px; text-align: left; color: rgb(0, 0, 0); font-size: 12px; vertical-align: top; background: rgb(255, 255, 255);">
				                <textarea id="con" rows="15"  class="must" name="content" style="width: 100%; border: 1px solid black; padding: 5px;"></textarea>
				            </td>
				        </tr> 
				        
						<c:if test="${apd_form eq 'AP003' or apd_form eq 'AP004' or apd_form eq 'AP005'}">
						 <!-- 파일 -->
				        <tr>
				        	<td colspan="3" style="padding: 5px; border: 1px solid black; height: 100px; text-align: left; color: rgb(0, 0, 0); 
				        		font-size: 12px; vertical-align: top; background: rgb(255, 255, 255);">
				        		<input type="file" name="file" multiple="multiple" id="reviewImgFileInput" >	
				        	</td>
				        </tr>
						</c:if>				        
					
				    </tbody>
				</table>
				
				<!-- 문서 하단 버튼 -->
				<div style="display: flex; justify-content: flex-end;" >
					<button class="btn btn-outline-primary" style="height: auto; margin: 5px 10px 0 0;" type="button" onclick="temp()">임시저장</button>
					<button class="btn btn-primary" style="height: auto; margin: 5px 10px 0 0;" >상신하기</button>
					<button type="button" onclick="check()">체크</button>
				</div>
				<div class="choice card info-card revenue-card">
						<span>결재자</span>
						<div class="must"  id="appr" style="flex: 1; margin-top: 10px;"></div>
						<input id="apprCho" name="apprLine" type="hidden">
					</div>
			</form>





</body>
</html>