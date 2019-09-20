<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table>
		<thead>
			<!-- 검색 창 -->
			<tr>
				<td><input type="button" value="메인화면" onclick="location.href='../MainView/wecal_MainView.jsp'"></td>
				<td>
					<form action="join_meet.do" method="post">
						<input type="hidden" id="currPage" name="currPage" value="1">
						<c:if test="${search eq ''}">
							<input type="text" placeholder="모임 이름으로 검색하세요." id="search" name="search">
						</c:if>
						<c:if test="${search ne ''}">
							<input type="text" value="${search }" id="search" name="search">
						</c:if>
						<input type="submit" value="검색">
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
					<th>${meet.get(i).meet_name }</th>
					<td>${meet.get(i).master_name }</td>
				</tr>
				<tr>
					<td colspan="2">${meet.get(i).meet_content }</td>
				</tr>
				</c:forEach>
			</c:if>
		</tbody>
		<tfoot>
			<!-- 페이징 -->
			<tr>
				<c:if test="${pv.listCnt != 0 }">
					<td colspan="2">
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