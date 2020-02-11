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
<!-- slider jQuery -->
<link rel="stylesheet" href="<c:url value="/resources/jquery-ui.css"/>">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="<c:url value="/resources/jquery.ui.touch-punch.min.js"/>"></script>
</head>
<body>
    <a href="<c:url value="/"/>">뒤로</a>
  
  <input type="radio" name="options" id="option1" value="1" onclick="div_OnOff(this.value);"> 국가별
  <input type="radio" name="options" id="option2" value="2" onclick="div_OnOff(this.value);"> 종류별
  <input type="radio" name="options" id="option3" value="3" onclick="div_OnOff(this.value);"> 도수별
  <form id="chkform">
  <div id="con1" style="display:none">
	국가별 검색 필터
    <input type="text" name="keyword" class="form-control" id="keywordinput">
    <div id="countrylist">
    </div>
  </div>
  <div id="con2" style="display:none">
	종류별 검색 필터
    <div id="typelist">
    <c:forEach items="${ typelist }" var="beertype">
    	<input id="${ beertype }" name="beertype" type="checkbox" value="${ beertype }">
    	<label for="${ beertype }">${ beertype }</label>
	</c:forEach>
    </div>
  </div>
  <div id="con3" style="display:none">
	도수별 검색필터
	<input type="text" id="minabv" name="minabv">
	<div id="slider-range"></div>
	<input type="text" id="maxabv" name="maxabv">
  </div>
  </form>
  <div id="beerlist">
    <a href="<c:url value="/beer/1"/>">맥주1</a>
  </div>
</body>
<script>
//검색 필터 보여주기
function div_OnOff(v){
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

var chklist = [];
var minabv = 0;
var maxabv = 20;
$(document).ready(function() {
	//국가 검색시 결과 가져오기
	$("#option1").on("change", function(event){
		$.ajax({
		    url : "<c:url value="/searchcountry"/>",
		    dataType : "json",
		    type : "post",
		    data : {keyword: ""},
		    success : function(result){
		    	var str = "";
		    	$.each(result, function(index, value){
		    		if(chklist.includes(value)){
		    			str += "<input name='country' class='countrycheck' type='checkbox' value='"
		    			+ value + "' id='" + value + "' checked><label for'" +
		    			value + "'>" + value + "</label>";
		    		} else{
			    		str += "<input name='country' class='countrycheck' type='checkbox' value='"
			    		+ value + "' id='" + value + "'><label for'" +
			    		value + "'>" + value + "</label>";
		    		}
		    	});
		    	$("#countrylist").html(str);
		    }
		});
	})
	$("#keywordinput").keyup(function(event){
		var keyword = document.getElementById("keywordinput").value.trim();
		$.ajax({
		    url : "<c:url value="/searchcountry"/>",
		    dataType : "json",
		    type : "post",
		    data : {keyword: keyword},
		    success : function(result){
		    	var str = "";
		    	$.each(result, function(index, value){
		    		if(chklist.includes(value)){
		    			str += "<input name='country' class='countrycheck' type='checkbox' value='"
		    			+ value + "' id='" + value + "' checked><label for'" +
		    			value + "'>" + value + "</label>";
		    		} else{
			    		str += "<input name='country' class='countrycheck' type='checkbox' value='"
			    		+ value + "' id='" + value + "'><label for'" +
			    		value + "'>" + value + "</label>";
		    		}
		    	});
		    	$("#countrylist").html(str);
		    }
		});
	})
	// 국가 체크시
	$("#chkform").on("change", function(event){
		console.log("chklist1: ", chklist);
		$("input[name='country']").each(function(i){
			if(chklist.includes($(this).val())){
				console.log("pop!", $(this).val());
				var idx = chklist.indexOf($(this).val());
				
				chklist.splice(idx, 1);
			}
		});
		$("input[name='country']:checked").each(function(i){
			   chklist.push($(this).val());
		});
		console.log("chklist2: ", chklist);
		$.ajax({
		    url : "<c:url value="/selectcountry"/>",
		    type : "post",
		    dataType : "html",
		    traditional : true,
		    async:false,
		    data : {
		    	chklist: chklist,
		    	minabv: minabv,
		    	maxabv: maxabv
		    	},
		    success : function(result){
		    	$("#beerlist").html(result);
		    },
		    error: function(request, status, error) {
				console.error("Error:", error);
			}
		});
	})
})

// 도수 range slider
$("#slider-range").slider({
	range: true,
	min: 0,
	max: 20,
	step: 0.1,
	values: [ 0, 20 ],
	slide: function( event, ui ) {
		minabv = new Number(ui.values[0]);
		maxabv = new Number(ui.values[1]);
		$("#minabv").val(minabv.toFixed(1));
		$("#maxabv").val(maxabv.toFixed(1));
	},
	change: function(event, ui){
		$.ajax({
		    url : "<c:url value="/selectcountry"/>",
		    type : "post",
		    dataType : "html",
		    traditional : true,
		    async:false,
		    data : {
		    	chklist: chklist,
		    	minabv: minabv,
		    	maxabv: maxabv
		    	},
		    success : function(result){
		    	$("#beerlist").html(result);
		    },
		    error: function(request, status, error) {
				console.error("Error:", error);
			}
		});
	}
});

</script>
</html>