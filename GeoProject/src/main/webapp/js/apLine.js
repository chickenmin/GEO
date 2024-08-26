/**
 * 
 */
 $(document).ready(function(){ // 브라우저 로드시
		
		
		
		$.ajax({	//jsTree 값 받아오기
		   	type : "POST",
		   	url : './jsTree.do',
		   	dataType:"json",
		   	success: function(data){
			        CreateJSTrees(data);
		    }
		});	//ajax 끝~
		
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
		
		
	}); //브라우저 로드
	 
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
	
	
	function check(){
		var dates = document.getElementById("dates").value;
		var con = document.getElementById("con").value;
		var apprCho = document.getElementById("apprCho").value;
		
		if(dates !== "" && con !== "" && apprCho !== ""){
				return true; // 모든 입력이 완료되면 폼 전송을 허용
			}
	
			alert("형식을 모두 입력해 주세요."); 
			return false; 
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	