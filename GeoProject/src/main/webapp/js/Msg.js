function cntUnreadMsg(){
	fetch("./cntUnreadMsg.do")
	.then(response => response.json())
	.then(data => {
		console.log(data);
		document.getElementById("cntUnreadMsg").innerText = data;
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
						
						msgUl.append('<li class="message-item"><a class="dropdown-item" href="/GeoProject/detailMsgRecv.do?no='
									+ msg.msg_no + '"><img src="assets/img/messages-1.jpg" alt="이미지" class="rounded-circle"><div><h4>'
									+ msg.msg_send_id + '</h4><p>' + msg.msg_content
									+ '</p><p>'+ timeDiff +'</p></div></a></li>');
					});
				}
				
				msgUl.append('<li><hr class="dropdown-divider"></li>');
				msgUl.append('<li><a class="dropdown-item text-center" href="./recvMsg.do">'
							+'모든 쪽지 보기<span class="badge rounded-pill bg-primary p-2 ms-2">View all</span></a></li>');
			},
			error: function(){
				var msgUl = $("#msgUl");
				msgUl.empty();
				msgUl.append('<li><hr class="dropdown-item" href="#">쪽지를 불러오지 못했습니다.</li>');
			}
		});
	});
	
	$.ajax({//jsTree 값 받아오기
	   	type : "POST",
	   	url : './jsTree.do',
	   	dataType:"json",
	   	success: function(data){
			CreateJSTrees(data);
	    }
	});
	
    //jstree 생성
	function CreateJSTrees(data){
		$('#tree').jstree({ 
			  'core' : {
			    'data' : data,
			    "check_callback" : true
			  },
			  'checkbox' : {
			        'three_state': false
			    },
			  "search": {
			        "show_only_matches": true,
			        "show_only_matches_children": true
			   },
			   "themes" : {
		            "responsive": true
		        },
			  "plugins" : ["search", "checkbox"]
		});
		console.log(typeof data,data);
	}	//jstree 생성 끝

	//jstree 클릭시 메소드
	$('#tree').on("select_node.jstree", function (e, data) {
		var text = data.node.original.text;
		var id = data.node.original.id;
		var parent = data.node.parent;
		var selectedNodes = $('#tree').jstree("get_selected","true");
		
		console.log("selectedNodes.length ",selectedNodes.length);
		if(selectedNodes.length >3){ //선택된 명수
			alert("3명까지 선택 가능합니다");
		}
		
		if(parent == "#"){
		 $('#tree').jstree(true).deselect_node(data.node);
		} else if(selectedNodes.length >3){ //선택된 명수
		 	$('#tree').jstree(true).deselect_node(data.node);
			alert("3명까지 선택 가능합니다");
		}else{
		 console.log("사원 이름과 id:", text ,id);
		}
    });
}); // $(document).ready() 끝

//체크박스 선택된 명수
var selectedNodes = $('#tree').jstree("get_selected","true");
	
//jstree 검색
function fSch() {
    console.log("search");
    $('#tree').jstree(true).search($("#schName").val());
}

function choice(event){
	//클릭한 버튼의 id
	const clickedButtonId = event.target.id;
	 if (clickedButtonId === "apC") {
		put("appr");
	} else if(clickedButtonId === "apR"){
		take("appr");
	}else if(clickedButtonId === "reC"){
		put("cc");
	}else {
		take("cc");
	}
}

//사람 선택
function put(id){
	//checkbox에 선택된 node의 값들
	var selectedNodes = $('#tree').jstree("get_selected","true");

	if(selectedNodes == 0 ){
		alert("선택된 사람이 없습니다.");
	}
	
	selectedNodes.forEach(function(item, index) {
		//선택된 이름들 화면에 넣기
   		 document.getElementById(id).innerHTML += item.text+"<br>";
   		 
   		 //체크박스 해제
   		 $('#tree').jstree("deselect_all");
   		 
   		 //선택된 id input value 값으로 넣기
   		 document.getElementById(id+"Cho").value += item.id+",";
   		 console.log(document.getElementById(id+"Cho"));
	});
}

//선택자 리셋
function take(id){
	var inner = document.getElementById(id).innerHTML;
	if(inner == ""){
		alert("선택된자가 없습니다.");
	}
	//체크박스 해제
	$('#tree').jstree("deselect_all");
	document.getElementById(id).innerHTML = "";
	document.getElementById(id+"Cho").value = "";
}

