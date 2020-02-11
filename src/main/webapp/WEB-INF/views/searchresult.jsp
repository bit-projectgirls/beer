<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<p>검색 결과</p>
<table class="table table-sm">
	<c:forEach items="${ beerlist }" var="beerVo">
		<tr>
			<td><a href="<c:url value="/beer/${ beerVo.beerNo }"/>"><strong>${ beerVo.beerName }</strong></a></td>
			<td>by ${ beerVo.company }</td>
		</tr>
	</c:forEach>
</table>