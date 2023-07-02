<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<!-- 부트스트랩 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<style>
.boardListTable th,td{
	text-align: center;	
}

.boardListTable td:nth-child(2) {
	text-align: left;
}

</style>

</head>
<body>
<%@include file = "/include/nav.jspf" %>
	
<%-- ${member }	--%>
<%-- 
${params } --%>
<%-- ${boardList }
${pagination } --%>



<div class="container">

<br>
<br>

	<c:if test="${not empty member }">
		<form action="createPost" method="get" class="mb-3" style="display: flex;justify-content: flex-end;">
		      <input type="hidden" name="page" value="${params.page}"/>
		      <input class="btn btn-secondary" type="submit" value="글쓰기" />
		</form>	                
	</c:if>
 
	<table class="table boardListTable">
		<thead class="table-light">
			<tr>
				<th style="width: 10%">글번호</th>
				<th style="width: 60%">제목</th>
				<th style="width: 15%">아이디</th>
				<th style="width: 15%">작성일자</th>
			</tr>
		</thead>

		<tbody>
		<c:choose>
			<c:when test="${empty boardList}">
				<tr>
					<td colspan="4" style="text-align: center;">등록된 게시글이 없습니다.</td>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach var="post" items="${boardList}">
					<c:choose>
						<c:when test="${post.is_blind == true}"> 
							<tr>
								<td>${post.board_id}</td>
								<td>관리자에 의해 규제된 게시글 입니다.</td>
								<td>${post.create_user}</td>
								<td>${post.create_date}</td>
							</tr>
						</c:when>
						<c:otherwise>
							<tr>	
								<td>${post.board_id}</td>
								<td><a href="getPost?boardId=${post.board_id}&page=${params.page}">${post.title}</a></td>
								<td>${post.create_user}</td>
								<td>${post.create_date}</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</c:otherwise>
		</c:choose>
		
		</tbody> 
	</table>
		 

<c:if test="${not empty pagination}">
	<nav aria-label="Page navigation example">
		<ul class="pagination justify-content-center">
			
			<!-- [이전으로]에 대한 사용여부 처리 -->
				<c:if test="${pagination.existPrevPage == true}">
					<li class="page-item">
						<a class="page-link" href="getBoard?page=${pagination.startPage - 1 }" aria-label="Previous">
							<span aria-hidden="true">&laquo;</span>
						</a>
					</li>
				</c:if>	
					<c:if test="${pagination.existPrevPage == false}">
					<li class="page-item disabled">
						<a class="page-link" href="getBoard?page=${pagination.startPage - 1 }" aria-label="Previous">
							<span aria-hidden="true">&laquo;</span>
						</a>
					</li>
					</c:if>	
			<!-- 블록내에 표시할 페이지 태그작성(시작페이지~끝페이지) -->
				<c:forEach var="pageNo" begin="${pagination.startPage }" end="${pagination.endPage }">
					<c:if test="${pageNo == params.page }">	
						<li class="page-item active"><a class="page-link" >${pageNo }</a></li>
					</c:if>
					<c:if test="${pageNo != params.page }">	
						<li class="page-item"><a class="page-link" href="getBoard?page=${pageNo }">${pageNo }</a></li>
					</c:if> 
				</c:forEach>
				
			<!-- [다음으로]에 대한 사용여부 처리	 -->
				<c:if test="${pagination.existNextPage == true }">
					<li class="page-item">
						<a class="page-link" href="getBoard?page=${pagination.endPage + 1 }" aria-label="Next">
							<span aria-hidden="true">&raquo;</span>
						</a>
					</li>
				</c:if>
				<c:if test="${pagination.existNextPage == false }">
					<li class="page-item disabled">
						<a class="page-link" href="getBoard?page=${pagination.endPage + 1 }" aria-label="Next">
							<span aria-hidden="true">&raquo;</span>
						</a>
					</li>
				</c:if>
					
		</ul>
	</nav>		
</c:if>
		
		 

</div> 
<script>
</script>   
</body>
</html>