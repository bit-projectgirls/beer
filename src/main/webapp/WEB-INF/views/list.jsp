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
<!-- star rating -->
<link href="<c:url value="/resources/star-rating.css"/>" media="all" rel="stylesheet" type="text/css" />
<script src="<c:url value="/resources/star-rating.js"/>" type="text/javascript"></script>
<link href="<c:url value="/resources/krajee-fa/theme.css"/>" media="all" rel="stylesheet" type="text/css" />
<script src="<c:url value="/resources/krajee-fa/theme.js"/>" type="text/javascript"></script>
<!-- font awesome -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.12.1/css/all.css" integrity="sha384-v8BU367qNbs/aIZIxuivaU55N5GPF89WBerHoGA4QTcbUjYiLQtKdrfXnqAcXyTv" crossorigin="anonymous">
<style>
	html, body {
	    position: relative;
	    height: 100%;
	}
	body {
	    font-family: Helvetica Neue, Helvetica, Arial, sans-serif;
	    font-size: 14px;
	    color:#000;
	    margin:0;
	    padding:0;
	}
	#modal {
		display:none;
		position:relative;
		width:100%;
		height:100%;
		z-index:1;
	}
	#modal .modal_content {
		width:100%;
		padding-top:80px;
		background:#fff;
	}
	#modal .modal_layer {
		position:fixed;
		top:0;
		left:0;
		width:100%;
		height:100%;
		background:rgba(0, 0, 0, 0.5);
		z-index:-1;
	}
	#list_content {
		top:60px;
		width: 300px;
		position: absolute;
		left: 50%;
		margin-left: -150px;
	}
	#filtermenu {
		width:300px;
		position: absolute;
		z-index:99;
		left: 50%;
		margin-left: -150px;
		text-align:center;
	}
	input[type="radio"] + label {
		width: 60px;
		height: 60px;
		margin: 10px 10px 20px 10px;
		padding: 5px 0 0 0;
		display:inline-block;
	}
	input[type="radio"]:checked + label {
		color:#fcba03;
	}
	input[type="radio"] {
		display:none;
	}
	input[type="checkbox"] + label {
		display:inline-block;
		border:1px solid #fcba03;
		border-radius:20px;
		margin:2px;
		padding:2px 5px;	
	}
	input[type="checkbox"]:checked + label {
		background-color:#fcba03;
	}
	input[type="checkbox"] {
		display:none;
	}
	#countrylist {
		overflow:auto;
	}
	ul{
		list-style:none;
		padding:0px;
	}
	.beercard {
		width: 300px;
		height: 150px;
		margin: 10px auto;
		border-radius: 20px;
		background: #ffe6db;
	}
	.beerpic {
		width:60px;
		height:120px;
		float:left;
		border:1px solid #303030;
		margin: 15px;
	}
	.lst_dsc {
		height: 150px;
		padding: 15px;
		margin: 0;
	}
	.company, .beerinfo, .beerrating {
		font-size: 1.0em;
		margin: 0;
		overflow: hidden; 
		text-overflow: ellipsis;
		white-space: nowrap; 
		width: 190px;
	}
	.beername {
		font-size: 1.5em;
		margin: 0;
		overflow: hidden; 
		text-overflow: ellipsis;
		white-space: nowrap; 
		width: 190px;
	}
	.rating-container .empty-stars {
		color: #000;
	}
	.rating-container .filled-stars {
		color: #000;
	}
	.beeridx {
		display: none;
	}
	.likeArea {
		float : right;
		margin: 10px 0 0 0;
	}
	.rating-container, .ratingcap {
		float: left;
	}
	.rating-xs  {
    	font-size: 0.9em;
	}
	.navbar {
	background:#fff;
	z-index:99;
  	position:fixed;
  	bottom: 0;
  	width: 100%;
	}
</style>
</head>
<body>
	<div id="filtermenu">
		<input type="radio" name="options" id="option1" value="1" onclick="div_OnOff(this.value);">
		<label for="option1" id="label1" class="btn" onclick="modal_OnOff(1);"><i class="fas fa-globe fa-lg"></i><br/><span>국가</span></label>
		<input type="radio" name="options" id="option2" value="2" onclick="div_OnOff(this.value);">
		<label for="option2" id="label2" class="btn" onclick="modal_OnOff(2);"><i class="fas fa-beer fa-lg"></i><br/><span>종류</span></label>
		<input type="radio" name="options" id="option3" value="3" onclick="div_OnOff(this.value);">
		<label for="option3" id="label3" class="btn" onclick="modal_OnOff(3);"><i class="fas fa-percentage fa-lg"></i><br/><span>도수</span></label>
	</div>
	<div id="modal">
	<div class="modal_content">
		<form id="chkform">
			<div id="con1" style="display:none">
				국가별 검색 필터
				<input type="text" name="keyword" class="form-control" id="keywordinput">
				<div id="countrylist"></div>
			</div>
			<div id="con2" style="display:none">
				종류별 검색 필터
				<div id="typelist">
				<c:forEach items="${ typeList }" var="beertype">
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
			<input type="reset">
		</form>
		<button onclick="modal_OnOff(4)">닫기</button>
		<div class="modal_layer"></div>
	</div>
	</div>
	<div id="list_content">
		<ul id="beerlist" class="beerlist">
		<c:forEach items="${ beerList }" var="beerVo">
			<li class='beercard'>
				<div class='beerpic'>그림</div>
				<dl class='lst_dsc'>
					<dd class='company'>${ beerVo.company }</dd>
					<dd class='beeridx' data-idx="${ beerVo.idx }"></dd>
					<dt class='beername'><a href="<c:url value="/beer/${ beerVo.beerNo }"/>">${ beerVo.beerName }</a></dt>
					<dd class='beerinfo'>${ beerVo.type } from ${ beerVo.country }</dd>
						<dd class='beerrating'><div class="ratingcap">${ beerVo.ratingBA }</div><input name="ratingBA" value="${ beerVo.ratingBA }" class="kv-fa rating"></dd>
					<c:if test='${ not empty authUser }'>
					<dd id='like${beerVo.beerNo }' class='likeArea' onclick='bLike(${ beerVo.beerNo})'>
						<c:set var='chkLike' value='false' />
						<c:forEach items='${ bLikeList }' var='likeVo'>
							<c:if test='${ likeVo.beerNo eq beerVo.beerNo }'>
								<c:set var='chkLike' value='true' />
							</c:if>
						</c:forEach>
						<c:choose>
						<c:when test='${ chkLike == true }'>
						<i class='fas fa-heart'></i>
						</c:when>
						<c:otherwise>
						<i class='far fa-heart'></i>
						</c:otherwise>
						</c:choose>
					</dd>
					</c:if>
				</dl>
			</li>
		</c:forEach>
		</ul>
	</div>
	<footer class="navbar">
		<c:import url="/WEB-INF/views/footer.jsp"/>
	</footer>
</body>
<script>
var ctrylist = [];
var chktypelist = [];
var minabv = 0;
var maxabv = 20;
var lastidx = 0;
var bLikeList = new Array();
<c:forEach items="${bLikeList}" var="likeVo">
bLikeList.push("${likeVo.beerNo}");
</c:forEach>
var authUser = "<c:out value="${authUser}"/>";
console.log(bLikeList);
//검색 필터 보여주기
function modal_OnOff(v){
	if(v == "4"){
		$("#modal").slideUp(300);
		$(".modal_layer").fadeOut(300);
		$("input[name='options']").prop("checked", false);
	} else{
		//$("#modal").css('display', 'block');
		$("#modal").slideDown(300);
		$(".modal_layer").fadeIn(300);
		div_OnOff(v);
		$("#option"+v).prop("checked", true);
	}
}
function div_OnOff(v){
  if(v == "1"){
	  $("#con1").css('display', 'block');
	  $("#con2").css('display', 'none');
	  $("#con3").css('display', 'none');
  }else if(v == "2"){
	  $("#con2").css('display', 'block');
	  $("#con1").css('display', 'none');
	  $("#con3").css('display', 'none');
  }else if(v == "3"){
	  $("#con3").css('display', 'block');
	  $("#con1").css('display', 'none');
	  $("#con2").css('display', 'none');
  }
}

//국가 검색시 결과 가져오기
$("#label1").on("click", function(event){
	$.ajax({
	    url : "<c:url value="/searchcountry"/>",
	    dataType : "json",
	    type : "post",
	    data : {keyword: ""},
	    success : function(result){
	    	var str = renderButton(result);
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
	    	var str = renderButton(result);
	    	$("#countrylist").html(str);
	    }
	});
})
// 체크시
$("#chkform").on("change", function(event){
	$("input[name='country']").each(function(i){
		if(ctrylist.includes($(this).val())){
			console.log("pop!", $(this).val());
			var idx = ctrylist.indexOf($(this).val());
			ctrylist.splice(idx, 1);
		}
	});
	$("input[name='country']:checked").each(function(i){
		console.log("push!", $(this).val());
		ctrylist.push($(this).val());
	});
	$("input[name='beertype']").each(function(i){
		if(chktypelist.includes($(this).val())){
			var idx = chktypelist.indexOf($(this).val());
			chktypelist.splice(idx, 1);
		}
	});
	$("input[name='beertype']:checked").each(function(i){
		   chktypelist.push($(this).val());
	});
	console.log("crtylist: ", ctrylist);
	console.log("chktypelist: ", chktypelist);
	$.ajax({
	    url : "<c:url value="/loadlist"/>",
	    type : "post",
	    dataType : "json",
	    traditional : true,
	    async:false,
	    data : {
	    	typeList: chktypelist,
	    	ctryList: ctrylist,
	    	minabv: minabv,
	    	maxabv: maxabv,
	    	idx: 0
	    	},
	    success : function(result){
	    	var html = "";
			$.each(result, function(index, value){
				html += renderList(value);
				if(authUser.length != 0){
					console.log(bLikeList.includes(String(value.beerNo)));
					if(bLikeList.includes(String(value.beerNo))){
						html += "<dd id='like" + value.beerNo + "' class='likeArea' onclick='bLike(" + value.beerNo +
						")'><i class='fas fa-heart'></i></dd></dl></li>";
					} else{
						html += "<dd id='like" + value.beerNo + "' class='likeArea' onclick='bLike(" + value.beerNo +
						")'><i class='far fa-heart'></i></dd></dl></li>";
					}
				} else {
					html += "</dl></li>"
				}
			});
	    	$("#beerlist").html(html);
	    	$("input[name='ratingBA']").rating({
	    		displayOnly: true,
	    		size: 'xs',
	    		step: 0.5,
	    		showCaption: false,
	    		theme: 'krajee-fa',
	    	  filledStar: '<i class="fas fa-star"></i>',
	    	  emptyStar: '<i class="far fa-star"></i>',
	    	});
	    },
	    error: function(request, status, error) {
			console.error("Error:", error);
		}
	});
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
		    url : "<c:url value="/loadlist"/>",
		    type : "post",
		    dataType : "json",
		    traditional : true,
		    async:false,
		    data : {
		    	typeList: chktypelist,
		    	ctryList: ctrylist,
		    	minabv: minabv,
		    	maxabv: maxabv,
		    	idx: 0
		    	},
		    success : function(result){
		    	var html = "";
				$.each(result, function(index, value){
					html += renderList(value);
					if(authUser.length != 0){
						console.log(bLikeList.includes(String(value.beerNo)));
						if(bLikeList.includes(String(value.beerNo))){
							html += "<dd id='like" + value.beerNo + "' class='likeArea' onclick='bLike(" + value.beerNo +
							")'><i class='fas fa-heart'></i></dd></dl></li>";
						} else{
							html += "<dd id='like" + value.beerNo + "' class='likeArea' onclick='bLike(" + value.beerNo +
							")'><i class='far fa-heart'></i></dd></dl></li>";
						}
					} else {
						html += "</dl></li>"
					}
				});
		    	$("#beerlist").html(html);
		    	$("input[name='ratingBA']").rating({
		    		displayOnly: true,
		    		size: 'xs',
		    		step: 0.5,
		    		showCaption: false,
		    		theme: 'krajee-fa',
		    	  filledStar: '<i class="fas fa-star"></i>',
		    	  emptyStar: '<i class="far fa-star"></i>',
		    	});
		    },
		    error: function(request, status, error) {
				console.error("Error:", error);
			}
		});
	}
});

// 무한 스크롤
$("#countrylist").scroll(function(){
	var innerHeight = $(this).innerHeight(); 
	var scroll=$(this).scrollTop() + $(this).innerHeight(); 
	var height=$(this)[0].scrollHeight;
	var keyword = document.getElementById("keywordinput").value.trim();
	if (scroll >= height){
		var idx = $(".ctryidx:last").attr("value");
		console.log("crtyidx: " + idx);
		$.ajax({
		    url : "<c:url value="/searchcountry"/>",
		    dataType : "json",
		    type : "post",
		    data : {
		    	keyword: keyword,
		    	idx: idx},
		    success : function(result){
		    	var str = renderButton(result);
		    	$("#countrylist").append(str);
		    }
		});
	}
})
$(window).scroll(function(){
	if ($(window).scrollTop() == $(document).height() - $(window).height()){
		lastidx = $(".beeridx:last").attr("data-idx");
		console.log("lastidx: " + lastidx);
		$.ajax({
			url : "<c:url value="/loadlist"/>",
			type : "post",
			datatype : "json",
		    traditional : true,
		    async:false,
			data: {
				typeList: chktypelist,
		    	ctryList: ctrylist,
		    	minabv: minabv,
		    	maxabv: maxabv,
		    	idx: lastidx
		    	},
	    	success : function(result){
		    	var html = "";
				$.each(JSON.parse(result), function(index, value){
					html += renderList(value);
					if(authUser.length != 0){
						console.log(bLikeList.includes(String(value.beerNo)));
						if(bLikeList.includes(String(value.beerNo))){
							html += "<dd id='like" + value.beerNo + "' class='likeArea' onclick='bLike(" + value.beerNo +
							")'><i class='fas fa-heart'></i></dd></dl></li>";
						} else{
							html += "<dd id='like" + value.beerNo + "' class='likeArea' onclick='bLike(" + value.beerNo +
							")'><i class='far fa-heart'></i></dd></dl></li>";
						}
					} else {
						html += "</dl></li>"
					}
				});
		    	$("#beerlist").append(html);
		    	$("input[name='ratingBA']").rating({
		    		displayOnly: true,
		    		size: 'xs',
		    		step: 0.5,
		    		showCaption: false,
		    		theme: 'krajee-fa',
		    	  filledStar: '<i class="fas fa-star"></i>',
		    	  emptyStar: '<i class="far fa-star"></i>',
		    	});
		    },
		    error: function(request, status, error) {
				console.error("Error:", error);
			}
		});
	}
})

// 태그 뿌려주기 
function renderList(vo){
	var html = "<li class='beercard'><div class='beerpic'>그림</div><dl class='lst_dsc'><dd class='company'>" + vo.company + 
	"</dd><dd class='beeridx' data-idx='" + vo.idx + 
	"'></td><dt class='beername'><a href='<c:url value='/beer/" + vo.beerNo + 
	"'/>'>" + vo.beerName + "</a></dt><dd class='beerinfo'>" + vo.type + 
	" from " + vo.country + "</dd><dd class='beerrating'><div class='ratingcap'>" + vo.ratingBA + 
	"</div><input name='ratingBA' value='" +  vo.ratingBA + "' class='kv-fa rating'></dd>";

	return html;
}
function renderButton(obj){
	var str = "";
	$.each(obj, function(index, value){
		if(ctrylist.includes(value.COUNTRY)){
			str += "<input type='hidden' class='ctryidx' name='countryidx' value='" + value.IDX +
			"'><input name='country' class='countrycheck' type='checkbox' value='"
			+ value.COUNTRY + "' id='" + value.COUNTRY + "' checked><label for='" +
			value.COUNTRY + "'>" + value.COUNTRY + "</label>";
		} else{
			str += "<input type='hidden' class='ctryidx' name='countryidx' value='" + value.IDX +
			"'><input name='country' class='countrycheck' type='checkbox' value='"
    		+ value.COUNTRY + "' id='" + value.COUNTRY + "'><label for='" +
    		value.COUNTRY + "'>" + value.COUNTRY + "</label>";
		}
	});
	return str;
}

// 좋아요 기능
function bLike(beerNo){
	console.log(beerNo);
	$.ajax({
		url:"<c:url value="/blike"/>",
		dataType : "json",
	    type : "post",
	    data : {beerNo: beerNo},
	    success : function(result){
	    	if(result.chkLike){
	    		var html = "<i class='fas fa-heart'></i>";
	    		$("#like"+result.beerNo).html(html);
	    	} else {
	    		var html = "<i class='far fa-heart'></i>";
	    		$("#like"+result.beerNo).html(html);
	    	}
	    }
	})
}

$("input[name='ratingBA']").rating({
	displayOnly: true,
	size: 'xs',
	step: 0.5,
	showCaption: false,
	theme: 'krajee-fa',
  filledStar: '<i class="fas fa-star"></i>',
  emptyStar: '<i class="far fa-star"></i>',
});
</script>
</html>