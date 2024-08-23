/**
 * 
 */
 
 function bookmark(clickedElement) {
        // 폼 제목 가져오기
       	 var formTitle = clickedElement.closest('tr').querySelector('.form_Title').textContent;
		// yesMark 클래스를 가진 요소의 수를 확인
         var yesMarkCount = document.querySelectorAll('.yesMark').length;      
       
       
       /////////////////////////////////////
       //북마크 생성
        if (clickedElement.classList.contains('noMark')) { // 북마크 설정하기
            
            // yesMark 클래스를 가진 요소의 수가 3개 이상인 경우 경고
            if (yesMarkCount >= 3) {
                alert('yesMark가 3개 이상입니다!');
                return;
            }
            console.log("양식번호",clickedElement.value);
            
           //////////////////////////////////////
           //ajax로 북마크 보내고, 화면도 생성
            $.ajax({
				url : "./addFav.do",
				type:"post",
				data:{"apd_form" :clickedElement.value},	
				
				success:function(msg){
					console.log("북마크 추가",typeof msg, msg);
					
					
					
					/////////////////////////////////////
					//화면 생성
					//즐겨찾기 div 생성
					const form = document.createElement('form');
					form.action= "./goForm.do"; 
					
					//카드 div 생성
					const cardDiv = document.createElement('div');
				    cardDiv.className = "card info-card revenue-card"; // 클래스 설정
				    cardDiv.style.width = "150px";
				    cardDiv.style.height = "150px";
				    cardDiv.style.background = "white";
				    cardDiv.style.display = "flex";
				    cardDiv.style.alignItems = "center";
				    cardDiv.style.justifyContent = "center";
				    cardDiv.style.position = "relative";
				    
				     // 3. 내부 div 생성
				    const innerDiv = document.createElement('div');
				    innerDiv.style.textAlign = "center";
				    
				    
			        // 4. span 요소 생성
				    console.log(formTitle);
				    const span = document.createElement('span');
				    span.innerHTML = `<b>${formTitle}</b>`;
				    
				     const hiddenInput = document.createElement('input');
				    hiddenInput.name = "formNo";
				    hiddenInput.value = clickedElement.value;
				    hiddenInput.style.display = "none";

					 // 6. 버튼 생성
				    const button = document.createElement('button');
				    button.className = "btn btn-primary";
				    button.textContent = "기안하기";
				
				    // 7. 요소들을 결합
				    innerDiv.appendChild(span);
				    innerDiv.appendChild(document.createElement('br'));
				    innerDiv.appendChild(document.createElement('br'));
				    innerDiv.appendChild(hiddenInput);
				    innerDiv.appendChild(button);
				    
				    cardDiv.appendChild(innerDiv);
				    form.appendChild(cardDiv);
				    
					document.getElementById("bookDiv").appendChild(form);
					
					// 북마크 이미지 변경
		            clickedElement.classList.add('yesMark');
		            clickedElement.classList.remove('noMark');
		            clickedElement.src = 'img/yesBookmark.png';  // 비북마크 이미지로 변경
		            
		            /////////////////////////////////////
					//원래 즐겨찾기 없었을때 화면 없애기
					if(yesMarkCount == 0){
						var noBook = document.getElementById("noBook"); 
						document.getElementById("noBook").classList.add('hidden');
					}
				},
				error:function(){
					alert("북마크 설정 ajax 실패");
				}
			}); //ajax 끝

            
            
        } else {// 북마크 해제
        
        	  $.ajax({
 				url : "./delFav.do",
 				type:"post",
 				data:{"apd_form" :clickedElement.value},	
 				success:function(msg){
 					console.log("북마크 제거",typeof msg, msg);

					//////////////////////////////// 					
 					//화면에서 삭제
	 				 const forms = document.querySelectorAll('form');

				    // 각 form 요소 중 삭제할 form 찾기
				    forms.forEach(form => {
				        // form 내의 b 요소를 찾습니다
				        const b = form.querySelector('b');
				        console.log("b",b);
				        console.log(b && b.textContent.trim() === formTitle);
				        // b 요소가 존재하고, 텍스트가 일치하는지 확인합니다
				        if (b && b.textContent.trim() === formTitle) {
				            form.remove(); // 일치하면 form 요소를 삭제합니다
				        }
				    });
				    
			 			
			 		//클래스, 이미지 변경		
		            clickedElement.classList.add('noMark');
		            clickedElement.classList.remove('yesMark');
		            clickedElement.src = 'img/nonBookmark.png';  // 북마크 이미지로 변경

	
					var noBook = document.getElementById("noBook");  
					var yesMarkCount = document.querySelectorAll('.yesMark').length;      
					if(noBook){
						if(yesMarkCount==0){
						document.getElementById("noBook").classList.remove('hidden');
						}
					}else{
						console.log("q")
						console.log("y",yesMarkCount);
						if(yesMarkCount == 0){
							console.log("y",yesMarkCount)
							const anyBook = document.createElement('div');
							anyBook.classList.add("centered-container");
							anyBook.id ="noBook";
							
							const h4 = document.createElement("h4");
							h4.textContent="자주 사용하는 양식이 없습니다."
							anyBook.appendChild(h4);
							document.getElementById("bookDiv").appendChild(anyBook);
						}
					}
 					
 				},//success 끝
 				error:function(){
 					alert("북마크 해제 ajax 실패");
 				}
 			});  //ajax 끝
        	
        }
    }
   
	
	