<%-- 
    Document   : Rep_Proveedores
    Created on : 02-sep-2016, 2:09:25
    Author     : swat-
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reporte Proveedores</title>
        <link href="Seg_Validación.css" type="text/css" rel="stylesheet"> 
         <script src="jquery-3.1.0.min.js"></script>
                <script type="text/javascript">


            function validaruc() {

                nombre = $('#txt_ruc').val();
                ruc = nombre.split('');
                if (nombre.length > 12 & nombre.length>0 & ruc[10] === '0' & ruc[11] === '0' & ruc[12] === '1') {

                    return true;
                } else {
                    if (nombre.length !== 0) {
                        alert('Por favor, ingrese un número de RUC válido');
                        return false;
                    }else{
                        return true;
                    }
                    

                }
            }
            
                  function isNumberKey(evt)
                {
                    var charCode = (evt.which) ? evt.which : event.keyCode;
                    if (charCode > 31 && (charCode < 48 || charCode > 57))
                        return false;

                    return true;
                }
            
            
            </script>
	
        
    </head>
    <body>
        <form action="Rep_Proveedores_Pdf.jsp" target="_blank" onsubmit="return validaruc()">
    <center>
        <font color="white">
        <h1>Instituto Tecnológico Superior "Cordillera"<br>
            Sistema de Registro y Control de Inventarios</h1>
        <hr/>
        <br>
        <h2>
            Reporte de Proveedores
        </h2>
        
            <br>
            <br>
            <br>
            
            <br>
            <br>
            <br>
        <table cellsapacing="35" align="center" heigth ="1000px">
            <tr>
                <td>Estado:</td>
            
                <td>
            <select style=" width:520px;" name="sel_estado">
                <option value="A">ACTIVO</option>
                <option value="I">INACTIVO</option>
            </select>
                <td>
            </tr>
            <br>
            <br>
            <br>
            <tr>
                <td>
                    R.U.C:
                </td>
                <td>
                    <input type="text" maxlength="13" minlength="13" name="txt_ruc" id= "txt_ruc" size="40" onkeypress="return isNumberKey(event)">
                </td>
            </tr>
      
           
        </table>
        <br>
        <br>
         <table cellspacing="8">
                <tr>
                    <td><input type="reset" value="Limpiar" size="80"  class="botones"></td>
            <td align="center">
            <input type="submit" value="Enviar"  class="botones" size="80" >
                </td>
                       <td><input type="button" name="volver" value="Menu Principal" onclick="window.location.href = 'Men_MenúPrincipal.jsp'" class="botones" ></td>
                </tr>
            </table>
        </font>
    </center>
        </form>
    </body>
</html>
