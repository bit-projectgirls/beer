<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- loadimage -->
<script src="<c:url value="/resources/load-image.all.min.js"/>"></script>

<style type="text/css" >
.wrap-loading{ /*화면 전체를 어둡게 합니다.*/
	position: fixed;
	left:0;
	right:0;
	top:0;
	bottom:0;
	color: #fff;
	background: rgba(0,0,0,0.2); /*not in ie */
	filter: progid:DXImageTransform.Microsoft.Gradient(startColorstr='#20000000', endColorstr='#20000000');    /* ie */  
}
.wrap-loading div{ /*로딩 이미지*/
	position: fixed;
	top:50%;
	left:50%;
	margin-left: -21px;
	margin-top: -21px;
}
.display-none{ /*감추기*/
	display:none;
}
#myimg {
    height: 100px;
    border: 1px solid #fff;
}
#imgwrap {
	position: inherit;
    top: 42px;
    left: 50%;
    margin-left: -100px;
	display: none;
	width: 200px;
	text-align: center;
}
</style>
<div class="imgwrap" id="imgwrap"><img id="myimg"></div>
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

<form method="post" enctype="multipart/form-data" action="" id="fileForm" style=" display: none">
   <input type="file" accept="image/*;capture=camera" id="picture" name="picture" style="display: none"/>
</form>
<div class="wrap-loading display-none">
	<div><i class="fas fa-spinner fa-spin fa-3x"></i></div>
</div>   

<script>
   // 파일 선택창에서 파일을 선택 했을 때
   $("#camerabtn").on("click", function(e) {
      $("#picture").click();
   });
   
   (function () {
       var matched, browser;
    
       // Use of jQuery.browser is frowned upon.
       // More details: http://api.jquery.com/jQuery.browser
       // jQuery.uaMatch maintained for back-compat
       jQuery.uaMatch = function (ua) {
           ua = ua.toLowerCase();
    
           var match = /(chrome)[ \/]([\w.]+)/.exec(ua) ||
               /(webkit)[ \/]([\w.]+)/.exec(ua) ||
               /(opera)(?:.*version|)[ \/]([\w.]+)/.exec(ua) ||
               /(msie) ([\w.]+)/.exec(ua) ||
               ua.indexOf("compatible") < 0 && /(mozilla)(?:.*? rv:([\w.]+)|)/.exec(ua) ||
               [];
    
           return {
               browser: match[1] || "",
               version: match[2] || "0"
           };
       };
       
       
       matched = jQuery.uaMatch(navigator.userAgent);
       browser = {};
    
       if (matched.browser) {
           browser[matched.browser] = true;
           browser.version = matched.version;
       }
    
       // Chrome is Webkit, but Webkit is also Safari.
       if (browser.chrome) {
           browser.webkit = true;
       } else if (browser.webkit) {
           browser.safari = true;
       }
    
       jQuery.browser = browser;
   })();
   // 리사이징 판별 메소드
   function isImageResizable() {
      var isCanvasUsable = !!document.createElement('canvas').getContext;
      var isLowerIE = false;
      if($.browser.msie) {
         if($.browser.version < 10) {
            // IE9은 Canvas는 쓸 수 있지만 file input에서 file Object를 가져오지 못해 제외
            isLowerIE = true; 
         }
      }
      return isCanvasUsable && !isLowerIE;
   }
   
   // fileInput Object에 값이 변경될 때
   $("#picture").change(function(){ 
      // 이미지 리사이즈 가능한 브라우져가 아니라면 일반적인 업로드로... 
      if(isImageResizable() == false) {
         // TODO : 일반 업로드 추가
      } else {
         // 이미지 리사이즈가 브라우저단에서 가능하다면 html5 사용... 
         var file = document.getElementById('picture').files[0];
         console.log('file: ', file);
         // file Object get...
         if(file.type.match(/image.*/)) { 
            // Load the image
            var reader = new FileReader();
            reader.onload = function (readerEvent) {
               var image = new Image();
               image.onload = function (imageEvent) {
                  // Resize the image
                  var canvas = document.createElement('canvas'),
                  max_size = 200,
                  width = image.width,
                  height = image.height;
                  if (width > height) { 
                     if (width > max_size) { 
                        height *= max_size / width;
                        width = max_size;
                     }
                  } else {
                     if (height > max_size) {
                        width *= max_size / height;
                        height = max_size;
                     }
                  }
                  var cc = {
                		  x : width / 10,
                		  cwidth : (width / 10) * 8
                  }
                  canvas.width = Math.floor(cc.cwidth);
                  canvas.height = height;
                  canvas.getContext('2d').drawImage(image, -Math.floor(cc.x), 0, width, height);
                  var dataUrl = canvas.toDataURL('image/jpeg');
                  //var dataUrl = canvas.toDataURL('image/jpeg', 0.90);
                  // 이미지 퀄리티 조절도 가능...
                  
                  var resizedImage = dataURLToBlob(dataUrl); // 이미지를 바이너리 형태로 변환
                  console.log(resizedImage);
                        
                  // 이미지가 리사이즈 되었으면 파일 업로드하는 메소드 호출
                  $.event.trigger({
                     type: "imageResized",
                     blob: resizedImage,
                     url: dataUrl 
                  });
                  return false;
               } 
               image.src = readerEvent.target.result;
            }
         var file_rotated = loadImage(
        		 file,
        		 function(img){
        			 return img;
        		 },
        		 {
        			 orientation: 1
        		 })
         reader.readAsDataURL(file);
         }
      }
      return false;
   });
   
   // String to Binary 메소드 같은데 구글링으로 얻어온 것이라 자세한 내용은 모름 ㅎㅎ
   var dataURLToBlob = function(dataURL) {
      var BASE64_MARKER = ';base64,';
      if (dataURL.indexOf(BASE64_MARKER) == -1) {
         var parts = dataURL.split(','); 
         var contentType = parts[0].split(':')[1];
         var raw = parts[1]; 
         return new Blob([raw], {type: contentType});
      }
      var parts = dataURL.split(BASE64_MARKER);
      var contentType = parts[0].split(':')[1];
      var raw = window.atob(parts[1]);
      var rawLength = raw.length;
      var uInt8Array = new Uint8Array(rawLength);
      for (var i = 0; i < rawLength; ++i) {
         uInt8Array[i] = raw.charCodeAt(i);
      }
      return new Blob([uInt8Array], {type: contentType});
   }
   $(document).on("imageResized", function (event) {
      var data = new FormData($("form[id*='fileForm']")[0]);
      if (event.blob && event.url) {
         // 리사이즈 된 이미지 첨부, 파일명은 실제 선택한 파일명을 넘겨 서버단에서 처리하도록...
         data.append('filedata', event.blob);
         console.log(event.blob);
         $.ajax({
            url:"<c:url value="/imageUpload"/>",
            data: data,
            cache: false,
            contentType: false,
            processData: false,
            type: 'POST', 
            success: function(result){
            	var url = URL.createObjectURL(event.blob);
            	const img = document.getElementById('myimg');
            	img.src = url;
            	img.onload = function() {
            		//cleanup.
            		URL.revokeObjectURL(this.src);
            	}
            	$('#imgwrap').css('display', 'block');
            	$('html').scrollTop(0);
				$('.wrap').html(result);
            },
            beforeSend:function(){
                $('.wrap-loading').removeClass('display-none');
            }
            ,complete:function(){
                $('.wrap-loading').addClass('display-none');     
            },
            //TODO: 로딩이미지 보여주기
            error : function(err){
               alert("파일 업로드를 할 수 없습니다. 잠시 후 다시 시도해 주세요.");
            }
         });
      }
   });
</script>