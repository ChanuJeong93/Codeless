<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/hung1001/font-awesome-pro@4cac1a6/css/all.css" />

<style type="text/css">

#span {
  color: #064CB5;
  font-weight: bold;
}

#span :hover{
  color: #064CB5;
  font-weight: bold;
  text-decoration: underline;
}

#nttable * {
  font-size: 100%;
  text-align: left;
  style="font-family: 'Noto Sans KR', sans-serif, 'Font Awesome 5 Free';"
}

#nttable {
  margin-bottom: 10px;
  border-collapse: collapse;
}

#nttable th,
#nttable td {
  padding: 5px;
}
.table td,
.table th {
  padding: 0.5rem;
}


.del-btn {
  border: none; /* 버튼 테두리 제거 */
  padding: 0; /* 버튼 안쪽 여백 제거 */
  font-size: 1.3rem !important; /* 아이콘 크기 조정 */
  color: #FF5733; /* 아이콘 색상을 빨간색으로 설정 */
  background-color: white; /* 배경 색상을 흰색으로 설정 */
  transition: all 0.2s ease-in-out; /* 애니메이션을 위한 속성 추가 */
  
}

.del-btn:hover {
  transform: scale(1.2); /* 마우스 호버 시 아이콘 크기를 1.1배로 확대 */
  color: red;
  cursor: pointer; /* 커서를 pointer로 변경 */
}
.del-btn:active {
  cursor: pointer; /* 클릭 시 커서를 pointer로 변경 */
}

</style>

<script type="text/javascript">
$(document).on("click", ".del-btn", function() {
	  var product_id = $(this).data("product-id");
	  
	  if (confirm("삭제 하시겠습니까?")) {
	    $.ajax({
	      url: "./AjaxDeleteProduct.aj",
	      data: { product_id: product_id },
	      success: function(response) {
	        alert('삭제 성공');
	        // 페이지 새로고침
	        location.reload();
	      },
	      error: function(jqXHR, textStatus, errorThrown) {
	        alert('삭제 실패');
	      }
	    });
	  }
	});

</script>
<%@ include file="../head.jsp" %>
</head>
<body>
<%@ include file="../nav.jsp"%><!-- nav 삽입 -->

<!-- 관리자페이지의 [상품관리]탭을 누르면 판매 상태여부에 관계 없이 모든 거래 리스트를 볼 수 있다. -->
<!-- 최신순으로 모든 상품의 리스트가 한 페이지 20개씩 출력됨 -->
<!-- 리스트로 출력되는 내용은 상품번호, 상품명, 판매가, 판매자, 구매자, 등록일시, 판매 상태(판매중, 판매완료) -->
<!-- 상품 링크를 클릭하면 해당 상품 페이지로 이동할 수 있음 -->
	<br>
 <h1 style="font-family: 'TheJamsil5Bold';" align="center">상품관리</h1>
<hr style="border: 0;height: 3px; background-color: gray;" width="95%";>	
	  
	  
	  <table id=nttable class="table" style= "width: 95%" ; align="center";  >
   <thead style="background-color: #F6F6F6;">
		<tr>
			<th>상품번호</th>
			<th>상품명</th>
			<th>가격</th>
			<th>판매자</th>
			<th>구매자</th>
			<th>등록일시</th>
			<th>주문진행상태</th>
			<th>삭제</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="dto" items="${requestScope.adminProductList}">
			<tr>
				<td>${dto.product_id}</td>
				<td><a href="./ProductContent.pr?product_id=${dto.product_id}"><span id="span">${dto.title}</span></a></td>
				<td>${dto.price}</td>
				<td>${dto.seller_id}</td>
				<td>${dto.buyer_id}</td>
				<td>${dto.order_date}</td>
				<td>
					<c:set var="status" value="${dto.order_status}" />
					<c:choose>
						<c:when test="${status == 1}">주문확인</c:when>
						<c:when test="${status == 2}">주문수락</c:when>
						<c:when test="${status == 3}">발송</c:when>
						<c:when test="${status == 4}">구매확정</c:when>
						<c:otherwise>알 수 없음</c:otherwise>
					</c:choose>
				</td>
				
				
				<td>
			
				
				  <button class="del-btn" data-product-id="${dto.product_id}" >
					  <i class="fas fa-trash"></i>
					</button> 
					
					
			</td>
			</tr>
		</c:forEach>
	</tbody>
</table>


			<div class="container" style="margin: auto;">
			  <ul class="pagination justify-content-center" id="pagination" style="margin-top: 50px;">
		  	<c:if test="${startPage > pageBlock }"> 
			<li class="page-item"><a class="page-link" href="./AdminProductList.my?pageNum=${startPage-pageBlock} "><sapn>이전</sapn></a></li>
			</c:if>
		   <c:forEach var="i" begin="${startPage }" end="${endPage }" step="1">
			<li class="page-item"><a class="page-link" href="./AdminProductList.my?pageNum=${i }"><span>${i }</span></a></li>
			</c:forEach>
		    <c:if test="${endPage<pageCount }">
			<li class="page-item"><a class="page-link" href="./AdminProductList.my?pageNum=${startPage+pageBlock} "><span>다음</span></a></li>
			</c:if>
		  </ul>
		 
  		</div>



<br>


 <%@ include file="../footer.jsp"%> <!-- footer 삽입 -->
</body>
</html>