<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<table>
		<thead>
			<!-- 검색 창 -->
			<tr>
			</tr>
		</thead>
		<tbody>
			<!-- 리스트 -->
			<c:forEach begin="${pv.startIndex }" var="i" end="${pv.endIndex }">
			<tr>
				<th>${meet.get(i).meet_name }</th>
				<td>${meet.get(i).master_name }</td>
			</tr>
			<tr>
				<td colspan="2">${meet.get(i).meet_content }</td>
			</tr>
			</c:forEach>
		</tbody>
		<tfoot>
			<!-- 페이징 -->
			<tr>
				<td colspan="2">
					<a href="<c:url value='join_meet.do'/>?currPage=1"><b>[처음으로]</b></a>&nbsp;
					<c:if test="${pv.currPage == 1}">
					<b>&lt;</b>
					</c:if>
					<c:if test="${pv.currPage != 1}">
						<a href="<c:url value='join_meet.do'/>?currPage=${pv.currPage-1 }"><b>&lt;</b></a>
					</c:if>
					<c:forEach begin="1" var="i" end="${pv.endPage }">&nbsp;<c:if test="${i == pv.currPage }"><font color="red">${i }</font></c:if><c:if test="${i != pv.currPage }"><a href="<c:url value='join_meet.do'/>?currPage=${i }">${i }</a></c:if></c:forEach>&nbsp;
					<c:if test="${pv.currPage == pv.endPage }">
					<b>&gt;</b>
					</c:if>
					<c:if test="${pv.currPage != pv.endPage }">
						<a href="<c:url value='join_meet.do'/>?currPage=${pv.currPage+1 }"><b>&gt;</b></a>
					</c:if>
					&nbsp;<a href="<c:url value='join_meet.do'/>?currPage=${pv.pageCnt }"><b>[끝으로]</b></a>
				</td>
			</tr>
		</tfoot>
	</table>
</body>
</html>