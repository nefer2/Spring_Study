<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<jsp:include page="../layout/header.jsp"></jsp:include>
<jsp:include page="../layout/navbar.jsp"></jsp:include>

<div class="container-md">
<h1>Board Modify Page</h1>
<c:set value="${bdto.bvo }" var="bvo"></c:set>
<form action="/board/modify" method="post" enctype="multipart/form-data"> 
<div class="mb-3">
  <label for="Bno" class="form-label">번호</label>
  <input type="text" name="Bno" class="form-control" id="Bno" value="${bvo.bno }" readonly="readonly">
</div>

<div class="mb-3">
  <label for="title" class="form-label">제목</label>
  <input type="text" name="title" class="form-control" id="title" value="${bvo.title }" >
</div>

<div class="mb-3">
  <label for="writer" class="form-label">작성자</label>
  <input type="text" name="writer" class="form-control" id="writer" value="${bvo.writer }" readonly="readonly">
</div>

<div class="mb-3">
  <label for="reg_date" class="form-label">작성일</label>
  <input type="text" name="reg_date" class="form-control" id="reg_date" value="${bvo.regAt }" readonly="readonly">
</div>

<div class="mb-3">
  <label for="content" class="form-label">내용</label>
  <textarea name="content" class="form-control" id="content" rows="3" >${bvo.content }</textarea>
</div>
	<!-- file line -->
<c:set value="${bdto.flist }" var="flist"></c:set>
	<div class="mb-3">
	<label for="f" class="form-label">File</label>
	<ul class="list-group list-group-flush">
		<c:forEach items="${flist }" var="fvo">
    		<li class="list-group-item">
    			<c:choose>
    				<c:when test="${fvo.fileType == 1 }">
    					<div>
    						<img alt="" src="/upload/${fvo.saveDir }/${fvo.uuid}_th_${fvo.fileName}">
    					</div>
    				</c:when>
    				<c:otherwise>
    					<div>
    						<!-- 일반 파일 표시할 아이콘 -->
    				<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-file-earmark-break" viewBox="0 0 16 16">
  <path d="M14 4.5V9h-1V4.5h-2A1.5 1.5 0 0 1 9.5 3V1H4a1 1 0 0 0-1 1v7H2V2a2 2 0 0 1 2-2h5.5L14 4.5zM13 12h1v2a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2v-2h1v2a1 1 0 0 0 1 1h8a1 1 0 0 0 1-1v-2zM.5 10a.5.5 0 0 0 0 1h15a.5.5 0 0 0 0-1H.5z"/>
</svg>
    					</div>
    				</c:otherwise>	
    			</c:choose>
    			<div class="ms-2 me-auto">
    				<div class="fw-bold">${fvo.fileName }</div>
    				<span class="badge rounded-pill text-bg-secondary">${fvo.fileSize }Byte</span>
    				<button type="button" data-uuid="${fvo.uuid }" class="btn btn-outline-danger file-x">x</button>
    			</div>
    		</li>
    	</c:forEach>
	</ul>
    
	</div>
<!-- file 등록 라인 추가 -->
      <div class="mb-3">
         <input type="file" class="form-control" name="files" id="files" multiple="multiple" style="display: none"> <br>
         <!-- 파일 버튼 트리거 사용하기 위해서 주는 버튼 -->
         <button type="button" class="btn btn-primary" id="trigger">FileUpload</button>
      </div>
      <!-- 파일 목록 표시라인 -->
      <div class="mb-3" id="fileZone">
         
      </div>


<a href="/board/list"><button type="button" class="btn btn-primary"> 리스트 </button></a>
<button type="submit" class="btn btn-success" id="regBtn"> 수정 </button>
</form>
</div>

<script src="/resources/js/boardModify.js"></script>
<script src="/resources/js/boardRegister.js"></script>


<jsp:include page="../layout/footer.jsp"></jsp:include>