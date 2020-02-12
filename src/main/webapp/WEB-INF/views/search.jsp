<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">
<!-- Bootstrap -->
<link rel="stylesheet" href="<c:url value="/resources/bootstrap/css/bootstrap.css"/>"/>
<!-- jQuery -->
<script src="<c:url value="/resources/jquery/jquery-3.4.1.min.js"/>"></script>
</head>
<body>
<div id="maincontent">
	<form name="searchform" action="" method="POST" onsubmit="return false;">
		<div class="input-group">
			<input type="text" name="keyword" class="form-control" id="keywordinput">
			<div class="input-group-append">
				<button id="btnSearch" name="btnSearch" type="button" class="btn btn-info">검색</button>
			</div>
		<a href="<c:url value="/"/>">뒤로</a>
		</div>
	</form>

	<h5>최근 검색 기록</h5>
	<div id="searchresult">
		<table class="table table-sm">
		<c:forEach items="${ beerlist }" var="beerVo">
			<tr>
				<td><a href="<c:url value="/beer/${ beerVo.beerNo }"/>"><strong>${ beerVo.beerName }</strong></a></td>
				<td>by ${ beerVo.company }</td>
			</tr>
		</c:forEach>
</table>
	</div>
</div>
</body>
<script>
$(document).ready(function() {
	console.log(document.cookie);
	$("#keywordinput").keyup(function(event){
		var keyword = document.getElementById("keywordinput").value.trim();
		if(keyword.length == 0){
			// 쿠키 사용 검색기록 출력
		}else{
			$.ajax({
			    url : "<c:url value="/searchkeyword"/>",
			    dataType : "html",
			    type : "post",
			    data : {keyword: keyword},
			    success : function(result){
			        $("#searchresult").html(result);
			    }
			});
		}
	})
});
</script>
</html>