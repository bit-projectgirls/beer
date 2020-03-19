<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


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
	.beercard.small {
		width: 200px;
		height: 100px;
		margin: 10px auto;
		border-radius: 20px;
		background: #fff;
	}
	.likeArea {
		font-size: 1.1em;
		color: #ff7575;
		float : right;
		margin: 0;
		padding: 0;
		position: relative;
		bottom: 6px;
	}
	.beerpic {   
		text-align: center;
		width:60px;
		height:120px;
		float:left;
		margin: 15px;
	}
	.beerpic.small {   
		text-align: center;
		width:30px;
		height:60px;
		float:left;
		margin: 20px 10px;
	}
	.beerpic img{
		height: 120px;
	}  
	.beerpic.small img{
		height: 60px;
	}
	.lst_dsc {
		height: 150px;
		padding: 15px;
		margin: 0;
	}
	.lst_dsc.small {
		height: 100px;
		padding: 10px
		margin: 0;
	}
	.company.sm, .beerinfo.sm, .beername.sm {
		width: 135px;
	}
	.beername.sm {
		height: 30px;
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
	.rating-container, .ratingcap {
		float: left;
	}
	.rating-xs  {
		font-size: 0.5em;
	}
	.beerrating.sm .rating-xs{
		font-size: 0.3em;
	}
	.navbar {
		background:#fff;
		z-index:99;
		position:fixed;
		bottom: 0;
		width: 100%;
	}
	h3 {
		font-size: 1.3em;
		color: #fff;
	}
	h5 {
		font-size: 0.9em;
		color:#fff;
	}
	.searchimg {
		top:0;
		left:0;
		z-index:2;
		position:fixed;
		background: #fde16d;
		padding: 10px;
		height: 152px;
		width: 100%;
		border-bottom-left-radius: 20px;
		border-bottom-right-radius: 20px;
	}
	.searchimg h3{
		color: #323940;
	}
	.searchresult {
		margin-top: 170px;
		margin-bottom: 20px;
	}
	.searchbox {
		margin:10px auto;
		width:300px;
		height:50px;
		vertical-align: middle;
		white-space: nowrap;
		position: relative;
	}
	.searchbox input#search {
		width: 300px;
		height: 40px;
		background: #fde16d;
		border: none;
		font-size: 10pt;
		float: left;
		color: #63717f;
		padding-left: 45px;
		border-radius: 20px;
		margin-top: 10px;
	}
	.searchbox .icon {
		position: relative;
		bottom: -20px;
		left: -285px;
		z-index: 1;
		color: #323940;
	}
</style>
	<div class="searchimg">
		<h3 align="center">검색에 사용된 이미지</h3>
	</div>
   <div class="searchresult">
      <h3 align="center">맥주 검색 결과!</h3>
      <ul class="beerlist">
      <c:forEach items="${ beerList }" var="beerVo" begin="0" end="0">
         <li class='beercard'>
            <div class='beerpic'><img src='<c:url value="${ beerVo.beerPic }"/>'></div>
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
   <div class="secondresult">
   <ul class="beerlist">
   <h5 align="center">찾으시는 맥주가 이 중에 있지는 않나요?</h5>
   <c:forEach items="${ beerList }" var="beerVo" begin="1">
         <li class='beercard small'>
            <div class='beerpic small'><img src='<c:url value="${ beerVo.beerPic }"/>'></div>
            <dl class='lst_dsc small'>
               <dd class='company sm'>${ beerVo.company }</dd>
               <dd class='beeridx' data-idx="${ beerVo.idx }"></dd>
               <dt class='beername sm'><a href="<c:url value="/beer/${ beerVo.beerNo }"/>" target='_blank'>${ beerVo.beerName }</a></dt>
               <dd class='beerinfo sm'>${ beerVo.type } from ${ beerVo.country }</dd>
               <dd class='beerrating sm'><div class="ratingcap">${ beerVo.ratingBA }</div><input name="ratingBA" value="${ beerVo.ratingBA }" class="kv-fa rating"></dd>
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
   <div class="searchbox">
      <h5 align="center">검색이 되지 않으면 이름으로 검색해보세요.</h5>
      <a href="<c:url value="/search"/>">
			<input type="search" name="keyword" id="search">
			<span class="icon"><i class="fas fa-search fa-lg"></i></span>
	  </a>
   </div>

<script>

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