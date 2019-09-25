<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript">
$(function(){
	alert("모임을 삭제하였습니다.");
	parent.location.href="../MainView/main.do?mnum="+<%=session.getAttribute("mnum")%>;
})
</script>
