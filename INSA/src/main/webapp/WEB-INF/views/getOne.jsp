<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>수정 페이지</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> 

<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">


<script type="text/javascript">

	$(document).ready(function (){
		
//		loadCommonCode();
		

	
		$('#delete').click(function(){
			var theSabun = $('#sabun').val();
			//form 동적 생성
			var form = document.createElement("form");
		  	form.setAttribute("charset", "UTF-8");
		    form.setAttribute("method", "Post");  //Post 방식
		    form.setAttribute("action", "del"); //요청 보낼 주소
	
		    var hiddenField = document.createElement("input");
		    hiddenField.setAttribute("type", "hidden");
		    hiddenField.setAttribute("name", "pickSabun");
		    hiddenField.setAttribute("value", theSabun);
		    form.appendChild(hiddenField);
		         
		    document.body.appendChild(form);
		    form.submit();
			alert("사번 "+$('#sabun').val()+" 삭제하겠습니다.."); 
			var thisForm = document.modi_Form;
			thisForm.method="post";
			thisForm.action="del";
			thisForm.submit();
			
		});
		
		$('#forward').click(function(){
			location.href="/insaList";
		});
		
		//input을 datepicker로 선언
        $("#join_day, #retire_day, .datepicker").datepicker({
            dateFormat: 'yy-mm-dd' //Input Display Format 변경
            ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
            ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
            ,changeYear: true //콤보박스에서 년 선택 가능
            ,changeMonth: true //콤보박스에서 월 선택 가능                
            ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
            ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
            ,buttonImageOnly: true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
            ,buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
            ,yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
            ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
            ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
            ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
            ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
//            ,minDate: "-1M" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
//            ,maxDate: "+1M" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)                
        });                    
        
        //초기값을 오늘 날짜로 설정
        $("#join_day, #retire_day, .datepicker").datepicker(); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)            
  		
      
   		$("#join_day").change(function(){
   			 if($("#join_day").val().trim()==""){
   				 $("#retire_day").attr("disabled", true);
   			 }else{
   				 $("#retire_day").attr("disabled",false);
   			 }
   		 });
        
   		$('#update').click(function(){
   			console.log("업데이트 실행");
   			var flag=true;
			var strNames="";
			var flagForFirstFocus=true;
			$('.necessary').each(function(index, item) {				//필수항목들 확인( each() 반복문 )
				if(item.value!=null && item.value!="" ){	//만약 만족한다면 넘어간다.
				}else{														//아니면 flag=false를 통해 ajax실행x 
					flag=false;
					if(flagForFirstFocus){
						item.focus();
						flagForFirstFocus=false;								
					}
					strNames+=" * "+item.title+"\n";
				}
			});
			console.log("necessary클래스 미입력\n"+strNames);
			console.log("비번재입력확인 : "+document.modi_Form.passwordCheck.value);
			if(flag && $("#passwordCheck").val()){
				console.log("수정::: ajax 실행한다.");
 				$.ajax({
//					headers: { 
//						 'Accept': 'application/json',
//					     'Content-Type': 'application/json' 
//				    },
	 				url:"update",
					type:"post",
//					dataType : 'json',
					data:JSON.stringify($('#modi_Form').serializeObject()), //$('#inputForm').serializeObject()),
					contentType: 'application/json;charset=UTF-8' ,

//					traditional:true,
						
				        //Ajax 성공시
					success : function(data){
						alert("수정성공");
						console.log("수정성공", data);
						return;
				        //Ajax 실패시
				    },error : function(status, error,request, data){
				    	console.log("수정실패\n"+status+"\n"+error+"\n"+request.responseText+"\n"+request.status+"\n////////");
				    	console.log($('#modi_Form').serializeObject());
				    	console.log(objToJson($('#modi_Form').serializeArray()));
				    	console.log($('#modi_Form').serializeArray());
				    }
					
				});
			}else{
				alert("***********필수항목 미입력***********\n"+strNames+"\n+++++++++++필수값을 입력해주세요.+++++++++++");
			}
		});
	
 /*   		$('#update').click(function(){
			console.log("업데이트 클릭");
			
			alert("업데이트 클릭");
			var flag=true;
			$('.necessary').each(function(index) {
				if(($(this).val()!=null && $(this).val()!="" )&& flag){
				}else{
					flag=false;
					alert("false");
				}
			
			});
			
			if(flag){
				var formObj = document.modi_Form;
				formObj.action="update";
				formObj.method="post";
				formObj.submit();
			}else{
				alert("필수값을 입력해주세요.");
			}
		}); */
	
	
		//퇴사일 입력시, 퇴사처리
		$('#retire_day').change(function(){
			console.log("retire_day 변경");
			if($('#retire_day').val().trim()==""){
				$('#join_gbn_code').val(1);		//입사중
				console.log("retire_day 변경 :::: 입사중");
			}else{
				$('#join_gbn_code').val(0);		//퇴사중
				console.log("retire_day 변경 :::: 퇴사");
			}
		});
		
		//비밀번호 수정
		$("#pwd").focus(function(){
			$("#pwd").val("");
			$("#repwd").attr("disabled", false);
			$("#passwordCheck.value").val(false);
		});
		$("#pwd").blur(function(){
			$("#repwd").focus();
		});
		//비밀번호 확인
		$("#repwd").blur(function(){
			var password = $("#pwd").val();
			var repass = $("#repwd").val();
			if(password != repass){
				alert("비밀번호를 다시 입력해주세요");
				$("#passwordCheck.value").val(false);
				repass="";
			}else{
				$("#passwordCheck.value").val(true);;
			}
		});
		
		//이메일주소 만들기
			$('#email_1, #email_2').change(function(){
				var email = $('#email_1').val() + $('#email_2').val();
				$('#email').val(email);
			});
		
		
		$("#mil_yn").change(function(){
			var milYN = $(this).val();
			if(milYN==1){
				$(".mil").show();
//				$("#mil_startdate").show();
//				$("#mil_enddate").show();
			} else{
				$(".mil").hide();
//				$("#mil_startdate").hide();
//				$("#mil_enddate").hide();
			}
		});
		
		$('#phone').change(function(){
			if($('#phone').val()==formatPhone($('#phone').val())){
				alert("올바른 전화번호를 넣어주세요");
				$('#phone').val("");
				$('#phone').focus();
			}else{
				$('#phone').val(formatPhone($('#phone').val()));
			}
		});
		$('#hp').change(function(){
			if($('#hp').val()==formatMobile($('#hp').val())){
				alert("올바른 핸드폰번호를 넣어주세요");
				$('#hp').val("");
				$('#hp').focus();
			}else{
				$('#hp').val(formatMobile($('#hp').val()));
			}
		});
		
		
		//파일 저장+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
		$('#profile_image, #cmp_reg, #resume').change(function() {
	        var formData = new FormData($("#modi_Form")[0]);
	        formData.append("fileUploadFor",$(this).attr("name"));
	        
	        console.log($(this).attr("name"));
	        
	        $.ajax({
	            type : 'post',
	            url : 'filesave',
	            data : formData,
	            processData : false,
	            contentType : false,
	            
	            success : function(data) {
	                alert("파일을 업로드하였습니다.");
	                console.log("업로드한 파일 경로 : "+data);
	                pathSaving(data);
	               	return data;
	            },
	            error : function(data,error) {
	                alert("파일 업로드에 실패하였습니다.");
	                alert(data);
	                console.log(error);
	                console.log(error.status);
	                return;
	            }
            });
        });
		
		$('#salaryShow').blur(function(){
			console.log("변경전 콤마값 ::::::::"+$('#salaryShow').val());
			$('#salary').val(uncomma($('#salaryShow').val()))
			console.log("변경후 숫자값:::::::"+$('#salary').val());
		});
		
	});
	
	$("#id").keyup(function(event){
		if (!(event.keyCode >=37 && event.keyCode<=40)) {
		var inputVal = $(this).val();
		$(this).val(inputVal.replace(/[^a-z0-9]/gi,''));
		}
		});

	
///////////////////////////////////////+++++document.ready+++++++++/////////////////////////////////////
	//파일경로값 저장
	function pathSaving(data){
		if(data.indexOf("pic")>0){
			console.log("pathSaving:::profile_image_name:::"+data);
			$('#profile_image_name').val(data);
			console.log("pathSaving:::$('#profile_image_name').val():::"+$('#profile_image_name').val());
		}else if(data.indexOf("resume")>0){
			$('#resume_file').val(data);
			showFileName($('#resume_file_lbl'), data);
		}else{
			$('#cmp_reg_imagefile').val(data);
			showFileName($('#cmp_reg_imagefile_lbl'), data);
		}
	}
	function showFileName(obj, path){
		console.log("showFileName / obj.id:::"+obj.attr("id"));
		var fileName = path.substring(path.lastIndexOf("/")+1);
		console.log("showFileName:::"+fileName);
		obj.text(fileName);
	}
	
	//json타입으로 바꾸기
	jQuery.fn.serializeObject = function() {
		var obj = null;
		try {
			if(this[0].tagName && this[0].tagName.toUpperCase() == "FORM" ) {
				var arr = this.serializeArray();
				if(arr){ 
					obj = {};
					jQuery.each(arr, function() {
						obj[this.name] = this.value; 
					}); 
				} 
			} 
		}catch(e) {
			alert(e.message);
		}finally { } 
		return obj;
	}

	//Object를 json타입으로 변환
	function objToJson(formData){
		var data = formData;
		var obj = {};
		$.each(data, function(idx, ele){
		obj[ele.name] = ele.value;
		});
		return obj;
	}
	
	function showMember(){
		$('#profile_image_name').val("${oneMember.profile_image_name}")
		if("${oneMember.profile_image_name}"==null || "${oneMember.profile_image_name}"==""){
		}else{
			$('#picture').attr("src", "resources/image/"+"${oneMember.profile_image_name}")
		}
		$('#sabun').val("${oneMember.sabun}");
		$('#name').val("${oneMember.name}");
		$('#eng_name').val("${oneMember.eng_name}");
		$('#id').val("${oneMember.id}");
		$('#pwd').val("${oneMember.pwd}");
		$('#phone').val("${oneMember.phone}");
		$('#hp').val("${oneMember.hp}");
		$('#reg_no').val("${oneMember.reg_no}");
		$('#age').val("${oneMember.age}");
		$('#email').val("${oneMember.email}");
		//이메일 나눠서 보여주기
		var email="${oneMember.email}";
		var email_1=email.substring(0, email.indexOf("@"));
		$('#email_1').val(email_1);
		var email_2=email.substring(email.indexOf("@"));
		var options = document.modi_Form.email_2.options;
		var flag_options = true;
		var flag_nothing=true;
		for(var i=0 ; i<options.length && flag_options ; i++){
			if(options[i].value==email_2){
				options[i].selected=true;
				flag_options=false;
				flag_nothing=false;
			}
			if(flag_nothing){
				options[options.length-1].selected=true;
			}
		}
/* 		var emailAddr =["naver","nate","google"];
		emailAddr.forEach(function (item,index) {
			if(email.indexOf(item)>-1){
				$('#email_2').val(index);
			}else{
				$('#email_2').val("");
				$('#email_1').val("@"+email+"com");
			}
		
		}); */
		
		$('#sex').val("${oneMember.sex}");
		$('#zip').val("${oneMember.zip}");
		$('#addr1').val("${oneMember.addr1}");
		$('#addr2').val("${oneMember.addr2}");
		$('#pos_gbn_code').val("${oneMember.pos_gbn_code}");
		$('#dept_code').val("${oneMember.dept_code}");
		
		$('#salary').val("${oneMember.salary}");
		$('#salaryShow').val("${oneMember.salary}");
		inputNumberFormat(document.modi_Form.salaryShow);
		
		$('#mil_yn').val("${oneMember.mil_yn}");
		if($('#mil_yn').val()==0){
			$(".mil").hide();
		}
		$('#mil_type').val("${oneMember.mil_type}");
		$('#mil_level').val("${oneMember.mil_level}");
		$('#mil_startdate').val("${oneMember.mil_startdate}");
		$('#mil_enddate').val("${oneMember.mil_enddate}");
		$('#kosa_reg_yn').val("${oneMember.kosa_reg_yn}");
		$('#kosa_class_code').val("${oneMember.kosa_class_code}");
		$('#kosa_class_code').val("${oneMember.kosa_class_code}");
		$('#join_day').val("${oneMember.join_day}");
		$('#retire_day').val("${oneMember.retire_day}");
		$('#join_gbn_code').val("${oneMember.join_gbn_code}");
		
		$('#cmp_name').val("${oneMember.cmp_name}");
		$('#cmp_reg_no').val("${oneMember.cmp_reg_no}");
		
		$('#cmp_reg_imagefile').val("${oneMember.cmp_reg_imagefile}");
		if("${oneMember.cmp_reg_imagefile}"!=null&& "${oneMember.cmp_reg_imagefile}"!=""){
//			var fileName = "${oneMember.cmp_reg_imagefile}".substring(path.lastIndexOf("/")+1);
//			console.log("=======:::"+fileName);
//			$('#cmp_reg_imagefile_lbl').text("${oneMember.cmp_reg_imagefile}".substring(path.lastIndexOf("/")+1));
			showFileName($('#cmp_reg_imagefile_lbl'), "${oneMember.cmp_reg_imagefile}")
		}else{
			$('#cmp_reg_imagefile_lbl').text("파일업로드");
		}
		
		$('#self_intro').val("${oneMember.self_intro}");
		
		$('#resume_file').val("${oneMember.resume_file}");
		if("${oneMember.resume_file}"!=null && "${oneMember.resume_file}"!=""){
			showFileName($('#resume_file_lbl'), "${oneMember.resume_file}")
		}else{
			$('#resume_file_lbl').text("파일업로드");
		}
		
		$('#puy_yn').val("${oneMember.puy_yn}");
		
	}
		
		
		
		
	
	
	//숫자만 들어오기
	function onlyNumber(event){
	    event = event || window.event;
	    var keyID = (event.which) ? event.which : event.keyCode;
	    if ( (keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105) || keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
	        return;
	    else
	        return false;
	}
	function removeChar(event) {
	    event = event || window.event;
	    var keyID = (event.which) ? event.which : event.keyCode;
	    if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ){
	        return;
	    } else {
	        event.target.value = event.target.value.replace(/[^0-9]/g, "");
	    }
	}
	
	//날짜확인
	function compareDate(){
		var thisDate = arguments[0].value;		
		var compare = arguments[1];
		compare_date = document.getElementById(compare).value;
		if(compare_date==""){
			var msg_compareDate;
			if(compare=="join_day"){
				msg_compareDate="입사일";
			}else{
				msg_compareDate="입영일자";
			}
			alert(msg_compareDate+"을(를) 먼저 입력해주세요.");
			compare_date="";	
		}else{
			if(compare_date > thisDate){
				window.alert('일자를 확인해주세요.');
				document.getElementById(arguments[0].id).value='';
			}
		}
	}
	
	function loadCommonCode(){
		$.ajax({
	//		headers: { 
	//			 'Accept': 'application/json',
	//		      'Content-Type': 'application/json' 
	//	    },
			url:"getcommonCode",
			type:"post",
	//		dataType : 'json',
	//		data:{ "commonCodeType" : commonCodeType },
	//		contentType: 'application/json;charset=UTF-8' ,
	
	//		traditional:true,
				
		        //Ajax 성공시
			success : function(data){
				console.log("로딩성공", data);
				console.log("데이타 보기"+data[0].code);
				var commonCode;
				for(var i=0 ; i<data.length ; i++){
					if(data[i].gubun=="AA"){
						document.inputForm.pos_gbn_code.options.add(
								new Option(data[i].name, data[i].code));
					}else if(data[i].gubun=="BB"){
						document.inputForm.dept_code.options.add(
								new Option(data[i].name, data[i].code));
					}else if(data[i].gubun=="MT"){
						document.inputForm.mil_type.options.add(
								new Option(data[i].name, data[i].code));
					}else if(data[i].gubun=="ML"){
						document.inputForm.mil_level.options.add(
								new Option(data[i].name, data[i].code));
					}else if(data[i].gubun=="KS"){
						document.inputForm.kosa_class_code.options.add(
								new Option(data[i].name, data[i].code));
					}else if(data[i].gubun=="CC"){
						document.inputForm.join_gbn_code.options.add(
								new Option(data[i].name, data[i].code));
					}else if(data[i].gubun=="DD"){
						document.inputForm.mil_yn.options.add(
								new Option(data[i].name, data[i].code));
					}else if(data[i].gubun=="GG"){
						document.inputForm.join_type.options.add(
								new Option(data[i].name, data[i].code));
					}else if(data[i].gubun=="HH"){
						document.inputForm.gart_level.options.add(
								new Option(data[i].name, data[i].code));
					}else if(data[i].gubun=="FF"){
						document.inputForm.put_yn.options.add(
								new Option(data[i].name, data[i].code));
					}else if(data[i].gubun=="EE"){
						document.inputForm.kosa_reg_yn.options.add(
								new Option(data[i].name, data[i].code));
					}
				}
				showMember();
				
		        //Ajax 실패시
		    },error : function(status, error,request, data){
		    	console.log("로딩실패\n"+status+"\n"+error+"\n"+request.responseText+"\n"+request.status+"\n////////");
		   		return;
		    }
			
		});
	}
	
	
	/** * 전화번호 포맷으로 변환 * * @param 데이터 */
	function formatPhone(phoneNum){ 
		if(isPhone(phoneNum)) { 
			var rtnNum;
			var regExp =/(02)([0-9]{3,4})([0-9]{4})$/;
			var myArray;
			if(regExp.test(phoneNum)){
				myArray = regExp.exec(phoneNum);
				rtnNum = myArray[1]+'-' + myArray[2]+'-'+myArray[3];
				return rtnNum;
			} else {
				regExp =/(0[3-9]{1}[0-9]{1})([0-9]{3,4})([0-9]{4})$/;
				if(regExp.test(phoneNum)){
					myArray = regExp.exec(phoneNum);
					rtnNum = myArray[1]+'-'+myArray[2]+'-'+myArray[3];
					return rtnNum;
				} else {
					return phoneNum;
				} 
			} 
		} else {
			return phoneNum;
		} 
	}
	
	/** * 핸드폰번호 포맷으로 변환 * * @param 데이터 */
	function formatMobile(phoneNum) {
		if(isMobile(phoneNum)) {
			var rtnNum;
			var regExp =/(01[016789])([1-9]{1}[0-9]{2,3})([0-9]{4})$/;
			var myArray;
			if(regExp.test(phoneNum)){
				myArray = regExp.exec(phoneNum);
				rtnNum = myArray[1]+'-'+myArray[2]+'-'+myArray[3];
				return rtnNum;
			} else {
				return phoneNum;
			} 
		} else {
			return phoneNum;
		}
	}
	/** * 전화번호 형식 체크 * * @param 데이터 */
	function isPhone(phoneNum) {
		//var regExp =/(02|0[3-9]{1}[0-9]{1})[1-9]{1}[0-9]{2,3}[0-9]{4}$/;
		var regExp =/(02)([0-9]{3,4})([0-9]{4})$/;
		var myArray;
		if(regExp.test(phoneNum)){
			myArray = regExp.exec(phoneNum);
			return true; 
		} else {
			regExp =/(0[3-9]{1}[0-9]{1})([0-9]{3,4})([0-9]{4})$/;
			if(regExp.test(phoneNum)){
				myArray = regExp.exec(phoneNum);
				return true;
			} else {
				return false;
			} 
		} 
	}
	/** * 핸드폰번호 형식 체크 * * @param 데이터 */
	function isMobile(phoneNum) {
		var regExp =/(01[016789])([1-9]{1}[0-9]{2,3})([0-9]{4})$/;
		var myArray;
		if(regExp.test(phoneNum)){
			myArray = regExp.exec(phoneNum);
			return true;
		} else {
				return false;
		} 
	}

	
//	[출처] input text 숫자 입력시 자동으로 콤마(,) 입력하기|작성자 마요네즈
	function inputNumberFormat(obj) { 
		    console.log("원래 salary:::::::"+obj.value);
		    obj.value = comma(uncomma(obj.value)); 
	} 
	function comma(str) { 
	    str = String(str); 
	    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,'); 
	} 
	function uncomma(str) { 
	    str = String(str); 
	    return str.replace(/[^\d]+/g, ''); 
	}

	
/* 	// ---------------------------미리보기 이미지 팝업창 ------------------------
	function go(img){
	   var img,x,y,x1,y1
	      if (img.length < 1) {
	            alert(" 이미지 파일이 선택되지 않았거나 \n\n 잘못된 파일이름 입니다 ")
	            document.registform.attachFile.focus();
	            return false;
	   } 
	   aa=LoadImg(img);
	   x= aa.wd;
	   y= aa.ht;
	          x1=500;
	          y1=400; 
	       if (x<x1) { 
	          x1=x;
	       }
	       if (y<y1) {
	          y1=y;
	       }
	    window.open('pop.jsp?'+img,'','width='+x1+',height='+y1+',top=100,left=100,scrollbars=1,resizable=1');  
	}
	//------------------로딩 이미지 크기 알아냄----------------
	function LoadImg(img) {
	 var d=new Object();
	    var imgInfo = new Image(); //이미지 객체를 생성하고
	    imgInfo.src = img; //이미지 주소를 대입한후에,
	 d.wd=imgInfo.width; //이미지의 너비와
	 d.ht=imgInfo.height; //높이를 구한뒤
	 return d; //값을 반환
	} */
	
	
	var imgObj = new Image();
	function showImgWin(imgName) {
		imgObj.src = "resources/image/"+imgName;
		setTimeout("createImgWin(imgObj)", 100);
	}
	function createImgWin(imgObj) {
		if (! imgObj.complete) {
			setTimeout("createImgWin(imgObj)", 100);
			return;
		}
		imageWin = window.open("", "imageWin",
		"width=" + imgObj.width + ",height=" + imgObj.height);
		imageWincument.write("<html><body style='margin:0'>") ;
		imageWincument.write("<img src=\'" + imgObj.src + "\'>") ;
		imageWincument.write("</body><html>") ;
		imageWincument.title = "resources/image/"+imgObj.src;
	}
	
	//사진 미리보기
	function getThumbnailPrivew(input, targetId) {
	    if (input.files && input.files[0]) {
	        var reader = new FileReader();
	        reader.onload = function (e) {
	            var element = windowcument.getElementById(targetId);
	            element.setAttribute("src", e.target.result);
	            console.log("thumbnail:::::::e.target.result::::::::::"+e.target.result);
	            console.log("thumbnail:::::::e.target::::::::::"+e.target);
	        }
	        reader.readAsDataURL(input.files[0]);
	    }
	}
	
//	document.getElementById('file-input').addEventListener('change', readFile, false);

	function readFile(e) {
		var fileData;
		var file = e.target.files[0];
		if (!file) {
			return;
		}
		var reader = new FileReader();
		reader.onload = function(e) {
			eData= e.target.result;
		    // 파일 데이터를 사용할 기능 구현 
		};
		reader.readAsText(file);
	}
	
	function readURL(input) {
        if (input.files && input.files[0]) {
          var reader = new FileReader();
          reader.onload = function(e) {
            $('#picture').attr('src', e.target.result);
          }
          reader.readAsDataURL(input.files[0]);
        }
      }
	
	
	

/////////////////////////////////////////////////////이미지파일 저장 관련//////////////////////////////////////////////////////	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
/* 	$(document).ready(function() {
	    $("#profile_image").on("change", fileChange);
	}); */

	var sel_file;
	function fileChange(e) {
		e.preventDefault();

		var files = e.target.files;
	    var filesArr = Array.prototype.slice.call(files);

	    filesArr.forEach(function(f) {
	        if(!f.type.match("image.*")) {
	            alert("확장자는 이미지 확장자만 가능합니다.");
	            return;
	        }

	        sel_file = f;

	        var reader = new FileReader();
	        reader.onload = function(e) {
	            $("#picture").attr("src", e.target.result);
	        }
	        reader.readAsDataURL(f);
	    });

	    var file = files[0];
	    console.log(file);
	    var formData = new FormData();

	    var formData = new FormData($("#modi_Form")[0]);
	    formData.append("file", file);
	    formData.append("fileUploadFor",$(this).attr("name"));

		$.ajax({
	    	url: 'fileUpload',
			data: formData,
			dataType:'text',
			processData: false,
			contentType: false,
			type: 'POST',
			success: function(data){
				alert("프로필 이미지가 변경 되었습니다.")
			 },
			error : function(data,error) {
                alert("파일 업로드에 실패하였습니다.");
                alert(data);
                console.log(error);
                console.log(error.status);
	       		return;
			}
		});
		
	 	//파일 저장+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
		$('#profile_image, #cmp_reg, #resume').change(function() {

		}
 		function checkImageType(fileName){
 			var pattern = /jpg$|gif$|png$|jpeg$/i;
 			return fileName.match(pattern);
 		}


 		function getOriginalName(fileName){
 			if(checkImageType(fileName)){
 				return;
 			}
 			var idx = fileName.indexOf("_") + 1 ;
 			return fileName.substr(idx);

 		}


 		function getImageLink(fileName){

 			if(!checkImageType(fileName)){
 				return;
 			}
 			var front = fileName.substr(0,12);
 			var end = fileName.substr(14);

 			return front + end;

 		}
	}
	function showPDF(pdfFile){
			window.open("resources/image/"+pdfFile, '_blank', 'fullscreen=yes');
	}


</script>

</head>
<body onload="loadCommonCode()" style="padding: 30px">
	<h1>직원상세정보</h1>
	<form name="modi_Form" id="modi_Form">
	<div style="float: right;" >
		<input type="button" id="update" value="수정" />
		<input type="button" id="delete" value="삭제" />
		<input type="button" id="forward" value="전화면" />
	</div>
	<hr>
		<table>
		<tr>
			<td rowspan="6" align="center">
				<img alt="사진" src="resources/image/user-empty.png" name="picture" id="picture" class="img-circle" width="150px" height="150px">
				<br>
				<input type="file" name="profile_image" id="profile_image" accept=".bmp, .gif, .jpg, .png" onchange="getThumbnailPrivew(this, 'picture');">
				<input type="hidden" name="profile_image_name" id="profile_image_name" >
			</td>
			<td>
				*사번</td>
			<td><input type="text" name="sabun" id="sabun" readonly="readonly" class="necessary" style="background-color:lightgrey"  >
			</td>
			<td>
				*한글성명</td>
			<td><input type="text" title="한글성명" name="name" id="name" class="necessary"  >
			</td>
			<td>
				영문성명
				</td>
			<td>
			<input type="text" name="eng_name" id="eng_name" >
			</td>
		</tr>
		<tr>
			<td>
				*아이디
				</td>
			<td>
			<input type="text" title="아이디" name="id" id="id" class="necessary"  >
			</td>
			<td>
				*비밀번호
				</td>
			<td>
			<input type="password" title="비밀번호" name="pwd" id="pwd" class="necessary"  >
			</td>
			<td>
				*비밀번호 확인
				</td>
			<td>	
				<input type="password" name="repwd" id="repwd" disabled="disabled"/>
				<input type="hidden" name="passwordCheck" id="passwordCheck" value="true" />
			</td>
			<td>
		</tr>
		<tr>
			<td>
				전화번호
			</td>
			<td>
				<input type="text" name="phone" id="phone" onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' >
			</td>
			<td>
				*핸드폰번호
			</td>
			<td>
				<input type="text" title="핸드폰번호" name="hp" id="hp" class="necessary" onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' >
			</td>
			<td>
			주민번호
			</td>
			<td>
				<input type="text" name="reg_no" id="reg_no" >
			</td>
		</tr>
		<tr>
			<td>
				연령
			</td>
			<td>
				<input type="text" name="age" id="age"onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' readonly="readonly"/>
			</td>
			<td>
				*이메일
				</td>
			<td>
				<input type="text" title="이메일" name="email_1" id="email_1" class="necessary" />
				<select name="email_2" id="email_2" class="email" >
					<option value="@naver.com">@naver.com</option>
					<option value="@nate.com">@nate.com</option>
					<option value="@google.com">@google.com</option>
					<option value="">직접입력</option>
				</select>
				<input type="hidden" name="email" id="email" >
			</td>
			<td>
				성별
				</td>
			<td>
				<select name="sex" id="sex" >
					<option value="0">(선택)</option>
					<option value="1">남자</option>
					<option value="2">여자</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>
				주소
			</td>
			<td>
				<input type="text" name="zip" id="zip" placeholder="우편번호" />
			</td>
			<td>
				<input type="text" name="addr1" id="addr1" />
			</td>
			<td>
				<input type="text" name="addr2" id="addr2"/>
			</td>
			<td>
				투입여부
				</td>
			<td>
				<select name="puy_yn" id="puy_yn" >
					<option value="">(선택)</option>
					
				</select>
			</td>
		</tr>
		<tr>
			<td>
				직위
				</td>
			<td>
				<select name="pos_gbn_code" id="pos_gbn_code" >
					<option value="">(선택)</option>
				
				</select>
			</td>
			<td>
				부서
			</td>
			<td>
				<select name="dept_code" id="dept_code">
					<option value="">(선택)</option>
					
				</select>
			</td>
			<td>
				연봉(만원)
			</td>
			<td>
				<input type="text" name="salaryShow" id="salaryShow" placeholder="(만원)" 
					onkeydown='return onlyNumber(event)' 
					onkeyup='removeChar(event), inputNumberFormat(this)' 
					style="text-align: right;">
				<input type="hidden" name="salary" id="salary" >
			</td>
		</tr>
		<tr>
			<td>
			군필여부<select name="mil_yn" id="mil_yn">
					<option value="1" >군필</option>
					<option value="0" selected="selected">미필</option>
				</select>
			</td>
			<td class="mil">
				군별
			</td>
			<td class="mil">
			<select name="mil_type"  class="mil" id="mil_type" >
					<option value="">(선택)</option>
				
				</select>
				계급<select name="mil_level" id="mil_level" class="mil" >
					<option>(선택)</option>
					
				</select>
			</td>
			<td class="mil">
				입영일자
			</td>
			<td class="mil">
				<input type="text" name="mil_startdate" class="datepicker" id="mil_startdate" readonly="readonly">
			</td>
			<td class="mil">
				전역일자
			</td>
			<td class="mil">
				<input type="text" name="mil_enddate" class="datepicker" id="mil_enddate" onchange="compareDate(this, 'mil_startdate')" readonly="readonly" >
			</td>
		</tr>
		<tr>
			<td>
				KOSA등록
			
				<select name="kosa_reg_yn" id="kosa_reg_yn">
					<option value="">(선택)</option>
				</select>
			</td>
			<td>
				KOSA등급
			</td>
			<td>
				<select name="kosa_class_code" id="kosa_class_code">
					<option value="">(선택)</option>
					
				</select>
			</td>
			<td>
				*입사일자
			</td>
			<td>
				<input type="text" title="입영일자" name="join_day" class="necessary" id="join_day" readonly="readonly">
			</td>
			<td>
				퇴사일자
			</td>
			<td>
				<input type="text" name="retire_day" id="retire_day" onchange="compareDate(this, 'join_day')" readonly="readonly" >
				<input type="hidden" name="join_gbn_code" id="join_gbn_code">
			</td>
		</tr>
		<tr>
			<td>
			</td>
			<td>
				업체명
			</td>
			<td>
			<input type="text" name="cmp_name" id="cmp_name">
			</td>
			<td>
				사업자번호
			</td>
			<td>
				<input type="text" name="cmp_reg_no" id="cmp_reg_no" onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)'>
			</td>
			<td>
				사업자등록증
				<input type="file" name="cmp_reg" id="cmp_reg" accept=".bmp, .gif, .jpg, .png" style="display:none;" >
				<label for="cmp_reg" id="cmp_reg_imagefile_lbl" style="border: 2px dotted black; border-radius: 5px; padding: 2px;">파일업로드</label>
				<input type="hidden" name="cmp_reg_imagefile" id="cmp_reg_imagefile" >	
			</td>
			<td>
				<input type="button" name="preview_cmp_reg" id="preview_cmp_reg" class="preview" value="미리보기" onclick="showImgWin(cmp_reg_imagefile.value)" >
			</td>
			<td>
			</td>
		</tr>
		<tr>
			<td>
			</td>
			<td>
				자기소개
			<td colspan="3">
				<textarea name="self_intro" id="self_intro" cols="60" placeholder="100자 내외로 적으시오"></textarea>
			</td>
			<td>
				이력서
				<input type="file" name="resume" id="resume" accept=".pdf" style="display:none;">
				<label for="resume" id="resume_file_lbl" style="border: 2px dotted black; border-radius: 5px; padding: 2px;">파일업로드</label>
				<input type="hidden" name="resume_file" id="resume_file" >
			</td>
			<td>
				<input type="button" name="previewResume" class="preview" value="미리보기" onclick="showPDF(resume_file.value)" >
			</td>
		</tr>
		
		</table>
	</form>
</body>
</html>