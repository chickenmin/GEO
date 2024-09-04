<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>

<%@ include file="../comm/header.jsp" %>
<script type="text/javascript">
function del(event) {
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
            location.href = "./delBoard.do"; // 삭제 후 게시판 목록으로 리다이렉트
        },
        error: function(error) {
            alert('삭제에 실패했습니다.');
        }
    });
}


</script>
<body>
	<%@ include file="../comm/sidebar.jsp" %>
 	<main id="main" class="main">
		<br>
		<h1>${Vo.bo_title}</h1>
		${Vo.emp_no} · ${Vo.bo_regdate}
		<button>첨부파일</button>
		<br><a onclick="history.back(-1)">뒤로가기</a><br>
		<br><br>
		${Vo.bo_title}
		<br><br>
		${Vo.bo_content}
		<hr>
		<form action="./likeCount.do" method="post">
		<input type="hidden" name="bo_no" value="${Vo.bo_no}">
		<input type="hidden" name="emp_no" value="${detailId.emp_no}">
		<input type="submit" value="추천">
		</form>	
		<button onclick="location.href='./modifyBoard.do?bo_no=${Vo.bo_no}'">글수정</button>		
		<button type="button" name="del" onclick="del(event)">삭제</button>
		<button id="descBtn">댓글</button>		
		<div id="description">
		 <div id="commentSection"></div>
		</div>
		<form action="./commentInsert.do" method="post">
		<div style="text-align: center;">
			<textarea name="comm_content" style="width: 800px; height: 200px; box-sizing: border-box;" placeholder="내용 입력"></textarea>
		<input style="text-align: right;" type="submit" value="댓글등록"><!-- 오른쪽으로 이동이 안된다 -->
		</div>
		</form>
  	</main><!-- End #main -->

</body>
  <%@ include file="../comm/footer.jsp" %>
<script type="text/javascript">
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
                            commentsHtml += '<p>'+comment.reg_id+ '<p>' + comment.comm_content + '</p>'+comment.reg_date+'</p>'; 
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
</script>
</html>