<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<%@ include file="./header.jsp" %>
<head>
	<script type="text/javascript" src="js/index3.js"></script>
	  <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
</head>

<body>
	<%@ include file="./sidebar.jsp" %>
 	<main id="main" class="main">
		<div style="width: 800px; background-color: white;">
			<form action=""  method="post">
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

        <!-- 연차 날짜 -->
        <tr>
            <td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; text-align: center; 
            	color: rgb(0, 0, 0); font-size: 14px; font-weight: bold;" >
                연차 날짜
            </td>
            <td style="padding: 5px; border: 1px solid black; text-align: center; color: rgb(0, 0, 0); font-size: 14px;"
            	colspan="2">
                <input type="text" id="mdp-demo" style="width: calc(100% - 110px); border: 1px solid black; padding: 5px;" />
                <button onclick="resetDay(event)" style="margin-left: 10px;">초기화</button>
            </td>
        </tr>

        <!-- 반차 여부 -->
        <tr>
            <td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; text-align: center; color: rgb(0, 0, 0); 
            			font-size: 14px; font-weight: bold;">
                반차 여부
            </td>
            <td style="padding: 5px; border: 1px solid black; text-align: left; color: rgb(0, 0, 0); font-size: 14px;" 
            	  colspan="2">
                <select name="half_yn" style="width: 100%; border: 1px solid black; padding: 5px;">
                    <option value="N">--사용안함--</option>
                    <option value="Y">사용</option>
                </select>
            </td>
        </tr>

        <!-- 휴가 사유 -->
        <tr>
            <td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; text-align: center; color: rgb(0, 0, 0); font-size: 14px; font-weight: bold;" colspan="3">
                <b style="color: rgb(255, 0, 0);">*</b>&nbsp;휴가 사유
            </td>
        </tr>
        <tr>
            <td colspan="3" style="padding: 5px; border: 1px solid black; height: 100px; text-align: left; color: rgb(0, 0, 0); font-size: 12px; vertical-align: top; background: rgb(255, 255, 255);">
                <textarea rows="5" name="content" style="width: 100%; border: 1px solid black; padding: 5px;"></textarea>
            </td>
        </tr>

        <!-- 추가 안내 사항 -->
        <tr>
            <td colspan="3" style="padding: 20px; border: 1px solid black; text-align: left; background: #ddd;">
                1. 연차의 사용은 근로기준법에 따라 전년도에 발생한 개인별 잔여 연차에 한하여 사용함을 원칙으로 한다. 단, 최초 입사시에는 근로 기준법에 따라 발생 예정된 연차를 차용하여 월 1회 사용 할 수 있다.<br>
                2. 경조사 휴가는 행사일을 증명할 수 있는 가족 관계 증명서 또는 등본, 청첩장 등 제출<br>
                3. 공가(예비군/민방위)는 사전에 통지서를, 사후에 참석증을 반드시 제출
            </td>
        </tr>
    </tbody>
</table>
				<div style="display: flex; justify-content: flex-end;" >
					<button class="btn btn-primary" style="height: auto;">상신하기</button>
				</div>
			</form>
		</div>
  	</main><!-- End #main -->

  <%@ include file="./footer.jsp" %>

</body>
<script type="text/javascript">

	/* $('#mdp-demo').multiDatesPicker({
	});
	const selectedDates = $('#mdp-demo').multiDatesPicker('getDates');
	console.log(selectedDates); */
	
      // multiDatesPicker 초기화
	 $(document).ready(function() {
         $('#mdp-demo').multiDatesPicker({
                 // 날짜가 선택될 때 호출되는 함수
             onSelect: function(dateText, inst) {
                 console.log('Selected date:', dateText);
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