<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:forEach items="${ beerList }" var="beerVo">
	<li>
		<div class='beerpic'>그림</div>
		<dl class='lst_dsc'>
			<dd>${ beerVo.company }</dd>
			<dd class='beeridx' data-idx="${ beerVo.idx }"></dd>
			<dt class='beername'><a href="<c:url value="/beer/${ beerVo.beerNo }"/>">${ beerVo.beerName }</a></dt>
			<dd class='beerinfo'>${ beerVo.type } from ${ beerVo.country }</dd>
			<dd class='beerrating'>${ beerVo.ratingBA }</dd>
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
