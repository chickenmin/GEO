/**
 * 
 */
 $(document).ready(function(){ // 브라우저 로드시
		

		var frm = document.submitForm;
		var submitBtns = document.querySelectorAll(".frmbtn");

		for (let i = 0; i < submitBtns.length; i++) 	{
			submitBtns[i].onclick = function(event) {
				event.preventDefault(); 
				console.log(this.textContent);
				var temp = this.textContent;
				var variety = (temp =="임시저장")?'temp':'submit' 

				var result = check();
				if (!result) {
					return;					
				}
				document.getElementById("dataType").value = temp;
				document.getElementById("variety").value = variety;
				
				console.log("이동할 리스트 종류",variety);
				
				validation();
				frm.submit(); // 폼 제출
								
			}	//submitBtns[i].onclick 
		}	//for 

		
		
		//데이트피커 설정
		$('#mdp-demo').multiDatesPicker({
			dateFormat : "yy/mm/dd",
			beforeShowDay : $.datepicker.noWeekends,
			// 날짜가 선택될 때 호출되는 함수
			onSelect : function(dateText, inst) {
				console.log('Selected date:', dateText);
				console.log('typeOf:', typeof dateText);
			}

		}); // mdp 실행
		
		//파일첨부가 있는 양식인지
		if (document.getElementById('reviewImgFileInput')) {
		    console.log("reviewImgFileInput 요소가 존재합니다.");
	         document.getElementById("reviewImgFileInput").onchange = function(){
		  			console.log("파일 업로드 버튼 실행");
		  			var imgFile = this.value.toLowerCase();
		  			var fileForm = /(.*?)\.(jpg|jpeg|bmp|png|gif|pdf|doc|docx|hwp|xls|xlsx)$/i;
		  			var maxSize = 5*1024*1024;
		  			var fileSize = document.getElementById("reviewImgFileInput").files[0].size;

		  			console.log(imgFile, fileForm,maxSize, fileSize);

		  			var checkImgTest = fileForm.test(imgFile);	//true/false
		  			var checkImgMath = imgFile.match(fileForm)	//객체 혹은 null

		  			if(checkImgMath){
		  				console.log("if 객체가 있으면 true이기 때문에");
		  			}

		  			if(!checkImgTest){ 	//정규화가 맞다면 true, 아니라면 false
		  				alert("가능한 파일 형식이 아닙니다.");
		  				this.value = "";
		  				return;
		  			}
		  			if(maxSize < fileSize){
		  				alert("이미지 파일은 5MB만 이하만 가능합니다.");
		  				return;
		  			}

		  		} // 파일 입력
		} else {
		    console.log("reviewImgFileInput 요소가 존재하지 않습니다.");
		}
		
		
		
		
		//////////////////////모달
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
		
		
		/////////////////////////임시저장일 경우///////////////
		//반차여부 기본 설정
		if ($('#beforeHalf').length) {
			var half = $('#beforeHalf').val();
			console.log(half);
			 $('#half').val(half);
		}
		
		//데이트피커 설정
		//임시저장했던 날짜로 지정
		if ($('#beforeHalf').length) {
		var apd_days = document.getElementById("beforeDates").value;
		var dateArray = apd_days.split(",").map(function(date) {
	            return date.trim(); // 날짜 앞뒤 공백 제거
	        });
		}
		

		
		
	}); //브라우저 로드 끝
	 
	 //체크박스 선택된 명수
	var selectedNodes = $('#tree').jstree("get_selected","true");
	
	//jstree 검색
	function fSch() {
	    console.log("search");
	    $('#tree').jstree(true).search($("#schName").val());
	}
	
	function choice(event){
		//클릭한 버튼의 id
		var clickedButtonId = event.target.id;
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
	   		 
	   		 //선택한 노드는 선택 못하게
	   		 $('#tree').jstree('disable_node', item);
	   		 
	   		 //선택된 id input value 값으로 넣기
	   		 document.getElementById(id+"Cho").value += item.id+",";
	   		 console.log(document.getElementById(id+"Cho"));
		}); //foreach문
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

	
	
	
	function check() {
		    // must 클래스를 가진 모든 요소를 선택
		    var mustFields = document.querySelectorAll('.must');
		    var isEmpty = false;
		
		    // 각 요소를 순회하면서 비어있는지 확인
		    mustFields.forEach(function(field) {
		        if (field.tagName.toLowerCase() === 'input' || field.tagName.toLowerCase() === 'textarea') {
		            // input이나 textarea의 값이 비어있는지 확인
		            if (field.value.trim() === '') {
		                isEmpty = true;
		            }
		        } else if (field.innerText.trim() === '') {
		            // 그 외의 요소들(예: div 등)의 innerText가 비어있는지 확인
		            isEmpty = true;
		        }
		    });
		
		    if (isEmpty) {
		        alert('모든 필수 입력 필드를 작성해 주세요.');
		        return false;
		    } else{
				return true;
		}
		  
	}
	
	
	
	//데이트피커 초기화
	function resetDay(event) {
		event.preventDefault();
		$('#mdp-demo').multiDatesPicker('resetDates');
		console.log("리셋")
	}
	
	function validation(){
		  var str = document.getElementById("con").value;

	    str = str.replace(/\r\n|\r|\n|\n\r/gim, "<br>");
	    str = str.replace(/ /g, "&nbsp;");
	    str = str.replace(/</gim, "&lt;");
	    str = str.replace(/>/gim, "&gt;");
	    str = str.replace(/\'/gim, "&#39;");
	    str = str.replace(/\"/gim, "&quot;"); // 추가: 쌍따옴표 처리
	   
	
	    document.getElementById("con").value = str;
	    //
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	