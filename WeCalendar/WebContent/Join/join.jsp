<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style type="text/css">
table {
	margin-left: auto;
	margin-right: auto;
}
#subject {
	font-size: 30px;
}
#pwd_hint, #pwd_check_hint {
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

$(function(){
	$('#member_pwd').keyup(function(){
		passwordCheck($('#member_pwd').val(), $('#member_id').val());
	})
	$('#member_pwd_check').keyup(function(){
		passwordCheck2($('#member_pwd').val(), $('#member_pwd_check').val());
	})
})

function formCheck(){
	
	if($('#member_name').val() == ""){
		alert("�̸��� �Է����ּ���!");
		$('#member_name').focus();
		return;
	}
	if($('#member_id').val() == ""){
		alert("���̵� �Է����ּ���!");
		$('#member_id').focus();
		return;
	}
	if(id_check){
		alert("���̵� �ߺ��˻縦 ���ּ���!");
		$('#member_id').focus();
		return;
	}
	if($('#member_pwd').val() == ""){
		alert("��й�ȣ�� �Է����ּ���!");
		$('#member_pwd').focus();
		return;
	}
	if(pwd_check){
		alert("��й�ȣ ������ �����ּ���!");
		$('#member_pwd').focus();
		return;
	}
	if(pwd_check2){
		alert("��й�ȣ�� ��й�ȣ Ȯ�� ���� �ٸ��ϴ�!");
		$('#member_pwd_check').focus();
		return;
	}
	
	$('#joinform').submit();
	
}

function passwordCheck(password, id){
	if(/(\w)\1\1\1/.test(password)){
        $('#pwd_hint').val('���� ���ڸ� 4�� �̻� ����Ͻ� �� �����ϴ�.');
        $('#pwd_hint').css('color','red');
        pwd_check = true;
    }
	else if(!/^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,25}$/.test(password)){
        $('#pwd_hint').val('����+������+Ư������ �������� 8�ڸ� �̻� ����ؾ� �մϴ�.');
        $('#pwd_hint').css('color','red');
        pwd_check = true;
    }
	else if(password.search(id) > -1 && id != ""){
        $('#pwd_hint').val('��й�ȣ�� ���̵� ���ԵǾ����ϴ�.');
        $('#pwd_hint').css('color','red');
        pwd_check = true;
    }
	else{
        $('#pwd_hint').val('�ùٸ� ��й�ȣ �Դϴ�.');
        $('#pwd_hint').css('color','green');
        pwd_check = false;
	}
}

function passwordCheck2(password, check){
	if(password != check){
        $('#pwd_check_hint').val('��й�ȣ�� �ٸ��ϴ�.');
        $('#pwd_check_hint').css('color','red');
        pwd_check2 = true;
	}
	else{
        $('#pwd_check_hint').val('��й�ȣ�� ��ġ�մϴ�.');
        $('#pwd_check_hint').css('color','green');
        pwd_check2 = false;
	}
}

function idCheck(){
	if($('#member_id').val() == ""){
		alert("���̵� �Է����ּ���!");
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
					alert("����� �� �ִ� ���̵� �Դϴ�.");
					id_check = false;
				}
				else if(data == "false"){
					alert("�ߺ��Ǵ� ���̵� �Դϴ�.");
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
				<th colspan="2" id="subject">ȸ������ �����Է�</th>
			</tr>
			<tr>
				<td class="text">�̸�</td>
				<td><input type="text" id="member_name" name="member_name"></td>
			</tr>
			<tr>
				<td class="text">���̵�</td>
				<td><input type="text" id="member_id" name="member_id"><input type="button" value="�ߺ�Ȯ��" onclick="idCheck()"></td>
			</tr>
			<tr>
				<td class="text">��й�ȣ</td>
				<td>
					<input type="password" id="member_pwd" name="member_pwd">
					<br>
					<input id="pwd_hint" type="text" value="��й�ȣ�� ����, Ư������ ���� �ּ� 8�ڸ� �Դϴ�." disabled="disabled">
				</td>
			</tr>
			<tr>
				<td class="text">��й�ȣ Ȯ��</td>
				<td>
					<input type="password" id="member_pwd_check">
					<br>
					<input id="pwd_check_hint" type="text" value="�Է��� ��й�ȣ�� �Ȱ��� �Է����ּ���." disabled="disabled">
				</td>
			</tr>
			<tr>
				<td class="text">�������</td>
				<td><input type="date" id="member_birth" name="member_birth"></td>
			</tr>
			<tr>
				<td class="text">����</td>
				<td>
					<label><input id="member_sex" name="member_sex" type="radio" value="����">����</label>
					<label><input id="member_sex" name="member_sex" type="radio" value="����">����</label>
					<label><input id="member_sex" name="member_sex" type="radio" value="��Ÿ">��Ÿ</label>
				</td>
			</tr>
			<tr>
				<td><input type="button" value="���" onclick="window.history.back()"></td>
				<td><input type="button" value="ȸ������" onclick="formCheck()"></td>
			</tr>
		</table>
	</form>
</body>
</html>