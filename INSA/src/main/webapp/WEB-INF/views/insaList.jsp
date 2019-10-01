<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	
	<title>인사 조회</title>
	
	<div align="right">
    <h2>IT & BIZ</h2>
    </div>
	    	<!-- jQuery UI CSS파일 -->  
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  
		<!-- jQuery 기본 js파일-->
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
		<!-- jQuery UI 라이브러리 js파일 -->
	<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>  

	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script type="text/javascript">

	function resetAll(){
 		var thisForm = arguments[0];
		for(var i=0 ; i<thisForm.length ; i++){
			if(thisForm[i].type!="button"){
				thisForm[i].value="";
				thisForm[i].disabled= false; 
			}
		}
		var list=null;
		makeList(list);
		
	}
		
	//검색
	function send(){
		var selectForm = arguments[0];
		var flagForSend = true;
		var str="";
		for (var idx=0 ; idx<selectForm.elements.length; idx++){				//폼의 모든 elements 가져오기
			if(selectForm.elements[idx].value.trim().length>0 && selectForm.elements[idx].type!="button"){	//값이 있는지 확인
				str += "인풋의 "+selectForm.elements[idx].name+"에 값있음 : "+selectForm.elements[idx].value+"\n";
				flagForSend=false;		//값이 있으면 getList, 값이 없으면 getAll
			}
		}
		console.log(str);
		var getterList;
		if(flagForSend){
			console.log("----------전체불러오기----------");
			ajaxCall_forGetAll();
			
		 	/* selectForm.action="getAll";
			selectForm.method="post";
			selectForm.submit();  */
 
		}else{
			console.log("------------조건불러오기---------");
			ajaxCall_forGetList();
			
 			/* selectForm.action="search";
			selectForm.method="post";
			selectForm.submit();  */

		}
	}
	
	function ajaxCall_forGetAll(){
		console.log("겟페이지:::ajaxCall_forGetAll(thisPage):::");
		$.ajax({
			headers: { 
//				'Accept': 'application/json',
//			    'Content-Type': 'application/json' 
		    },
			url: "getAll",
			type:"post",
//			dataType : 'json',
			data:JSON.stringify($('#selectForm').serializeObject()),
			contentType: 'application/json;charset=UTF-8' ,
	//		traditional:true,
	        //Ajax 성공시
			success : function(data){
				console.log("--------불러오기 성공-------\n DATA : ", data);
	//			console.log("데이타 확인 0번 : "+data[0].sabun);
				if(data.length!=0){
					makeList(data);
				}else{
					makeList(null);
					alert("해당 결과가 없습니다.");
				}
		    },
	        //Ajax 실패시
		    error : function(status, error,request, data){
		    	console.log("불러오기 실패\n"+status+"\n"+error+"\n"+request.responseText+"\n"+request.status+"\n////////");
		   		return;
		    }
		});
	}
	function ajaxCall_forGetList(){
		console.log("겟페이지:::ajaxCall_forGetList:::");
		$.ajax({
			headers: { 
//				'Accept': 'application/json',
//			    'Content-Type': 'application/json' 
		    },
			url: "search",
			type:"post",
//			dataType : 'json',
			data:JSON.stringify($('#selectForm').serializeObject()),
			contentType: 'application/json;charset=UTF-8' ,
	//		traditional:true,
	        //Ajax 성공시
			success : function(data){
				console.log("--------불러오기 성공-------\n DATA : ", data);
	//			console.log("데이타 확인 0번 : "+data[0].sabun);
				if(data.length!=0){
					makeList(data);
				}else{
					makeList(null);
					alert("해당 결과가 없습니다.");
				}
		    },
	        //Ajax 실패시
		    error : function(status, error,request, data){
		    	console.log("불러오기 실패\n"+status+"\n"+error+"\n"+request.responseText+"\n"+request.status+"\n////////");
		   		return;
		    }
		});
	}
	//json타입으로 바꾸기1
	jQuery.fn.serializeObject = function() {
		var obj = null;
		try {
			if(this[0].tagName && this[0].tagName.toUpperCase() == "FORM" ) {
				console.log("getPage:::serializeObject 실행");
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
	}
	
	function makeList(list){
		var html="";
		if( list==null || list.length==0){
			html ="<tr><td colspan=\"9\" align=\"center\">검색된 데이터가 없습니다.</td></tr>";
		}else{
			
			for(var idx=0 ; idx<list.length ; idx++){
				var row = list[idx];
				var join
				console.log("투입여부 : "+row.put_yn);
				
				var strput_yn;
				var strpos_gbn_code;
				if(row.put_yn==1){
					strput_yn="투입";
				}else {
					strput_yn="미투입";
				}
						
			
				console.log("직위 : "+row.pos_gbn_code);
				if(row.pos_gbn_code == null) {
					   strpos_gbn_code = "";
				} 
				if(row.pos_gbn_code=="0001"){
					strpos_gbn_code="사원";
				}else if(row.pos_gbn_code=="0002"){
					strpos_gbn_code="대리";
				}else if(row.pos_gbn_code=="0003"){
					strpos_gbn_code="과장";
				}else if(row.pos_gbn_code=="0004"){
					strpos_gbn_code="차장";
				}else if(row.pos_gbn_code=="0005"){
					strpos_gbn_code="부장";
				}else if(row.pos_gbn_code=="0006"){
					strpos_gbn_code="사장";
				}
				 /* html +="<tr class=\"resultRow\" onclick=\"resultRowClick(this)\"><td class=\"td_sabun\">"+row.sabun+"</td><td>"
					+row.name+"</td><td>"+row.reg_no+"</td><td>"
					+row.hp+"</td><td>"+strpos_gbn_code+"</td><td>"
					+row.join_day+"</td><td>"+row.retire_day+"</td><td>"
					+strput_yn+"</td><td align=\"right\">"+comma(row.salary)+"</td></tr>";  */

				html +="<tr class=\"resultRow\">";
				html +="	<td>" +row.sabun+ "</td>";
				html +="	<td>" +row.name+ "</td>";
				html +="	<td>" +row.reg_no+ "</td>";
				html +="	<td>" +row.hp+ "</td>";
				html +="	<td>" +strpos_gbn_code+ "</td>";
				html +="	<td>" +row.join_day+ "</td>";
				html +="	<td>" +row.retire_day+ "</td>";
				html +="	<td>" +strput_yn+ "</td>";
				html +="	<td align=\"right\">" +comma(row.salary)+ "</td>";
				html +="</tr>";
				
			}
		} 

		$('#listView').html(html);
		
		$('#listView').innerHTML = html;
		
 		//console.log("html : " + $('#listView').html());
          


	}
	
	function comma(str) { 
	    str = String(str); 
	    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,'); 
	} 
	

	function loadCommonCode(){
		$.ajax({
//			headers: { 
//				 'Accept': 'application/json',
//			      'Content-Type': 'application/json' 
//		    },
			url:"getcommonCode",
			type:"post",
//			dataType : 'json',
//			data:{ "commonCodeType" : commonCodeType },
//			contentType: 'application/json;charset=UTF-8' ,

//			traditional:true,
				
		        //Ajax 성공시
			success : function(data){
				console.log("로딩성공", data);
				//console.log("데이타 보기"+data[8].code);
				var commonCode;
				for(var i=0 ; i<data.length ; i++){
					if(data[i].gubun=="AA"){
						document.selectForm.pos_gbn_code.options.add(
								new Option(data[i].name));
					}else if(data[i].gubun=="FF"){
						document.selectForm.put_yn.options.add(
								new Option(data[i].name));
					}
				}
		        //Ajax 실패시
		    },error : function(status, error,request, data){
		    	console.log("로딩실패\n"+status+"\n"+error+"\n"+request.responseText+"\n"+request.status+"\n////////");
		   		return;
		    }
		});
		
		
	}
	/* function pagingCounter(){
		var totalCount;
		$.ajax({
			url:"totalPagingCounter",
			type:"post",
			success : function(data){
				
			},
			error : function(data, error){
				
			}
		});
		return totalCount;
	} */
	
	
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	$(document).ready(function(){
	 	 loadCommonCode();
		$('#put_yn').change(function(){
			console.log($('#put_yn').val());
		});
		$('#pos_gbn_code').change(function(){
			console.log($('#pos_gbn_code').val());
		}); 
		
		$('.resultRow').click(function(){
			var theSabun = $(this).children().eq(0).text();
			alert("선택 사번 : "+theSabun);
			location.href="/insaDetail?sabun="+theSabun;
		});  
 
/* 	 		$('#reset').click(function(){
				alert("reset");
				$(":text").val()="";
//				$(":option").value="";
				document.getElementById("sabun").disabled=false;
				document.getElementsByClassName("form-control").disabled=false;
			});  */
				
		
		/*  //검색
		 $('#search').click(function(){
				location.href="/getAll";
		});   */
		//초기화
		$('#reset').click(function(){
				location.href="/insaList";
		});
		//이전화면
		$('#forward').click(function(){
				location.href="/";
		});
		
		
		
		$('#sabun').focus(function(){
			$(".form-control").attr("disabled", true);
			
/* 			if(selectForm.sabun.value.trim()!=""){
			}else{
				$(":disabled").attr("disabled", false);
			}
 */		});	
		
		/* $('#sabun').blur(function(){
			if(selectForm.sabun.value.trim()==""){
				$(":disabled").attr("disabled", false);
//				$(".form-control").attr("disabled", false);
				insaList.sabun.value="";
			} 
		});
		
		*/
		$('#sabun').blur(function(){
			if($("#sabun").val().trim()=="" || $("#sabun").val()==null){
				$("#sabun").val("");
				$(":disabled").attr("disabled", false);
			}	
		}); 
	
		$(".form-control").focus(function(){
			$('#sabun').attr("disabled", true);
		});
		$(".form-control").blur(function(){
			var flag_hasContents=true;
			$(".form-control").each(function(idx, item){
				if(item.value!=0 || item.value.trim()!="" ){
					flag_hasContents=false;	
				}
				if(flag_hasContents){
					$('#sabun').attr("disabled", false);
				}
				
			});
			//for()
				
		});
		//enabled , disabled로 중복 없애보기
	});
	
/* 		var sabun_showMember = arguments[0];
		sabun_showMember.action="getOne";
		sabun_showMember.method="get";
		sabun_showMember.submit();
	}
	 */
	
	
	
</script>

	</head>
		<div align="center";>
		<h1>인사 관리 시스템</h1>
		</div>
	<body>
	<h1 style="margin-top: 0px;">직원 리스트</h1>
	<form id="selectForm" name="selectForm" method="post">
		<!-- 버튼 라인 -->
		
			<input type="button" id="search" value="검색" onclick="send(this.form)"/>
			<input type="button" id="reset" value="초기화" onclick="reset"/>
			<input type="button" id="forward" value="전화면" />
			<hr>
		<table>
			<!-- 1번째 줄 -->
			<tr>
				<!-- 사번 -->
					<td>사번</td>
					<td>
						<input type="text"  id="sabun" name="sabun" style="text-align: right;">
					</td>
				<!-- 성명 -->
					<td>성명</td>
					<td>
						<input type="text" class="form-control" id="name" name="name" style="text-align: right;">
					</td>
				<!-- 입사구분 -->
					<td>입사구분</td>
					<td>
						<select class="form-control" id="put_yn" name="put_yn">
							<option></option>
						</select>
					</td>				
				</tr>
					
			<!-- 2번째 줄 -->
				<tr>
				<!-- 직위 -->
					<td>직위</td>
					<td>
						<select name="pos_gbn_code" id="pos_gbn_code">
							<option></option>
						</select>
					</td>
				<!-- 입사일자 -->
					<td>입사일자</td>
					<td>
						<input type="date" id="join_day" name="join_day" class="form-control">
					</td>
				<!-- 퇴사일자 -->
					<td>퇴사일자</td>
					<td>
						<input type="date" id="retire_day" name="retire_day" class="form-control">
					</td>
				
				</tr>
			<br>
	
		</table>
	</form>
	<br>
	<hr>
	<br>
	<table  border="2">
		<thead>
			<tr align="center">
				<th>　　사번　　</th>
				<th>　　성명　　</th>
				<th>　주민번호　</th>
				<th>　핸드폰번호　</th>
				<th>　　직위　　</th>
				<th>　입사일자　</th>
				<th>　퇴사일자　</th>
				<th>　투입여부　</th>
				<th>　연봉(만원) </th>
			</tr>
		</thead>
		<tbody id="listView">
			<tr>
				<td colspan="9" align="center">검색된 데이터가 없습니다.</td>
			</tr>
			<%-- <c:choose>
				<c:when test="${empty list || list==null }">
					<tr>
						<td colspan="9" align="center">검색된 데이터가 없습니다.</td>
					</tr>
				</c:when>
				 <c:otherwise>
					<c:forEach items="${list}" var="searchResult">
						<tr class="resultRow">
								<td align="center" id="td_sabun"><a href="/insaDetail?pickSabun=${searchResult.sabun}">${searchResult.sabun}</td>
								<td align="center" id="td_name">${searchResult.name}</a></td>
								<td align="center" id="td_reg_no">${searchResult.reg_no}</td>
								<td align="center" id="td_hp">${searchResult.hp}</td>
								<td align="center" id="td_pos_gbn_code">${searchResult.pos_gbn_code}</td>
								<td align="center" id="td_join_day">${searchResult.join_day}</td>
								<td align="center" id="td_retire_day">${searchResult.retire_day}</td>
								<td align="center" id="td_put_yn">${searchResult.put_yn}</td>
								<td align="right" id="td_salary">${searchResult.salary}</td>
						</tr>
					</c:forEach>
				</c:otherwise>			
			</c:choose> --%>
		</tbody>
		<tfoot>
						
		</tfoot>
	</table>
	
</body>
</html>