<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<%@ include file="../../comm/header.jsp" %>
<head>
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
				    <thead>
				        <tr>
				            <td style="width: 100%; padding: 10px; border: 1px solid black; font-size: 22px; font-weight: bold; text-align: center; vertical-align: middle;" colspan="3">
				                연차신청서
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
				                출장자
				            </td>
				            <td style="padding: 5px; border: 1px solid black; text-align: center; color: rgb(0, 0, 0); font-size: 14px;"
				            	colspan="2">
				            	${login.emp_name }	
				            </td>
						</tr>
					
				        <!-- 연차 날짜 -->
				        <tr>
				            <td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; text-align: center; 
				            	color: rgb(0, 0, 0); font-size: 14px; font-weight: bold;" >
				                연차 날짜
				            </td>
				            <td style="padding: 5px; border: 1px solid black; text-align: center; color: rgb(0, 0, 0); font-size: 14px;"
				            	colspan="2">
				                <input name="dates" type="text" id="mdp-demo" style="width: calc(100% - 110px); border: 1px solid black; padding: 5px;" />
				                <button onclick="resetDay(event)" style="margin-left: 10px;">초기화</button>
				            </td>
				        </tr>
				
				        
				
				        <!-- 사유 -->
				        <tr>
				            <td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; text-align: center; color: rgb(0, 0, 0); font-size: 14px; font-weight: bold;" colspan="3">
				                <b style="color: rgb(255, 0, 0);">*</b>&nbsp;연차 사유
				            </td>
				        </tr>
				        <tr>
				            <td colspan="3" style="padding: 5px; border: 1px solid black; height: 100px; text-align: left; color: rgb(0, 0, 0); font-size: 12px; vertical-align: top; background: rgb(255, 255, 255);">
				                <textarea rows="15" name="content" style="width: 100%; border: 1px solid black; padding: 5px;"></textarea>
				            </td>
				        </tr>
				
				    
				    </tbody>
				</table>
				<br>
				<div style="display: flex; justify-content: flex-end;" >
					<button class="btn btn-outline-primary" style="height: auto;">임시저장</button>
					<button class="btn btn-primary" style="height: auto;">상신하기</button>
				</div>
				<jsp:include page="../apprLine.jsp"></jsp:include>
			</form>
		</div>
  	</main><!-- End #main -->

  <%@ include file="../../comm/footer.jsp" %>

</body>
<script type="text/javascript">

	
      // multiDatesPicker 초기화
	 $(document).ready(function() {
         $('#mdp-demo').multiDatesPicker({
        		dateFormat: "yy-mm-dd",
        		beforeShowDay: $.datepicker.noWeekends,
                 // 날짜가 선택될 때 호출되는 함수
             onSelect: function(dateText, inst) {
                 console.log('Selected date:', dateText);
                 console.log('typeOf:', typeof dateText);
             }
             
         });
         
     });
			
      function resetDay(event){
    	  event.preventDefault();
    	  $('#mdp-demo').multiDatesPicker('resetDates');
    	  console.log("리셋")
      }


</script>

</html>