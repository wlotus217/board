<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<!-- 부트스트랩 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>

<script src="https://code.jquery.com/jquery-3.4.1.js"></script>    
<style>
* { padding: 0; margin: 0; }

html, body {
  height: 100%;
  background: #ffffff;
}

#container {
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: center;
  height: 100%;
}

#loginBox {
  width: 300px;
  text-align: center;
  background-color: #ffffff;
}
.input-form-box {
  border: 0px solid #ff0000;
  display: flex;
  margin-bottom: 5px;
}
.input-form-box > span {
  display: block;
  text-align: left;
  padding-top: 5px;
  min-width: 80px;
}
.button-login-box {
  margin: 10px 0;
}
#loginBoxTitle {
  color:#000000;
  font-weight: bold;
  font-size: 32px;
  text-transform: uppercase;
  padding: 5px;
  margin-bottom: 20px;
  background: linear-gradient(to right, #270a09, #8ca6ce);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}
#inputBox {
  margin: 10px;
}

.inputBoxBtn {
  padding: 3px 5px;
  width: 135px;
  height: 40px;
  margin-top: 20px;
}
</style>
</head>
<body class="text-center">
<%-- msg : ${msg }  --%>
<div id="container">
	<div id="loginBox">
	
	<!-- 로그인 페이지 타이틀 -->
	<div id="loginBoxTitle">Board Login</div>
	
		<!-- 아이디, 비번, 버튼 박스 -->
		<div id="inputBox">
			<form action="login" method="post" name="loginForm">
				<div class="input-form-box">
					<span>아이디 </span>
					<input type="text" id="id" name="id" class="form-control">
				</div>
				<div class="input-form-box">
					<span>비밀번호 </span>
					<input type="password" id="password" name="password" class="form-control">
				</div>
				
				<input type="button" class="inputBoxBtn btn btn-primary" id="loginBtn" value="로그인">
				<input type="button" class="inputBoxBtn btn btn-secondary" value="회원가입" onclick="location.href='signUp'">
			</form>
		</div>
	</div>

</div>

<script>
$(document).ready(function(){
	var msg = '<c:out value="${msg}"/>';
	console.log('msg:'+msg);
	if(msg=='로그인실패'){
		alert('일치하는 회원정보가 없습니다.\n다시 시도해주세요.');
	}
	if(msg=='가입성공'){
		alert('회원가입이 완료되었습니다.\n로그인 후 이용해주세요.');
		
	}
	
	$('#loginBtn').click(function(){
		var id = $('#id').val();
		var password = $('#password').val();
		
		if(id == ''){
			alert("아이디를 입력하세요.");
			$('#id').focus();
			return;
		}
		if(password == ''){
			alert("비밀번호를 입력하세요.");
			$('#password').focus();
			return;
		}
		
		document.loginForm.submit();
	});
});

</script>


</body>
</html>