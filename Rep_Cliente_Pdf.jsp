<%-- 
    Document   : Rep_Cliente_Pdf
    Created on : 28-ago-2016, 15:16:36
    Author     : swat-
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>

<%@page import="net.sf.jasperreports.engine.*"%>
<%@page import="net.sf.jasperreports.view.JasperViewer"%>


<%@page import="javax.servlet.ServletResponse"%>
<%@include file ="Rep_Conexion.jsp" %>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <frameset rows="20%">
        <body>
        <h2>asdasd</h2>
        
        </body>
    </frame>
    <frameset rows="80%">
    <body>
        
        <%
         File reportfile = new File(application.getRealPath("Rep_Reportes/Rep_Clientes.jasper"));
        
           Map<String,Object> parameter = new HashMap<String,Object>();
               String valor = request.getParameter("sel_estado");
           String valor2= request.getParameter("tdni");
           String valor3 = request.getParameter("dni");
           
           parameter.put("est", new String(valor));
           parameter.put("tdni", new String(valor2));
           parameter.put("dni", new String(valor3));
        
         byte[]bytes = JasperRunManager.runReportToPdf(reportfile.getPath(), parameter,con);
         
       
           
         response.setContentType("application/pdf");
         response.setContentLength(bytes.length);
         ServletOutputStream outputstream = response.getOutputStream();
         outputstream.write(bytes,0,bytes.length);
         outputstream.flush();
         outputstream.close();
        %>
    </body>
    </frameset>
</html>
