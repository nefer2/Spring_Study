<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="../layout/header.jsp"></jsp:include>
<jsp:include page="../layout/navbar.jsp"></jsp:include>

<div class="col-sm-12 col-md-6">
	<form action="/board/list" method="get">
		<div class="input-group mb-3">
			<c:set value="${ph.pgvo.type}" var="typed"></c:set>
			<select class="form-select" name="type" id="inputGroupSelect" aria-label="Default select example">
			  <option ${typed eq null ? 'selected':'' }>Choose...</option>
			  <option value="t" ${typed eq 't' ? 'selected' : '' }>Title</option>
			  <option value="w" ${typed eq 'w' ? 'selected' : '' }>Writer</option>
			  <option value="c" ${typed eq 'c' ? 'selected' : '' }>Content</option>
			  <option value="tw" ${typed eq 'tw' ? 'selected' : '' }>Title & Writer</option>
			  <option value="tc" ${typed eq 'tc' ? 'selected' : '' }>Title & Content</option>
			  <option value="wc" ${typed eq 'wc' ? 'selected' : '' }>Writer & Content</option>
			  <option value="twc" ${typed eq 'twc' ? 'selected' : '' }>All</option>
			</select>
				<input type="hidden" name="pageNo" value="1">
				<input type="hidden" name="qty" value="${ph.pgvo.qty }">
			    <input class="form-control me-2" name="keyword" value="${ph.pgvo.keyword }" type="search" placeholder="Search" aria-label="Search">
      		    <button class="btn btn-outline-success" type="submit">Search
      		    <span class="badge text-bg-info">${ph.totalCount }</span>
      		    </button>
		</div>
	</form>
</div>


<table class="table">
  <thead>
    <tr>
      <th scope="col">#</th>
      <th scope="col">제목</th>
      <th scope="col">작성자</th>
      <th scope="col">조회수</th>
      <th scope="col">댓글수</th>
      <th scope="col">파일수</th>
      <th scope="col">작성 시간</th>
    </tr>
  </thead>
  <tbody>
  
  <c:forEach items="${list }" var="bvo">
    <tr>
      <th scope="row">${bvo.bno }</th>
      <td><a href="/board/detail?bno=${bvo.bno }">${bvo.title }</a></td>
      <td>${bvo.writer }</td>
      <td>${bvo.readCount }</td>
      <td>${bvo.cmtQty }</td>
      <td>${bvo.hasFile }</td>
      <td>${bvo.regAt }</td>
    </tr>
    </c:forEach>
    
  </tbody>
</table>

<!-- 페이징 라인 처리 -->
<nav aria-label="Page navigation example">
  <ul class="pagination">
  
<!-- prev -->
<c:if test="${ph.prev }">
    <li class="page-item">
      <a class="page-link" href="/board/list/?pageNo=${ph.startPage-1 }&qty=${ph.pgvo.qty}&type=${ph.pgvo.type }&keyword=${ph.pgvo.keyword }" aria-label="Prev">
        <span aria-hidden="true">&laquo;</span>
      </a>
    </li>
</c:if>
<!-- paging 번호 -->
<c:forEach begin="${ph.startPage }" end="${ph.endPage }" var="i" >
    <li class="page-item"><a class="page-link" href="/board/list/?pageNo=${i}&qty=${ph.pgvo.qty}&type=${ph.pgvo.type }&keyword=${ph.pgvo.keyword }">${i }</a></li>
</c:forEach>
   
<!-- next -->
<c:if test="${ph.next }">
    <li class="page-item">
      <a class="page-link" href="/board/list/?pageNo=${ph.endPage+1}&qty=${ph.pgvo.qty}&type=${ph.pgvo.type }&keyword=${ph.pgvo.keyword }" aria-label="Next">
        <span aria-hidden="true">&raquo;</span>
      </a>
    </li>
</c:if>
  </ul>
</nav>


<jsp:include page="../layout/footer.jsp"></jsp:include>