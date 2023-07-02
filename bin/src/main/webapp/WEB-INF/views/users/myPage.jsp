<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<!-- 부트스트랩 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>


<style>

body {
	min-height: 100vh;
	background: -moz-linear-gradient(bottom left, #92b5db 0%, #1d466c 100%);
	background: -o-linear-gradient(bottom left, #92b5db 0%, #1d466c 100%);
}

.input-form {
	max-width: 680px;
	margin-top: 80px;
	padding: 32px;
	background: #fff;
	-webkit-border-radius: 10px;
	-moz-border-radius: 10px;
	border-radius: 10px;
	-webkit-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
	-moz-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
	box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15)
}

</style>
</head>

<body>
<%@include file = "/include/nav.jspf" %>
<div class="container">
<div class="input-form-backgroud row">
	<div class="input-form col-md-12 mx-auto">
		<h4 class="mb-3">마이페이지</h4>
		
		<form>
			<div class="mb-3">
			<label for="id" class="form-label">아이디</label> 
			<input type="text" class="form-control" id="id" name="id" value="${member.id }" readonly>
			</div>
			<!-- 
			<div class="">
				<label for="password" class="form-label">비밀번호</label> 
				<input type="password" class="form-control" id="password" name="password" value="">
				<label for="confirmPassword" class="form-label">비밀번호확인</label>
				<input type="password" class="form-control" id="password2" required onchange="confirmPassword()">
			</div>
			 -->
			<div class="mb-3">
				<label for="name" class="form-label">이름</label> 
				<input type="text" class="form-control" id="name" name="name" value="${member.name }" readonly>
			</div>
			<div class="mb-3">
				<label for="admin" class="form-label">등급</label> 
				<c:if test="${member.admin eq 'superAdmin'}">
					<input type="text" class="form-control" id="admin" name="admin" value="최고관리자" readonly>
				</c:if>
				<c:if test="${member.admin eq 'admin'}">
					<input type="text" class="form-control" id="admin" name="admin" value="관리자" readonly>
				</c:if>
				<c:if test="${member.admin eq 'regular'}">
					<input type="text" class="form-control" id="admin" name="admin" value="일반" readonly>
				</c:if>
			</div>
			<div class="mb-3">
				<label for="email" class="form-label">이메일</label> 
				<input type="email" class="form-control" id="email" name="email" value="${member.email }" readonly>
			</div>
			<div class="mb-3">
				<label for="zipcode" class="form-label">주소</label> 
				<input type="text" class="form-control" id="zipcode" name="zipcode" value="${member.zipcode }" readonly>
				<input type="text" class="form-control" id="address" name="address" value="${member.address }" readonly>
				<input type="text" class="form-control" id="addressDetail" name="addressDetail" value="${member.addressDetail }" readonly> 
			</div>
			<div class="mb-3">
				<label for="phone" class="form-label">휴대폰번호</label> 
				<input type="text" class="form-control" id="phone" name="phone" value="${member.phone }" readonly>
			</div>
		
		
		</form>
	<br>
	<br>
	</div>
</div>
	
</div>

</body>
</html>