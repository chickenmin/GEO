function cntUnreadMsg(){
	fetch("./cntUnreadMsg.do")
	.then(response => response.json())
	.then(data => {
		console.log(data);
		document.getElementById("cntUnreadMsg").innerText = data;
		document.getElementById("cntDropdown").innerHTML =
				data + "개의 읽지 않은 쪽지가 있습니다."
				+"<a href='./recvMsg.do'><span class='badge rounded-pill bg-primary p-2 ms-2'>View all</span></a>";
	})
	.catch(error => console.error("Error fetching data:", error));
}

//setInterval(cntUnreadMsg, 5000); // 5초에 한번씩 실행
//setInterval(cntUnreadMsg, 10000); // 10초에 한번씩 실행(배포용)

window.onload = cntUnreadMsg;

$(document).ready(function() {
	$('#msgIcon').on('click', function(){
		$.ajax({
			url: "./selectLatestMsg.do",
			method: "GET",
			success: function(){
				var msgUl = $("#msgUl");
				msgUl.empty();
				
				if(data.length === 0) {
					msgUl.append();
				} else {
					$.each(data, function(index, msg) {
						msgUl.append('<li><a class="dropdown-item" href="/detailMsgRecv.do?no=' + msg.msg_no + '">' + msg.msg_content + '</a></li>');
					})
				}
			},
			error: function(){
				
			}
		});
	});
});

