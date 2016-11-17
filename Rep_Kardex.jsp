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
        <title>Reporte Kardex</title>
        <link href="Seg_Validación.css" type="text/css" rel="stylesheet"> 
        <script src="jquery-3.1.0.min.js"></script>
        <script type="text/javascript">
            <sql:setDataSource driver="com.mysql.jdbc.Driver"
                               url="jdbc:mysql://localhost:3306/inventariospi?zeroDateTimeBehavior=convertToNull"
                               user="root"
                               password="System19"
                               var="con"
                               />


            function habilitar()
            {
                document.getElementById("form").removeAttribute("action");
                document.getElementById("form").setAttribute("action", "Rep_Kardex_Bodega_Pdf.jsp");
                document.getElementById("bode").disabled = false;
                document.getElementById("pro").value = "0";
            }
            function habilitar2()
            {
                document.getElementById("form").removeAttribute("action");
                document.getElementById("form").setAttribute("action", "Rep_Kardex_Pdf.jsp");
                document.getElementById("pro").value = "0";
                document.getElementById("bode").value = "0";
                document.getElementById("bode").disabled = true;
            }
            function campos() {
                var x = document.getElementById("pro").value;

                var w = document.getElementById("bod").checked;
                var y = document.getElementById("gen").checked;
                var z = document.getElementById("bode").value;
                if (x !== "0" & y === true || z !== "0" & w === true & z !== "0") {
                    return true;
                } else {
                    if (x === "0") {
                        alert("Por Favor, Ingrese el producto del cual se generará el reporte");
                    }
                    if (w === true & z === "0") {
                        alert("Por Favor , Ingrese la bodega de la cual se desea el reporte.");
                    }
                    return false;
                }
            }


        </script>


    </head>
    <sql:query var="productos" dataSource="${con}">  
        SELECT * FROM INVENTARIOSPI.INV_PRODUCTOS
    </sql:query> 
    <sql:query var="bodegas" dataSource="${con}">  
        SELECT B.* FROM INVENTARIOSPI.INV_BODEGAS B WHERE (SELECT COUNT(*) FROM INVENTARIOSPI.INV_SALDOS_POR_BODEGA S WHERE S.BOD_ID = B.BOD_ID )<>0
    </sql:query> 



    <body>
        <form action="Rep_Kardex_Pdf.jsp" target="_blank" id="form" onsubmit="return campos()">
            <center>
                <font color="white">
                <h1>Instituto Tecnológico Superior "Cordillera"<br>
                    Sistema de Registro y Control de Inventarios</h1>
                <hr/>
                <br>
                <h2>
                    Reporte de Kardex
                </h2>

                <br>
                <br>
                <br>

                <br>
                <br>
                <br>
                <table cellsapacing="35" align="center" heigth ="1000px">
                    <tr>
                        <td>Tipo de Kardex:</td>


                        <td>
                            &nbsp;      &nbsp;      &nbsp;      &nbsp;
                            <input style =" transform: scale(2);"type='radio' name='pbod' id="gen" value="G" onclick="habilitar2()" checked>General
                            &nbsp;     &nbsp;      &nbsp;      &nbsp;      &nbsp;
                            <input style =" transform: scale(2);" type='radio' name='pbod'id="bod"  value="P" onclick="habilitar()" >Por Bodega
                        </td>

                    </tr>
                    <br>
                    <br>
                    <br>
                    <tr>
                        <td>Producto:</td>
                        <td><select name="pro" id="pro"  style=" width:520px; "   >
                                <option value="0"  selected>--SELECCIONE--</option>
                                <c:forEach var="cols" items="${productos.rows}"> 
                                    <option value="${cols.PRO_ID}"  > ${cols.PRO_DETALLE} </option>
                                </c:forEach> 
                            </select> </td>

                    </tr>
                    <tr>              <td>Bodega:</td>
                        <td><select name="bode" id="bode"  style=" width:520px; " disabled>
                                <option value="0"  selected>--SELECCIONE--</option>
                                <c:forEach var="colsP" items="${bodegas.rows}"> 

                                    <option value="${colsP.BOD_ID}"  > ${colsP.BOD_DESCRIPCION} </option>
                                </c:forEach> 
                            </select> </td>
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
