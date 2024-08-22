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


function del(event){
	event.preventDefault();
	//var i = [];
	var i = "";
	$('.chDel:checked').each(function(index, item){
		//i.push({ch:item.value});
		i += item.value;
	});
	var con=confirm("abc132선택된 글이 삭제됩니다");
	if(con){
		$.ajax({
			url : "/realDelete.do",
			type : "post",
			dataType:"text",
			data : 'chDel='+i,
			success : function(msg) {
				alert('aa');
			},
			error : function(error) {
				alert('bb');
			}
		});
	// frm.action="./realDelete.do";
	// frm.method="post";
	// frm.submit();
	}else{
		alert("삭제가 취소되었습니다");
	}
	
}



