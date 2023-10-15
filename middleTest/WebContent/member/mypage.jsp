<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="../js/jquery-3.7.1.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="../css/public.css">
<style>
#mypageDiv {
	margin : 10px;
}

#left {
	border: 2px solid green;
	float : left;
	width : 400px;
}

#left ul {
	list-style: none;
	padding-left: 0px;
}

#left li:hover {
	background: lightgreen;
}

a {
	color : black;
	text-decoration: none;
}

a:visited {
	color : black;
}

iframe {
	border: 2px solid blue;
	width : calc(100% - 400px);
	height : 100%;
}
</style>
<script>
	
</script>
</head>
<body>

<div id="mypageDiv">
	<aside id="left">
	  <h4>카테고리</h4>
	  <ul class="list-group">
	  	<li class="list-group-item"><a href="../member/selectMyinfo.jsp" target="ifr">내 정보 조회</a></li>
	  	<li class="list-group-item"><a href="../member/updateMyinfo.jsp" target="ifr">내 정보 수정</a></li>
	  	<li class="list-group-item">예약 내역
	  	<ul>
		  	<li class="list-group-item"><a href="#" target="ifr">&nbsp;&nbsp;- 예약 조회</a></li>
		  	<li class="list-group-item"><a href="#" target="ifr">&nbsp;&nbsp;- 취소 내역 조회</a></li>
	  	</ul>
	  	</li>
	  	
	  	<li class="list-group-item"><a href="../member/deleteMyinfo.jsp" target="ifr">회원탈퇴</a></li>
	  </ul>
	</aside>
	<section id="selectMyinfo">
	  <article>
	  	<iframe src="../member/selectMyinfo.jsp" name="ifr"></iframe>
	  </article>
	</section> 
</div>


</body>
</html>