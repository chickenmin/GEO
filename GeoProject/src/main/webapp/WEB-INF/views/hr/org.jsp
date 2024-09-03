<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>

<%@ include file="../comm/header.jsp"%>
<head>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
<script type="text/javascript" src="./js/apLine.js"></script>
</head>

<body>
	<%@ include file="../comm/sidebar.jsp"%>
	<main id="main" class="main">

		<div id="tree">
					
		</div>
	


	</main>
	<!-- End #main -->


</body>
<%@ include file="../comm/footer.jsp"%>
<script type="text/javascript">
			//jstree 생성
			$(document).ready(function(){
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
)};
			</script>

</html>