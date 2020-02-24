<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:forEach items="${ beerList }" var="beerVo">
	<li class='beercard'>
		<div class='beerpic'>그림</div>
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
<script>
//좋아요 기능
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
	    		$("#li"+result.beerNo).css('display', 'none');
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