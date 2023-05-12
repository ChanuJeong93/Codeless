<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.min.js"></script>
<title>상품 등록</title>

<style>
	body {
		background-color: #f2f2f2;
		font-family: Arial, sans-serif;
	}

	h1 {
		color: #000000;
	}

	form {
		background-color: #fff;
		padding: 20px;
		border-radius: 5px;
		box-shadow: 0 2px 5px rgba(0,0,0,0.3);
	}

	input[type="text"], select, textarea {
		display: block;
		width: 100%;
		padding: 12px;
		border: 1px solid #ccc;
		border-radius: 4px;
		box-sizing: border-box;
	}

	input[type="file"] {
		padding: 5px;
		border: none;
		border-bottom: 1px solid #ccc;
	}

	input[type="submit"] {
		display: inline-block;
		margin: 10px;
		padding: 10px 20px;
		background-color: #333;
		color: #fff;
		text-decoration: none;
		border-radius: 4px;
		border: 1px solid #333;
		transition: all 0.3s ease;
	}

	input[type="submit"]:hover {
			background-color: #fff;
			color: #333;
	}

	input[type="radio"], input[type="checkbox"] {
		margin-right: 10px;
	}

	label {
		display: block;
		margin-bottom: 10px;
	}

	.error-message {
		color: red;
		margin-top: 10px;
	}
</style>
<script>
$('document').ready(function() {
	//지역 변수생성
	
	 var area0 = ["시/도 선택","서울특별시","인천광역시","대전광역시","광주광역시","대구광역시","울산광역시","부산광역시","경기도","강원도","충청북도","충청남도","전라북도","전라남도","경상북도","경상남도","제주도"];
	  var area1 = ["강남구","강동구","강북구","강서구","관악구","광진구","구로구","금천구","노원구","도봉구","동대문구","동작구","마포구","서대문구","서초구","성동구","성북구","송파구","양천구","영등포구","용산구","은평구","종로구","중구","중랑구"];
	   var area2 = ["계양구","남구","남동구","동구","부평구","서구","연수구","중구","강화군","옹진군"];
	   var area3 = ["대덕구","동구","서구","유성구","중구"];
	   var area4 = ["광산구","남구","동구",     "북구","서구"];
	   var area5 = ["남구","달서구","동구","북구","서구","수성구","중구","달성군"];
	   var area6 = ["남구","동구","북구","중구","울주군"];
	   var area7 = ["강서구","금정구","남구","동구","동래구","부산진구","북구","사상구","사하구","서구","수영구","연제구","영도구","중구","해운대구","기장군"];
	   var area8 = ["고양시","과천시","광명시","광주시","구리시","군포시","김포시","남양주시","동두천시","부천시","성남시","수원시","시흥시","안산시","안성시","안양시","양주시","오산시","용인시","의왕시","의정부시","이천시","파주시","평택시","포천시","하남시","화성시","가평군","양평군","여주군","연천군"];
	   var area9 = ["강릉시","동해시","삼척시","속초시","원주시","춘천시","태백시","고성군","양구군","양양군","영월군","인제군","정선군","철원군","평창군","홍천군","화천군","횡성군"];
	   var area10 = ["제천시","청주시","충주시","괴산군","단양군","보은군","영동군","옥천군","음성군","증평군","진천군","청원군"];
	   var area11 = ["계룡시","공주시","논산시","보령시","서산시","아산시","천안시","금산군","당진군","부여군","서천군","연기군","예산군","청양군","태안군","홍성군"];
	   var area12 = ["군산시","김제시","남원시","익산시","전주시","정읍시","고창군","무주군","부안군","순창군","완주군","임실군","장수군","진안군"];
	   var area13 = ["광양시","나주시","목포시","순천시","여수시","강진군","고흥군","곡성군","구례군","담양군","무안군","보성군","신안군","영광군","영암군","완도군","장성군","장흥군","진도군","함평군","해남군","화순군"];
	   var area14 = ["경산시","경주시","구미시","김천시","문경시","상주시","안동시","영주시","영천시","포항시","고령군","군위군","봉화군","성주군","영덕군","영양군","예천군","울릉군","울진군","의성군","청도군","청송군","칠곡군"];
	   var area15 = ["거제시","김해시","마산시","밀양시","사천시","양산시","진주시","진해시","창원시","통영시","거창군","고성군","남해군","산청군","의령군","창녕군","하동군","함안군","함양군","합천군"];
	   var area16 = ["서귀포시","제주시","남제주군","북제주군"];

	 

	 // 시/도 선택 박스 초기화

	 $("select[name^=sido]").each(function() {
	  $selsido = $(this);
	  $.each(eval(area0), function() {
	   $selsido.append("<option value='"+this+"'>"+this+"</option>");
	  });
	  $selsido.next().append("<option value=''>구/군 선택</option>");
	 });

	 

	 // 시/도 선택시 구/군 설정

	 $("select[name^=sido]").change(function() {
	  var area = "area"+$("option",$(this)).index($("option:selected",$(this))); // 선택지역의 구군 Array
	  var $gugun = $(this).next(); // 선택영역 군구 객체
	  $("option",$gugun).remove(); // 구군 초기화

	  if(area == "area0")
	   $gugun.append("<option value=''>구/군 선택</option>");
	  else {
	   $.each(eval(area), function() {
	    $gugun.append("<option value='"+this+"'>"+this+"</option>");
	   });
	  }
	 });
	 
	 //특정 브랜드 선택시 모델옵션 변경
	 var apple = ["에어팟 1세대","에어팟 2세대","에어팟 3세대","에어팟프로","에어팟프로 2세대"];
	 var samsung = ["버즈","버즈 플러스","버즈 라이브","버즈 프로","버즈2","버즈2 프로"];
	 
	 //삼성 브랜드 색상
	 var color1=  ["블랙","옐로우","화이트"];
	 var color2 = ["블루","블랙","화이트","레드","핑크"];
	 var color3 = ["미스틱 블랙","미스틱 화이트","미스틱 브론즈","레드","오닉스"];
	 var color4 = ["팬텀 바이올렛","팬텀 블랙","팬텀 실버","팬텀 화이트"];
	 var color5 = ["라벤더","올리브","화이트","그라파이트"];
	 var color6 = ["퍼플","그라파이트","화이트"];
	 
	 $('#brand').change(function () {
		if($('#brand').val() == "1"){
			$('#model option').remove();
			$('#color option').remove();
			$('#model').append("<option value=''>모델명을 선택하세요</option>");
			$('#color').append("<option value=''>색상을 선택하세요</option>");
			$('#color').append("<option value='1'>화이트</option>");			
			$.each(apple,function(idx,model){
			$('#model').append("<option value='"+idx+"'>"+model+"</option>");
			});//애플 모델 
		}else if($('#brand').val() == "2"){
			$('#model option').remove();
			$('#color option').remove();
			$('#model').append("<option value=''>모델명을 선택하세요</option>");
			$('#color').append("<option value=''>색상을 선택하세요</option>");
			$.each(samsung,function(idx,model){
			$('#model').append("<option value='"+idx+"'>"+model+"</option>");
			});//삼성 모델
				 
		}else{
			$('#model option').remove();
			$('#model').append("<option value=''>모델명을 선택하세요</option>");
		}//미선택시
	});//특정 브랜드 선택시 모델옵션 변경
	 
	
	 $('#model').change(function() {
			if($('#brand').val() == "2")  {
			var color = "color"+$("option",$(this)).index($("option:selected",$(this)));
		    $('#color option').remove();
		    $('#color').append("<option value=''>색상을 선택하세요</option>");
		    $.each(eval(color), function() {
			$('#color').append("<option value='"+this+"'>"+this+"</option>");
		    });
		    }
	});//삼성 모델 색상 옵션
	
	
	$('#trade').change(function() {
		if($('#trade').val()=="1"){
			$('#trmsg').hide();
			$('#sido1').show();
			$('#gugun1').show();
		}else{
			$('#trmsg').show();
			$('#trmsg').text(" (직거래만 가능합니다.)");
			$('#sido1').hide();
			$('#gugun1').hide();
		}//택배거래 선택시 지역선택 못하게함
	});

	});//script끝
</script>
</head>
<body>

	<h1>상품 등록</h1>
	<form action="./ProductWriteAction.pr" method="post" >
		<input type="hidden" name="user_id" value="${sessionScope.id}"> <!-- user_id를 hidden으로 전송 -->
		<table>
			<tr>
				<td>판매자:</td> 
				<td>${sessionScope.id}</td> 
			</tr>
			<tr>
				<td>상품 제목:</td>
				<td><input type="text" placeholder="글 제목을 입력하세요" name="title" required></td>
			</tr>
			<tr>
				<td>카테고리:</td>
				<td><select name="" id="brand" class="form-control">
						<option value="">제조사를 선택하세요</option>
						<option value="1">애플</option>
						<option value="2">삼성</option>
				</select></td>
				<td><select name="" id="model" class="form-control" style="">
						<option value="">모델명을 선택하세요</option>
				</select></td>
				<td><select name="" id="color" class="form-control">
						<option value="">색상을 선택하세요</option>
				</select></td>
			</tr>
			<tr>
				<td>상품 부품:</td>
				<td><select name="parts" required>
						<option value="left">좌</option>
						<option value="right">우</option>
						<option value="body">본체</option>
				</select></td>

			</tr>
			<tr>
				<td>상품 내용:</td>
				<td><textarea name="content" placeholder="글 내용을 작성하세요" rows="5"
						cols="30"></textarea></td>
			</tr>
			<tr>
				<td>이미지 업로드 :</td>
				<td><input type="file" name="product_image" ></td>
			</tr>
			<tr>
				<td>상품 가격:</td>
				<td><input type="number" name="price" placeholder="가격을 입력해주세요" required></td>
			</tr>
			<tr>
				<td>상품 등급:</td>
				<td><select name="grade">
						<option value="1">상</option>
						<option value="2">중</option>
						<option value="3">하</option>
				</select></td>
			</tr>
			<tr>
				<td>거래 방식:</td>
				<td><select name="" id="trade" class="form-control">
						<option value="">거래방식을 선택하세요</option>
						<option value="1">직거래</option>
						<option value="2">택배</option>
				</select>
			</tr>
			<tr>
				<td>지역:</td>
				<td><select name="sido1" id="sido1" class="form-control"></select></td>
				<td><select name="gugun1" id="gugun1" class="form-control"></select></td>
			</tr>
			<tr>
				<td>결제방식 :</td>
				<td><input type="radio" name="charge" value="0" />계좌거래</td>
				<td><input type="radio" name="charge" value="1" />안전결제</td>
			</tr>
			<tr>
				<td>배송비 :</td>
				<td><input type="radio" name="fee" value="0" />배송비 포함</td>
				<td><input type="radio" name="fee" value="3000" />배송비 미포함</td>
			</tr>

		</table>
		<input type="submit" value="등록">
	</form>

</body>
</html>