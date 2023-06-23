<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 수정</title>
<!-- 부트스트랩 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>

<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
</head>
<body>
<%@include file = "/include/nav.jspf" %>	
<br>

<div class="container">    
<form class="form" action="updatePost" method="post" name="updatePostForm">
	<div class="form-group row">
		<label for="Input1" class="col-sm-2 col-form-label">제목</label>
		<div class="col-sm-10">
			<input type="text" name="title" id="title" value="${post.title}" class="form-control" >
		</div>
	</div>

	<div class="form-group row">
		<label for="Textarea1" class="col-sm-2 col-form-label">내용</label>
		<div class="col-sm-10">
			<textarea class="form-control" name="content" id="content" rows="15">${post.content}</textarea>
		</div>
	</div>
	<div class="form-group row">
		<div class="col-sm-10">
			<input type="hidden" name="modifyUser" value="${member.id}">
			<input type="hidden" name="boardId" value="${post.boardId}">
			<input type="hidden" name="page" value="${page}">
			<input type="button" class="btn btn-secondary"  value="수정" id="updateBtn">
			<input type="button" class="btn btn-secondary"  value="취소" onclick="location.href='getPost?boardId=${post.boardId}&page=${page}'">
		</div>
	</div>
</form>
  
</div>  
<script>
$(document).ready(function(){
	
	$('#updateBtn').click(function(){
		var title = $('#title').val();
		var content = $('#content').val();
		
		if(title.trim() == ''){
			alert("제목을 입력하세요.");
			$('#title').focus();
			return;
		}
		if(content.trim() == ''){
			alert("내용을 입력하세요.");
			$('#content').focus();
			return;
		}
		
		document.updatePostForm.submit();
	});
	
}); 
</script>
</body>
</html>