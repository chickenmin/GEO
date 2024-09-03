<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<%@ include file="../comm/header.jsp" %>
<head>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />
<style type="text/css">
	
    .modal-body {
        display: flex; /* Flexbox를 사용 */
        justify-content: space-evenly; /* 요소들 사이에 균등한 간격을 두고 정렬 */
        align-items: start; /* 요소들을 컨테이너의 시작 부분에 정렬 */
    }
    .info-card {
        width: 200px; 
        background: white;
        display: flex;
        align-items: center;
        justify-content: center;
        position: relative;
    }
    .main-card {
        height: 400px; /* 첫 번째 카드의 높이 */
    }
    .choice {
        height: 150px; /* choice 클래스를 가진 카드의 높이 */
    }
    .choices-container {
        display: flex; /* 내부 카드들을 세로로 배치 */
        flex-direction: column; /* 세로 방향으로 요소들을 배치 */
        justify-content: space-between; /* 요소 사이의 간격을 균등하게 배분 */
    }
    .selTitle{
    	background-color: lightgreen;
    }
</style>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
<script type="text/javascript" src="./js/apLine.js"></script>
</head>

<body>
	<%@ include file="../comm/sidebar.jsp" %>
 	<main id="main" class="main d-flex justify-content-center align-items-center" style="min-height: 100vh;">
		<div style="width: 800px; ">
		<!-- FORM -->
			<form  action="./submitForm2.do"  method="post" name="submitForm"  enctype="multipart/form-data" >
			
				<!-- 화면에 노출없이, 폼으로 넘겨야 하는 값 -->
				<input type="hidden" name="apd_form" value="${apd_form}">
				<c:if test="${apd_form ne 'AP002'}">
					<input type="hidden" name="apd_half_yn" value="N">
				</c:if>
				
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
						<!-- 기안자 -->
						<tr>
							<td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; text-align: center; 
				            	color: rgb(0, 0, 0); font-size: 14px; font-weight: bold;" >
				                기안자
				            </td>
				            <td style="padding: 5px; border: 1px solid black; text-align: center; color: rgb(0, 0, 0); font-size: 14px;"
				            	colspan="2">
				            	${sessionScope.loginVo.emp_name}	
				            	<input type="hidden" name="emp_no" value="${sessionScope.loginVo.emp_no}">
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
					            		<input name="apd_days" type="text" id="mdp-demo"  class="must" style="width: calc(100% - 110px); border: 1px solid black; padding: 5px;" />
					                	<button onclick="resetDay(event)" style="margin-left: 10px;">초기화</button>
					            	</c:when>
					            	<c:otherwise>
					                	<input id="dates"  class="must"  name="apd_days" type="date" style="width: calc(100% - 110px); border: 1px solid black; padding: 5px;" />
					                </c:otherwise>
				           		 </c:choose>
				            </td>
				        </tr>
				        <c:if test="${apd_form eq 'AP002'}">
					        <tr>
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
							</tr>
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
				                <textarea id="con" rows="15"  class="must" name="apd_con" style="width: 100%; border: 1px solid black; padding: 5px;"></textarea>
				            </td>
				        </tr> 
				        
						<c:if test="${apd_form eq 'AP003' or apd_form eq 'AP004' or apd_form eq 'AP005'}">
						 <!-- 파일 -->
				        <tr>
				        	<td colspan="3" style="padding: 5px; border: 1px solid black; height: 100px; text-align: left; color: rgb(0, 0, 0); 
				        		font-size: 12px; vertical-align: top; background: rgb(255, 255, 255);">
				        		<input type="file" name="file" multiple="multiple" id="reviewImgFileInput">	
				        	</td>
				        </tr>
						</c:if>				        
					
				    </tbody>
				</table>
				
				<!-- 문서 하단 버튼 -->
				<div style="display: flex; justify-content: flex-end;" >
					<input type="hidden" name="type" id="dataType">
					<input type="hidden" name="variety" id="variety">
					<button class="btn btn-outline-primary frmbtn"  style="height: auto; margin: 5px 10px 0 0;" >임시저장</button>
					<button class="btn btn-primary frmbtn"  style="height: auto; margin: 5px 10px 0 0;" >상신하기</button>
				</div>
				<jsp:include page="./apprLine.jsp"></jsp:include>
			</form>
		</div>
  	</main><!-- End #main -->


</body>
  <%@ include file="../comm/footer.jsp" %>
  



</html>