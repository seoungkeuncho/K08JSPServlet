<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration02.html</title>
    <link rel="stylesheet" href="../Common/style.css">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script>
    $( function() {
        //라디오를 버튼모양으로 바꿔주는 jQuery UI
        $("input[type=radio]").checkboxradio({
            icon: false
        });
        //날짜선택을 편리하게 - Date Picker
        $("#birthday").datepicker({
            dateFormat : "yy-mm-dd",
            showOn: "both",
            buttonImage: "../images/pick.jpg",
            buttonImageOnly: true,
        });    
        $('img.ui-datepicker-trigger').css({'position':'relative','top':'11px','width':'33px','marginTop':'-5px'});
    } );
    </script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>
    function zipcodeFind(){
        new daum.Postcode({
            oncomplete: function(data) {
                //DAUM 우편번호API가 전달해주는 값을 콘솔에 출력
                console.log("zonecode", data.zonecode);
                console.log("address", data.address);
                //회원 가입폼에 적용
                var f = document.registFrm;//<form>태그의 DOM객체를 변수에 저장
                f.zipcode.value = data.zonecode;
                f.address1.value = data.address;
                f.address2.focus();
            }
        }).open();
    }
    </script>
    <script>
    function registValdidate(form){
   	
   
    	 if(form.userid.value==""){
    		alert("아이디 입력해주세요.");
    		form.userid.foucus();
    		return false;
    	}
    	 if(!form.pass1.value || !form.pass2.value){
    		alert("패스워드를  입력해주세요.");
    		return false;
    	} 
    	  if(form.pass1.value != form.pass2.value){
    	        alert("입력한 패스워드가 일치하지 않습니다.");
    	        //기존에 입력된 비밀번호를 지워준다. value에 빈값을 지정하면 된다. 
    	        form.pass1.value=""; 
    	        form.pass2.value=""; 
    	        form.pass1.focus();
    	        return false;
    	    }
    	if(form.name.value==""){
    		alert("이름 입력해주세요.");
    		form.name.focus();
    		return false;
    	}  
    	 var isGender = false;
        //라디오의 갯수만큼 반복한다. 
        for(var i=0 ; i<form.gender.length ; i++){
            //체크된 항목이 있는지 확인해서..
            if(form.gender[i].checked==true){
                //있다면 true로 값을 변경한다. 
                isGender = true;
                //radio는 하나만 선택할 수 있으므로 확인되면 즉시 탈출한다. 
                break;
            }
        }
    	 if(isGender != true){
    	        alert("성별을 선택해 주세요");
    	        //라디오는 여러항목이 있으므로 focus()를 사용시 인덱스를 명시해야한다. 
    	        form.gender[0].focus();
    	        return false;
    	    } 
    	if(form.birthday.value==""){
    		alert("생년월일 입력해주세요.");
    		form.birthday.focus();
    		return false;
    	}
    	if(form.zipcode.value==""){
    		alert("주소 입력해주세요.");
    		form.zipcode.focus();
    		return false;
    	}
    	 if(!form.email1.value || !form.email2.value){
     		alert("이메일  입력해주세요.");
     		form.email1.focus();
     		return false;
     	} 
    	 if(!form.mobile1.value || !form.mobile2.value || !form.mobile3.value){
      		alert("휴대폰번호  입력해주세요.");
      		form.mobile1.focus();
      		return false;
      	} 
   
    }
function idCheck(form){
    	//alert("아이디 중복체크는 하지않습니다.");
    	if(form.userid.value==""){
    		alert("아이디 중복체크는 하지않습니다.");
    		form.userid.foucus();
    		return;
    	} 
}
    	
    
 /* function inputEmail(form){
	  $("form.email_domain").change(function(){
		  consol.log("form.email_domain");
		  var value= $(this).val();
          console.log("선택한값 ",value);
          if(value==""){
              //읽기 전용 속성을 부여하고, 기존에 입력된 값을 지운다.
              $('input[name=email2]').attr('readonly',true);
              $('input[name=email2]').val('');
          }
          //직접입력을 선택했을때
          else if(value == 'direct'){
              //직접입력해야 하므로 읽기 전용 속성은 해제하고, 기존 입력값을 지운다.
              $('input[name=email2]').attr('readonly',false);
              $('input[name=email2]').val('');
              
          }
          else{
              //선택한 값으로 입력되야 하므로 읽기전용 속성은 활성화한다.
             $('input[name=email2]').attr('readonly',true);
              //<select>에서 선택한값을 입력한다.
              $('input[name=email2]').val(value);
              
          }

      });
  });  */
    
   $(function(){
        //이메일 선택시 입력하기
        $('.s01').change(function(){
            //<select> 태그에서 선택한 <option>의 value를 가져올때 두가지 방법으로 모두 사용가능함.
            // var value = $(this).val();
            var value= $(this).val();
            console.log("선택한값 ",value);
            if(value==""){
                //읽기 전용 속성을 부여하고, 기존에 입력된 값을 지운다.
                $('input[name=email2]').attr('readonly',true);
                $('input[name=email2]').val('');
            }
            //직접입력을 선택했을때
            else if(value == 'direct'){
                //직접입력해야 하므로 읽기 전용 속성은 해제하고, 기존 입력값을 지운다.
                $('input[name=email2]').attr('readonly',false);
                $('input[name=email2]').val('');
                
            }
            else{
                //선택한 값으로 입력되야 하므로 읽기전용 속성은 활성화한다.
               $('input[name=email2]').attr('readonly',true);
                //<select>에서 선택한값을 입력한다.
                $('input[name=email2]').val(value);
                
            }

        });
    });  
    function commonFocusMove(obj, charLen, nextObj){
    	//alert("글자수 "+charLen+"이 되면 "+nextObj+"으로 포커스가 이동합니다.");
    		
           //입력한 값의 글자수를 확인한다. 
           var strLen = obj.value.length;
           //글자수가 6글자라면 포커스를 두번째자리로 이동한다. 
           if(strLen==charLen){
        	   document.getElementsByName(nextObj)[0].focus();
           }
       }
    </script>
</head>
<body>
<form action="registProcess.jsp" method="post" name="registFrm" onsubmit="return registValdidate(this)">
<div class="AllWrap">
    <div class="wrap_regiform">
        <p>*필수입력사항</p>
        <table class="regi_table">
            <colgroup>
                <col width="180px">
                <col width="*">
            </colgroup>
            <tr>
                <td><span class="red">*</span> 아이디</td>
                <td>
                    <input type="text" class="w01" name="userid" value="" />       
                    <button type="button" onclick="idCheck(this.form);">중복확인</button>             
                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <span class="comment">※ 8~16자의 영문과 숫자만 가능합니다.</span>                
                </td>
            </tr>
            <tr>
                <td><span class="red">*</span> 비밀번호</td>
                <td>
                    <input type="password" class="w01" name="pass1" value="" />                   
                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <span class="comment">
                        ※ 영문/숫자/특수문자 조합 6~20자 이상 입력해주세요.
                    </span>
                </td>
            </tr>
            <tr>
                <td><span class="red">*</span> 비밀번호확인</td>
                <td>
                    <input type="password" class="w01" name="pass2" value="" />
                </td>
            </tr>
            <tr>
                <td><span class="red">*</span> 이름</td>
                <td>
                    <input type="text" class="w01" name="name" value="" />
                    
                    <label for="radio-1">남</label>
                    <input type="radio" name="gender" id="radio-1" value="남" >
                    <label for="radio-2">여</label>
                    <input type="radio" name="gender" id="radio-2" value="여">
                    
                </td>
            </tr>
            <tr>
                <td><span class="red">*</span> 생년월일</td>
                <td style="padding: 0px 0 5px 5px;">
                    <input type="text" class="w02" name="birthday" id="birthday" value="" />
                    <!-- <img src="./images/pick.jpg" id="pick" class="pick" /> -->
                </td>
            </tr>
            <tr>
                <td><span class="red">*</span> 주소</td>
                <td>
                    <input type="text" class="w03" name="zipcode" value="" />
                    <button type="button" onclick="zipcodeFind();">우편번호찾기</button> 
                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <input type="text" class="w04" name="address1" value="" />                
                    <input type="text" class="w04" name="address2" value="" />
                </td>
            </tr>
            <tr>
                <td><span class="red">*</span> 이메일</td>
                <td>
                    <input type="text" class="w05" name="email1" value="" />
                    @
                    <input type="text" class="w05" name="email2" value="" />
                    <select name="email_domain" class="s01" onchange="inputEmail(this.form);">
                        <option value="">직접입력</option>
                        <option value="naver.com">naver.com</option>
                        <option value="hanmail.net">hanmail.net</option>
                        <option value="gmail.com">gmail.com</option>
                    </select>
                </td>
            </tr>
           <script>
        
          
           </script>
            <tr>
                <td><span class="red">*</span> 휴대폰번호</td>
                <td>
                    <select name="mobile1" class="s02" onchange="commonFocusMove(this, 3, 'mobile2');">
                        <option value=""></option>
						<option value="010">010</option>
                        <option value="011">011</option>
                        <option value="016">016</option>
                        <option value="017">017</option>
                        <option value="018">018</option>
                        <option value="019">019</option>
                    </select>
                    -
                    <input type="text" class="w06" name="mobile2" maxlength="4" 
                        value="" onkeyup="commonFocusMove(this, 4, 'mobile3');" />
                    -
                    <input type="text" class="w06" name="mobile3" maxlength="4" 
                        value="" onkeyup="commonFocusMove(this, 4, 'tel1');" />
                </td>
            </tr>
          
            
            <tr>
                <td>전화번호</td>
                <td>
                    <select name="tel1" class="s02" onchange="commonFocusMove(this, 3, 'tel2');">
                        <option value=""></option>
						<option value="02">02</option>                        
                        <option value="031">031</option>
						<option value="032">032</option>
						<option value="033">033</option>
                    </select>
                    -
                    <input type="text" class="w06" name="tel2" maxlength="4" value="" onkeyup="commonFocusMove(this, 4, 'tel3');" />
                    -
                    <input type="text" class="w06" name="tel3" maxlength="4" value="" />
                </td>
            </tr>
            
        </table>
        <div style="text-align: center; margin-top:10px;">
            <button type="submit" class="btn_search">회원가입</button>
            <button type="reset" class="btn_search">다시쓰기</button>
        </div>
    </div>
</div>
</form>
</body>
</html>