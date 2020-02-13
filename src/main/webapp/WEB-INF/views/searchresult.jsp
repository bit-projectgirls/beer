<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:forEach items="${ beerlist }" var="beerVo">
	<li>
		<div class='beerpic'>그림</div>
		<dl class='lst_dsc'>
		<dd>${ beerVo.company }</dd>
		<dd class='beeridx' data-idx="${ beerVo.idx }"></td>
		<dt class='beername'><a href="<c:url value="/beer/${ beerVo.beerNo }"/>">${ beerVo.beerName }</a></dt>
		<dd class='beerinfo'>${ beerVo.type } from ${ beerVo.country }</dd>
		<dd class='beerrating'>${ beerVo.ratingBA }</dd>
		</dl>
	</li>
</c:forEach>
