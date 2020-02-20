<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<h1>hello</h1>
<h3>${ result }</h3>
<c:forEach items="${ beerList }" var="beerVo">
		<li>
			<div class='beerpic'>그림</div>
			<dl class='lst_dsc'>
				<dd>${ beerVo.company }</dd>
				<dd class='beeridx' data-idx="${ beerVo.idx }"></dd>
				<dt class='beername'><a href="<c:url value="/beer/${ beerVo.beerNo }"/>">${ beerVo.beerName }</a></dt>
				<dd class='beerinfo'>${ beerVo.type } from ${ beerVo.country }</dd>
				<dd class='beerrating'>${ beerVo.ratingBA }</dd>
				<dd id='like${beerVo.beerNo }' class='likeArea' onclick='bLike(${ beerVo.beerNo})'>
					<i class='fas fa-heart'></i>
				</dd>
			</dl>
		</li>
</c:forEach>

<script type='text/javascript'>
</script>
