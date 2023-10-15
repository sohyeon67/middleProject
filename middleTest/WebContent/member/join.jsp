<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>캠핑장</title>
<script src="../js/jquery-3.7.1.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="../css/public.css">
<style>
#joinDiv {
	border : 3px solid red;
	margin : 30px auto;
	padding : 0 300px;
	text-align: center;
}

#joinForm {
	margin : 0 auto;
	border : 3px solid blue;
	text-align: left;
	width : 800px;
}

#joinForm * {
	margin : 5px;
}

#pageTitle {
	text-align : center;
	margin-bottom : 50px;
}

#joinForm label {
	width : 100px;
}

#joinForm div input:not(input[type=button], .email, .addr) {
	display: inline-block;
	width : 200px;
}

.email {
	display : inline-block;
	width : 150px;
}

#email_domain {
	width : auto;
}


input[type=button] {
	margin: 5px;
	border-radius: 30px;
}


.ziptr:hover {
	background : crimson;
}

.addr {
	display : inline-block;
	width : 300px;
}

.addr#add1 {
	width : 450px;
}


#bottomBtn {
	margin-top : 50px;
	text-align: center;
}

#bottomBtn * {
	width : 150px;
}

</style>
<script>
$(function() {
	
	// 아이디 중복검사 버튼 클릭
	$('input[value=중복검사]').on('click', function() {
		
		// 입력한 값 가져오기
		idvalue = $('#id').val().trim();
		
		// 값의 형식비교
		idreg = /^[a-z][a-zA-Z0-9]{3,11}$/;	// 4~12자
		if(!(idreg.test(idvalue))) {
			alert("id형식오류 입니다");
			return false;
		}
		
		// 서버로 전송
		$.ajax({
			url : "<%= request.getContextPath()%>/IdCheck.do",
			data : { "id" : idvalue },
			type : 'get',
			success : function(res) {
				$('#idcheck').text(res.flag).css('color', 'red');
			},
			error : function(xhr) {
				alert("상태 : " + xhr.status);
			},
			dataType : 'json'
		})
	});

	// 
	$('#id').on('keyup', function() {
		$('#idcheck').text("");
	});
	
	// 비밀번호 일치 여부 확인
	$('#pwdconfirm').on('keyup', function() {
		vpwd = $('#pwd').val();
		vpwdconfirm = $('#pwdconfirm').val();

		if (vpwd === vpwdconfirm && vpwd.length > 0 && vpwdconfirm.length > 0) {
			$('#pwdcheck').text('비밀번호가 일치합니다.').css('color', 'gray');
		} else {
			$('#pwdcheck').text('비밀번호가 일치하지 않습니다.').css('color', 'red');
		}
	});
	
	// 이메일 입력
	$('#email_domain').on('change', function() {
		vdomain = $('#email_domain option:selected').val();
		
		if(vdomain == "direct") {	// 직접 입력하기
			$('#email2').val("");
			$('#email2').removeAttr('readonly');
		} else {
			$('#email2').val(vdomain);
			$('#email2').attr('readonly', 'readonly');
		}
	})
	
	// 주소 모달에서 확인버튼을 눌렀을 때
	$('#search_zip').on('click', function(){
		dongvalue = $('#dong').val().trim();
		console.log(dongvalue);
		
		if(dongvalue.length < 1) {
			alert("동이름 입력");
			return false;
		}
		
		dongreg = /^[가-힣]+$/;
		
		if(!(dongreg.test(dongvalue))) {
			alert("형식오류~~");
			return false;
		}
		
		$.ajax({
			url : 'http://localhost/middleTest/SelectByDong.do',
			data : { "dong" : dongvalue },
			type : 'post',
			success : function(res) {
				
				code = "<table class='table table-hover' id='ziptb'>";
				code += "<tr><th>우편번호</th><th>주소</th><th>번지</th></tr>";
				$.each(res, function(i, v) {
					
					bunji = v.bunji;
					if(typeof bunji == "undefined") bunji = "";
					
					code += `<tr class="ziptr"><td>${v.zipcode}</td>`;
					code += `<td>${v.sido} ${v.gugun} ${v.dong}</td>`;
					code += `<td>${bunji}</td><tr>`;
				})
				code += "</table>";
				
				$('#result1').html(code);
				
			},
			error : function(xhr) {
				alert("상태 : " + xhr.status);
			},
			dataType : 'json'
		}) // ajax	
		
	});
	
	// 우편번호 검색 결과에서 한 행을 선택하면
	$(document).on('click', '.ziptr', function() {
		zipcode = $('td:eq(0)', this).text();
		add1 = $('td:eq(1)', this).text();
				
		$('#zip').val(zipcode);
		$('#add1').val(add1);

		$('#dong').val("");
		$('#result1').empty();
		$('#myModal').modal('hide');
	})
	
	
	
	// 가입하기
	// submit버튼이 아니고 type=button일 경우
	$('button[type=button]').on('click', function() {
		
		if($(idcheck).text() == "") {
			alert("ID 중복검사는 필수입니다.");
			return false;
		}
		
		// input type="hidden"에 값 지정해주기 name이 mem_mail, mem_addr
		hiddenValues = {
				mem_mail: $('#email1').val() + "@" + $('#email2').val(),
				mem_addr: $('#add1').val() + " " + $('#add2').val()
		};
		
		$('input[type=hidden]').each(function() {
			vname = $(this).attr('name');	// mem_mail, mem_addr
			if (hiddenValues.hasOwnProperty(vname)) {
				$(this).val(hiddenValues[vname]);
			}
		});
		
		
		// name 속성을 이용하여 자동으로 만들기 - test console
		sv = $('form').serialize();
		vdata = $('form').serializeArray();
		console.log(sv);
		console.log(vdata);
		
		$.ajax({
			url : "<%= request.getContextPath()%>/Insert.do",
			data : vdata,
			type : 'post',
			success : function(res) {
				alert(res.sw);
				if(res.join == "완료") {
					location.href="http://www.naver.com";	// 서블릿으로 보내거나?
				}
			},
			error : function(xhr) {
				alert("상태 : " + xhr.status);
			},
			dataType : 'json'
		})
	})
	
})
</script>
</head>
<body>


<div id="joinDiv">
  <form id="joinForm">
    <h2 id="pageTitle">회원가입</h2>
    <div>
      <label for="id">아이디</label>
      <input type="text" class="form-control" id="id" name="mem_id">
      <input type="button" value="중복검사" class="btn btn-success btn-sm">
      <span id="idcheck"></span>
    </div>
    
    <div>
      <label for="pwd">비밀번호</label>
      <input type="password" class="form-control" id="pwd" name="mem_pass">
    </div>
    
    <div>
      <label for="pwdconfirm">비밀번호 확인</label>
      <input type="password" class="form-control" id="pwdconfirm">
      <span id="pwdcheck"></span>
    </div>
  
    <div>
      <label for="name">이름</label>
      <input type="text" class="form-control" id="name" name="mem_name">
    </div>
      
    <div>
      <label for="bir">생년월일</label>
      <input type="date" class="form-control" id="bir" name="mem_bir">
    </div>
    
    <div>
      <label for="hp">전화번호</label>
      <input type="text" class="form-control" id="hp" name="mem_hp">
    </div>
    
    <div>
      <label for="email1">이메일</label>
      <input type="text" class="form-control email" id="email1">@
      <input type="text" class="form-control email" id="email2">
      <select id="email_domain" class="form-select email">
      	<option value="naver.com">naver.com</option>
      	<option value="hanmail.net">hanmail.net</option>
      	<option value="gmail.com">gmail.com</option>
      	<option value="nate.com">nate.com</option>
      	<option value="direct" selected>직접 입력하기</option>
      </select>
      <input type="hidden" name="mem_mail">
    </div>
    
    <div>
      <label for="zip">우편번호</label>
      <input type="text" class="form-control" id="zip" name="mem_zip">
      <input type="button" value="우편번호 찾기" class="btn btn-success btn-sm" data-bs-toggle="modal" data-bs-target="#myModal">
    </div>
    
    <div>
      <label for="add1">주소</label>
      <input type="text" class="form-control addr" id="add1">
    </div>
    
    <div>
      <label for="add2">상세주소</label>
      <input type="text" class="form-control addr" id="add2">
    </div>
    <input type="hidden" name="mem_addr">
    
  
	<div id="bottomBtn">
	  <button type="button" class="btn btn-primary btn-lg">회원가입</button>
      <button type="reset" class="btn btn-primary btn-lg">초기화</button>
	</div>
    
  </form>
</div>
  



<!-- 우편번호 Modal -->
<div class="modal fade" id="myModal">
  <div class="modal-dialog modal-dialog-scrollable modal-lg">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">우편번호 찾기</h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
        <p>찾는 동이름을 입력하세요</p>
		<input type="text" id="dong">
		<input type="button" value="검색" id="search_zip">
		<br><br>
		<div id="result1"></div>
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
      </div>

    </div>
  </div>
</div>

</body>
</html>