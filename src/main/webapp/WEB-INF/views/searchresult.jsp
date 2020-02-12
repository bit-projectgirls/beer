<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:forEach items="${ beerlist }" var="beerVo">
	<tr>
		<td class="beeridx" data-idx="${ beerVo.idx }"></td>
		<td><a href="<c:url value="/beer/${ beerVo.beerNo }"/>"><strong>${ beerVo.beerName }</strong></a></td>
		<td>by ${ beerVo.company }</td>
	</tr>
</c:forEach>
