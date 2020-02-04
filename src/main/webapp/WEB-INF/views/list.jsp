<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인</title>
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">
<!-- Bootstrap -->
<link rel="stylesheet" href="<c:url value="/resources/bootstrap/css/bootstrap.css"/>"/>
<!-- jQuery -->
<script src="<c:url value="/resources/jquery/jquery-3.4.1.min.js"/>"></script>
</head>
<body>
    <a href="<c:url value="/"/>">뒤로</a>
  
  <input type="radio" name="options" id="option1" value="1" onclick="div_OnOff(this.value,'con');"> 국가별
  <input type="radio" name="options" id="option2" value="2" onclick="div_OnOff(this.value,'con');"> 종류별
  <input type="radio" name="options" id="option3" value="3" onclick="div_OnOff(this.value,'con');"> 도수별
  <div id="con1" style="display:none">
	국가별 검색 필터
    <input type="text" name="keyword" class="form-control" id="keywordinput">
    <div id="countryList">대한민국 미국 프랑스 등등</div>
    <div id="searchresult"></div>
  </div>
  <div id="con2" style="display:none">
	종류별 검색 필터
  </div>
  <div id="con3" style="display:none">
	도수별 검색필터
  </div>
  <div>
    <a href="<c:url value="/beer/1"/>">맥주1</a>
  </div>
  <div>
    <a href="">맥주2</a>
  </div>
</body>
<script>
//검색 필터 보여주기
function div_OnOff(v,id){
  if(v == "1"){
	  $("#con1").slideDown(300);
	  $("#con2").css('display', 'none');
	  $("#con3").css('display', 'none');
  }else if(v == "2"){
	  $("#con2").slideDown(300);
	  $("#con1").css('display', 'none');
	  $("#con3").css('display', 'none');
  }else if(v == "3"){
	  $("#con3").slideDown(300);
	  $("#con1").css('display', 'none');
	  $("#con2").css('display', 'none');
  }
}
//검색시 결과 가져오기
$(document).ready(function() {
	$("#keywordinput").keyup(function(event){
		var keyword = document.getElementById("keywordinput").value.trim();
		if(keyword.length == 0){
			$("#countryList").css('display', 'block');
		}
		$.ajax({
		    url : "<c:url value="/searchcountry"/>",
		    dataType : "html",
		    type : "post",
		    data : {keyword: keyword},
		    success : function(result){
		        $("#searchresult").html(result);
		        $("#countryList").css('display', 'none');
		    }
		});
	})
})
</script>
</html>