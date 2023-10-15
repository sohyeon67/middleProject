<%@page import="com.google.gson.Gson"%>
<%@page import="kr.or.ddit.member.vo.ZipVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
List<ZipVO> list = (List<ZipVO>)request.getAttribute("result");

Gson gson = new Gson();

String result = gson.toJson(list);

out.print(result);
out.flush();

%>