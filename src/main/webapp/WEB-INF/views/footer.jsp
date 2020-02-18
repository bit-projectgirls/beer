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
<form method="post" enctype="multipart/form-data" action="<c:url value="/sample/imageUpload"/>" id="fileForm"style=" display: none">
   <input type="file" accept="image/*" capture="camera" id="picture" name="picture" style="display: none">
</form>

<script>
	// 카메라 연동 밑 실행 이미지가져오기 
	var picture = document.getElementById('picture');
   
	// 파일 선택창에서 파일을 선택 했을 때
	function changeValue(e) {
		// var file = e.target.files[0];
		// Do something with the image file.
		// frame.src = URL.createObjectURL(file);
		console.log("ajax 호출: ", picture);
		//$.ajax({
		//	url:"<c:url value="/sample/imageUpload"/>",
		//	dataType : "json",
		//    type : "post",
		//    data : {picture: picture},
		//    success : function(result){
		    	
		//   }
		//})
		$("#fileForm").submit();
	}

	$("#camerabtn").on("click", function(e) {
		$("#picture").click();
	});
   
	$("#picture").on("change", changeValue);
	
	function ResizeImage() {
		var filesToUpload = document.getElementById('picture').files;
		var file = filesToUpload[0];
		
		// 문서내에 img 객체를 생성합니다
		var img = document.createElement("img");
	
		// 파일을 읽을 수 있는 File Reader 를 생성합니다
		var reader = new FileReader();

		// 파일이 읽혀지면 아래 함수가 실행됩니다
		reader.onload = function(e) {
			img.src = e.target.result;
			// HTML5 canvas 객체를 생성합니다
	        var canvas = document.createElement("canvas");      
	        var ctx = canvas.getContext("2d");
	        // 캔버스에 업로드된 이미지를 그려줍니다
		    ctx.drawImage(img, 0, 0);
			
	        // 최대폭을 400 으로 정했다고 가정했을때
			// 최대폭을 넘어가는 경우 canvas 크기를 변경해 줍니다.
			var MAX_WIDTH = 400;
			var MAX_HEIGHT = 400;
			var width = img.width;
			var height = img.height;

			if (width > height) {
				if (width > MAX_WIDTH) {
					height *= MAX_WIDTH / width;
					width = MAX_WIDTH;
				}
			} else {
				if (height > MAX_HEIGHT) {
					width *= MAX_HEIGHT / height;
					height = MAX_HEIGHT;
				}
			}
			canvas.width = width;
			canvas.height = height;
			// canvas에 변경된 크기의 이미지를 다시 그려줍니다.
			var ctx = canvas.getContext("2d");
			ctx.drawImage(img, 0, 0, width, height);
			// canvas 에 있는 이미지를 img 태그로 넣어줍니다
			var dataurl = canvas.toDataURL("image/png");
			document.getElementById('output').src = dataurl;
	
		    }
		reader.readAsDataURL(file);
		}
</script>