<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> --%>
<!DOCTYPE html>
<html lang="ko">
<head>
 <!-- jQuery -->
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
    <%@ include file="../head.jsp"%>
    <!-- iamport.payment.js -->
    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
    <!-- 주소api -->
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
    // 주소 메서드
    function addr() {
		new daum.Postcode({
			    oncomplete : function(data) {
				document.getElementById("receiver_post").value = data.zonecode; // 우편 번호 넣기
				document.getElementById("receiver_addr1").value = data.address; // 주소 넣기
			}
		}).open();
	};
	// 변수
    var order_id ="";
    var email ="";
    var name ="";
    var receiver_phone ="";
    var receiver_addr1 ="";
    var receiver_addr2 ="";
    var receiver_post ="";
    var amount ="";
    var product_id ="";
    var title ="";
    var payment ="";
    $(function(){
    	order_id = $('#order_id').attr('value');
    	email = $('#id').attr('value');
    	name = $('#receiver_name').attr('value');
    	receiver_phone = $('#receiver_phone').attr('value');
    	receiver_addr1 = $('#receiver_addr1').attr('value');
    	receiver_addr2 = $('#receiver_addr2').attr('value');
    	receiver_post = $('#receiver_post').attr('value');
    	amount = $('#amount').attr('value');
    	product_id = $('#product_id').attr('value');
    	title = $('#title').attr('value');
    	payment = $('.pm:checked').val();
    	console.log(name);
    	console.log(email);
    	console.log(payment);
    }); //(document).ready
    	
        var IMP = window.IMP; 
        IMP.init("imp88454102"); 
      
        var today = new Date();   
        var hours = today.getHours(); // 시
        var minutes = today.getMinutes();  // 분
        var seconds = today.getSeconds();  // 초
        var milliseconds = today.getMilliseconds();
        var makeMerchantUid = hours +  minutes + seconds + milliseconds; //주문일시
       	var year = today.getFullYear(); // 년도
       	var month = today.getMonth() + 1;  // 월
       	var date = today.getDate();  // 날짜
       	var day = today.getDay();  // 요일
     	// 두자리 수를 표현하기 위한 0 추가 
        if(month <10){ month = "0"+month; } 
        if(date <10){ date = "0"+date; }      
       	var order_date = year+"-"+month+"-"+date+" "+hours+":"+minutes+":"+seconds; //주문일시
       	
       	// 결제
        function requestPay() {
        	// 약관동의 결제제한
        	if($('#check-all').is(':checked') == false){
    			alert('약관에 동의해주세요.');
    			$('#check-all').focus();
    			return false;
    	 	}
        	// 카드결제
        	if($('.pm:checked').val() == "html5_inicis"){
        	var pay_form = {
                    pg : 'html5_inicis',
                    pay_method : 'card',
                    merchant_uid: "IMP"+makeMerchantUid, 
                    name : title, //상품명
                    amount : amount, //금액
                    buyer_email : email,
                    buyer_name : name, // 구매자
                    buyer_tel : receiver_phone, // 전화번호
                    buyer_addr : receiver_addr1, //주소
                    buyer_postcode : receiver_post // 우편변호
                };
			// 카카오페이
        	}else if($('.pm:checked').val() == "kakaopay"){
            	var pay_form = {
                        pg : 'kakaopay',
                        pay_method : 'EASY_PAY',
                        merchant_uid: "IMP"+makeMerchantUid, 
                        name : title, //상품명
                        amount : amount, //금액
                        buyer_email : email,
                        buyer_name : name, // 구매자
                        buyer_tel : receiver_phone, // 전화번호
                        buyer_addr : receiver_addr1, //주소
                        buyer_postcode : receiver_post // 우편변호
                    };
        	}
        	console.log(pay_form);
            IMP.request_pay(pay_form, function (rsp) { 
            	console.log(rsp);
                if (rsp.success) {
                	// 결제 성공시 로직
                	var msg = '결제가 완료되었습니다.';
//                 			msg += '\n주문일시 : ' + order_date;
//                 			msg += '\n고유ID : ' + rsp.imp_uid;
//                 			msg += '\n상점 거래ID : ' + rsp.merchant_uid;
//                 			msg += '\결제 금액 : ' + rsp.paid_amount;
//                 			msg += '카드 승인번호 : ' + rsp.apply_num;
                	alert(msg);
                	
                	var data ={
                			order_id : order_id,
                			product_id : product_id,
                			order_date : order_date,
                			name : name,
                			receiver_phone : receiver_phone,
                			receiver_addr1 : receiver_addr1,
                			receiver_addr2 : receiver_addr2,
                			receiver_post : receiver_post,
                			amount : amount,
                			payment : payment
                			}

                	$.ajax({
    					type : 'post',
    	 				url : './OrderAddAction.or',
    	 				data : data,
    	 				dataType : 'TEXT',
    	 				error: function(xhr, status, error){
    	 					alert(error);
    	 				},
    	 				success : function(text){
//     	 					msg : "데이터 전송 성공";
//     	 					alert(msg);
    	 					
						location.href="./OrderContent.or?product_id="+product_id+"&order_id="+order_id;
    	 				}
                	})// ajax
    	 			
                	}else{
                	// 결제 실패시 로직
                	var msg = '결제 실패';
                	msg += '에러내용 : ' + rsp.error_msg;
                	alert(msg);
                    console.log(rsp);
                } //else
            } //function(rsp)
            ); // IMP.request_pay()
    } // function requestPay()
        
    </script>

  
    <meta charset="UTF-8">
    <title>Sample Payment</title>
</head>
<body>
<%-- <%@ include file="../nav.jsp"%> --%>
<!-- nav 삽입 --> 

<div class="col-sm-8" style="margin:auto;">
 <div id="right" style="margin: 50px; width: 100%; color: black;" >
 <h1 style="font-family: 'TheJamsil5Bold';">주 문 서</h1>
<hr style="border: 0;height: 3px; background-color: black;">

<!-- 	<h1>주문서</h1> -->
	<div class="orderWrite">
	<fieldset>
		<legend>상품 정보</legend>
		<input type="hidden" id="title" name="title" value="${dto.title}">
		<input type="hidden" name="price" value="${dto.price}">
		<input type="hidden" name="fee" value="${dto.fee}">
		<div style="display: flex; align-items: center;" >
			<img src="${dto.product_image}" alt="이미지 없음" width="150px" style="display: block; margin-right: 10px;">
			<table>
				<tr>
					<td style="text-align: left;"><span style="color: black; margin-right: 20px;">상품명</span></td>
					<td style="text-align: right;"><span style="color: black;">${dto.title}</span></td>
				</tr>
				<tr>
					<td style="text-align: left;"><span style="color: black; margin-right: 20px;">가격</span></td>
					<td style="text-align: right;"><span style="color: black;">${dto.price}원</span></td>
				</tr>
				<tr>
					<td style="text-align: left;"><span style="color: black; margin-right: 20px;">배송비</span></td>
					<td style="text-align: right;"><span style="color: black;">${dto.charge}원</span></td>
				</tr>
				<tr>
					<td style="text-align: left;"><span style="color: black; margin-right: 20px;">수수료</span></td>
					<td style="text-align: right;"><span style="color: black;">${dto.fee}원</span></td>
				</tr>
			</table>
		</div>
	</fieldset>
</div>
		<hr>
	<div class="tracking" style="color: black;">
	<fieldset>
	<legend>배송 정보</legend>
	<form action="./AddrChangeAction.or" method="post">
		<input type="hidden" id="order_id" name="order_id" value="${dto.order_id}">
		<input type="hidden" id="id" name="id" value="${dto.id}">
		<input type="hidden" id="product_id" name="product_id" value="${dto.product_id}">
		<table>
			<tr>
				<td style="text-align: justify; "><label for="receiver_name"><span style="color: black; margin-right: 20px;">이름</span></label></td>
				<td style="text-align: justify;">
					<input type="text" id="receiver_name" name="receiver_name" value="${dto.receiver_name}" placeholder="이름을 입력해주세요">
				</td>
			</tr>
			<tr>
				<td style="text-align: justify; "><label for="receiver_phone"><span style="color: black; margin-right: 20px;">전화번호</span></label></td>
				<td style="text-align: justify;">
					<input type="text" id="receiver_phone" name="receiver_phone" value="${dto.receiver_phone}" placeholder="전화번호를 입력해주세요">
				</td>
			</tr>
			<tr>
				<td style="text-align: justify; "><label for="receiver_addr"><span style="color: black; margin-right: 20px;">주소</span></label></td>
				<td style="text-align: justify;">
					<input type="text" name="receiver_post" id="receiver_post" size="15" value="${dto.receiver_post}" readonly>
					<input type="button" value="우편번호찾기" onclick="addr();">
					<br>
					<input type="text" name="receiver_addr1" id="receiver_addr1" value="${dto.receiver_addr1}" size="35" onclick="addr();">
					<br>
					<input type="text" name="receiver_addr2" id="receiver_addr2" value="${dto.receiver_addr2}" size="35" placeholder="상세주소를 입력해주세요.">
				</td>
			</tr>
			<tr>
				<td style="text-align: right;" colspan="2">
					<input type="submit" value="변경하기">
				</td>
			</tr>
		</table>
	</form>
</fieldset>
	</div>
	<hr>
	<div class="payInfo">
	<fieldset>
	<legend>결제정보</legend>
		<table>
		<tr>
			<td style="color: black;">총 금액: ${dto.price + dto.fee} 원</td>
		</tr>
	</table>
		<input type="hidden" id="amount" name="amount" value="${dto.price+dto.fee }">
		<!-- 카드결제 선택시 일반 카드결제 / 카카오페이 선택시 카카오페이 간편결제 -->
		결제수단 : 
		<input type="radio" class="pm" name = "payment" value="html5_inicis" checked="checked"> 카드결제  
		<input type="radio" class="pm" name = "payment"  value="kakaopay"> 카카오페이
	</fieldset>
	</div>
	<hr>
	 <fieldset>
    <legend>약관동의</legend>
    <div class="payAgreement">
      <div class="form-check">
        <input class="form-check-input" type="checkbox" id="check-all">
        <label class="form-check-label" for="check-all">
          아래 내용에 전체 동의합니다.
        </label>
      </div>
      <div class="form-check">
        <input class="form-check-input" type="checkbox" id="check-agreement1">
        <label class="form-check-label" for="check-agreement1" style="color : gray;">
          코드리스 서비스 이용약관 동의(필수)
          <a href="#" class="show-details" data-toggle="modal" data-target="#agreement1Modal">(자세히)</a>
        </label>
      </div>
      <div class="form-check">
        <input class="form-check-input" type="checkbox" id="check-agreement2">
        <label class="form-check-label" for="check-agreement2" style="color : gray;">
          개인정보 수집 이용 동의(필수)
          <a href="#" class="show-details" data-toggle="modal" data-target="#agreement2Modal">(자세히)</a>
        </label>
      </div>
      <div class="form-check">
        <input class="form-check-input" type="checkbox" id="check-agreement3">
        <label class="form-check-label" for="check-agreement3" style="color : gray;">
          개인정보 제3자 제공 동의(필수)
           <a href="#" class="show-details" data-toggle="modal" data-target="#agreement3Modal">(자세히)</a>
        </label>
      </div>
    </div>
  </fieldset>

  <!-- 약관 내용을 보여주기 위한 모달(Modal) -->
  <div class="modal fade" id="agreement1Modal" tabindex="-1" role="dialog" aria-labelledby="agreement1ModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="agreement1ModalLabel" style="font-family: 'TheJamsil5Bold';">코드리스 서비스 이용약관 동의</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <textarea rows="8" class="form-control" readonly>
코드리스 서비스 이용약관 동의          
제 1장 총칙

제 1조 (목적)
본 약관은 중고거래 서비스 이용자와 서비스 제공자 사이의 권리와 의무, 중고거래 서비스 이용조건 및 절차 등을 정하는 것을 목적으로 합니다.

제 2조 (정의)
본 약관에서 사용하는 용어의 정의는 다음과 같습니다.
1. 중고거래 서비스: 서비스 제공자가 제공하는 중고 상품 거래 관련 서비스 일체를 의미합니다.
2. 이용자: 중고거래 서비스를 이용하는 개인 또는 법인을 의미합니다.
3. 서비스 제공자: 중고거래 서비스를 제공하는 주체를 의미합니다.

제 3조 (약관의 효력 및 변경)
1. 이용자는 중고거래 서비스를 이용함으로써 본 약관에 동의한 것으로 간주됩니다.
2. 서비스 제공자는 필요한 경우 약관을 변경할 수 있으며, 변경된 약관은 중고거래 서비스 웹사이트를 통해 공지됩니다. 변경된 약관은 공지일로부터 일정 기간이 경과하면 효력을 발생합니다.

제 4조 (중고거래 서비스의 제공)
1. 서비스 제공자는 중고거래 서비스를 제공하기 위해 최선의 노력을 다합니다.
2. 이용자는 중고거래 서비스를 이용함에 있어 법령과 본 약관에서 규정한 사항을 준수해야 합니다.

...

제 10조 (분쟁의 해결)
본 약관에 따른 분쟁에 대해서는 서비스 제공자와 이용자 간의 합의를 원칙으로 합니다. 합의가 이루어지지 않을 경우 관할 법원의 전속 관할로 합니다.

제 11조 (약관의 해석)
본 약관에 명시되지 않은 사항 및 약관의 해석에 관해서는 관련 법령 및 상관례에 따릅니다.

제 12조 (서비스 제공의 제한)
서비스 제공자는 특정 이용자에게 중고거래 서비스의 일부 또는 전부를 제한할 수 있습니다.

본 약관에 동의합니다.
          </textarea>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
        </div>
      </div>
    </div>
  </div>
  <!-- 약관동의2 모달 -->
    <div class="modal fade" id="agreement2Modal" tabindex="-1" role="dialog" aria-labelledby="agreement2ModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="agreement2ModalLabel" style="font-family: 'TheJamsil5Bold';">개인정보 수집 이용 동의</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <textarea rows="8" class="form-control" readonly>
개인정보 수집 동의

1. 개인정보 수집 및 이용 목적
본 개인정보 수집은 다음 목적을 위해 수행되며, 수집된 개인정보는 해당 목적 이외의 다른 용도로 사용되지 않습니다.
- [목적 입력]

2. 수집하는 개인정보 항목
본 서비스에서 수집하는 개인정보는 다음과 같습니다:
- [개인정보 항목 입력]

3. 개인정보의 보유 및 이용 기간
본 서비스는 개인정보를 수집 후, 목적을 달성한 이후에는 해당 정보를 즉시 파기합니다. 다만, 관련 법령에 의해 보관이 필요한 경우에는 해당 법령에 따라 일정 기간 동안 보관하며, 법적 근거가 없어지는 즉시 파기합니다.

4. 개인정보의 제공 및 위탁
본 서비스는 이용자의 개인정보를 제3자에게 제공하거나 위탁하지 않습니다. 다만, 이용자의 사전 동의가 있는 경우 또는 관련 법령에 의해 요구되는 경우에는 예외로 합니다.

5. 개인정보의 파기
이용자의 개인정보는 수집 및 이용 목적이 달성된 후에는 지체 없이 파기됩니다. 파기된 개인정보는 복구 및 복원이 불가능한 방법으로 안전하게 처리됩니다.

6. 동의 철회 및 개인정보 열람, 정정, 삭제
이용자는 개인정보 수집 및 이용에 대한 동의를 철회할 수 있으며, 열람, 정정, 삭제 등의 권리를 행사할 수 있습니다. 자세한 내용은 개인정보 처리방침을 참고하시기 바랍니다.

위 내용을 숙지하고 동의합니다.
          </textarea>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
        </div>
      </div>
    </div>
  </div>
   <!-- 약관동의3 모달 -->
    <div class="modal fade" id="agreement3Modal" tabindex="-1" role="dialog" aria-labelledby="agreement3ModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="agreement3ModalLabel" style="font-family: 'TheJamsil5Bold';" >개인정보 제3자 제공 동의</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <textarea rows="8" class="form-control" readonly>
개인정보 제3자 제공 동의서

1. 개인정보 제공 목적
본 개인정보 제공은 다음 목적을 위해 수행되며, 제공된 개인정보는 해당 목적 이외의 다른 용도로 사용되지 않습니다.
- [목적 입력]

2. 제공하는 개인정보 항목
본 서비스에서 제공하는 개인정보는 다음과 같습니다:
- [개인정보 항목 입력]

3. 개인정보를 제공받는 자
본 서비스는 다음과 같은 제3자에게 개인정보를 제공할 수 있습니다:
- [개인정보를 제공받는 자 입력]

4. 개인정보의 보유 및 이용 기간
본 서비스는 개인정보를 제공한 후, 목적을 달성한 이후에는 해당 정보를 즉시 파기합니다. 다만, 관련 법령에 의해 보관이 필요한 경우에는 해당 법령에 따라 일정 기간 동안 보관하며, 법적 근거가 없어지는 즉시 파기합니다.

5. 개인정보 제공의 동의 철회
이용자는 개인정보 제3자 제공에 대한 동의를 철회할 수 있으며, 동의 철회 시 본 서비스로 연락하여 신속하게 조치하겠습니다.

위 내용을 숙지하고 동의합니다.
          </textarea>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
        </div>
      </div>
    </div>
  </div>
  <script>
    // "전체동의" 체크박스 클릭 시 다른 체크박스도 같은 상태로 변경되도록 설정
    $('#check-all').change(function() {
      $('.form-check-input').prop('checked', $(this).prop('checked'));
    });

    // 다른 체크박스 클릭 시 "전체동의" 체크 상태 갱신
    $('.form-check-input').change(function() {
      if (!$(this).prop('checked')) {
        $('#check-all').prop('checked', false);
      } else {
        if ($('.form-check-input:not(#check-all)').length === $('.form-check-input:checked:not(#check-all)').length) {
          $('#check-all').prop('checked', true);
        }
      }
    });
  </script>

 	<br>
 	<button type="submit" id="pay_btn" onclick="requestPay()">결제하기</button>
</div>
</div>
</body>
</html>