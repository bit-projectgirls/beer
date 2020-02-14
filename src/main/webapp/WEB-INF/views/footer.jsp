<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<a href="<c:url value="/"/>" class="btn btn-sm">
<i class="fas fa-home fa-lg"></i><br/>
<span class="text">Home</span>
</a>
<a href="<c:url value="/list"/>" class="btn btn-sm">
<i class="fas fa-bars fa-lg"></i><br/>
<span class="text">List</span>
</a>
<a href="#" class="btn btn-sm">
<i class="fas fa-camera fa-lg"></i><br/>
<span class="text">Camera</span>
</a>
<a href="<c:url value="/map"/>" class="btn btn-sm">
<i class="fas fa-map-marker-alt fa-lg"></i><br/>
<span class="text">Map</span>
</a>
<a href="<c:url value="/mypage"/>" class="btn btn-sm">
<i class="fas fa-user fa-lg"></i><br/>
<span class="text">MyPage</span>
</a>

