<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Insert title here</title>
</head>
<body>

	<form id="test" name="test" action="/test" method="post">
			<div style="float: right;" >
			이름
			<input type="text" id="name" name="name" value="test">
			성별
			<select name="sex" id="sex" >
						<option value="0">(선택)</option>
						<option value="1">남자</option>
						<option value="2">여자</option>
			</select>
			*입사일자
			<input type="date" title="입사일자" name="join_day" class="necessary" id="join_day" value="1">
			<input type="submit" id="save" name="save" value="저장"/>
			</div>
			</form>
</body>
</html>