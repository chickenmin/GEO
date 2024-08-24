//전체 체크
$(function(){
	console.log("jquery checkbox FN onload");
	$(".allCheckBox").click(function(){
		$(".ch").prop("checked",this.checked);
	});
});

//체크된 박스 갯수
var chCheckedCount=function(){
	var chs=document.getElementsByName("ch");
	let cnt=0;
	for(let i=0;i<chs.length;i++){
		if(chs[i].checked){
			cnt++;
		}
	}
	return cnt;

}
//체크된게 없을 시 출력
function chkSubmit(){
	var cnt=chCheckedCount();
	if(cnt==0){
		alert("선택된 글이 없습니다");
	}else{
		submitForm();
	}
	console.log("onsubmit 동작 fn");
	return false;
}


function del(event) {
    event.preventDefault(); // 기본 폼 제출 동작을 방지합니다.
    var i = ""; // 선택된 체크박스의 값을 저장할 빈 문자열을 초기화합니다.
    // 클래스가 'ch'이고 체크된 상태인 모든 체크박스에 대해 반복합니다.
    $('.ch:checked').each(function(index, item) {
        i += item.value; // 각 체크박스의 값을 문자열에 추가합니다.
        // 이 경우, 모든 체크박스의 값이 연속된 문자열로 저장됩니다.
    });
    var con = confirm("선택된 글이 삭제됩니다. 삭제하시겠습니까?"); 
    if (con) {
        $.ajax({
            url: "./realDelete.do", 
            type: "post", 
            dataType: "text", // 응답 데이터 형식을 텍스트로 설정합니다.
            data: 'ch=' + i, // 체크박스의 값을 'ch'라는 이름으로 서버에 전송합니다.
            success: function(msg) {
                alert('삭제가 완료되었습니다.'); 
            },
            error: function(error) {
                alert('삭제에 실패했습니다.'); 
            }
        });
    } else {
        alert("삭제가 취소되었습니다"); 
    }
}




