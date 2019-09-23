<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모임 가입하기</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript">
function joinMeet(meet_num){
	$.ajax({
		type:'POST',
		url:'member_meet.do',
		data:{
			"meet_num":meet_num
		},
		success:function(data){
			alert("가입되었습니다!");
			location.reload();
		},
		error:function(e){
			
		}
	})
}
</script>
<style type="text/css">
html, body {
	height: 100%;
}
table {
	width: 95%;
	height: 500px;
	margin-left: auto;
	margin-right: auto;
}
thead {
	background-color: #f3f9d7;
	width: 100%;
	height: 100px;
}
.search_text {
	width: 80%;
	height: 20px;
	margin-left: 10px;
}
.search_btn {
	width: 15%;
	height: 25px;
	margin-left: 5px;
}
.join_btn {
	height: 50px;
}
</style>
</head>
<body>
	<table>
		<thead>
			<!-- 검색 창 -->
			<tr>
				<td><input type="button" value="메인화면" onclick="location.href='../MainView/wecal_MainView.jsp'" style="width: 100%;"></td>
				<td colspan="2">
					<form action="join_meet.do" method="post">
						<input type="hidden" id="currPage" name="currPage" value="1">
						<c:if test="${search eq ''}">
							<input type="text" placeholder="모임 이름으로 검색하세요." id="search" name="search" class="search_text">
						</c:if>
						<c:if test="${search ne ''}">
							<input type="text" value="${search }" id="search" name="search" class="search_text">
						</c:if>
						<input type="submit" value="검색" class="search_btn">
					</form>
				</td>
			</tr>
		</thead>
		<tbody>
			<!-- 리스트 -->
			<c:if test="${pv.listCnt == 0 }">
				<tr>
					<td rowspan="2" colspan="2">검색 결과가 없습니다.</td>
				</tr>
			</c:if>
			<c:if test="${pv.listCnt != 0 }">
				<c:forEach begin="${pv.startIndex }" var="i" end="${pv.endIndex }">
				<tr>
					<th width="20%">${meet.get(i).meet_name }</th>
					<td width="70%">${meet.get(i).master_name }</td>
					<td rowspan="2" width="5%"><input type="button" value="가입하기" class="join_btn" onclick="joinMeet(${meet.get(i).meet_num})"></td>
				</tr>
				<tr>
					<td colspan="2">${meet.get(i).meet_content }<hr></td>
				</tr>
				</c:forEach>
			</c:if>
		</tbody>
		<tfoot>
			<!-- 페이징 -->
			<tr>
				<c:if test="${pv.listCnt != 0 }">
					<td colspan="2" align="center">
						<a href="<c:url value='join_meet.do'/>?currPage=1&search=${search}"><b>[처음으로]</b></a>&nbsp;
						<c:if test="${pv.currPage == 1}">
						<b>&lt;</b>
						</c:if>
						<c:if test="${pv.currPage != 1}">
							<a href="<c:url value='join_meet.do'/>?currPage=${pv.currPage-1 }&search=${search}"><b>&lt;</b></a>
						</c:if>
						<c:forEach begin="1" var="i" end="${pv.endPage }">&nbsp;<c:if test="${i == pv.currPage }"><font color="red">${i }</font></c:if><c:if test="${i != pv.currPage }"><a href="<c:url value='join_meet.do'/>?currPage=${i }&search=${search}">${i }</a></c:if></c:forEach>&nbsp;
						<c:if test="${pv.currPage == pv.endPage }">
						<b>&gt;</b>
						</c:if>
						<c:if test="${pv.currPage != pv.endPage }">
							<a href="<c:url value='join_meet.do'/>?currPage=${pv.currPage+1 }&search=${search}"><b>&gt;</b></a>
						</c:if>
						&nbsp;<a href="<c:url value='join_meet.do'/>?currPage=${pv.pageCnt }&search=${search}"><b>[끝으로]</b></a>
					</td>
				</c:if>
			</tr>
		</tfoot>
	</table>
</body>
</html>