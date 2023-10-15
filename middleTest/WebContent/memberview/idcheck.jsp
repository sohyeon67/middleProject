<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String res = (String)request.getAttribute("result");
	
	if(res == null) {	// 사용 가능
%>
		{
			"flag" : "사용 가능 ID"
		}
<%
	} else {	// 사용 불가능
%>
		{
			"flag" : "사용 불가능 ID"
		}
<%
	}
%>