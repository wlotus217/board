<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 관리</title>
<!-- 부트스트랩 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<style>
.memberTable th, td {
	width: 25%;
	height: 55px;
	text-align: center;
	vertical-align: middle;
}

.memberTable button {
	width: 150px; 
}


</style>
</head>
<body>
<%@include file = "/include/nav.jspf" %>

<div class="container">

<br>
<br>
	<table class="memberTable table table-borderd">
		<thead>
			<tr>
				<th>아이디</th>
				<th>가입일</th>	
				<th>회원등급</th>	
				<th>등급변경</th>	
			</tr>
		
		</thead>
		
		<tbody class="table-group-divider">
		
			<c:forEach var="memberList" items="${memberList}">
				<tr>
					<td>${memberList.id }</td>
					<td>${memberList.createDate }</td>
						<c:if test="${memberList.admin eq 'regular'}">	
							<td>일반</td>
						</c:if>
						<c:if test="${memberList.admin eq 'superAdmin'}">	
							<td>최고관리자</td>
						</c:if>
						<c:if test="${memberList.admin eq 'admin'}">	
							<td>관리자</td>
						</c:if>
					<td>
						<c:if test="${memberList.admin eq 'regular'}">	
							<button onclick="changeAdmin('${memberList.id }','regular')" class="btn btn-secondary btn-xs">관리자 변경</button>
						</c:if>	
						<c:if test="${memberList.admin eq 'admin'}">	
							<button onclick="changeAdmin('${memberList.id }','admin')" class="btn btn-secondary btn-xs">일반회원 변경</button>
						</c:if>	
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

<nav aria-label="Page navigation example">
	<ul class="pagination justify-content-center">
	
	<%--[이전으로]에 대한 사용여부 처리 --%>
		<c:if test="${pagination.existPrevPage  == true}">
			<li class="page-item">
				<a class="page-link" href="getMemberList?page=${pagination.startPage - 1 }" aria-label="Previous">
					<span aria-hidden="true">&laquo;</span>
				</a>
			</li>
		</c:if>	
			<c:if test="${pagination.existPrevPage  == false}">
			<li class="page-item disabled">
				<a class="page-link" href="getMemberList?page=${pagination.startPage - 1 }" aria-label="Previous">
					<span aria-hidden="true">&laquo;</span>
				</a>
			</li>
			</c:if>	
	<%-- 블록내에 표시할 페이지 태그작성(시작페이지~끝페이지) --%>
		<c:forEach var="pageNo" begin="${pagination.startPage }" end="${pagination.endPage }">
			<c:if test="${pageNo == params.page }">	
				<li class="page-item active"><a class="page-link" >${pageNo }</a></li>
			</c:if>
			<c:if test="${pageNo != params.page }">	
				<li class="page-item"><a class="page-link" href="getMemberList?page=${pageNo }">${pageNo }</a></li>
			</c:if>
		</c:forEach>
		
	<%-- [다음으로]에 대한 사용여부 처리 --%>	
		<c:if test="${pagination.existNextPage == true }">
			<li class="page-item">
				<a class="page-link" href="getMemberList?page=${pagination.endPage + 1 }" aria-label="Next">
					<span aria-hidden="true">&raquo;</span>
				</a>
			</li>
		</c:if>
		<c:if test="${pagination.existNextPage == false }">
			<li class="page-item disabled">
				<a class="page-link" href="getMemberList?page=${pagination.endPage + 1 }" aria-label="Next">
					<span aria-hidden="true">&raquo;</span>
				</a>
			</li>
		</c:if>
		
	</ul>
</nav>
</div>
<script>
function changeAdmin(id,admin){
	if(admin == 'regular'){
		if(confirm("관리자로 변경하시겠습니까?")){
			location.href="changeAdmin?id="+id+"&admin="+admin;
		}
	}else {
		if(confirm("일반회원으로 변경하시겠습니까?")){
			location.href="changeAdmin?id="+id+"&admin="+admin;
		}
	}
}
</script>
</body>
</html>