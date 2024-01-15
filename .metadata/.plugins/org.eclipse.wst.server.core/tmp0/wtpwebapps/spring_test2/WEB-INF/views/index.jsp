<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>

<jsp:include page="./layout/header.jsp"></jsp:include>
<jsp:include page="./layout/navbar.jsp"></jsp:include>


<body>
<h1>
	Hello world!  
</h1>

<P>  The time on the server is ${serverTime}. </P>

<a href="/board/register"><button>Register Board</button></a>
</body>


<jsp:include page="./layout/footer.jsp"></jsp:include>