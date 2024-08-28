//fullcalendar
$( document ).ready(function() {
  selectAjax();
});



function selectAjax(){
	$.ajax({
		type: "get",
		url: "./calendarAjax.do",
		dataType: "json",
		success: function(data){
				var calendarEl = document.getElementById('calendar');
				
				var cal_title = $("#cal_title").val();
				var cal_content = $("#cal_content").val();
				var cal_start = $("#datetimepicker1").val();
				var cal_stop = $("#datetimepicker2").val();
				var cal_type = $("#cal_type").val();
				
				var calendar = new FullCalendar.Calendar(calendarEl, {
					initialView: 'dayGridMonth', // 처음 로드될때 보이는 출력 형태 (월별)
					googleCalendarApiKey: 'AIzaSyDjeT9qD3xBctq6xLuV4LNuFATkG20l61I', // 구글캘린더 키 입력
			        selectable: true, // 달력 셀 선택 활성화
			        displayEventTime: false, // 시간 표시 제거
			        editable: true,
			        slotMinTime: "09:00:00",
			        slotMaxTime: "18:00:00",
			        navLinks: true,
			        local:'ko',
			        select: function(info) {	
			            $('#addEventModal').modal('show'); // 달력 셀을 클릭할 때 모달 열기
			            $('#cal_start').val(info.cal_start); 
			            $('#cal_stop').val(info.cal_stop);
			        },

			       	
					eventSources: [
						{
							googleCalendarId: "ko.south_korea.official#holiday@group.v.calendar.google.com" // 구글 캘린더에서 가져올 공휴일 이벤트의 ID
							, className: "koHolidays" // 클릭 이벤트를 제거하기 위해 넣은 클래스
							, editable: false
							, color: "#ABF200" //이벤트의 색
							, textColor: "#FFFFFF" //이벤트의 텍스트 컬러
						}
					],
					editable: true,
							
					events:data,
					eventDrop: function(info) {
						console.log(dateFormat(info.event.cal_start));
						console.log(dateFormat(info.event.cal_stop));
						console.log(info.event.extendedProps.cal_no);
						// info.event.start(Thu May 12 2022 09:30:00 GMT+0900 (한국 표준시)) 를 202205120903 형식으로 바꾸어 
						// updateDragAjax를 통해 일정 업데이트
						updateDragAjax(dateFormat(info.event.cal_start), dateFormat(info.event.cal_stop), info.event.extendedProps.cal_no);
						
					},	
//					dateClick: function(info) {    
//		            // 날짜 클릭 시 모달 열기 및 입력 필드 초기화
//		            $('#cal_no').val(''); // 새로운 이벤트이므로 번호 초기화
//		            $('#cal_title').val(''); // 새로운 이벤트이므로 타이틀 초기화
//		            $('#cal_content').val(''); // 새로운 이벤트이므로 내용 초기화
//		            $('#cal_start').val(info.dateStr); // 클릭한 날짜로 시작일 설정
//		            $('#cal_stop').val(info.dateStr); // 종료일도 동일하게 설정 (사용자가 수정할 수 있음)
//		            $('#cal_type').val('');
//		            $('#cal_open_yn').val('');
//		            $('#addEventModal').modal('show'); // 모달 열기
//			        },			
				});				
				calendar.render();// 달력 초기화시 필수		
				
			},
			error: function() {
				
			}
		});
	}








	
// form을 통한 일정 등록
// 입력 값 : 작성자(writer), 일정명(title), 내용(content), 그룹(group), 일정 시작일(start), 일정 종료일(end)
// 돌아오는 반환값(data)값 : boolean
// true : 성공 / false : 실패
function insertAjax() {
	console.log($("#datetimepicker1").val())
	
	var cal_title = $("#cal_title").val();
	var cal_content = $("#cal_content").val();
	var cal_start = $("#datetimepicker1").val();
	var cal_stop = $("#datetimepicker2").val();
	var cal_type = $("#cal_type").val();
	
	
	// 일정명 칸이 비었을 경우
	if ($("#title").val() == "") {
		alert("일정명을 입력해주세요")
		$("#title").focus();
		return false;
	}
	
	// 내용칸이 비었을 경우
	if ($("#content").val() == "") {
		alert("내용을 입력해주세요")
		$("#content").focus();
		return false;
	}
	
	// 시작일, 종료일이 비엇을경우
	if ($("#datetimepicker1").val() == "" || $("#datetimepicker2").val() == "") {
		alert("시간을 입력해 주세요")
		return false;
	}

	// 시작일이 종료일보다 클 시 아작스 강제 종료
	// dateVal() 시작일 값과 종료일 값을 밀리세컨드로 바꿔 크기를 비교해주는 function
	if (dateVal('datetimepicker1', 'datetimepicker2') == false) {
		return false;
	}

	// serialize() 값 : 작성자(writer), 일정명(title), 내용(content), 그룹(group), 일정 시작일(start), 일정 종료일(end)
	var str = $("#frm").serialize();
	console.log(str);

	// 인서트 성공 시 결과값을 boolean으로 반환
	$.ajax({
		url: "./calendarInsert.do",
		data: { "cal_title": cal_title, "cal_content": cal_content, "cal_start": cal_start, "cal_stop": cal_stop, "cal_type": cal_type },
		type: "post",
		dataType: "json",

		success: function(msg) {
			console.log(msg);
			if (msg !== true) {
				alert("일정 등록에 실패하였습니다.")
				return false;
			} else {
				selectAjax();
				console.log("일정 등록 성공")
			}
		},
		error: function() {
			alert("안녕");
		}
	})
}

// 드래그를 통한 시간 업데이트 ajax
// 파라미터 값 : 시작일(start), 종료일(end), 아이디(id)
// 돌아오는 반환값(data)값 : boolean
// true : 성공 / false : 실패
// 드래그를 통한 시간 업데이트 ajax
function updateDragAjax(cal_start, cal_stop, cal_no) {
    console.log("시작일:", cal_start);
    console.log("종료일:", cal_stop);
//    console.log("번호:", cal_no);
//    var cal_no = $(cal_no).val();
    var cal_no = 34;
    var cal_stop = '202408160301';
    var cal_start = '202408160101';
    console.log("번호2:", cal_no);
    console.log("시작일2:", cal_start);
    console.log("종료일2:", cal_stop);
    $.ajax({
    url: '/GeoProject2/updateDragAjax.do',
    type: 'POST',
    data: {
        cal_no: cal_no,  
        cal_start: cal_start,
        cal_stop: cal_stop
    },
    success: function(response) {
        if(response === 'true') {
            alert('Event updated successfully');
        } else {
            alert('Failed to update event');
        }
    },
    error: function() {
        alert('Error occurred');
    }
});

}


function dateVal(dtp, dtp2) {
	let date1 = $("#" + dtp + "")  // start 의 date 값 ex) Wed May 11 2022 11:10:17 GMT+0900 (한국 표준시)
	let i = date1.datetimepicker('getValue');	
	let date2 = $("#" + dtp2 + "")  // end 의 date 값 ex) Wed May 11 2022 11:10:17 GMT+0900 (한국 표준시)
	let i2 = date2.datetimepicker('getValue');
	console.log(i, i2)
	// test.valueOf() 밀리세컨트로 반환
	// 밀리세컨트로 반환한 i 와 i2 의 시간을 비교하여 시작일보다 종료일이 작은 경우를 방지
	if (i.valueOf() >= i2.valueOf()) {
		date1.val("")
		date2.val("")
		alert("일정 종료일이 시작일보다 과거또는 같은 시간입니다.")
		return false;
	}
}	


function dateFormat(date) {  // date( Thu May 12 2022 09:30:00 GMT+0900 (한국 표준시) ) 를 202205120903 형식으로 바꾸어줌
	var date = new Date();
	
	let year = date.getFullYear();
	let month = zeroPlus(date.getMonth() + 1);
	let day = zeroPlus(date.getDate());
	let hour = zeroPlus(date.getHours());
	let min = zeroPlus(date.getMinutes());
	let startVal = year + "" + month + "" + day + "" + hour + "" + min
	return startVal;
} 

// 만약 1~9 월일 경우 뒤에 0을 붙여주어 01, 02, 03으로 바꾸어줌
// 월, 일, 시간, 분 을 바꿀때 사용
// ex) 1월 => 2월
function zeroPlus(time) {
	console.log("###################", time)
	return time < 10 ? "0" + time : time;
}

