<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
table {
	margin-left: auto;
	margin-right: auto;
}
#subject {
	font-size: 30px;
}
#pwd_hint, #pwd_check_hint, #email_hint {
	border: none;
	background-color: white;
	width: 500px;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript">

var pwd_check = true;
var pwd_check2 = true;
var id_check = true;
var email_check = true;

$(function(){
	$('#member_pwd').keyup(function(){
		passwordCheck($('#member_pwd').val(), $('#member_id').val());
	})
	$('#member_pwd_check').keyup(function(){
		passwordCheck2($('#member_pwd').val(), $('#member_pwd_check').val());
	})
	$('#member_id').keyup(function(){
		emailCheck($('#member_id').val());
	})
})

function formCheck(){
	
	if($('#member_name').val() == ""){
		alert("이름을 입력해주세요!");
		$('#member_name').focus();
		return;
	}
	if($('#member_id').val() == ""){
		alert("아이디를 입력해주세요!");
		$('#member_id').focus();
		return;
	}
	if(email_check){
		alert("올바른 이메일 형식이 아닙니다!");
		$('#member_id').focus();
		return;
	}
	if(id_check){
		alert("아이디 중복검사를 해주세요!");
		$('#member_id').focus();
		return;
	}
	if($('#member_pwd').val() == ""){
		alert("비밀번호를 입력해주세요!");
		$('#member_pwd').focus();
		return;
	}
	if(pwd_check){
		alert("비밀번호 형식을 지켜주세요!");
		$('#member_pwd').focus();
		return;
	}
	if(pwd_check2){
		alert("비밀번호와 비밀번호 확인 란이 다릅니다!");
		$('#member_pwd_check').focus();
		return;
	}
	
	$('#joinform').submit();
	
}

function passwordCheck(password, id){
	if(/(\w)\1\1\1/.test(password)){
        $('#pwd_hint').val('같은 문자를 4번 이상 사용하실 수 없습니다.');
        $('#pwd_hint').css('color','red');
        pwd_check = true;
    }
	else if(!/^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,25}$/.test(password)){
        $('#pwd_hint').val('숫자+영문자+특수문자 조합으로 8자리 이상 사용해야 합니다.');
        $('#pwd_hint').css('color','red');
        pwd_check = true;
    }
	else if(password.search(id) > -1 && id != ""){
        $('#pwd_hint').val('비밀번호에 아이디가 포함되었습니다.');
        $('#pwd_hint').css('color','red');
        pwd_check = true;
    }
	else{
        $('#pwd_hint').val('올바른 비밀번호 입니다.');
        $('#pwd_hint').css('color','green');
        pwd_check = false;
	}
}

function passwordCheck2(password, check){
	if(password != check){
        $('#pwd_check_hint').val('비밀번호와 다릅니다.');
        $('#pwd_check_hint').css('color','red');
        pwd_check2 = true;
	}
	else{
        $('#pwd_check_hint').val('비밀번호와 일치합니다.');
        $('#pwd_check_hint').css('color','green');
        pwd_check2 = false;
	}
}

function emailCheck(id){
	if(!/^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])+@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/i.test(id)){
        $('#email_hint').val('이메일 형식이 아닙니다.');
        $('#email_hint').css('color','red');
        email_check = true;
	}
	else{
        $('#email_hint').val('올바른 이메일 형식입니다.');
        $('#email_hint').css('color','green');
        email_check = false;
	}
}

function idCheck(){
	if($('#member_id').val() == ""){
		alert("아이디를 입력해주세요!");
		$('#member_id').focus();
		return;
	}
	else if(email_check){
		alert("올바른 이메일 형식이 아닙니다!");
		$('#member_id').focus();
		return;
	}
	else{
		$.ajax({
			type:'POST',
			url:'idcheck.do',
			data:{
				"id":$('#member_id').val()
			},
			success:function(data){
				if(data == "true"){
					alert("사용할 수 있는 아이디 입니다.");
					id_check = false;
				}
				else if(data == "false"){
					alert("중복되는 아이디 입니다.");
					id_check = true;
				}
			},
			error:function(e){
				alert("error: "+e);
			}
		})
	}
}

</script>
</head>
<body>
	<form id="joinform" action="../join.do" method="post" onkeydown="javascript:if(event.keyCode==13) return false;">
		<table>
			<tr>
				<th colspan="2" id="subject">회원가입 정보입력</th>
			</tr>
			<tr>
				<td class="text">이름</td>
				<td><input type="text" id="member_name" name="member_name"></td>
			</tr>
			<tr>
				<td class="text">아이디</td>
				<td>
					<input type="text" id="member_id" name="member_id"><input type="button" value="중복확인" onclick="idCheck()">
					<br>
					<input type="text" id="email_hint" value="이메일 형식으로 아이디를 지정해 주세요." disabled="disabled">
				</td>
			</tr>
			<tr>
				<td class="text">비밀번호</td>
				<td>
					<input type="password" id="member_pwd" name="member_pwd">
					<br>
					<input id="pwd_hint" type="text" value="비밀번호는 영문, 특수문자 포함 최소 8자리 입니다." disabled="disabled">
				</td>
			</tr>
			<tr>
				<td class="text">비밀번호 확인</td>
				<td>
					<input type="password" id="member_pwd_check">
					<br>
					<input id="pwd_check_hint" type="text" value="입력한 비밀번호와 똑같이 입력해주세요." disabled="disabled">
				</td>
			</tr>
			<tr>
				<td class="text">생년월일</td>
				<td><input type="date" id="member_birth" name="member_birth"></td>
			</tr>
			<tr>
				<td class="text">성별</td>
				<td>
					<label><input id="member_sex" name="member_sex" type="radio" value="남자">남자</label>
					<label><input id="member_sex" name="member_sex" type="radio" value="여자">여자</label>
					<label><input id="member_sex" name="member_sex" type="radio" value="기타">기타</label>
				</td>
			</tr>
			<tr>
				<td><input type="button" value="취소" onclick="window.history.back()"></td>
				<td><input type="button" value="회원가입" onclick="formCheck()"></td>
			</tr>
		</table>
	</form>
</body>
</html>