<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<!-- 부트스트랩 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
	crossorigin="anonymous"></script>
<!-- 제이쿼리 -->	
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>

<style>
body {
	min-height: 100vh;
	background: -moz-linear-gradient(bottom left, #92b5db 0%, #1d466c 100%);
	background: -o-linear-gradient(bottom left, #92b5db 0%, #1d466c 100%);
}

.input-form {
	max-width: 680px;
	margin-top: 80px;
	margin-bottom: 80px;
	padding: 32px;
	background: #fff;
	-webkit-border-radius: 10px;
	-moz-border-radius: 10px;
	border-radius: 10px;
	-webkit-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
	-moz-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
	box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15)
}

.buttonGroup {text-align: center;}
</style>
</head>

<body>
	<div class="container">
		<div class="input-form-backgroud row">
			<div class="input-form col-md-12 mx-auto">
				<h4 class="mb-3">회원가입</h4>
				
				
				<form class="validation-form needs-validation" method="post" action="signUp">
					<div class="mb-3">
						<label for="id" class="form-label" >아이디</label> 
						<input type="text" class="form-control" id="id" name="id" required onchange="idCheck()">
						<div class="invalid-feedback invalidId" id="enterId">아이디를 입력해주세요.</div>
						<div class="invalid-feedback invalidId" id="existId" style="display: none;">이미 사용중인 아이디입니다.</div>
						<div class="invalid-feedback invalidId" id="invalidId" style="display: none;">아이디는 영어와 숫자를 포함하여 6~20자로 입력해주세요..</div>
						<div class="valid-feedback" >사용가능한 아이디 입니다.</div>
					</div>
						
					
					<div class="row">
						<div class="col-md-6 mb-3"">
							<label for="password" class="form-label">비밀번호</label> 
							<input type="password" class="form-control" id="password" name="password" onchange="passwordCheck()" required>
							<div class="invalid-feedback invalidPW" id="enterPW" >비밀번호를 입력해주세요</div>
							<div class="invalid-feedback invalidPW" id="invalidPW" style="display: none;">비밀번호는 영문, 숫자, 특수문자를 포함하여 8~16자로 입력해주세요.</div>
						</div>
						<div class="col-md-6 mb-3"">
							<label for="confirmPassword" class="form-label">비밀번호확인</label> 
							<input type="password" class="form-control" id="password2" required onChange="confirmPassword()">
							<div class="valid-feedback">비밀번호가 일치합니다.</div>
							<div class="invalid-feedback">비밀번호를 확인해주세요.</div>
						</div>
					</div>
					<div class="mb-3">
						<label for="name" class="form-label">이름</label> 
						<input type="text" class="form-control " id="name" name="name" onchange="nameCheck()" required>
						<div class="invalid-feedback invalidName" id="enterName">이름을 입력해주세요.</div>
						<div class="invalid-feedback invalidName" id="invalidName" style="display: none;">한글 2~10자로 입력해주세요.</div>
					</div>
					
					<div class="row">
					
						<label for="email" class="form-label">이메일</label>
						<div class="row"> 
							<div class="col-md-6 mb-1">
								<input type="text" class="form-control" id="email" placeholder="sample@example.com" name="email" required>
									<div class="invalid-feedback invalidEmail" id="enterEmail">이메일을 입력해주세요.</div>
									<div class="invalid-feedback invalidEmail" id="invalidEmail" style="display: none;">올바른 이메일 형식이 아닙니다.</div>
							</div>
							<div class="col-md-6 mb-1">
								<input type="button" class="btn btn-secondary" onclick="sendEmail()" value="이메일 인증번호 전송">
							</div>
						</div>
						<div class="row"> 
						<div class="col-md-6 mb-3">
							<input type="text" class="form-control" id="confirmCode" placeholder="인증번호 입력" required>
								<div class="valid-feedback" >인증번호가 일치합니다.</div>
								<div class="invalid-feedback" >인증번호를 다시 확인해주세요.</div>
						</div>
							<div class="col-md-6 mb-3">
								<input type="button" class="btn btn-secondary" id="confirmCodeButton" onclick="comfirmCode()" value="인증번호 확인">
							</div>
						</div>
					</div>
					
	
					<div class="row">
						<label for="zipcode" class="form-label">주소</label>
						<div class="row">
							<div class="col-md-6 mb-1">
								<input type="text" class="form-control" id="zipcode" name="zipcode" value=""
									placeholder="우편번호" readonly="readonly">
							</div>
							<div class="col-md-6 mb-1">
								<input type="button" class="btn btn-secondary" id="" value="우편번호 찾기"
									onclick="daumPostcode()">
							</div>
						</div>
					</div>
					<div class="mb-1">
						<input type="text" class="form-control" id="address" name="address" placeholder="주소" readonly required>
					</div>
					<div class="mb-3">
						<input type="text" class="form-control" id="addressDetail" name="addressDetail" placeholder="상세주소">
					</div>

					<div class="mb-3">
						<label for="phone" class="form-label">휴대폰번호</label> 
						<input type="text" class="form-control" id="phone" placeholder="010-1234-5678" name="phone" onchange="phoneCheck()" required>
						<div class="invalid-feedback invalidPhone" id="enterPhone">휴대폰번호를 입력해주세요.</div>
						<div class="invalid-feedback invalidPhone" id="invalidPhone" style="display: none;" > 010-1234-5678 형식으로 입력해주세요.</div>
					</div>
					

					<div class="custom-control custom-checkbox">
						<input type="checkbox" class="custom-control-input" id="aggrement" required> 
							<label class="custom-control-label"for="aggrement">
							개인정보 수집 및 이용에 동의합니다.
							</label>
						<div class="invalid-feedback" id="" >개인정보 수집 이용 동의는 필수 입니다. </div>
					</div>
					<div class="mb-4"></div>
					<div class="buttonGroup">
						<button class="btn btn-primary btn-lg btn-block" type="submit">가입하기</button>
						<button class="btn btn-secondary btn-lg btn-block" type="button" onclick="location.href='/boardSystem'">취소</button>
					</div>
				</form>				
			
			</div>
		</div>

	</div>
	
<script>

window.addEventListener('load', () => {
  const forms = document.getElementsByClassName('validation-form');

  Array.prototype.filter.call(forms, (form) => {
    form.addEventListener('submit', function (event) {
		if (sentEmail != $('#email').val()){
			alert("인증된 이메일이 아닙니다.\n인증번호를 다시 전송해주세요.");
			event.preventDefault();
			event.stopPropagation();
			$('#email').focus();
			return;
		}
    	
		if (form.checkValidity() === false) {
		  event.preventDefault();
		  event.stopPropagation();
		}
		
		form.classList.add('was-validated');
    }, false);
  });
}, false); 
 

$(document).ready(function() {
	
	var msg = '<c:out value="${msg}"/>';
	console.log('msg:'+msg);
	if(msg=='가입오류'){
	    alert("가입오류\n회원가입이 처리되지 않았습니다.\n다시 시도해주세요.");
		
	}
	if(msg=='가입실패'){
	    alert("가입실패\n회원가입이 처리되지 않았습니다.\n다시 시도해주세요.");
		
	}
});

/* 아이디 유효성 체크 */
function idCheck(){
	var id = $('#id').val();
	//아이디 영어와 숫자를 포함하여 6~20자 정규식
	var idCheck = /^([a-zA-Z0-9]){6,20}$/;
	
	if(id == '') { //아이디 입력 안되었을때
		$('#id').removeClass('is-valid');
		$('#id').addClass('is-invalid');
		$('.invalidId').hide();
		$('#enterId').show();
		$('#id').focus();
		return;
	}
	
	if(!idCheck.test(id)){ //정규식과 형식 일치하지 않을때
		$('#id').removeClass('is-valid');
		$('#id').addClass('is-invalid');
		$('.invalidId').hide();
		$('#invalidId').show();
		$('#id').focus();
		return;
	} else { 
		$('#id').removeClass('is-invalid');
		$('#id').addClass('is-valid');
		$('.invalidId').hide();
		idExistCheck();
		return;
	}
	
	
	
}
/* 아이디 중복확인 */
function idExistCheck(){
	var id = $('#id').val();
	$.ajax({
		type : 'post',
		url : '/boardSystem/idCheck',
		data : {"id" : id },
		success : function (data) {
			console.log("data : " +  data);
			if(data == 'Available') {
				//alert('사용가능한 아이디 입니다.')
				$('#id').removeClass('is-invalid');
				$('#id').addClass('is-valid');
				$('.invalidId').hide();
				return;
			} 
			
			if(data == 'Exist') {
				//alert('이미 사용중인 아이디 입니다.\n다른 아이디를 입력해주세요.')
				$('#id').removeClass('is-valid');
				$('#id').addClass('is-invalid');
				$('.invalidId').hide();
				$('#existId').show();
				$('#id').focus();
				return;
			}
		},
		error : function(){
			alert('통신실패');
		}
	}); // end ajax
}


/* 비밀번호 유효성 체크 */
function passwordCheck(){
	
	var password = $('#password').val();
	
	//비밀번호 영문, 숫자, 특수문자 8~16자 정규식
	var pwdCheck = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,16}$/;
	
	if(password == ''){ //비밀번호 입력 안되었을때
		$('#password').addClass('is-invalid');
		$('#password').removeClass('is-valid');
		$('.invalidPW').hide();
		$('#enterPW').show();
		$('#password').focus();
		return;
	}
	
	if(!pwdCheck.test(password)){ //정규식과 형식 일치하지 않을때
		$('#password').addClass('is-invalid');
		$('#password').removeClass('is-valid');
		$('.invalidPW').hide();
		$('#invalidPW').show();
		$('#password').focus();
		return;
	} else { 
		$('#password').addClass('is-valid');
		$('#password').removeClass('is-invalid');
		$('.invalidPW').hide();
	}
	
}

/* 비밀번호 확인 */
function confirmPassword(){
	var password = $('#password').val();
	var password2 = $('#password2').val();
	
	if(password != password2){ //비밀번호 확인이 일치하지 않을 때
		$('#password2').addClass('is-invalid');
		$('#password2').removeClass('is-valid');
		$('#password2').val('');
		$('#password2').focus();
		
	} else{ //비밀번호 확인이 일치 할 때
		$('#password2').addClass('is-valid');
		$('#password2').removeClass('is-invalid');
	}
}

/* 이름 유효성 체크 */
function nameCheck() {
	var name = $('#name').val();
	var nameCheck = /^[가-힣]{2,10}$/;
	
	
	if(name == ''){ //전화번호 입력 안되었을때
		$('#name').removeClass('is-valid');
		$('#name').addClass('is-invalid');
		$('.invalidName').hide();
		$('#enterName').show();
		$('#name').focus();
		return;
	} 
	
	if(!nameCheck.test(name)){ //휴대폰번호 형식에 안맞을때
		$('#name').removeClass('is-valid');
		$('#name').addClass('is-invalid');
		$('.invalidName').hide();
		$('#invalidName').show();
		$('#name').focus();
		return;
	} else {
		$('#name').removeClass('is-invalid');
		$('#name').addClass('is-valid');
		$('.invalidName').hide();
	}
	
}



var code; // 이메일 인증번호
var sentEmail;
/* 이메일 인증번호 메일 전송 */
function sendEmail(){
	var email = $('#email').val();
	var emailCheck = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/;
	
	if(email == ''){ //이메일 입력 안되었을때
		$('#email').removeClass('is-valid');
		$('#email').addClass('is-invalid');
		$('.invalidEmail').hide();
		$('#enterEmail').show();
		$('#email').focus();
		return;
	} 
	
	if(!emailCheck.test(email)){ //이메일 형식에 안맞을때
		$('#email').removeClass('is-valid');
		$('#email').addClass('is-invalid');
		$('.invalidEmail').hide();
		$('#invalidEmail').show();
		$('#email').focus();
		return;
	} else {
		$('#email').removeClass('is-invalid');
		$('#email').addClass('is-valid');
		$('.invalidEmail').hide();
		$.ajax({
			type : 'post',
			url : '/boardSystem/emailConfirm',
			data : {"email" : email },
			success : function (data) {
				console.log("data : " +  data);
				if (data != 'Failed'){
					/* 
					$('#email').removeClass('is-invalid');
					$('#email').addClass('is-valid');
					$('.invalidEmail').hide();
					 */
					code = data;
					sentEmail = email;
					alert('인증번호가 전송되었습니다.');
				} else {
					$('#email').removeClass('is-valid');
					$('#email').addClass('is-invalid');
					$('.invalidEmail').hide();
					$('#invalidEmail').show();
					$('#email').focus();
					alert('메일전송에 실패했습니다.\n메일주소를 확인해주세요.');
				}
			}, 
			error : function(){
				alert('통신실패');
			}
		}); // end ajax
	}
} 
 
/* 인증번호 확인 */ 
function comfirmCode(){
	var comfirmCode = $('#confirmCode').val();
	console.log('인증번호:'+code);
	console.log('입력값:'+comfirmCode);
	if(code != comfirmCode) { // 인증번호 일치하지 않을 때
		console.log("불일치");
		$('#confirmCode').removeClass('is-valid');
		$('#confirmCode').addClass('is-invalid');
		$('#confirmCode').val('');
		$('#confirmCode').focus();
		
	} else{ //일치 할 때
		console.log("일치");
		$('#confirmCode').removeClass('is-invalid');
		$('#confirmCode').addClass('is-valid');
	}
}


/* 카카오 우편번호 찾기 */
function daumPostcode() {
	new daum.Postcode({
		oncomplete : function(data) {
			// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
			// 각 주소의 노출 규칙에 따라 주소를 조합한다.
			// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
			var addr = ''; // 주소 변수
			var extraAddr = ''; // 참고항목 변수
			//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
			if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
				addr = data.roadAddress;
			} else { // 사용자가 지번 주소를 선택했을 경우(J)
				addr = data.jibunAddress;
			}
			// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
			if (data.userSelectedType === 'R') {
				// 법정동명이 있을 경우 추가한다. (법정리는 제외)
				// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
				if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
					extraAddr += data.bname;
				}
				// 건물명이 있고, 공동주택일 경우 추가한다.
				if (data.buildingName !== '' && data.apartment === 'Y') {
					extraAddr += (extraAddr !== '' ? ', '
							+ data.buildingName : data.buildingName);
				}
				// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
				if (extraAddr !== '') {
					extraAddr = ' (' + extraAddr + ')';
				}
				// 조합된 참고항목을 해당 필드에 넣는다.
				//document.getElementById("extraAddress").value = extraAddr;
				addr += extraAddr;
			}
			// 우편번호와 주소 정보를 해당 필드에 넣는다.
			document.getElementById('zipcode').value = data.zonecode;
			document.getElementById("address").value = addr;
			// 커서를 상세주소 필드로 이동한다.
			document.getElementById("addressDetail").focus();
			
		}
	}).open();
}
/* 휴대폰번호 유효성 체크 */
function phoneCheck() {
	var phone = $('#phone').val();
	var phoneCheck = /^(01[016789]{1})-?[0-9]{3,4}-?[0-9]{4}$/;
	
	
	if(phone == ''){ //전화번호 입력 안되었을때
		$('#phone').removeClass('is-valid');
		$('#phone').addClass('is-invalid');
		$('.invalidPhone').hide();
		$('#enterPhone').show();
		$('#phone').focus();
		return;
	} 
	
	if(!phoneCheck.test(phone)){ //휴대폰번호 형식에 안맞을때
		console.log("휴대폰 형식 안맞음");
		$('#phone').removeClass('is-valid');
		$('#phone').addClass('is-invalid');
		$('.invalidPhone').hide();
		$('#invalidPhone').show();
		$('#phone').focus();
		return;
	} else {
		console.log("휴대폰 형식 맞음");
		$('#phone').removeClass('is-invalid');
		$('#phone').addClass('is-valid');
		$('.invalidPhone').hide();
	}
	
}


</script>
</body>

</html>