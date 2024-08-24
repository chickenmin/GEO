 <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>

<%@ include file="../comm/header.jsp"%>
<head>
<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap"
	rel="stylesheet">
<style type="text/css">

/*자주 사용하는 양식이 없음 div  */
 .centered-container {
            width: 730px;
            height: 150px;
            border-radius: 10px;
            background: white;
            display: flex;
            align-items: center; /* 세로 가운데 정렬 */
            justify-content: center; /* 가로 가운데 정렬 */
            text-align: center; /* 텍스트 가운데 정렬 */
        }
/* 양식없음의 h4 */
 .centered-container h4 {
            margin: 0; /* 기본 여백 제거 */
        }
 /* 양식 없어짐의 hidden : 북마크 추가되면 생김 */       
 .hidden{
        	display:none;
        }
        
 .card.info-card.revenue-card {
		    width: 150px;
		    height: 150px;
		    background: white;
		    display: flex;
		    align-items: center;
		    justify-content: center;
		    position: relative;
		}
        
</style>
<script type="text/javascript" src="./js/appr.js"></script>
</head>

<body>
	<%@ include file="../comm/sidebar.jsp"%>
	<main id="main" class="main">

		<div class="pagetitle">
			<h1>전자결재</h1>
		</div>
		<!-- End Page Title -->


		<div style="height: 200px; margin: 20px;" >
			<span class="card-title">자주쓰는 양식</span><br>
			<div id="bookDiv" style="display: flex; justify-content: space-evenly;">
				<c:choose>
					<c:when test="${fn:length(favList) == 0}">
						<div class="centered-container " id="noBook">
							<h4>자주 사용하는 양식이 없습니다.</h4>
						</div>
					</c:when>
					<c:otherwise>
						<c:forEach var="fav" items="${favList}">
							<form action="./goForm.do">
								<div class="card info-card revenue-card"
									style="width: 150px; height: 150px; background: white; display: flex; align-items: center; justify-content: center; position: relative;">
									<div style="text-align: center;">
										<span> <b> ${fav.apf_name}</b></span> <br>
										<br> <input name="formNo" value="${fav.apd_form}"
											style="display: none">
										<button class="btn btn-primary">기안하기</button>
									</div>
								</div>
							</form>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</div>
		</div>






		<div class="card">
			<div class="card-body">
				<h5 class="card-title">결재 양식함</h5>

				<table class="table">
					<thead>
						<tr>
							<th scope="col">No.</th>
							<th scope="col">양식 제목</th>
							<th scope="col">비고</th>
							<th scope="col">즐겨찾기</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th scope="row">1</th>
							<td><a href="./daily.do" class="form_Title">일일업무일지</a> <input name="formNo"
								value="AP001" style="display: none"></td>
							<td></td>
							<td><c:set var="stopLoop" value="true" scope="page" /> 
							<c:forEach var="fav" items="${favList}">
									<c:if test="${stopLoop}">
										<c:if test="${fav.apd_form eq 'AP001'}">
											<input class="yesMark book" type="image" src="img/yesBookmark.png" onclick="bookmark(this)" value="AP001">
											<c:set var="stopLoop" value="false" scope="page" />
										</c:if>
									</c:if>
								</c:forEach> <c:if test="${stopLoop}">
									<input  class="noMark book" type="image" src="img/nonBookmark.png" onclick="bookmark(this)" value="AP001">
								</c:if></td>
						</tr>
						<tr>
							<th scope="row">2</th>
							<td><a href="./dayOff.do" class="form_Title">연차신청서</a></td>
							<td></td>
							<td><c:set var="stopLoop" value="true" scope="page" /> 
								<c:forEach var="fav" items="${favList}">
									<c:if test="${stopLoop}">
										<c:if test="${fav.apd_form eq 'AP002'}">
											<input class="yesMark book" type="image" src="img/yesBookmark.png" onclick="bookmark(this)" value="AP002">
											<c:set var="stopLoop" value="false" scope="page" />
										</c:if>
									</c:if>
								</c:forEach> <c:if test="${stopLoop}">
									<input class="noMark book"  type="image" src="img/nonBookmark.png" onclick="bookmark(this)" value="AP002">
								</c:if></td>
						</tr>
						<tr>
							<th scope="row">3</th>
							<td><a href="./pay.do" class="form_Title">지출결의서</a></td>
							<td></td>
							<td><c:set var="stopLoop" value="true" scope="page" /> 
								<c:forEach var="fav" items="${favList}">
									<c:if test="${stopLoop}">
										<c:if test="${fav.apd_form eq 'AP003'}">
											<input class="yesMark book" type="image" src="img/yesBookmark.png" onclick="bookmark(this)" value="AP003">
											<c:set var="stopLoop" value="false" scope="page" />
										</c:if>
									</c:if>
								</c:forEach> <c:if test="${stopLoop}">
									<input class="noMark book"  type="image" src="img/nonBookmark.png" onclick="bookmark(this)" value="AP003">
								</c:if></td>
						</tr>
						<tr>
							<th scope="row">4</th>
							<td><a href="./reason.do" class="form_Title">사유서</a></td>
							<td></td>
							<td><c:set var="stopLoop" value="true" scope="page" /> 
								<c:forEach var="fav" items="${favList}">
									<c:if test="${stopLoop}">
										<c:if test="${fav.apd_form eq 'AP004'}">
											<input class="yesMark book" type="image" src="img/yesBookmark.png" onclick="bookmark(this)" value="AP004">
											<c:set var="stopLoop" value="false" scope="page" />
										</c:if>
									</c:if>
								</c:forEach> <c:if test="${stopLoop}">
									<input  class="noMark book" type="image" src="img/nonBookmark.png" onclick="bookmark(this)" value="AP004">
								</c:if></td>
						</tr>
						<tr>
							<th scope="row">5</th>
							<td><a href="./tripReport.do" class="form_Title">출장보고서</a></td>
							<td></td>
							<td><c:set var="stopLoop" value="true" scope="page" /> 
							<c:forEach var="fav" items="${favList}">
									<c:if test="${stopLoop}">
										<c:if test="${fav.apd_form eq 'AP005'}">
											<input class="yesMark book" type="image" src="img/yesBookmark.png" onclick="bookmark(this)" value="AP005">
											<c:set var="stopLoop" value="false" scope="page" />
										</c:if>
									</c:if>
								</c:forEach> <c:if test="${stopLoop}">
									<input class="noMark book" type="image" src="img/nonBookmark.png" onclick="bookmark(this)" value="AP005">
								</c:if></td>
						</tr>

					</tbody>
				</table>

			</div>
		</div>

	</main>
	<!-- End #main -->

	<%@ include file="../comm/footer.jsp"%>

</body>

<script type="text/javascript">
	
	
	
</script>

</html>