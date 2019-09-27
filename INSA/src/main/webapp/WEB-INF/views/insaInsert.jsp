<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>인사 등록</title>
</head>	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> 
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script type="text/javascript">

	$(document).ready(function(){
		console.log("다큐준비");
	});
		$(document).ready(function onload(){		//처음 로딩시 실행
//			var flag_onload = false;
			console.log("onload()실행");
			loadCommonCode();
			
			
				//이름칸 한글만 입력 가능
		 	$("#name").keyup(function(event){
				  regexp = /[a-z0-9]|[ \[\]{}()<>?|`~!@#$%^&*-_+=,.;:\"'\\]/g;
				  v = $(this).val();
				  if( regexp.test(v) ) {
				   alert("한글만입력하세요");
				   $(this).val(v.replace(regexp,''));
				  }
			 });
				
				//영문성명칸 영문만 입력 가능
		 	$("#eng_name").keyup(function(event){
		 		if (!(event.keyCode >=37 && event.keyCode<=40)) {
		 			var inputVal = $(this).val();
		 			$(this).val(inputVal.replace(/[^a-z]/gi,''));
	 			}
			});
			
	
		     //입사일을 기입하면 퇴사일 활성화
		     $("#join_day").change(function(){
				 if($("#join_day").val().trim()==""){
					 $("#retire_day").attr("disabled", true);
				 }else{
					 $("#retire_day").attr("disabled",false);
				 }
			 });
			//재확인 비밀번호
			$("#pwd").focus(function(){
				$("#pwd").val("");
				$("#repwd").attr("disabled", false);
				$("#passwordCheck.value").val(false);
				
			});
		     
			//저장++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
				$('#save').click(function(){
					 existThisMember($('#sabun').val());
					console.log($('#sabun').val());
				});
	
				//초기화시, 다시 사번 받아오기++++++++++++++++++++++++++++++
				$('#reset').click( function(){
					location.href="/reset";
					
		 			$.ajax({
						url:"reset",
						type:"post",
						dataType: "text",
						success : function(data){
							alert("리셋성공");
							console.log(data);
							$('#sabun').val(data);
						},
						error: function(data){
							alert("에러입니다");
						}
					}); 
				});
				
				//전 화면++++++++++++++++++++++++++++++++++
				$('#forward').click(function(){
					location.href="/";
				});
				
				//입사퇴사++++++++++++++++++++++++++++++++++++++++++
				$('#retire_day').change(function(){
					if($('#retire_day').val().trim()==""){
						$('#join_gbn_code').val(1);		//입사중
					}else{
						$('#join_gbn_code').val(0);		//퇴사중
					}
				});
			
				//비밀번호 확인++++++++++++++++++++++++++++++++++++++
				$("#repwd").blur(function(){
					var password = document.inputForm.pwd.value;
					var repass = document.inputForm.repwd.value;
					if(password != repass){
						alert("비밀번호를 똑같이 입력해주세요");
						document.inputForm.passwordCheck.value="false";
						repass="";
					}else{
						document.inputForm.passwordCheck.value="true";
					}
				});
				
				//이메일주소 만들기++++++++++++++++++++++++++++++++++
				$('#email_1, #email_2').blur(function(){
					var email = document.inputForm.email_1.value + document.inputForm.email_2.value;
					document.inputForm.email.value = email;
				});

				//군관련 보이기++++++++++++++++++++++++++++++
				$(".mil").hide();
				$("#mil_yn").change(function(){
					var milYN = $(this).val();
					if(milYN==1){
						$(".mil").show();
//						$("#mil_startdate").show();
//						$("#mil_enddate").show();
					} else{
						$(".mil").hide();
//						$("#mil_startdate").hide();
//						$("#mil_enddate").hide();
					}
				});
				
				//주민번호 확인+++++++++++++++++++++++++++++++++++++++++++++++++++++++
				$("#reg_no").off().on('keyup',function (e) {
					if(e.keyCode==8||e.keyCode==39||e.keyCode==37){
						return false;
					}
				        $("#reg_no").val($("#reg_no").val().replace(/[^0-9]/g,""));
//				        $("#reg_no").checkNum($("#reg_no"), e);
			    	});
					
				$("#reg_no").change(function(){
					var jumin = $("#reg_no");
					var flag_reg_no = false;
					
					if(jumin.val().length!=13 ) {
				   			flag_reg_no=true;
				   			alert("13자리 아님");
					}else{
						var yearsCheck = jumin.val().substring(0,2);
						var genderCheck = jumin.val().substring(6,7);
			   			if(genderCheck=="1" || genderCheck=="2"){
					        //"-" 넣기
			   				var str1 = jumin.val().substring(0,6);
					        var str2 = jumin.val().substring(6,jumin.val().length);
					        $("#reg_no").val(str1+'-'+str2);
					       //성별 계산
					        if(genderCheck=="1"){
					        	$("#sex").val("1");
					        }else{
					        	$("#sex").val("2");
					        }
					       //나이계산 
					        var birthday = new Date(yearsCheck);
					        var today = new Date(); 
					        var years = today.getFullYear() - birthday.getFullYear();
					        $("#years").val(years+1);

					        flag_reg_no=false;
			   			}else{
			   				
			   				flag_reg_no=true;
			   			}
			   		}
					if(flag_reg_no){
						alert("주민등록번호를 정확히 입력해주세요");
			   			$("#reg_no").val("");
			   			$("#reg_no").focus();
			   			flag_reg_no=false;
					}
				});
				//새로 포커스가 올 경우 모두 지우기
				$("#reg_no").focus(function(){
					$("#reg_no").val("");
					$("#years").val("");
					$("#sex").val("0");
				});
				
				
				/* //파일 저장+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
				$('#pic_file, #cmp_reg, #resume').change(function() {
			        var formData = new FormData($("#inputForm")[0]);
			        formData.append("fileUploadFor",$(this).attr("name"));
			        
			        console.log($(this).attr("name"));
			        
			        $.ajax({
			            type : 'post',
			            url : 'filesave',
//			            url : 'filesaveToDB',
			            data : formData,
			            processData : false,
			            contentType : false,
			            
			            success : function(data) {
			                alert("파일을 업로드하였습니다.");
			                console.log("업로드한 파일 이름 : "+data);
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
				
				 */
				$('#phone').change(function(){
					if($('#phone').val()==formatPhone($('#phone').val())){
						alert("전화번호 오류");
						$('#phone').val("");
						$('#phone').focus();
					}else{
						$('#phone').val(formatPhone($('#phone').val()));
					}
				});
				$('#hp').change(function(){
					if($('#hp').val()==formatMobile($('#hp').val())){
						alert("핸드폰번호 오류");
						$('#hp').val("");
						$('#hp').focus();
					}else{
						$('#hp').val(formatMobile($('#hp').val()));
					}
				});
				

				
				$('#salaryShow').blur(function(){
					console.log("변경전 콤마값 ::::::::"+$('#salaryShow').val());
					$('#salary').val(uncomma($('#salaryShow').val()))
					console.log("변경후 숫자값:::::::"+$('#salary').val());
				});
			    
				
				$('#cmp_reg_no').blur(function(){
					var cmp_reg_no = $('#cmp_reg_no').val();
					if(cmp_reg_no.length!=10){
						alert("사업자번호를 잘못입력하였습니다.");
						$('#cmp_reg_no').val("");
					}else if(cmp_reg_no!="" && cmp_reg_no!=null){
						$('#cmp_reg_no').val(company_registration_number(cmp_reg_no));
					}
					
				});
				
		/* 		$('#join_day').blur(function(){
					var date= $('#join_day').val();
					var first = date.indexOf("-");
					var second = date.indexOf(first+1, "-");
					alert("first : "+first+"second::"+second);
					if(first==4 && second==7){
						alert("맞는데");
					}else{
						 if(date.lenght!=8){
							alert("날짜를 올바른 형식으로 입력해주세요\n***YYYY-MM-DD***")
						}else if(date!=null && date!=""){
							$('#join_day').val(calendar_format(date));
						}
						
					}
				}); */
			

				
			
			/* 	<c:set var="theMember" value="${theMember}" />
			<c:choose>
				<c:when test="${theMember != null}">
					flag_onload=true;			
					document.inputForm.sabun.value=${theMember.sabun};
					document.inputForm.name.value=${theMember.name};
					document.inputForm.eng_name.value=${theMember.eng_name};
				
				
				//값 넣기//////////////////////////////////////////////
	 			$.ajax({
			      type: "POST",
			      contentType : 'application/json; charset=utf-8',
			      dataType : 'json',
			      url: "/loadCommonCode",
			      data: JSON.stringify(search), // Note it is important
			      success :function(result) {
			       // do what ever you want with data
			     }
			  	


				</c:when>
				<c:otherwise>
					alert("새아이:"+"${newSabun}");
					document.inputForm.sabun.value="${newSabun}";
				</c:otherwise>
				
			</c:choose>
			});

			if(flag_onload){
				var theMember = "<c:out value='${theMember}' />"
				$('#sabun').val(theMember.getSabun());
				$('#name').val(theMember.getName());
			} 
		*/
		}); 
	//////////////////////////////////////DOCUMENT.READY///////////////////////////////////////////////////	
		
		function existThisMember(sabun){
			console.log("existThisMember의 사번:::"+sabun);
			$.ajax({
				url:"existThisMember",
				type:"post",
				data:{"sabun":sabun},
				
				success:function(data){
					
					console.log("인서트에서 해당 사번이존재하는가?:::"+data);
					
					if(data){
						console.log("existThisMember의 업데이트:::"+data);
						update();
					}else{
						console.log("existThisMember의 세이브:::"+data);
						 save();
					}
				},
				error:function(data, error){
					console.log("existThisMember 에러:::"+error);
				}
				
			});
		}
		
		function save(){
			console.log("세이브:::들어옴");
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
			console.log("비번재입력확인 : "+document.inputForm.passwordCheck.value);
			if(flag && document.inputForm.passwordCheck.value=="true"){
	 			/* var formObj = document.inputForm;
				formObj.action="insaInsert";
				formObj.method="post";
				formObj.submit(); */
	
//					var param = $('#inputForm').serialize();
				$.ajax({
	 			url:"insaInsert",
				type:"post",
//				dataType : 'json',
				data:JSON.stringify($('#inputForm').serializeObject()), //$('#inputForm').serializeObject()),
				contentType: 'application/json;charset=UTF-8' ,
//				traditional:true,		
				//Ajax 성공시
				success : function(data){
					alert("저장성공");
			      //Ajax 실패시
			   	},
			   	error : function(status, error,request, data){
			    	console.log("저장실패\n"+status+"\n"+error+"\n"+request.responseText+"\n"+request.status+"\n////////");
			//    	console.log("저장실패2\n"+data.sabun);
				}
					
			});
		}else{
			alert("***********필수항목 미입력***********\n"+strNames+"\n+++++++++++필수값을 입력해주세요.+++++++++++");
		}
		}
		
		function update(){
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
			console.log("비번재입력확인 : "+document.inputForm.passwordCheck.value);
			console.log("비번재입력확인 : "+$("#passwordCheck").val());
			console.log("flag : "+flag);
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
					data:JSON.stringify($('#inputForm').serializeObject()), //$('#inputForm').serializeObject()),
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
				    	console.log($('#inputForm').serializeObject());
				    	console.log(objToJson($('#inputForm').serializeArray()));
				    	console.log($('#inputForm').serializeArray());
				    }
					
				});
			}else{
				alert("***********필수항목 미입력***********\n"+strNames+"\n+++++++++++필수값을 입력해주세요.+++++++++++");
			}
		}
		//주소 api
		function sample6_execDaumPostcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var addr = ''; // 주소 변수
	                var extraAddr = ''; // 참고항목 변수

	                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    addr = data.roadAddress;
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.jibunAddress;
	                }

	                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	                if(data.userSelectedType === 'R'){
	                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있고, 공동주택일 경우 추가한다.
	                    if(data.buildingName !== '' && data.apartment === 'Y'){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                    if(extraAddr !== ''){
	                        extraAddr = ' (' + extraAddr + ')';
	                    }
	                    // 조합된 참고항목을 해당 필드에 넣는다.
	                    document.getElementById("sample6_extraAddress").value = extraAddr;
	                
	                } else {
	                    document.getElementById("sample6_extraAddress").value = '';
	                }

	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('zip').value = data.zonecode;
	                document.getElementById("addr1").value = addr;
	                // 커서를 상세주소 필드로 이동한다.
	                document.getElementById("addr2").focus();
	            }
	        }).open();
	    }
		//파일경로값 저장
		function pathSaving(data){
			if(data.indexOf("pic")>0){
				$('#pic_file_name').val(data);
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
		//json타입으로 바꾸기1
		jQuery.fn.serializeObject = function() {
			var obj = null;
			try {
				if(this[0].tagName && this[0].tagName.toUpperCase() == "FORM" ) {
					console.log("serializeObject 실행");
					var arr = this.serializeArray();
					console.log(arr);
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
			conlole.log(obj);
		}
		//json타입으로 바꾸기2++++++++++++++++++++++++++++++++++++++++++++++++++확인하기
		function objToJson(formData){
			var data = formData;
			conlole.log(data);
			var obj = {};
			$.each(data, function(idx, ele){
			obj[ele.name] = ele.value;
			});
			return obj;
		}
		
		//사진 미리보기
		function getThumbnailPrivew(input, targetId) {
		    if (input.files && input.files[0]) {
		        var reader = new FileReader();
		        reader.onload = function (e) {
		            var element = windowcument.getElementById(targetId);
		            element.setAttribute("src", e.target.result);
		        }
		        reader.readAsDataURL(input.files[0]);
		    }
		}

		 
		
		
	/*	
	 	function save(){
				var formObj = document.getElementById("inputForm");
				formObj.action="input";
				formObj.method="post";
				formObj.submit();

		}
		
	*/	

		//날짜 확인+++++++++++++++++++++++++++++++++++++++++++++++++++++++
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
		    if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
		        return;
		    else
		        event.target.value = event.target.value.replace(/[^0-9]/g, "");
		}
		
		
		// ---------------------------미리보기 이미지 팝업창 ------------------------
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
		    window.open('pop.htm?'+img,'','width='+x1+',height='+y1+',top=100,left=100,scrollbars=1,resizable=1');  
		}
		//------------------로딩 이미지 크기 알아냄----------------
		function LoadImg(img) {
		 var d=new Object();
		    var imgInfo = new Image(); //이미지 객체를 생성하고
		    imgInfo.src = img; //이미지 주소를 대입한후에,
		 d.wd=imgInfo.width; //이미지의 너비와
		 d.ht=imgInfo.height; //높이를 구한뒤
		 return d; //값을 반환
		}
		
		
		
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
		
		function showPDF(pdfFile){
			window.open("resources/image/"+pdfFile, '_blank', 'fullscreen=yes');
	}	
		
		
	 		
		
	/* 	$(document).ready(function(){
		});
		
		$("#" + id).bind("keyup", function(event) {
		    var regNumber = /^[0-9]*$/;
		    var temp = $("#" + id).val();
		    if(!regNumber.test(temp))
		    {
		        console.log('숫자만 입력하세요');
		        $("#"+id).val(temp.replace(/[^0-9]/g,""));
		    }
		}); */
		
		
		//사업자 번호 형식
		function company_registration_number(reg_num){ 
			var crn_rtn;
			var regExp =/([1-9]{1}[0-9]{2})([0-9]{2})([0-9]{5})$/;
			var myArray;
			myArray = regExp.exec(reg_num);
			rtnNum = myArray[1]+'-' + myArray[2]+'-'+myArray[3];
			return rtnNum;
		}
		
		//달력형식
		function calendar_format(num){ 
			var crn_rtn;
			var regExp =/([1-2]{1}[0-9]{3})([0-1]{1}[0-9]{1})([0-3]{1}[0-9]{1})$/;
			var myArray;
			myArray = regExp.exec(num);
			rtnNum = myArray[1]+'-' + myArray[2]+'-'+myArray[3];
			return rtnNum;
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
		
		
		//처음 로딩
		function loadCommonCode(){
			$.ajax({
//				headers: { 
//					 'Accept': 'application/json',
//				      'Content-Type': 'application/json' 
//			    },
				url:"getcommonCode",
				type:"post",
//				dataType : 'json',
//				data:{ "commonCodeType" : commonCodeType },
//				contentType: 'application/json;charset=UTF-8' ,

//				traditional:true,
					
			        //Ajax 성공시
				success : function(data){
					console.log("로딩성공", data);
					//console.log("데이타 보기"+data[8].code);
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
						}else if(data[i].gubun=="II"){
							document.inputForm.email_2.options.add(
									new Option(data[i].name, data[i].code));
						}
					}
			        //Ajax 실패시
			    },error : function(status, error,request, data){
			    	console.log("로딩실패\n"+status+"\n"+error+"\n"+request.responseText+"\n"+request.status+"\n////////");
			   		return;
			    }
			});
			
			
		}
		
		function imageLoad(){
			//이미지로드		
			//출처: http://webclub.tistory.com/489 [Web Club]
			$.ajax({
				url: 'imageLoad',
				type: 'POST',
				dataType : 'json',
				success : function (data) {
					createImages(data);
					} 
			});
		}

	/* 	function createImages(objImageInfo) {
			var images = objImageInfo.images;
			var strDOM = ""; 
			for (var i = 0; i < images.length; i++) { 
				// N번째 이미지 정보를 구하기
				var image = images[i]; 
				// N번째 이미지 패널을 생성
				
				strDOM += '<div class="image_panel">';
				strDOM += ' '<img src="' + image.url + '">';
				strDOM += ' '<p class="title">' + image.title + ''</p>';
				strDOM += ''</div>';
			} 
			
			// 이미지 컨테이너에 생성한 이미지 패널들을 추가하기 
			var $imageContainer = $("#image_container");
			$imageContainer.append(strDOM);
		}
		*/
	 
	    // 특수문자, 특정문자열(sql예약어의 앞뒤공백포함) 제거
	    function checkSearchedWord(obj) {
	 
	        if (obj != null && obj != "") {
	 
	            //특수문자 제거
	            var expText = /[%=><+!^*]/;
	            if (expText.test(obj) == true) {
	                alert("특수문자를 입력 할수 없습니다.");
	                $("#txt_SearchText").val(obj.replace(expText, ""));
	                return false;
	            }
	 
	            //특정문자열(sql예약어의 앞뒤공백포함) 제거
	            var sqlArray = new Array("AND", "OR", "SELECT", "INSERT", "DELETE", "UPDATE", "CREATE", "ALTER", "DROP", "EXEC", "UNION", "FETCH", "DECLARE", "TRUNCATE", "SHUTDOWN");
	 
	            for (var i = 0; i < sqlArray.length; i++) {
	                if (obj.match(sqlArray[i])) {
	                    alert(sqlArray[i] + "와(과) 같은 특정문자로 검색할 수 없습니다.");
	                    $("#txt_SearchText").val(obj.replace(sqlArray[i], ""));
	                    return false;
	                }
	            }
	        }
	        return true;
	    }
	 

		function inputNumberFormat(obj) { 
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

		
</script>

<head><body style="padding: 30px">

	<div align="right">
	   <h2>IT & BIZ</h2>
	</div>

	<div align="center">
		<h1>인사 관리 시스템</h1>
	</div>
	<h1>직원 등록</h1>
	<form id="inputForm" name="inputForm" action="/insaInsert" method="post">
		<div style="float: right;">
			<!-- <button type="submit" name="save" id="save" value="저장">저장</button> -->
			<input type="button" id="save" name="save" value="저장">
			<input type="reset" id="reset" name="reset" value="초기화">
			<input type="button" id="forward" name="forward" value="전화면">
		</div>
	<hr>
		<table>
			<tr>
				<td rowspan="6" align="center">
					<img alt="사진" src="resources/image/user-empty.png" name="profile_image" id="profile_image" value="1" class="img-circle" width="100px" height="100px"> <!--alt="사진" src="resources/image/user-empty.png"  -->
					<br>
					<input type="text" name="profile_image" id="profile_image" accept=".bmp, .gif, .jpg, .png" onchange="getThumbnailPrivew(this, 'picture');">
					<input type="hidden" name="profile_image_name" id="profile_image_name">
				</td> 
			</tr>
			<tr>
				<td>*사번</td>
				<td>
					<input type="text" name="sabun" id="sabun" value="${newSabun}" class="necessary" style="background-color:lightgrey">
				</td>
				<td>*한글성명</td>
				<td>
					<input type="text" title="한글성명" name="name" id="name" value="한글" class="necessary">
				</td>
				<td>영문성명</td>
				<td>
					<input type="text" name="eng_name" id="eng_name" value="">
				</td>
			</tr>
			<tr>
				<td>*아이디</td>
				<td>
					<input type="text" title="아이디" name="id" id="id" value="123" class="necessary">
				</td>
				<td>*비밀번호</td>
				<td>
					<input type="password" title="비밀번호" name="pwd" id="pwd" class="necessary">
				</td>
				<td>*비밀번호 확인</td>
				<td>	
					<input type="password" name="repwd" id="repwd">
					<input type="hidden" name="passwordCheck" id="passwordCheck" value="false">
				</td>
			</tr>
			<tr>
				<td>전화번호</td>
				<td>
					<input type="text" name="phone" id="phone" onkeydown="return onlyNumber(event)" onkeyup="removeChar(event)" value="">
				</td>
				<td>*핸드폰번호</td>
				<td>
					<input type="text" title="핸드폰번호" name="hp" id="hp" value="01012341234" class="necessary" onkeydown="return onlyNumber(event)" onkeyup="removeChar(event)">
				</td>
				<td>주민번호</td>
				<td>
					<input type="text" name="reg_no" id="reg_no" placeholder="******-*******">
				</td>
			</tr>
			<tr>
				<td>연령</td>
				<td>
					<input type="text" id="years" name="years" value="">
				</td>
				<td>*이메일</td>
				<td>
				<input type="text" title="이메일" name="email_1" id="email_1" class="necessary">
				<select name="email_2" id="email_2" class="email">
					<option value="">(선택)</option>
				</select>
				<input type="hidden" name="email">
			</td>
				<td>성별</td>
				<td>	
					<select name="sex" id="sex">
						<option value="0">(선택)</option>
						<option value="1">남자</option>
						<option value="2">여자</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>주소</td>
				<td>
				<input type="text" id="zip" name="zip" placeholder="우편번호">
				<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기">
				<input type="text" id="addr1" name="addr1" placeholder="주소">
				<input type="text" id="addr2" name="addr2" placeholder="상세주소">
				<input type="text" id="sample6_extraAddress" placeholder="참고항목">
				</td>
			</tr>
			<tr>
				<td>입사구분</td>
			 	<td>
					<select id="put_yn" name="put_yn">
					  <option value="">(선택)</option>
					</select>
					
				</td>
				<td>직위</td>
				<td>
					<select id="pos_gbn_code" name="pos_gbn_code">
					    <option value="">(선택)</option>
					</select>
				</td>
				<td>부서</td>
				<td>
					<select id="dept_code" name="dept_code">
					     <option value="">(선택)</option>
					</select>
				</td>
				<td>직종</td>
				<td>
					<select id="join_gbn_code" name="join_gbn_code">
					     <option value="">(선택)</option>
					</select>
				</td>
				<td>연봉</td>
				<td>
				<input type="text" name="salaryShow" id="salaryShow" placeholder="(만원)" onkeydown="return onlyNumber(event)" onkeyup="removeChar(event), inputNumberFormat(this)" style="text-align: right;">
				<input type="hidden" name="salary" id="salary">
			</td>
			</tr>
			<tr>
				<td>군필여부</td>
				<td>
					<select id="mil_yn" name="mil_yn">
					  <option value="">(선택)</option>
					</select>
				</td>
				<td class="mil">군별</td>
				<td class="mil">
					<select id="mil_type" name="mil_type">
					  <option value="">(선택)</option>
					</select>
					계급
					<select id="mil_level" name="mil_level">
					  <option value="">(선택)</option>
					</select>
				</td>
				<td class="mil">입영일자</td>
				<td class="mil">
					<input type="date" name="mil_startdate" class="datepicker" id="mil_startdate">
				</td>
				<td class="mil">전역일자</td>
				<td class="mil">
					<input type="date" name="mil_enddate" class="datepicker" id="mil_enddate" onchange="compareDate(this, 'mil_startdate')">
				</td>
			</tr>
			<tr>
				<td>
					KOSA등록
					<select id="kosa_reg_yn" name="kosa_reg_yn">
					  <option value="">(선택)</option>
					</select>
				</td>
				<td>KOSA등급</td>
				<td>
					<select id="kosa_class_code" name="kosa_class_code">
					  <option value="">(선택)</option>
					</select>
				</td>
				<td>*입사일자</td>
				<td>
					<input type="date" title="입사일자" name="join_day" class="necessary" id="join_day" value="">
				</td>
				<td>퇴사일자</td>
				<td>
					<input type="date" name="retire_day" id="retire_day" value=""> <!-- onchange="compareDate(this, 'join_day')" disabled="disabled" -->
					
				</td>
				
			</tr>
			<tr>
				<td>업체명</td>
				<td>
					<input type="text" name="crm_name" value="">
				</td>
				<td>등급</td>
				<td>
					<select id="gart_level" name="gart_level">
					  <option value="">(선택)</option>
					</select>
				</td>
				<td>입사여부</td>
				<td>
					<select id="join_type" name="join_type">
					  <option value="">(선택)</option>
					</select>
				</td>
				<td>
					사업자번호
				</td>
				<td>
					<input type="text" name="cmp_reg_no" id="cmp_reg_no" value="" cols="20" onkeydown="return onlyNumber(event)" onkeyup="removeChar(event)">
				</td>
				<td>
					사업자등록증
				</td>
				<td>
					<input type="text" name="cmp_reg" id="cmp_reg"> <!-- accept=".bmp, .gif, .jpg, .png" style="display:none;"  -->
					<!-- <label for="cmp_reg" id="cmp_reg_imagefile_lbl" 
								style="border: 2px dotted black; border-radius: 5px; padding: 2px;">파일업로드</label> -->
					<input type="hidden" name="cmp_reg_image" id="cmp_reg_image">	 
				</td>
				<!-- <td>
					<input type="button" name="preview_cmp_reg" class="preview" value="미리보기" onclick="showImgWin(cmp_reg_imagefile.value)">
				</td> -->
			</tr>
			<tr>
				<td>
					자기소개
				</td><td colspan="3">
					<textarea name="self_intro" id="self_intro" cols="60" placeholder="100자 내외로 적으시오"></textarea>
				</td>
				
				<td>
					이력서
				</td>
				<td>
					<input type="text" name="carrier" id="carrier"> <!--  accept=".pdf" style="display:none;" -->
					<!-- <label for="carrier" id="carrier_image_lbl" 
							style="border: 2px dotted black; border-radius: 5px; padding: 2px;">파일업로드</label> -->
					<input type="hidden" name="carrier_image" id="carrier_image">
				</td>
				<!-- <td>
					<input type="button" name="preview_cmp_reg" class="preview" value="미리보기" onclick="showImgWin(cmp_reg_imagefile.value)">
				</td> -->
			</tr>
		</table>
	</form>
</body></head>

</html>