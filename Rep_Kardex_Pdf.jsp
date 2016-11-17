<%-- 
    Document   : Rep_Proveedores_Pdf
    Created on : 02-sep-2016, 2:49:30
    Author     : swat-
--%>

<%@page import="net.sf.jasperreports.engine.JasperRunManager"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@include file="Rep_Conexion.jsp" %>
<%@include file="Rep_Proveedores.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
       <%
         File reportfile = new File(application.getRealPath("Rep_Reportes/Rep_Kardex_General.jasper"));
        
           Map<String,Object> parameter = new HashMap<String,Object>();
           String valor = request.getParameter("pro");
           parameter.put("pro", new String(valor));
        
         byte[]bytes = JasperRunManager.runReportToPdf(reportfile.getPath(), parameter,con);
        
         response.setContentType("application/pdf");
         response.setContentLength(bytes.length);
         ServletOutputStream outputstream = response.getOutputStream();
         outputstream.write(bytes,0,bytes.length);
         outputstream.flush();
         outputstream.close();
        %>
    </body>
</html>
