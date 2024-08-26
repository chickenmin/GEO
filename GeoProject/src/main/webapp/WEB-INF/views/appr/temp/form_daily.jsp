<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<%@ include file="../../comm/header.jsp" %>
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
	<%@ include file="../../comm/sidebar.jsp" %>
 	<main id="main" class="main">
		<div style="width: 800px; ">
		
		<!-- FORM -->
			<form action="./submitForm.do"  method="post">
				<input type="hidden" name="apd_form" value=${apd_form}>
				<button type="button" id="apprLine" class="btn btn-primary rounded-pill" data-bs-toggle="modal" style="float: right; margin-bottom: 10px;" data-bs-target="#basicModal">
					결재 라인
				</button>
				<table class="__se_tbl" style="width: 800px; border-collapse: collapse !important; color: black; background: white; 
				border: 1px solid black; font-size: 12px; font-family: malgun gothic, dotum, arial, tahoma;">
				    <thead >
				        <tr>
				            <td style="width: 100%; padding: 10px; border: 1px solid black; font-size: 22px; font-weight: bold; text-align: center; vertical-align: middle;" colspan="3">
				                일일 업무 일지
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
				            	${sessionScope.empNo}	
				            </td>
						</tr>
					
				        <!-- 날짜 -->
				        <tr>
				            <td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; text-align: center; 
				            	color: rgb(0, 0, 0); font-size: 14px; font-weight: bold;" >
				                업무 날짜
				            </td>
				            <td style="padding: 5px; border: 1px solid black; text-align: center; color: rgb(0, 0, 0); font-size: 14px;"
				            	colspan="2">
				                <input name="dates" type="date" style="width: calc(100% - 110px); border: 1px solid black; padding: 5px;" />
				            </td>
				        </tr>
				
				
				        <!-- 사유 -->
				        <tr>
				            <td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; text-align: center; color: rgb(0, 0, 0); font-size: 14px; font-weight: bold;" colspan="3">
				                <b style="color: rgb(255, 0, 0);">*</b>&nbsp;업무 내용
				            </td>
				        </tr>
				        <tr>
				            <td colspan="3" style="padding: 5px; border: 1px solid black; height: 100px; text-align: left; color: rgb(0, 0, 0); font-size: 12px; vertical-align: top; background: rgb(255, 255, 255);">
				                <textarea rows="15" name="content" style="width: 100%; border: 1px solid black; padding: 5px;"></textarea>
				            </td>
				        </tr> 
						
				    </tbody>
				</table>
				
				<!-- 문서 하단 버튼 -->
				<div style="display: flex; justify-content: flex-end;" >
					<button class="btn btn-outline-primary" style="height: auto; margin: 5px 10px 0 0;">임시저장</button>
					<button class="btn btn-primary" style="height: auto; margin: 5px 10px 0 0;">상신하기</button>
				</div>
				<jsp:include page="../apprLine.jsp"></jsp:include>
			</form>
		</div>
  	</main><!-- End #main -->


</body>
  <%@ include file="../../comm/footer.jsp" %>



</html>