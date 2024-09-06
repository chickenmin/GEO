var externalDept = "";
var externalName = "";
var externalId = "";

$(document).ready(function() {
	var selectedNodes = null;
	
	$.ajax({ // 일단 DOM 로드되고 나면 ./jsTree.do 로 요청 보내서 부서/사원 정보 받아오기
	   	type : "POST",
	   	url : './jsTree.do',
	   	dataType:"json",
	   	success: function(data){
			CreateJSTrees(data);
	    }
	});
	
    // jstree 그리는 함수
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

	// jstree 노드 선택시
	$('#tree').on("select_node.jstree", function(e, data) {
        	var text = data.node.original.text;
			var id = data.node.original.id;
			var parent = data.node.parent;
			selectedNodes = $('#tree').jstree("get_selected","true");
			
			console.log("selectedNodes.length ",selectedNodes.length);

			if(parent == "#"){
				$('#tree').jstree(true).deselect_node(data.node);
			} else if(selectedNodes.length > 1){ //선택된 명수
			 	$('#tree').jstree(true).deselect_node(data.node);
				alert("1명만 선택 가능합니다");
			} else{
				// 정상 처리
				console .log("사원 이름과 id와 부서:", text , id, parent);
				externalName = text;
				externalId = id;
				if (parent == "DE001") {
					externalDept = "개발팀 ";
				} else if (parent == "DE002") {
					externalDept = "인사팀 ";
				} else if (parent == "DE003") {
					externalDept = "생산팀 ";
				} else if (parent == "DE004") {
					externalDept = "총무팀 ";
				} else if (parent == "DE005") {
					externalDept = "영업팀 ";
				} else if (parent == "DE006") {
					externalDept = "마케팅팀 ";
				}
			}
    });
    
    document.getElementById("select").onclick = function(){
		var recv_jsTree = externalDept + externalName + " (" + externalId + ")";
		console.log("recv_jsTree",recv_jsTree);
		document.getElementById("recv_jsTree").readOnly = true;
		document.getElementById("recv_jsTree").disabled = true;
		document.getElementById("recv_jsTree").value = recv_jsTree;
		
		recv_jsTree = recv_jsTree.match(/\(([^)]+)\)/)[1];
		console.log("recv_jsTree",recv_jsTree);
		document.getElementById("msg_recv_id").value = recv_jsTree;
	}
    
}); // $(document).ready() 끝

// jstree 검색
function fSch() {
    console.log("search");
    $('#tree').jstree(true).search($("#schName").val());
}
