<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script> <!-- 간편로그인 sdk -->
<script type="text/javascript">

	Kakao.init('d024657e59f07ee69d6d1407441dfe53'); // 카카오 API 초기화
function kakaoLogout() {
    if (Kakao.Auth.getAccessToken()) {
      Kakao.API.request({
        url: '/v1/user/unlink',
        success: function (response) {
        	
        	location.href='./MemberLogout.me';
        
        },
        fail: function (error) {
        	alert(error);
        },
      })
      Kakao.Auth.setAccessToken(null);
  	
    }else {
    	location.href='./MemberLogout.me'; //일반회원일 때 로그아웃
    }
  }  //카카오 간편로그인 로그아웃. (간편로그인 토큰때문에 따로 로그아웃 처리를 해주어야한다!)

   window.onload = function() {
    // 스크롤 이벤트 핸들러 등록
    window.addEventListener('scroll', function() {
      // 현재 스크롤 위치
      var scrollPosition = window.pageYOffset;
      // 배경색을 변경할 요소
      var targetElement = document.querySelector('.navbar');
      // 스크롤 위치에 따라 배경색 변경
      if (scrollPosition > 150) {
		 targetElement.style.backgroundColor = '#E2E2E2';//연회색 적용
		 targetElement.style.height = '70px';//높이
		 targetElement.classList.add('shadow');//그림자적용
	} else {
		 targetElement.style.backgroundColor = 'transparent';
		 targetElement.style.height = '100px';//높이
	 	 targetElement.classList.remove('shadow');	
		}
	  });
	}; //스크롤 내리면 회색, 올리면 투명
  
</script>
<!-- 
style="  background-color: transparent !important;box-shadow: none !important;" nav바 투명하게 -->

<!-- transition: background-color 0.5s ease; navbar 스무스하게 나오게 -->
	 <nav class="navbar navbar-expand-lg fixed-top" style=" background-color: transparent !important;transition: background-color 0.5s ease; height:100px; " id="navbar">
		<div class="container">
			<a class="navbar-brand" href="./Main.me">
			<span style=" color: white; border: 5px solid #ffba5a; padding: 5px 5px;">CODELESS</span></a>
			<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
			<span class="oi oi-menu"></span> Menu
			</button>

	      <div class="collapse navbar-collapse" id="ftco-nav">
	        <ul class="navbar-nav ml-auto">
				<c:if test="${empty id}">
					<li class="nav-item"><a href="./MemberLogin.me" class="nav-link"><b>로그인</b></a></li>
					<li class="nav-item"><a href="./MemberJoin.me" class="nav-link"><b>회원가입</b></a></li>
				</c:if>
				<c:if test="${!empty id }">

					<li class="nav-item"><a href="#" class="nav-link" onclick="kakaoLogout();"><b>로그아웃</b></a></li>
					
	 <li class="nav-item dropdown">
      <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
       <c:if test="${id!='admin' && id!='admin@gmail.com' }">
        <b>마이페이지</b>
        </c:if>
         <c:if test="${id=='admin' || id=='admin@gmail.com' }">
          <b>관리자페이지</b>
         </c:if>
        
      </a>
      <div class="dropdown-menu">
            <c:if test="${id!='admin' && id!='admin@gmail.com' }">
		   <a class="dropdown-item" href="./MemberInfo.my"> 내정보보기</a>
		   <a class="dropdown-item" href="./MypageSalesList.my"> 판매목록</a>
		   <a class="dropdown-item" href="./MypagePurchaseList.my">구매목록</a>
		   <a class="dropdown-item" href="./UserQNAList.qn"> 1:1 문의 </a>
		   <a class="dropdown-item" href="./LikeList.my"> 찜목록 </a>
		   <a class="dropdown-item" href="./ChatBox.ch"> 채팅목록 </a>
		  </c:if>
		  
		  <c:if test="${id=='admin' || id=='admin@gmail.com' }">
		   <a class="dropdown-item" href="./MemberInfo.my"> 내정보보기</a>
		   <a class="dropdown-item" href="./MemberList.me"> 회원관리</a>
		   <a class="dropdown-item" href="./AdminProductList.my"> 상품관리 </a>
		   <a class="dropdown-item" href="./AdminQNAList.qn"> 1:1문의관리</a>	
		  </c:if>
      </div>
   	  </li>
				</c:if>
	        </ul>
	      </div>
	    </div>
	  </nav>
	  
