<%-- 
    Document   : Rep_Proveedores
    Created on : 02-sep-2016, 2:09:25
    Author     : swat-
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reporte Ventas</title>
        <link href="Seg_Validación.css" type="text/css" rel="stylesheet"> 
        <script src="jquery-3.1.0.min.js"></script>

        <script>
            
            function fecha(){
            var today = new Date();
            var dd = today.getDate();
            var mm = today.getMonth() + 1; //January is 0!
            var yyyy = today.getFullYear();
            if (dd < 10) {
                dd = '0' + dd;
            }
            if (mm < 10) {
                mm = '0' + mm;
            }

            today = yyyy + '-' + mm + '-' + dd;
            document.getElementById("fecha1").setAttribute("max", today);
            document.getElementById("fecha2").setAttribute("max", today);
        
            document.getElementById("fecha2").setAttribute("value", today);
        }
        
        function validar(){
           var a =document.getElementById("fecha1").value;
            
            var b =document.getElementById("fecha2").value;
            
            if(a!=="" || b !== ""){
                if (a>b){
                alert("La fecha 'Desde' no puede ser mayor a la fecha 'Hasta'");
                return false;
            }else{
                return true;}
            
            }
            else{
                alert("Por favor, Ingrese las dos fechas");
                return false;
            
                
        }
        }
        </script>

    </head>
    <body onload="fecha()">
        <form action="Rep_Ventas_Pdf.jsp" target="_blank" onsubmit="return validar()">
            <center>
                <font color="white">
                <h1>Instituto Tecnológico Superior "Cordillera"<br>
                    Sistema de Registro y Control de Inventarios</h1>
                <hr/>
                <br>
                <h2>
                    Reporte de Ventas por Fechas
                </h2>

                <br>
                <br>
                <br>

                <br>
                <br>
                <br>
                <table cellsapacing="35" align="center" heigth ="1000px">
                    <tr>
                        <td>Desde:</td>
                        <td><input type="date" name="fecha1" id="fecha1" size="180" ></td>
                    </tr>
                    <br>
                    <br>
                    <br>
                    <tr>
                        <td>Hasta:</td>
                        <td><input type="date" name="fecha2" id="fecha2" size="180" ></td>
                    </tr>


                </table>
                <br>
                <br>
                <table cellspacing="8">
                    <tr>
                        <td><input type="reset" value="Limpiar" size="80"  class="botones" onclick="ver()"></td>
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
