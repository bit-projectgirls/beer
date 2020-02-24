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
<!-- Google Font -->
<link href="https://fonts.googleapis.com/css?family=Knewave|Nanum+Gothic&display=swap" rel="stylesheet">
<style>
	html, body {
	    position: relative;
	    height: 100%;
	}
	body {
	    font-family: 'Nanum Gothic', sans-serif;
		background-color: #323940;
	    margin:0;
	    padding:0;
	}
	.wrap {
		padding-bottom: 80px;
	}
	#modal {
		font-size: 0.8em;
		display:none;
		position:relative;
		width:100%;
		height:100%;
		z-index:1;
	}
	#modal .modal_content {
		width:100%;
		padding-top:70px;
		background:#fff;
		border-bottom-right-radius: 20px;
		border-bottom-left-radius: 20px;
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
	#con1, #con2, #con3 {
		padding: 10px;
	}
	#list_content {
		top: 70px;
		width: 300px;
		position: absolute;
		left: 50%;
		margin-left: -150px;
	}
	#filtermenu {
		background-color: #fff;
		width:100%;
		height: 70px;
		padding-top:5px;
		position: absolute;
		z-index:99;
		left: 50%;
		margin-left: -50%;
		text-align:center;
	}
	#filtermenu label span {
		font-size: 0.8em;
	}
	input[type="radio"] + label {
		color: #323940;
		width: 60px;
		height: 60px;
		margin: 4px 10px 10px 10px;
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
		margin:3px;
		padding:3px 6px;	
	}
	input[type="checkbox"]:checked + label {
		background-color:#fcba03;
		color: #fff;
	}
	input[type="checkbox"] {
		display:none;
	}
	.searchbox {
		margin:0 auto 10px auto;
		width:300px;
		height:40px;
		vertical-align: middle;
		white-space: nowrap;
		position: relative;
	}
	.searchbox input#keywordinput {
		width: 300px;
		height: 40px;
		background-color: #fde16d;
		border: none;
		font-size: 10pt;
		float: left;
		color: #323940;
		padding-left: 45px;
		border-radius: 20px;
	}
	.searchbox .icon {
		position: absolute;
		top: 12px;
		left: 20px;
		z-index: 1;
		color: #323940;
	}
	#countrylist {
		overflow:auto;
		max-height: 250px;
	}
	#con3 {
		height: 50px;
		width: 315px;
		margin: 0 auto
	}
	#minabv, #maxabv {
		border: 0;
		margin: 5px;
		width: 40px;
		float: left;
		text-align: center;
	}
	#slider-range {
		margin: 10px 10px 5px 5px;
		width: 180px;
		border: 0;
		background-color: #c7c7c7;
		float: left;
		border-radius:5px;
	}
	#slider-range .ui-slider-range {
		background-color: #fde16d;
		border:0;
	}
	#slider-range .ui-slider-handle {
		background-color: #fde16d;
		border: 5px solid #fff;
		border-radius:10px;
		box-shadow: 0px 2px 3px 1px rgba(0, 0, 0, 0.2)
	}
	.modal_bottom {
		height: 40px;
		border-bottom-right-radius: 20px;
		border-bottom-left-radius: 20px;
		background-color: #fde16d;
	}
	#clearbtn {
		margin: 6px 11px;
		padding: 3px 7px;
		border: 0;
		background-color: #fff;
		border-radius: 20px
	}
	#closebtn {
		margin: 6px 11px;
		padding: 3px 7px;
		border: 0;
		float: right;
		background-color: #fff;
		border-radius: 20px
	}
	ul {
		list-style:none;
		padding:0px;
	}
	.beercard {
		width: 300px;
		height: 150px;
		margin: 10px auto;
		border-radius: 20px;
		background: #fff;
	}
	.beerpic {
		width:60px;
		height:120px;
		float:left;
		margin: 15px;
	}
	.beerpic img{
		height: 120px;
	}
	.lst_dsc {
		height: 150px;
		padding: 15px;
		margin: 0;
	}
	.company, .beerinfo {
		color: #323940;
		font-size: 0.8em;
		margin: 0;
		overflow: hidden; 
		text-overflow: ellipsis;
		white-space: nowrap;
		width: 190px;
	}
	.beerrating {
		font-size: 1.1em;
	}
	.beername {
		font-size: 1.5em;
		line-height: 1.1em;
		margin: 0;
		width: 190px;
		height: 55px;
		overflow: hidden;
		display: -webkit-box;
		-webkit-line-clamp: 2;
		-webkit-box-orient: vertical;
	}
	.beername a {
		color: #000;
	}
	.rating-container .empty-stars {
		color: #fcba03;
	}
	.rating-container .filled-stars {
		color: #fcba03;
	}
	.beeridx {
		display: none;
	}
	.likeArea {
		font-size: 1.1em;
		color: #ff7575;
		float : right;
		margin: 0;
		padding: 0;
		position: relative;
		bottom: 5px;
		right: 2px;
	}
	.rating-container, .ratingcap {
		float: left;
	}
	.rating-xs  {
    	font-size: 0.5em;
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
	<div class="wrap">
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
		<form name="chkform" id="chkform">
			<div id="con1" style="display:none">
				<div class="searchbox">
					<input type="text" name="keyword" id="keywordinput" placeholder="국가를 검색해보세요">
					<span class="icon"><i class="fas fa-search fa-lg"></i></span>
				</div>
				<div id="countrylist"></div>
			</div>
			<div id="con2" style="display:none">
				<div id="typelist">
				<c:forEach items="${ typeList }" var="beertype">
					<input id="${ beertype }" name="beertype" type="checkbox" value="${ beertype }">
					<label for="${ beertype }">${ beertype }</label>
				</c:forEach>
				</div>
			</div>
			<div id="con3" style="display:none">
				<input type="text" id="minabv" name="minabv" value="0.0%" readonly>
				<div id="slider-range"></div>
				<input type="text" id="maxabv" name="maxabv" value="20.0%" readonly>
			</div>
		</form>
		<div class="modal_bottom">
			<button id="clearbtn">선택 초기화</button>
			<button id="closebtn" onclick="modal_OnOff(4)">닫기</button>
		</div>
		<div class="modal_layer"></div>
	</div>
	</div>
	<div id="list_content">
		<ul id="beerlist" class="beerlist">
		<c:forEach items="${ beerList }" var="beerVo">
			<li class='beercard'>
				<div class='beerpic'><img src="<c:url value="${ beerVo.beerPic }"/>"></div>
				<dl class='lst_dsc'>
					<dd class='company'>${ beerVo.company }</dd>
					<dd class='beeridx' data-idx="${ beerVo.idx }"></dd>
					<dt class='beername'><a href="<c:url value="/beer/${ beerVo.beerNo }"/>" target='_blank'>${ beerVo.beerName }</a></dt>
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
var idx = 0;
var bLikeList = new Array();
<c:forEach items="${bLikeList}" var="likeVo">
bLikeList.push("${likeVo.beerNo}");
</c:forEach>
var authUser = "<c:out value="${authUser}"/>";
PrimarySlider();
console.log(bLikeList);

function ajax_call(){
	idx = 0;
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
	    	idx: idx
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

// 초기화 버튼
$("#clearbtn").on("click", function(){
	ctrylist = [];
	$("form")[0].reset();
	$( "#slider-range" ).slider("destroy");
	$("input[name='country']:checked").prop("checked", false);
	PrimarySlider();
	minabv = 0;
	maxabv = 20;
	ajax_call();
});
//검색 필터 보여주기
function modal_OnOff(v){
	if(v == "4"){
		$("#modal").slideUp(300);
		$(".modal_layer").fadeOut(300);
		$('body').css("overflow", "auto");
		$("input[name='options']").prop("checked", false);
	} else{
		//$("#modal").css('display', 'block');
		$("#modal").slideDown(300);
		$(".modal_layer").fadeIn(300);
		$('body').css("overflow", "hidden");
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
	ajax_call();
})


// 도수 range slider
function PrimarySlider(){
$("#slider-range").slider({
	range: true,
	min: 0,
	max: 20,
	step: 0.1,
	values: [ 0, 20 ],
	slide: function( event, ui ) {
		minabv = new Number(ui.values[0]);
		maxabv = new Number(ui.values[1]);
		$("#minabv").val(minabv.toFixed(1) + "%");
		$("#maxabv").val(maxabv.toFixed(1) + "%");
	},
	change: function(event, ui){
		ajax_call();
	}
});
}
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
		idx = $(".beeridx:last").attr("data-idx");
		console.log("lastidx: " + idx);
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
		    	idx: idx
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
	"'/>' target='_blank'>" + vo.beerName + "</a></dt><dd class='beerinfo'>" + vo.type + 
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