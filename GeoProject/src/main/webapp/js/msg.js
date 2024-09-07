function cntUnreadMsg(){
	fetch("./cntUnreadMsg.do")
	.then(response => response.json())
	.then(data => {
		console.log(data);
		document.getElementById("cntUnreadMsg").innerText = data;
	})
	.catch(error => console.error("Error fetching data:", error));
}

function cntUnreadNoti(){
	fetch("./cntUnreadNoti.do")
	.then(response => response.json())
	.then(data => {
		console.log(data);
		document.getElementById("cntUnreadNoti").innerText = data;
	})
	.catch(error => console.error("Error fetching data:", error));
}

//setInterval(cntUnreadMsg, 5000); // 5초에 한번씩 실행
//setInterval(cntUnreadNoti, 5000); // 5초에 한번씩 실행
//setInterval(cntUnreadMsg, 10000); // 10초에 한번씩 실행(배포용)
//setInterval(cntUnreadNoti, 10000); // 10초에 한번씩 실행(배포용)

window.onload = function(){
	cntUnreadMsg();
	cntUnreadNoti();
};

$(document).ready(function() {
	$('#msgIcon').on('click', function(){
		$.ajax({
			url: "./selectLatestMsg.do",
			method: "GET",
			success: function(data){
				var msgUl = $("#msgUl");
				msgUl.empty();
				
				if(data.length === 0) {
					msgUl.append('<li>읽지 않은 쪽지가 없습니다.</li>');
				} else {
					$.each(data, function(index, msg) {
						var timeDiff = 0;
						
						var start = new Date(msg.msg_send_date);
						var end = new Date();
						
						const seconds = Math.floor((end.getTime() - start.getTime()) / 1000);
						if (seconds < 60) {
							timeDiff = '방금 전';
						} else {
							const minutes = seconds / 60;
							if (minutes < 60) {
								timeDiff = `${Math.floor(minutes)}분 전`;
							} else {
								const hours = minutes / 60;
								if (hours < 24) {
									timeDiff = `${Math.floor(hours)}시간 전`;
								} else {
									const days = hours / 24;
									if (days < 7) {
										timeDiff = `${Math.floor(days)}일 전`;
									}
								}
							}
						}
						
						console.log(msg.reg_date);
						
						msgUl.append(`<li class="message-item">
									    <a class="dropdown-item" href="/GeoProject/detailMsgRecv.do?no=${msg.msg_no}">
									      <img src="storage/${msg.reg_date}" 
									           onerror="this.style.backgroundColor = '#FFFFFF';" 
									           class="rounded-circle">
									      <div>
									        <h4>${msg.msg_send_id}</h4>
									        <p>${msg.msg_content}</p>
									        <p>${timeDiff}</p>
									      </div>
									    </a>
									  </li>
									  <li><hr class="dropdown-divider"></li>
									`);
					});
				}
				
				msgUl.append(`<li>
							    <a class="dropdown-item text-center" href="./recvMsg.do">
							      모든 쪽지 보기
							      <span class="badge rounded-pill bg-primary p-2 ms-2">View all</span>
							    </a>
							  </li>
							`);
			},  
			error: function(){
				var msgUl = $("#msgUl");
				msgUl.empty();
				msgUl.append(`<li><hr class="dropdown-item" href="#">쪽지를 불러오지 못했습니다.</li>`);
			}
		});
	}); // $('#msgIcon').on('click', function()) 끝
	
	$('#notiIcon').on('click', function(){
		$.ajax({
			url: "./selectLatestNoti.do",
			method: "GET",
			success: function(data){
				var notiUl = $("#notiUl");
				notiUl.empty();
				
				if(data.length === 0) {
					notiUl.append('<li>읽지 않은 쪽지가 없습니다.</li>');
				} else {
					$.each(data, function(index, noti) {
						var timeDiff = 0;
						
						var start = new Date(noti.noti_date);
						var end = new Date();
						
						const seconds = Math.floor((end.getTime() - start.getTime()) / 1000);
						if (seconds < 60) {
							timeDiff = '방금 전';
						} else {
							const minutes = seconds / 60;
							if (minutes < 60) {
								timeDiff = `${Math.floor(minutes)}분 전`;
							} else {
								const hours = minutes / 60;
								if (hours < 24) {
									timeDiff = `${Math.floor(hours)}시간 전`;
								} else {
									const days = hours / 24;
									if (days < 7) {
										timeDiff = `${Math.floor(days)}일 전`;
									}
								}
							}
						}
						
						console.log(noti.noti_date);
						
						notiUl.append(`<li class="notification-item">
									      <i class="bi ${noti.noti_status == 1 ? 'bi-exclamation-circle text-warning' : 
										             noti.noti_status == 2 ? 'bi-check-circle text-success' : 
										             noti.noti_status == 3 ? 'bi-x-circle text-danger' : ''} "></i>
										    
										      <div>
										        <h4>
										        	${noti.noti_status == 1 ? '사내 공지사항' : 
										             noti.noti_status == 2 ? '결재 승인 안내' : 
										             noti.noti_status == 3 ? '결재 반려 안내' : ''}
										        </h4>
										        <p>${noti.noti_content}</p>
										        <p>${timeDiff}</p>
										      </div>
										      
									  </li>
									`);
						if (index < data.length - 1) {
					        notiUl.append(`<li><hr class="dropdown-divider"></li>`);
					    }
					});
				}
			},  
			error: function(){
				var msgUl = $("#msgUl");
				notiUl.empty();
				notiUl.append(`<li><hr class="dropdown-item" href="#">쪽지를 불러오지 못했습니다.</li>`);
			}
		});
	}); // $('#notiIcon').on('click', function()) 끝
}); // $(document).ready() 끝