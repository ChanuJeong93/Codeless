<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
  <head>
	
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.min.js"></script>
  <%@ include file="../head.jsp" %>
    <link rel="stylesheet" href="css/aos.css">
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script>
Kakao.init('d024657e59f07ee69d6d1407441dfe53'); //js토큰키 사용
console.log(Kakao.isInitialized()); // sdk초기화 여부 판단
//카카오로그인
function kakaoLogin() {
    Kakao.Auth.login({
      success: function (res) {
        Kakao.API.request({
          url: '/v2/user/me',
          success: function (res) {
        	  sessionStorage.setItem("id",res.id); //session에 카카오로그인 아이디 담음
        	  var id = sessionStorage.getItem("id");
        	  $.ajax({
				  url : "./AjaxAction.aj",
				  data: {"id": id},
				  success:function(data){
					  const result = $.trim(data);
					  if(result=="yes"){
						alert('회원정보가 없습니다. 회원가입페이지로 이동합니다.');
						location.href="./MemberJoin.me?id="+id;
					  
					  }else if ( result=="no"){
					 	alert('코드리스 회원입니다.');
					 	location.href="./KakaoLogin.me?id="+id; //페이지 이동해서 데이터(db에서 id값만 갖고와도 로그인 성공하도록 해야함!!)
				
					  }
				  }//success 
			  });// ajax
        	  
          },
          fail: function (error) {
            console.log(error)
          },
        })
      },
      fail: function (error) {
        console.log(error)
      },
    })
  }

</script>
  <script type="text/javascript">

		
		$(document).ready(function () {
			
			$('#fr').submit(function() {
				if($('#id').val() == ""){
					alert('아이디를 입력하세요.');
					$('#id').focus();
					return false;
				}//아이디 입력 제어
				
				if($('#password').val() == ""){
					alert('비밀번호를 입력하세요.');
					$('#password').focus();
					return false;
				}//비밀번호 입력 제어
			});
			
		});
		

  
  </script>
  </head>    
<body>
 <%@ include file="../nav.jsp" %><!-- nav 삽입 -->
 
	
 <div class="container" id="login-con">
  <form action="./MemberLoginAction.me" id="fr" method="post"> 
    <div class="form-group" id="log-form">
     <div style="text-align: center;"><a class="navbar-brand" href="./Main.me" style="font-size: 40px;"><span>CODELESS</span></a></div>
     
      <input type="text" class="form-control"  placeholder="아이디를 입력해주세요." name="id" style="margin-bottom: 10px;" id="id">
      <!-- 실행 편의를 위해 email타입을 text로 바꿈 -->
	 
      <input type="password" class="form-control" placeholder="비밀번호를 입력해주세요." name="password" id="password">

      <button type="submit" class="btn btn-primary btn-block" style="margin-top: 30px;" >로그인</button>
     
      <button type="button" class="btn btn-dark btn-block" style="margin-top: 15px;" onclick="location.href='./MemberJoin.me'" >
      회원가입</button>
   	  
   	  <a href="javascript:void(0)">
      <img onclick="kakaoLogin();" src="//k.kakaocdn.net/14/dn/btqbjxsO6vP/KPiGpdnsubSq3a0PHEGUK1/o.jpg" 
      width="100%;" height="50%;"  style="margin-top: 15px; padding-inline: 50px;" />
      </a><!-- 카카오 로그인 버튼!-->
  
  
       <hr>        
      <span onclick="location.href='./IdFind.me'" style="margin-left:85px; cursor:pointer;" >아이디 찾기</span>  |
      
      <span onclick="location.href='./PwFind.me'" style="cursor:pointer;" >비밀번호 찾기</span>  
      
    
   </div>
  </form>
</div><!-- 로그인 컨테이너박스 끝 -->
 <%@ include file="../footer.jsp" %> <!-- footer 삽입 -->

</body>
</html>