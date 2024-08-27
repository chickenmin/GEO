$(document).ready(function(){
	// 언어를 한국어로 변경
	$.datetimepicker.setLocale('ko');
// datetimepicker 생성
$("#datetimepicker1").datetimepicker({
	
});

$("[id*=datetimepicker2]").datetimepicker({
	
});

$("#imagebutton").click(function(){
	$("#datetimepicker1").datetimepicker('show');
});

$("#imagebutton2").click(function(){
	$("#datetimepicker2").datetimepicker('show');
});

})
