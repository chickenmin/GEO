<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>

<%@ include file="../comm/header.jsp"%>


<body>
	<%@ include file="../comm/sidebar.jsp"%>
	<main id="main" class="main">
		<div class="card-body">
			<div>
				<h5 class="card-title">조직도</h5>

				<!-- Default Tabs -->
				<ul class="nav nav-tabs" id="myTab" role="tablist">
					<li class="nav-item" role="presentation">
						<button class="nav-link active" id="home-tab" data-bs-toggle="tab"
							data-bs-target="#home" type="button" role="tab"
							aria-controls="home" aria-selected="true">개발</button>
					</li>
					<li class="nav-item" role="presentation">
						<button class="nav-link" id="profile-tab" data-bs-toggle="tab"
							data-bs-target="#profile" type="button" role="tab"
							aria-controls="profile" aria-selected="false" tabindex="-1">인사</button>
					</li>
					<li class="nav-item" role="presentation">
						<button class="nav-link" id="contact-tab" data-bs-toggle="tab"
							data-bs-target="#contact" type="button" role="tab"
							aria-controls="contact" aria-selected="false" tabindex="-1">생산</button>
					</li>
					<li class="nav-item" role="presentation">
						<button class="nav-link" id="contact-tab" data-bs-toggle="tab"
							data-bs-target="#contact" type="button" role="tab"
							aria-controls="contact" aria-selected="false" tabindex="-1">총무</button>
					</li>
					<li class="nav-item" role="presentation">
						<button class="nav-link" id="contact-tab" data-bs-toggle="tab"
							data-bs-target="#contact" type="button" role="tab"
							aria-controls="contact" aria-selected="false" tabindex="-1">영업</button>
					</li>
					<li class="nav-item" role="presentation">
						<button class="nav-link" id="contact-tab" data-bs-toggle="tab"
							data-bs-target="#contact" type="button" role="tab"
							aria-controls="contact" aria-selected="false" tabindex="-1">마케팅</button>
					</li>
				</ul>
				<div class="tab-content pt-2" id="myTabContent">
					<div class="tab-pane fade show active" id="home" role="tabpanel"
						aria-labelledby="home-tab">
						<p>사원</p>
						<c:forEach var="vo" items="${vo}">
							<c:if test="${vo.emp_dept eq 'DE001' && vo.emp_pos eq 'PO001'}">
								<div>
									<div class="card" style="width: 200px; height: 200px;">
										
										<div class="card-body" style="text-align: center;">
											<img src="<c:url value='/storage/${vo.emp_img}'/>" class="card-img-top" alt="...">
											<h5 class="card-title" style="display: inline-block">${vo.emp_name}</h5>
										</div>
									</div>
								</div>
							</c:if>
						</c:forEach>
					</div>
					<div class="tab-pane fade" id="profile" role="tabpanel"
						aria-labelledby="profile-tab">Nesciunt totam et.
						Consequuntur magnam aliquid eos nulla dolor iure eos quia.
						Accusantium distinctio omnis et atque fugiat. Itaque doloremque
						aliquid sint quasi quia distinctio similique. Voluptate nihil
						recusandae mollitia dolores. Ut laboriosam voluptatum dicta.</div>
					<div class="tab-pane fade" id="contact" role="tabpanel"
						aria-labelledby="contact-tab">Saepe animi et soluta ad odit
						soluta sunt. Nihil quos omnis animi debitis cumque. Accusantium
						quibusdam perspiciatis qui qui omnis magnam. Officiis accusamus
						impedit molestias nostrum veniam. Qui amet ipsum iure. Dignissimos
						fuga tempore dolor.</div>
					<div class="tab-pane fade" id="contact" role="tabpanel"
						aria-labelledby="contact-tab">Saepe animi et soluta ad odit
						soluta sunt. Nihil quos omnis animi debitis cumque. Accusantium
						quibusdam perspiciatis qui qui omnis magnam. Officiis accusamus
						impedit molestias nostrum veniam. Qui amet ipsum iure. Dignissimos
						fuga tempore dolor.</div>
					<div class="tab-pane fade" id="contact" role="tabpanel"
						aria-labelledby="contact-tab">Saepe animi et soluta ad odit
						soluta sunt. Nihil quos omnis animi debitis cumque. Accusantium
						quibusdam perspiciatis qui qui omnis magnam. Officiis accusamus
						impedit molestias nostrum veniam. Qui amet ipsum iure. Dignissimos
						fuga tempore dolor.</div>
					<div class="tab-pane fade" id="contact" role="tabpanel"
						aria-labelledby="contact-tab">Saepe animi et soluta ad odit
						soluta sunt. Nihil quos omnis animi debitis cumque. Accusantium
						quibusdam perspiciatis qui qui omnis magnam. Officiis accusamus
						impedit molestias nostrum veniam. Qui amet ipsum iure. Dignissimos
						fuga tempore dolor.</div>
				</div>
				<!-- End Default Tabs -->

			</div>
		</div>




	</main>
	<!-- End #main -->


</body>
<%@ include file="../comm/footer.jsp"%>



</html>