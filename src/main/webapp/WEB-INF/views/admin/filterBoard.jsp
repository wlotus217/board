<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비속어 관리 게시판</title>
<!-- 부트스트랩 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>

<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<!-- 데이터테이블 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.2.0/css/bootstrap.min.css"/>
<link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/dataTables.bootstrap5.min.css"/>
<link rel="stylesheet" href="https://cdn.datatables.net/select/1.2.1/css/select.dataTables.min.css"/> 
<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/select/1.2.1/js/dataTables.select.min.js"></script>
<script src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script>
<style>

.row>* {
    max-width: 90%;
}    
#groupCodeTable th, td { text-align: center;}
#commonCodeTable th, td { text-align: center;}
</style>

</head>
<body>
<%@include file = "/include/nav.jspf" %>
<div class="container">

<br>
<br>
	<div class="row">
		<div class="col">
			<table class="table table-hover" id="groupCodeTable">
				<thead>
					<tr>
						<th style="width:20%;">그룹코드</th>
						<th style="width:40%;">코드명</th>
						<th style="width:20%;">수정</th>
						<th style="width:20%;">삭제</th>
					</tr>
				</thead>
				<tbody>
				
				</tbody>	
			</table>
			
			<button class="btn btn-secondary" id="insertGroupBtn">추가</button>
		</div>
		<div class="col">
			<table class="table" id="commonCodeTable">
				<thead>
					<tr>
						<th style="width:20%;">공통코드</th>
						<th style="width:40%;">코드명</th>
						<th style="width:20%;">수정</th>
						<th style="width:20%;">삭제</th>
					</tr>
				</thead>
				<tbody>
					
				</tbody>	
			</table>
			
			<button class="btn btn-secondary" id="insertCommonBtn">추가</button>
	 	</div>
	</div>
<!-- 그룹코드 모달 -->
<div class="modal" tabindex="-1" id="modifyGroupModal" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">그룹 수정</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<form id="modifyGroupForm" method="post" >
					<label for="codeName" class="col-form-label">코드명:</label>
					<input type="text" class="form-control" id="modifyCodeName" name="codeName" value="">
					<input type="hidden" class="form-control" id="groupCode" name="groupCode" value="">
					<input type="hidden" class="form-control" id="modifyUser" name="modifyUser" value="${member.id }">
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
				<button type="button" class="btn btn-primary" id="modifyGroupFormSubmit">수정</button>
			</div>
		</div>
	</div>
</div>

<div class="modal" tabindex="-1" id="insertGroupModal" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">그룹 추가</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<form id="insertGroupForm" method="post">
					<label for="codeName" class="col-form-label">코드명:</label>
					<input type="text" class="form-control" id="insertCodeName" name="codeName" value="">
					<input type="hidden" class="form-control" id="createUser" name="createUser" value="${member.id }">
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
				<button type="button" class="btn btn-primary" id="insertGroupFormSubmit">저장</button>
			</div>
		</div>
	</div>
</div>
<!-- 그룹코드 모달끝 -->

<!-- 공통코드 모달 -->
<div class="modal" tabindex="-1" id="modifyCommonModal" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">공통코드 수정</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<form id="modifyCommonForm" method="post" >
					<label for="codeName" class="col-form-label">그룹명:</label>
					<input type="text" class="form-control" id="codeName" name="codeName" value="" readonly="readonly">
					<label for="commonCodeName" class="col-form-label">코드명:</label>
					<input type="text" class="form-control" id="modifyCommonCodeName" name="commonCodeName" value="">
					<input type="hidden" class="form-control" id="commonCode" name="commonCode" value="">
					<input type="hidden" class="form-control" id="modifyUser" name="modifyUser" value="${member.id }">
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
				<button type="button" class="btn btn-primary" id="modifyCommonFormSubmit">수정</button>
			</div>
		</div>
	</div>
</div>

<div class="modal" tabindex="-1" id="insertCommonModal" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">공통코드 추가</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<form id="insertCommonForm" method="post">
					<label for="codeName" class="col-form-label">그룹명:</label>
					<input type="text" class="form-control" id="codeName" name="codeName" value="" readonly="readonly">
					<label for="commonCodeName" class="col-form-label">코드명:</label>
					<input type="text" class="form-control" id="insertCommonCodeName" name="commonCodeName" value="">
					<input type="hidden" class="form-control" id="groupCode" name="groupCode" value="">
					<input type="hidden" class="form-control" id="createUser" name="createUser" value="${member.id }">
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
				<button type="button" class="btn btn-primary" id="insertCommonFormSubmit">저장</button>
			</div>
		</div>
	</div>
</div>
<!-- 그룹코드 모달끝 -->

</div>


<script>

/* 그룹코드 추가 */
$(document).on("click", "#insertGroupBtn", function () {
	$('#insertGroupModal').modal('show');
});

$(document).on("click", "#insertGroupFormSubmit", function () {
	var formData = $("#insertGroupForm").serialize();
	var insertCodeName = $('#insertCodeName').val();
	if(insertCodeName.trim().length == 0){
		alert("코드명을 입력하세요.");
		$('#insertCodeName').focus();
		return;
	}
	$('#insertGroupModal').modal('hide');
	$.ajax({
		type:'post',
		url:'insertGroup',
		data: formData,
		success:function(result){
			if(result === 'InsertSuccess') { 
				console.log(result);
				getGroupCodeList();
			} else {
				console.log(result);
				getGroupCodeList();
			}
			$("#insertGroupModal #insertCodeName").val('');
		},
		error:function(){
			alert('통신실패');
			getGroupCodeList();
			$("#insertGroupModal #insertCodeName").val('');
		}
		
	});
	
});

/* 그룹코드 수정 */
$(document).on("click", "#modifyGroupBtn", function () {
	var selectedGroupCode = $(this).data('id');
    $("#modifyGroupModal #groupCode").val( selectedGroupCode );
    
    var codeName = getOneGroup(selectedGroupCode);
    $("#modifyGroupModal #modifyCodeName").val( codeName );
});

$(document).on("click", "#modifyGroupFormSubmit", function () {
	var formData = $("#modifyGroupForm").serialize();
	
	var modifyCodeName = $('#modifyCodeName').val();
	if(modifyCodeName.trim().length == 0){
		alert("코드명을 입력하세요.");
		$('#modifyCodeName').focus();
		return;
	}
	
	
	$('#modifyGroupModal').modal('hide');
	$.ajax({
		type:'post',
		url:'modifyGroup',
		data: formData,
		success:function(result){
			if(result === 'ModifySuccess') { 
				console.log(result);
				getGroupCodeList();
			} else {
				console.log(result);
				getGroupCodeList();
			}
		},
		error:function(){
			alert('통신실패');
			getGroupCodeList();
		}
		
	});
	
});
/* 모달창 표시할 그룹코드 불러오기 */
function getOneGroup(groupCode){
	var codeName = '';
	$.ajax({
		
		type:'post',
		url:'getOneGroup',
		async: false,
		data: 
			{
				"groupCode":groupCode,
			},
		
		success:function(groupCode){
			console.log('통신성공' + groupCode);
			codeName = groupCode.codeName;
		},
		error:function(){
			alert('통신실패');
		}
		
	});
	return codeName;
}

/* 그룹코드 삭제 */
function deleteGroup(groupCode){
	if(confirm("그룹코드를 삭제하시겠습니까?"))
	$.ajax({
		type:'post',
		url:'deleteGroup',
		async: false,
		data: 
			{
				"groupCode":groupCode,
			},
		
		success:function(result){
			console.log('통신성공' + result);
			if(result === 'DeleteSuccess') { 
				console.log(result);
				getGroupCodeList();
			} else {
				console.log(result);
				getGroupCodeList();
			}
		},
		error:function(){
			alert('통신실패');
		}
	});
} 

/* 데이터테이블 생성 */
$(document).ready(function(){
	$('#groupCodeTable').DataTable({
		info: false,
		language: {
	  		emptyTable : '데이터가 없습니다.',
	  		lengthMenu :'_MENU_ 개씩 보기',
	  		zeroRecords: '검색 결과가 없습니다.',
	  		paginate : {
	  			next : '다음',
	  			previous : '이전'
	  		},
	  		search : '검색'
			
	  	}
	});
	$("#commonCodeTable ").DataTable({
		info: false,
		language: {
	  		emptyTable : '데이터가 없습니다.',
	  		lengthMenu :'_MENU_ 개씩 보기',
	  		zeroRecords: '검색 결과가 없습니다.',
	  		paginate : {
	  			next : '다음',
	  			previous : '이전'
	  		},
	  		search : '검색'
			
	  	}
	}); 
	
	getGroupCodeList();
	
	/* 그룹코드 행(tr) 클릭시 공통코드 목록 불러오기 */ 
	$("#groupCodeTable tbody").on('click', 'tr', function () {
		
	    var data = $("#groupCodeTable").DataTable().row(this).data();
	    console.log(data);
	    getCommonCodeList(data.groupCode);
	}); 
	
}); 

/* 그룹코드테이블 불러오기 */
function getGroupCodeList(){
	console.log('getGroupCodeList실행');
	$("#groupCodeTable ").DataTable().destroy();
	
		$.ajax({
			type:'get',
			url:'getGroupCodeList',
			success:function(data){
				
				console.log('통신성공');
				
				$("#groupCodeTable ").DataTable({
					data: data,
					columns: [
				  		{ data: 'groupCode'},
				  		{ data: 'codeName'},
				  		{ data: 'groupCode',
				  			render : function(data) {
				  				return '<button class="btn btn-secondary btn-sm" id="modifyGroupBtn" data-bs-toggle="modal" data-bs-target="#modifyGroupModal" data-id="'+data+'">수정</button>';
				  			}
				  		
				  		},
				  		{ data: 'groupCode',
				  			render : function(data) {
				  				return '<button class="btn btn-secondary btn-sm" onclick="deleteGroup('+data+')">삭제</button>';
				  			}
				  		
				  		}
				  	],
				  	select: {
                        style: 'single'
				  		},
				  	info: false,
				  	destroy: true,
					language: {
				  		emptyTable : '데이터가 없습니다.',
				  		lengthMenu :'_MENU_ 개씩 보기',
				  		zeroRecords: '검색 결과가 없습니다.',
				  		paginate : {
				  			next : '다음',
				  			previous : '이전'
				  		},
				  		search : '검색'
						
				  	}
					
				}); 
				
			},
			error:function(){
				alert('통신실패');
			} 
		});
} 





/* 공통코드리스트 불러오기 */
 
var globalGroupCode;
var globalCodeName;


function getCommonCodeList(groupCode){
	$("#commonCodeTable ").DataTable().destroy();
	console.log('getCommonCodeList실행');
	console.log('그룹코드:' + groupCode);
	
	globalGroupCode = groupCode;
	globalCodeName = getOneGroup(groupCode);
	
	$.ajax({
		type:'get',
		url:'getCommonCodeList',
		data: 
			{
				"groupCode":groupCode
			},
		success:function(data){
			
			console.log('통신성공');
			
			$("#commonCodeTable ").DataTable({
				data: data,
				columns: [
			  		{ data: 'commonCode'},
			  		{ data: 'commonCodeName'},
			  		{ data: 'commonCode',
			  			render : function(data) {
			  				return '<button class="btn btn-secondary btn-sm" id="modifyCommonBtn" data-bs-toggle="modal" data-bs-target="#modifyCommonModal" data-id="'+data+'">수정</button>';
			  			}
			  		
			  		},
			  		{ data: 'commonCode',
			  			render : function(data) {
			  				return '<button class="btn btn-secondary btn-sm" onclick="deleteCommon('+data+')">삭제</button>';
			  			}
			  		
			  		}
			  		
			  		
			  	],
			  	info: false,
				language: {
			  		emptyTable : '데이터가 없습니다.',
			  		lengthMenu :'_MENU_ 개씩 보기',
			  		zeroRecords: '검색 결과가 없습니다.',
			  		paginate : {
			  			next : '다음',
			  			previous : '이전'
			  		},
			  		search : '검색'
					
			  	}
				
			}); 
			
		},
		error:function(){
			alert('통신실패');
		} 
	});
}
		
/* 공통코드 삭제 */
function deleteCommon(commonCode){
	if(confirm("공통코드를 삭제하시겠습니까?"))
	$.ajax({
		type:'post',
		url:'deleteCommon',
		async: false,
		data: 
			{
				"commonCode":commonCode,
			},
		
		success:function(result){
			console.log('통신성공' + result);
			if(result === 'DeleteSuccess') { 
				console.log(result);
				getCommonCodeList(globalGroupCode);
			} else {
				console.log(result);
				getCommonCodeList(globalGroupCode);
			}
		},
		error:function(){
			alert('통신실패');
		}
	});
}  

/* 모달창 표시할 공통코드 불러오기 */
function getOneCommon(commonCode){
	var data = {commonCodeName : "" , groupCode : "", codeName: ""};
	$.ajax({
		
		type:'post',
		url:'getOneCommon',
		async: false,
		data: 
			{
				"commonCode":commonCode,
			},
		
		success:function(commonCode){
			console.log('통신성공' + commonCode);
			data.commonCodeName = commonCode.commonCodeName;
			data.groupCode = commonCode.groupCode;
			data.codeName = commonCode.codeName;
			console.log(data);
		},
		error:function(){
			alert('통신실패');
		}
		
	});
	return data;
}

/* 공통코드 수정 */
$(document).on("click", "#modifyCommonBtn", function () {
	var selectedCommonCode = $(this).data('id');
    $("#modifyCommonModal #commonCode").val( selectedCommonCode );
    var commonData = getOneCommon(selectedCommonCode);
    $("#modifyCommonModal #modifyCommonCodeName").val( commonData.commonCodeName );
    $("#modifyCommonModal #groupCode").val( commonData.groupCode );
    $("#modifyCommonModal #codeName").val( commonData.codeName );
});



$(document).on("click", "#modifyCommonFormSubmit", function () {
	var modifyCommonCodeName = $('#modifyCommonCodeName').val();
	if(modifyCommonCodeName.trim().length == 0){
		alert("코드명을 입력하세요.");
		$('#modifyCommonCodeName').focus();
		return;
	}
	
	var formData = $("#modifyCommonForm").serialize();
	$('#modifyCommonModal').modal('hide');
	$.ajax({
		type:'post',
		url:'modifyCommon',
		data: formData,
		success:function(result){
			if(result === 'ModifySuccess') { 
				console.log(result);
				getCommonCodeList(globalGroupCode);
			} else {
				console.log(result);
				getCommonCodeList(globalGroupCode);
			}
		},
		error:function(){
			alert('통신실패');
			getCommonCodeList(globalGroupCode);
		}
		
	});
	
});

/* 공통코드 추가 */
$(document).on("click", "#insertCommonBtn", function () {
	$("#insertCommonModal #groupCode").val( globalGroupCode );
    $("#insertCommonModal #codeName").val( globalCodeName );
	$('#insertCommonModal').modal('show');
});

$(document).on("click", "#insertCommonFormSubmit", function () {
	var insertCommonCodeName = $('#insertCommonCodeName').val();
	if(insertCommonCodeName.trim().length == 0){
		alert("코드명을 입력하세요.");
		$('#insertCommonCodeName').focus();
		return;
	}
	
	var formData = $("#insertCommonForm").serialize();
	$('#insertCommonModal').modal('hide');
	$.ajax({
		type:'post',
		url:'insertCommon',
		data: formData,
		success:function(result){
			if(result === 'InsertSuccess') { 
				console.log(result);
				getCommonCodeList(globalGroupCode);
			} else {
				console.log(result);
				getCommonCodeList(globalGroupCode);
			}
			
			$("#insertCommonModal #insertCommonCodeName").val('');
		},
		error:function(){
			alert('통신실패');
			getCommonCodeList(globalGroupCode);
			$("#insertCommonModal #insertCommonCodeName").val('');
		}
		
	});
	
});
</script>

</body>
</html>