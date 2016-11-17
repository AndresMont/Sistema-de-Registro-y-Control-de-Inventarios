<%-- 
    Document   : Rep_Conexion
    Created on : 28-ago-2016, 15:04:16
    Author     : swat-
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import= "java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
        Connection con = null;
        try{
            Class.forName("com.mysql.jdbc.Driver");
            con = (Connection)DriverManager.getConnection("jdbc:mysql://localhost:3306/inventariospi?zeroDateTimeBehavior=convertToNull","root","System19");
            out.print("Conexion en Linea");
        }catch(Exception ex){
            out.print("Error"+ex.getMessage());
        }
        %>
    </body>
</html>
