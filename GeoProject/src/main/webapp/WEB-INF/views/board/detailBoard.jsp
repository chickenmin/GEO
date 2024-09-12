<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
 <link rel="stylesheet" type="text/css" href="./css/board.css">
<%@ include file="../comm/header.jsp" %>
<script type="text/javascript">
function del(event) {
	var userConfirmed = confirm("삭제하시겠습니까?");
	if(userConfirmed){
    // 게시글 번호 가져오기
    var bo_no = '${Vo.bo_no}';

    // AJAX 요청
    $.ajax({
        url: "./multiDeleteBoard.do",
        type: "post",
        dataType: "text",
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        data: {
            ch: bo_no
        },
        success: function(msg) {
            alert('삭제가 완료되었습니다.');
            if(${loginVo == 'AU002'}){
            location.href = "./delBoard.do"; // 삭제 후 게시판 목록으로 리다이렉트
            }else{
            	location.href="./nomalBoard.do";
            }
        },
        error: function(error) {
            alert('삭제에 실패했습니다.');
        }
    });
}
}

</script>
<body>
	<%@ include file="../comm/sidebar.jsp" %>
 	<main id="main" class="main">
		<br>
		<div class="post-container">
        <div class="post-title">${Vo.bo_title}</div>
        <div class="post-info">${Vo.emp_name} · ${Vo.bo_regdate} · 조회수(${Vo.bo_view_count})</div>
       
		<c:choose>
			<c:when test="${file == null}">
		  				첨부파일 없음
		  			</c:when>
			<c:otherwise>
				<c:forEach var="f" items="${file}">
				 <div class="file-card">
						${f.file_oname}
					<form action="./boardFile.do" method="post" style="display:inline;">
						<input type="hidden" name="file_no" value="${f.file_no}">
						<button type="submit">다운로드</button>
					</form>
					</div>
				</c:forEach>
			</c:otherwise>
		</c:choose>


		<br>
		<div class="post-content">${Vo.bo_content}</div>
		</div>
		<div class="button-container">
		<form action="./likeCount.do" method="post">
		<input type="hidden" name="bo_no" value="${Vo.bo_no}">
		<input class="btn btn-info" type="submit" value="추천(${Vo.bo_like_count})">
		</form>	
		<c:if test="${loginVo.emp_no == Bvo.emp_no ||loginVo.emp_auth == 'AU002'}">
		<button class="btn btn-success" onclick="location.href='./modifyBoard.do?bo_no=${Vo.bo_no}'">글수정</button>
		</c:if>	
		<c:if test="${loginVo.emp_no == Bvo.emp_no && loginVo.emp_auth != 'AU002'}">
		<button class="btn btn-danger" type="button" name="del" onclick="del(event)">삭제</button>
		</c:if>
		<c:if test="${loginVo.emp_auth == 'AU002'}">
		<button class="btn btn-danger" type="button" name="readDel" onclick="realDel(event)">완전삭제</button>
		</c:if>		
		<button class="btn btn-primary" id="descBtn">댓글</button>	
		</div>	
		<div id="description">
		 <div id="commentSection"></div>
		</div>
		<form action="./commentInsert.do" method="post" onsubmit="return showAlert()">
		<input type="hidden" name="bo_no" value="${Vo.bo_no}">
		<div style="text-align: center;">
			<textarea name="comm_content" style="width: 800px; height: 200px; box-sizing: border-box;" placeholder="내용 입력"></textarea>
			<input style="text-align: right;" type="submit" value="댓글등록">
		</div>
		</form>
		
		
  	</main><!-- End #main -->

</body>
  <%@ include file="../comm/footer.jsp" %>
<script type="text/javascript">
function showAlert(){
	alert("댓글 작성을 완료하시겠습니까?");
	return true;
}

window.onload = function () {
    var desc = document.getElementById("description");
    var descBtn = document.getElementById("descBtn");
    var commentSection = $("#commentSection");
    desc.style.display = "none";
    
    descBtn.onclick = function () {
        if (desc.style.display == "none") {
            desc.style.display = "block";
            descBtn.textContent = "댓글닫기";
            
            $.ajax({
                url: './commList.do',
                type: 'GET',
                data: { bo_no: '${Vo.bo_no}' }, // 게시판 번호 전달
                success: function (response) {
                    if (response.length === 0) {
                        // 댓글이 없을 때 메시지 표시
                        commentSection.html('<p>댓글이 없습니다.</p>');
                    } else {
                        // 댓글 데이터를 화면에 표시
                        var commentsHtml = '';
                        $.each(response, function (index, comment) {
                        	var brContent = comment.comm_content.replace(/\n/g, '<br>');
                            commentsHtml += '<p><h4><strong>'+comment.emp_name+
                            				'<p></h4></strong>' + brContent +
                            				'</p><small>'+comment.reg_date+'</p></small>'+'<hr>';
                        });
                        commentSection.html(commentsHtml);
                    }
                },
                error: function (xhr, status, error) {
                    commentSection.html('<p>댓글을 불러오는 데 실패했습니다.</p>');
                }
            });
        } else {
            desc.style.display = "none";
            descBtn.textContent = "댓글열기";
        }
    }
}
function realDel(event) {
var con = confirm("선택된 글이 삭제됩니다. 삭제하시겠습니까?"); 
if (con) {
    $.ajax({
        url: "./realDelete.do", 
        type: "post", 
        dataType: "text", // 응답 데이터 형식을 텍스트로 설정합니다.
        data:'ch=${Vo.bo_no}', // 체크박스의 값을 'ch'라는 이름으로 서버에 전송합니다.
        success: function(msg) {
            alert('삭제가 완료되었습니다.'); 
            location.href="./delBoard.do";
        },
        error: function(error) {
            alert('삭제에 실패했습니다.'); 
        }
    });
} else {
    alert("삭제가 취소되었습니다"); 
}
}
</script>
</html>