<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%
session.removeAttribute("USER_NAME");
session.removeAttribute("USER_ID");
response.sendRedirect("login.jsp");

%>
