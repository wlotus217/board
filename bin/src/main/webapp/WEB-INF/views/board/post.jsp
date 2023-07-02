<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 상세</title>
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
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<style>
.postContent {
	height: 500px;
}

.reply td {
	padding-left:20px;
}

.commentTable thead>tr {
	height: 45px;
}

#addBtn td {
	text-align:center;
	border-bottom: none;
}
#addBtn .btn {
	 width: 150px;
}

</style>
</head>
<body>
	<%@include file="/include/nav.jspf"%>
	
	<div class="container">

		<br>
		<div style="display: flex; justify-content: flex-end;">
		<button id="shareButton" class="btn btn-secondary btn-xs mb-3" style="width:100px;">공유하기</button>

		<c:if test="${member.id eq post.createUser }">
			<span style="margin-left: 3px;">
				<input type="button" class="btn btn-secondary btn-xs" value="수정" style="width:60px;"
					onclick="location.href='goUpdatePost?boardId=${post.boardId}&page=${page}'"/>
			</span>
			<span style="margin-left: 3px;">
				<input type="button" class="btn btn-secondary btn-xs" value="삭제"
					onclick="deletePost('${post.boardId}','${page}')" style="width:60px;"/>
			</span>
		</c:if>
		</div>

		<table class="table table-borderd">
			<thead>
				<tr>
					<td colspan="2"><strong>${post.title }</strong></td>
				</tr>
				<tr>
					<td style="width: 70%">작성자: ${post.createUser }</td>
					<td>등록일: ${post.createDate }</td>


				</tr>
			</thead>
			<tbody>
				<tr>
					<td class="postContent" colspan="2">${post.content }</td>
				</tr>
			</tbody>
		</table>


		<table class="commentTable table  " id="commentTable">
			<thead>
				<tr>
					<th colspan="3">
						댓글(<span id="commentCnt">${commentCnt}</span>)
					</th>
				</tr>
			</thead>
			<tbody id="commentTableBody">
				 
			</tbody>
			
		</table>


		
		<table class="table table-borderless" style="width: 100%;">
			<thead>
				<tr>
					<td><span style="font-weight: bold">${member.id}</span></td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<textarea id="commentContent" name="content" rows="5" class="form-control" placeholder="댓글을 남겨보세요"></textarea>
					</td>
				</tr>
				<tr>
					<td style="height: 30px; ">
						<input type="button" value="댓글 작성" class="btn btn-secondary" style="width:150px; float: left;" onclick="insertComment()">
						<span style="float: right;" id="commentLength">0/200</span>
					</td>
				</tr>
				<tr>
					<td>
					</td>
				</tr>
			</tbody>
		</table>
		
		<input type="button" value="목록 돌아가기" class="btn btn-outline-secondary" style="width:200px; float: right;" onclick="getBoardList()">
		<br>
		<br>
		<br>
		<br>				

	</div>
	


<script>
/* 공유하기 */
var shareButton = document.getElementById('shareButton');
var postTitle = '${post.title}';
var postUrl = document.location.href;

shareButton.addEventListener("click", async () => {
	  try {
	    await navigator.share({ title: postTitle, url: postUrl });
	    console.log("Data was shared successfully");
	  } catch (err) {
	    console.error("Share failed:", err.message);
	  }
});

/* 댓글불러오기 */
$(document).ready(function(){
	commentList();
	
	
});

/* 댓글 글자수 제한 */
var commentContent = $('#commentContent'); 
var commentLength = $('#commentLength');

var replyTextarea, replyLength;
var modifyTextarea, modifyLength;

commentContent.on('keyup', function(){
	commentLength.html($(this).val().length+"/200");
	
	if($(this).val().length >= 200) {  //최대 200까지 쓸 수 있게 설정
		$(this).val(commentContent.val().substring(0, 200));
		commentLength.html("200/200"); //200이 넘어가도 200으로 리셋될 수 있도록 설정해 줌
	}
});

/* 댯굴 더보기 클릭시 */
var addBtnClick = 1; //더보기 클릭 횟수
var parentCommentCnt ; //부모댓글 갯수(=index)
var commentDisplayCnt = 5; //댓글 표시 개수(부모댓글기준)

function moreCommentList(){
	addBtnClick ++;
	var printDataCnt = addBtnClick * commentDisplayCnt; //더보기 클릭시 표시할 데이터 갯수(부모댓글 기준)
	
	console.log("parentCommentCnt :"+parentCommentCnt );
	console.log("printDataCnt:"+printDataCnt);
	
	//더보기버튼 숨기기
	if (printDataCnt >= parentCommentCnt ) $('#addBtn').hide();
	
	for(var i= (printDataCnt - commentDisplayCnt + 1) ; i <= printDataCnt;i++){
		$('.parentComment-'+i).show();
		$('.childComment-'+i).show();
	}
}

/* 댓글불러오기 */
function commentList(){
	let boardId = ${post.boardId};
	let memberId = '${member.id}';
	
	$.ajax({
	        url : "getCommentList",
	        type : "POST",
	        async: false,
	        dataType: 'json',
	        data : {
		        	"boardId": boardId
	        		},
	        success : function(data){
	        	
	           	console.log(data);
	        	
	           	
	           	var content="";
	           	
	           	/* 댓글이 없을때 */
            	if (data.length == 0) {
            		content += 
            		
            		"<tr>"+
            			'<td colspan="3">아직 댓글이 없습니다.</td>'+
            		"</tr>";
            	}
	           	
	            /* child 체크 후 있으면 출력 */	
	            var index = 0; // 출력할 부모댓글 갯수
	            for(var i=0; i< data.length; i++){
	            	
		        	var result = childCommentCheck(data[i].commentId);
		        	if(result =='Exist') {
		        	/* 부모댓글삭제안됨 + 자식댓글 있음 => 둘다 출력*/
		        	/* 부모댓글삭제됨 + 자식댓글 있음 => 둘다 출력*/
		        	
			        	/* 부모댓글 일때 */
		            	if (data[i].groupNum == 0) {
		            		
		            		index ++;
		            	
		            		content +=
				                '<tr class="parentComment-'+index+'" id="parentCommentTr1-'+data[i].commentId+'" style="display:none;">'+
				                    '<th style="width: 70%; border-bottom: none;">'+data[i].createUser+'</th>'+
				                    '<td style="border-bottom: none;">'+data[i].createDate+'</td>'+
				                    	'<td style="color: blue;border-bottom: none;">' ;
				                    	
			                if(memberId == data[i].createUser && data[i].deleted == false){ //수정,삭제버튼 생성
			                	content +=
			                    	'<a href="javascript:modifyComment('+data[i].commentId +',\'' + data[i].content + '\',\'parent\')">[수정]</a>'+
			                    	'<a href="javascript:deleteComment('+data[i].commentId +','+ boardId +')">[삭제]</a>';
			                }    
		                	if(memberId != ''){
				                content +=	
				                	'<a href="javascript:replyComment('+data[i].commentId + ')">[답글]</a>'; //답글 버튼 생성
		                	}
		                	
		                	content +=
										"</td>" +
				               		 "</tr>" +
				               		'<tr class="parentComment-'+index+'" id="parentCommentTr2-'+data[i].commentId+'" style="display:none;">'+
											'<td colspan="3">'+data[i].content+'</td>'+
									"</tr>"
									;
		            		}
		            		
		            	/* 대댓글 일때 */
		            	else if(data[i].groupNum != 0 && data[i].deleted == false){
		            		content +=
		    	                '<tr class="childComment-'+index+'" id="childCommentTr1-'+data[i].commentId+'" style="display:none;">'+
		    	                    '<th style="width: 70%;padding-left:20px;border-bottom: none;">'+data[i].createUser+'</th>'+
		    	                    "<td style='border-bottom: none;'>"+data[i].createDate+"</td>"+
		    	                    '<td style="color: blue;border-bottom: none;">' ;
		    						
		    	                    
		    	                    if('${member.id}' == data[i].createUser){
		    		                	content +=
		    		                		'<a href="javascript:modifyComment('+data[i].commentId +',\''+ data[i].content + '\',\'child\')">[수정]</a>'+
		    		                    	'<a href="javascript:deleteComment('+data[i].commentId +','+ boardId+')">[삭제]</a>';
		    		                    	
		    		                } 
							content +=	
		    						"</td>" +
		    	                "</tr>" +
		    	                '<tr class="childComment-'+index+'" id="childCommentTr2-'+data[i].commentId+'" style="display:none;">' +
		    								'<td colspan="3" style="padding-left:20px;" >'+"ㄴ"+data[i].content+'</td>'+
		    							"</tr>";
		            	
		            		
		            	}
		        		
		        	} else if(result =='Nothing' && data[i].deleted == false) { /* 부모댓글삭제안됨 + 자식댓글 없음 => 부모댓글만 출력*/
		        	
		        		/* 부모댓글 일때 */
		            	if (data[i].groupNum == 0 ) {
		            		
		            		index ++;
		            	
		            		content +=
				                '<tr class="parentComment-'+index+'" id="parentCommentTr1-'+data[i].commentId+'" style="display:none;">'+
				                    '<th style="width: 70%;border-bottom: none;">'+data[i].createUser+'</th>'+
				                    "<td style='border-bottom: none;'>"+data[i].createDate+"</td>"+
				                    	'<td style="color: blue;border-bottom: none;">' ;
				                    	
			                if(memberId == data[i].createUser ){
			                	content +=
			                    	'<a href="javascript:modifyComment('+data[i].commentId +',\'' + data[i].content + '\',\'parent\')">[수정]</a>'+
			                    	'<a href="javascript:deleteComment('+data[i].commentId +','+ boardId +')">[삭제]</a>';
			                    	
			                }   
			                
			                if(memberId != ''){
			                	content +=	
				                	'<a href="javascript:replyComment('+data[i].commentId + ')">[답글]</a>';
			                }
				                content +=	
										"</td>" +
				               		 "</tr>" +
				               		'<tr class="parentComment-'+index+'" id="parentCommentTr2-'+data[i].commentId+'" style="display:none;">'+
											'<td colspan="3">'+data[i].content+'</td>'+
									"</tr>"
									;
		            	}	
		        	}
		        	
		        	
		        /* 부모댓글삭제됨 + 자식댓글 없음 => 둘다 출력 x*/
			            
	           	}
	            var addBtn = ""
	            	addBtn +=
	            		'<tr id="addBtn">'+
							'<td colspan="3" >'+
								'<a href="javascript:moreCommentList()" class="btn btn-outline-primary">더보기</a>'+
							'</td>'+
						'</tr>';
				
				//더보기 버튼 생성 (부모댓글 5개씩 출력)
				if (index > (addBtnClick*5)) content += addBtn; 
				
				//전역변수 parentCommentCnt 에 index 대입
				parentCommentCnt  = index;
				
				console.log("data.length:"+data.length);	
	            $('#commentTableBody').html(content);
	            console.log("addBtnClick: "+ addBtnClick);
	            
	            //더보기 클릭수 만큼 5개씩 댓글 출력
	            for(var j=1 ;j<=(addBtnClick*5);j++){
	        		
	        		$('.parentComment-'+j).show();
	        		$('.childComment-'+j).show();
					console.log("j:"+j);	
	        	}
	         
	        }, error:function(request,status,error){
	            alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	           }
	});
	
}
/* 자식댓글 존재여부 확인 */
function childCommentCheck(commentId){
	var result;
	$.ajax({
		type:'post',
		url:'getChildComment',
		async: false,
		data: 
			{
				"commentId":commentId,
			},
		
		success:function(data){
			console.log('통신성공' + data);
			if(data === 'Exist') { //부모 댓글 밑 대댓글 생성
				console.log(data);
			} else if(result === 'Nothing'){
				console.log(data);
			} else{
				console.log(data);
			}
			result = data;
		},
		error:function(){
			alert('통신실패');
		}
	});
	return result;
}

/* 댓글 작성하기 */
function insertComment() {
		let boardId = ${post.boardId };
		let createUser = '${member.id }';
		let commentContent = $('#commentContent').val();
		
		console.log(boardId);
		console.log(createUser);
		console.log(commentContent);
	
		if(createUser == ''){
			alert('로그인 후 이용해주세요');
			return;
		}
		if(commentContent.trim().length == 0) {
			alert('내용을 입력하세요');
			return;
		}
		
		$.ajax({
			type:'post',
			url:'createComment',
			data: 
				{
					"boardId":boardId,
					"createUser":createUser,
					"content":commentContent
				},
			
			success:function(data){
				console.log('통신성공' + data);
				if(data === 'InsertSuccess') {
					//alert('댓글 등록이 완료되었습니다.');
					console.log('댓글 등록 완료');
					$('#commentContent').val('');
					commentList();
					
					//댓글 갯수 변경
					$.ajax({
						type:'post',
						url:'getCommentCnt',
						data: {
							"boardId":boardId	
						},
						success:function(result){
							$('#commentCnt').html(result);
						},
						error:function(){
							alert('통신실패');
						}
						
					});//댓글 갯수 변경 끝
					
				} else {
					alert('댓글 등록 실패');
				}
			},
			error:function(){
				alert('통신실패');
			}
		});// 댓글 비동기 끝
		
}// 댓글등록 이벤트 끝


/* 댓글 삭제하기 */
function deletePost(postNum,page) {
	if(confirm("게시글을 삭제하시겠습니까?")){
		location.href="deletePost?boardId=" + postNum + "&page=" + page;
	} else { 
		return;
	}
}

/* 대댓글 작성폼 생성*/
function replyComment(commentId) {
	
	//생성되어있는 modifyForm, replyForm이 있다면 삭제하기 
	if($('.modifyForm').length){
	    $(".modifyForm").remove();
	} else if($('.replyForm').length){
		$(".replyForm").remove();
	}
	
	var replyForm ="";
		replyForm += 
			'<tr id="reply-' + commentId + '" class="replyForm">'+
			 	'<td colspan="3">'+
				'<span style="font-weight: bold">'+'${member.id}'+'</span>'+
				'<br>'+
					'<form class="replyForm" id="reply-"'+commentId +'" action="createComment" method="post">'+
						'<textarea id="replyTextarea" name="content" style="width: 100%;height: 100px;"></textarea>'+
						'<br> '+
						'<input type="hidden" name="parentCommentId" value="'+commentId+'">'+
						'<input type="hidden" name="boardId" value="'+${post.boardId }+'"> '+
						'<input type="hidden" name="createUser" value="'+'${member.id }'+'">'+
						'<input type="button" class="btn btn-secondary" value="작성" onclick="insertReply()" style="float: left;">'+
						'<input type="button" class="btn btn-secondary" value="취소" onclick="replyCancle()" style="margin-left:5px; float: left;">'+
						'<span style="float: right;" id="replyLength">0/200</span>'+
					'</form>'+
				'</td>'+
			'</tr>';
			
		$('#parentCommentTr2-' + commentId).after(replyForm);
		$('#replyTextarea').focus();
	
		
		replyTextarea = $('#replyTextarea');
		replyLength = $('#replyLength');

		replyTextarea.on('keyup', function(){
			replyLength.html($(this).val().length+"/200");
			
			if($(this).val().length >= 200) {  //최대 200까지 쓸 수 있게 설정
				$(this).val(replyTextarea.val().substring(0, 200));
				replyLength.html("200/200"); //200이 넘어가도 200으로 리셋
			}
		});
}

/* 대댓글 작성하기 */
function insertReply(){
	let boardId = ${post.boardId };
	
	$.ajax({
		type:'post',
		url:'createComment',
		data: $(".replyForm").serialize(),
		success:function(data){
			console.log('통신성공' + data);
			if(data === 'InsertSuccess') {
				//alert('댓글 등록이 완료되었습니다.');
				console.log('댓글 등록 완료');
				commentList();
				replyCancle();
				
				//댓글 갯수 변경
				$.ajax({
					type:'post',
					url:'getCommentCnt',
					data: {
						"boardId":boardId	
					},
					success:function(result){
						$('#commentCnt').html(result);
					},
					error:function(){
						alert('통신실패');
					}
					
				});//댓글 갯수 변경 끝
				
			} else {
				alert('댓글 등록 실패');
			}
		},
		error:function(){
			alert('통신실패');
		}
	});// 댓글 비동기 끝
}

/* 대댓글 작성폼 삭제 */
function replyCancle() {
	 $(".replyForm").remove();
}

/* 리뷰 수정폼 생성*/
function modifyComment(commentId,content,str) {
	//생성되어있는 modifyForm, replyForm이 있다면 삭제하기 
	if($('.modifyForm').length){
	    $(".modifyForm").remove();
	} else if($('.replyForm').length){
		$(".replyForm").remove();
	}
	
	var length = content.length;
	
	var modifyForm = "";
		modifyForm +=
			
				'<tr id="modify-'+commentId+'" class="modifyForm">'+
					'<td colspan="3">'+
					'<span style="font-weight: bold">'+'${member.id}'+'</span>'+
					'<br>'+
					'<form class="modifyForm" id="modify-"'+commentId +'" >'+
						'<textarea id="modifyTextarea" name="content" style="width:100%; height: 100px;">'+content+'</textarea>'+
						'<br>'+
						'<input type="hidden" name="boardId" value="'+${post.boardId }+'">'+
						'<input type="hidden" name="commentId" value="'+commentId+'"> '+
						'<input type="hidden" name="modifyUser" value="'+'${member.id }'+'">'+
						'<input type="button" class="btn btn-secondary" value="수정" onclick="updateComment()" style="float: left;">'+
						'<input type="button" class="btn btn-secondary" value="취소" onclick="modifyCancle()" style="margin-left:5px; float: left;">'+
						'<span style="float: right;" id="modifyLength">' + length+ '/200</span>'+
					'</form>'+
					'</td>'+
				'</tr>' ;
				
	if(str == 'parent'){
		$('#parentCommentTr2-' + commentId).after(modifyForm);
	}
	if(str == 'child'){
		$('#childCommentTr2-' + commentId).after(modifyForm);
	}
	var len = $('#modifyTextarea').val().length;
	$('#modifyTextarea').focus();
	$('#modifyTextarea')[0].setSelectionRange(len, len);
	
	modifyTextarea = $('#modifyTextarea');
	modifyLength = $('#modifyLength');
	
	
	modifyTextarea.on('keyup', function(){
		modifyLength.html($(this).val().length+"/200");
		
		if($(this).val().length >= 200) {  //최대 200까지 쓸 수 있게 설정
			$(this).val(modifyTextarea.val().substring(0, 200));
			modifyLength.html("200/200"); //200이 넘어가도 200으로 리셋될 수 있도록 설정해 줌
		}
	});
	
}

/* 댓글 수정하기 */
function updateComment(){
	$.ajax({
		type:'post',
		url:'updateComment',
		data: $(".modifyForm").serialize(),
		success:function(data){
			console.log('통신성공' + data);
			if(data === 'UpdateSuccess') {
				//alert('댓글 등록이 완료되었습니다.');
				console.log('댓글 수정 완료');
				commentList();
				
			} else {
				alert('댓글 수정 실패');
			}
		},
		error:function(){
			alert('통신실패');
		}
	});// 댓글 비동기 끝
}

/* 댓글 수정폼 삭제 */
function modifyCancle() {
	 $(".modifyForm").remove();
}

/* 댓글 삭제하기 */	
function deleteComment(commentId, boardId) {
	if(confirm("댓글을 삭제하시겠습니까?")){
		
		$.ajax({
			type:'post',
			url:'deleteComment',
			data: 
				{
					"commentId":commentId,
				},
			
			success:function(data){
				console.log('통신성공' + data);
				if(data === 'DeleteSuccess') {
					console.log('댓글 삭제 완료');
					commentList();
					
					//댓글 갯수 변경
					$.ajax({
						type:'post',
						url:'getCommentCnt',
						data: {
							"boardId":boardId	
						},
						success:function(result){
							$('#commentCnt').html(result);
						},
						error:function(){
							alert('통신실패');
						}
						
					});//댓글 갯수 변경 끝
					
				} else {
					alert('댓글 삭제 실패');
				}
			},
			error:function(){
				alert('통신실패');
			}
		});// 댓글 비동기 끝
		
	} else { 
		return;
	}
}

/* 게시글 목록 돌아가기 */
function getBoardList(){
	location.href="getBoard?page="+${page};
}


	
</script>

</body>
</html>