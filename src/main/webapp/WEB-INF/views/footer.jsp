<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<a href="<c:url value="/"/>" class="btn btn-sm">
	<i class="fas fa-home fa-lg"></i><br/>
	<span class="text">Home</span>
</a>

<a href="<c:url value="/list"/>" class="btn btn-sm">
	<i class="fas fa-bars fa-lg"></i><br/>
	<span class="text">List</span>
</a>

<a class="btn btn-sm" id="camerabtn">
	<i class="fas fa-camera fa-lg"></i><br/>
	<span class="text">Camera</span>
</a>

<a href="<c:url value="/map"/>" class="btn btn-sm">
	<i class="fas fa-map-marker-alt fa-lg"></i><br/>
	<span class="text">Map</span>
</a>

<a href="<c:url value="/mypage"/>" class="btn btn-sm">
	<i class="fas fa-user fa-lg"></i><br/>
	<span class="text">MyPage</span>
</a>

<!-- To Do : action에 url 채우기( multipart/form-data 컨트롤러 ) -->   
<form method="post" enctype="multipart/form-data" action="<c:url value="/imgpreview"/>" id="fileForm"style=" display: none">
   <input type="file" accept="image/*" capture="camera" id="camera" name="camera" style="display: none">
</form>

<script>
	// 카메라 연동 밑 실행 이미지가져오기 
	var camera = document.getElementById('camera');
	var frame = document.getElementById('frame');
   
	// 파일 선택창에서 파일을 선택 했을 때
	function changeValue(e) {
		// var file = e.target.files[0];
		// Do something with the image file.
		// frame.src = URL.createObjectURL(file);
		$("#fileForm").submit();
	}

	$("#camerabtn").on("click", function(e) {
		$("#camera").click();
	});
   
	$("#camera").on("change", changeValue);
</script>