
$(document).ready(function() {
		
		
		var btns = document.querySelectorAll(".category");

		for (let i = 0; i < btns.length; i++) 	{
			btns[i].onclick = function() {
				console.log(this.textContent);
				var group = this.textContent.trim(); //클릭한 버튼 이름
				console.log("group",group);
				var status = btnClass(group);  //원하는 카테고리 : 대기, 완료..
				console.log(status)
				changeClass(status);
			} //버튼 클릭 끝
		} //버튼 for문 끝
		
		
	var no = document.getElementsByName("apd_nos");
	var allCheck = document.getElementById("allCheck");
	
	for(let i = 0 ;i<no.length ; i++){
		no[i].onclick = function(){
			if(no.length == chksCount(no)){
				allCheck.checked = true;
			} else{
				allCheck.checked = false;
			}
		}
	}
		
		
		
});//ready 끝

function chksCount(no){
	let cnt = 0;
	for(let c of no){
		if(c.checked){
		cnt++;
		}
	}
	return cnt;
}

function allSelect(bool){
	console.log("this로 입력받은 값: " ,bool);
	
	//dom탐색을 통한 check박스 상태값 검색
	var checkStaus = document.getElementById("allCheck");
	console.log("checkbox의 value: ", checkStaus.value);
	console.log("checkbox의 checked: ", checkStaus.checked); //true /false
	//체크박스는 value값이 항상 on
	
	var no = document.getElementsByName("apd_nos");
	
	for(let i=0;i<no.length;i++){
		no[i].checked = bool;
	}
	
}





function btnClass(group){
		var listClass = '';
		if(group == "대기"){
			listClass = "W";
		}else if(group == "진행"){
			listClass = "P";
		}else if(group == "완료"){
			listClass = "C";
		}else{
			listClass = "R";
		}
		
		return listClass;
}

function changeClass(status){
		fetch("./changeClass.do",{
					method:"post",
					headers : {
						"Content-Type":"application/x-www-form-urlencoded"
					},
					body:"apd_status="+status
				})
				.then(response => {
					if (!response.ok) {
						throw new Error("rest 잘못된 요청처리");
					}
					return response.json();
				})
				.then(msg => {
					if ($.fn.dataTable.isDataTable('#apprList')) {
				        $('#apprList').DataTable().clear().destroy();
				    }
					makeList(msg);
					 $('#apprList').DataTable();
				})
				.catch(error=>{
					alert("js 메소드 잘못된 요청처리")
				});
		}
		
		
 function makeList(array){
	   var tbody= document.querySelector('.listBody')
	   tbody.innerHTML = ''; //기존 리스트 삭제
	    
	    //배열 foreach
		array.forEach(function(item, index,array) {
		    console.log('Item:', item);    // 배열의 현재 요소
		    console.log('Index:', index);  // 현재 요소의 인덱스
	    
		    var newTr = makeTr(item,index,array);
		    tbody.appendChild(newTr);

	    	
		});//foreach 끝
}	

//화면 다시 만들기
function makeTr(vo,index,array){
	 const tr = document.createElement("tr");	//tr
	 
	 // 2. <th> 요소 생성
    const thElement = document.createElement('th');
    thElement.setAttribute('scope', 'row');
    thElement.classList.add('text-center');
    const thLink = document.createElement('a');
    thLink.textContent = array.length - index;
    thElement.appendChild(thLink);
    tr.appendChild(thElement);
	 
	 // 3. 첫 번째 <td> 요소 생성 (내용 링크)
    const tdElement1 = document.createElement('td');
    tdElement1.classList.add('text-center');
    const tdLink1 = document.createElement('a');
    tdLink1.href = `./detailAppr.do?apd_no=${vo.apd_no}&variety=appr`;
    tdLink1.textContent = `${vo.apd_con}...`;
    tdElement1.appendChild(tdLink1);
    tr.appendChild(tdElement1);
    
     // 4. 두 번째 <td> 요소 생성 (emp_no)
    const tdElement2 = document.createElement('td');
    tdElement2.classList.add('text-center');
    tdElement2.textContent = vo.emp_no;
    tr.appendChild(tdElement2);

    // 5. 세 번째 <td> 요소 생성 (reg_date)
    const tdElement3 = document.createElement('td');
    tdElement3.classList.add('text-center');
    tdElement3.textContent = vo.reg_date;
    tr.appendChild(tdElement3);

    // 6. 네 번째 <td> 요소 생성 (상태)
    const tdElement4 = document.createElement('td');
    tdElement4.classList.add('text-center');
    var spanElement = checkStatus(vo.apd_status)
    tdElement4.appendChild(spanElement);
    tr.appendChild(tdElement4);

    return tr;
}
		
		
		
		
function checkStatus(status){
	var newSpan = document.createElement('span');
	let spanText = '';
    newSpan.classList.add('badge', 'border-1', 'text-center');
    
    if (status === 'W') {
        newSpan.classList.add('border-primary', 'text-primary');
        spanText = '대기';
    } else if (status === 'C') {
        newSpan.classList.add('border-warning', 'text-warning');
        spanText = '완료';
    } else if (status === 'P') {
        newSpan.classList.add('border-success', 'text-success');
        spanText = '진행';
    } else {
        newSpan.classList.add('border-secondary', 'text-secondary');
        spanText = '반려';
    }
    
    newSpan.textContent = spanText;
    
    return newSpan;
}


		
		
		
		
		
		
		
		