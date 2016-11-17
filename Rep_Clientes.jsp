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
        <title>Reporte Clientes</title>
        <link href="Seg_Validación.css" type="text/css" rel="stylesheet"> 
        <script src="jquery-3.1.0.min.js"></script>
        <script type="text/javascript">


            function validaruc() {

                nombre = $('#txt_ruc').val();
                ruc = nombre.split('');
                if (nombre.length > 12 & nombre.length > 0 & ruc[10] === '0' & ruc[11] === '0' & ruc[12] === '1') {

                    return true;
                } else {
                    if (nombre.length !== 0) {
                        alert('Por favor, ingrese un número de RUC válido');
                        return false;
                    } else {
                        return true;
                    }


                }
            }

            function validacedula() {
                nombre = $('#dni').val();
                if (nombre.length === 10) {
                    return true;
                } else {
                    if (nombre.length !== 0) {
                        alert('Por favor, ingrese un número de cédula válido');
                    }
                    return false;

                }
            }

            function isNumberKey(evt)
            {
                var charCode = (evt.which) ? evt.which : event.keyCode;
                if (charCode > 31 && (charCode < 48 || charCode > 57))
                    return false;

                return true;
            }
            function tipodni() {

                var d = document.getElementById("tdni").value;
                if (d === 'I' || d === 'C') {
                    cedula();
                }
                if (d === 'R') {
                    ruc();
                }
                if (d === 'P') {
                    pasaporte();
                }
            }
            function cedula() {
                document.getElementById("dni").value = "";
                document.getElementById("dni").disabled = false;
                document.getElementById("dni").focus();
                document.getElementById("dni").setAttribute("maxlength", "10");
                document.getElementById("dni").setAttribute("onkeypress", "return isNumberKey(event)");

            }
            function ruc() {
                document.getElementById("dni").value = "";
                document.getElementById("dni").disabled = false;
                document.getElementById("dni").focus();
                document.getElementById("dni").setAttribute("maxlength", "13");
                document.getElementById("dni").setAttribute("onkeypress", "return isNumberKey(event)");
            }
            function pasaporte() {
                document.getElementById("dni").value = "";
                document.getElementById("dni").disabled = false;
                document.getElementById("dni").focus();
                document.getElementById("dni").setAttribute("maxlength", "13");
                document.getElementById("dni").removeAttribute("onkeypress");
                document.getElementById("dni").setAttribute("onkeyup", "mayusculas()");
            }

     
            function validar() {
           
                var d = document.getElementById("tdni").value;
                var c = document.getElementById("dni").value;
                
                var b= null;
             if(d ==="" ){
                 return true;
             }else{
             if (d === 'I' || d === 'C') {
                 b = validacedula();
                 if (b=== false & c==="" ){
                     return true;
                 }
             }
             if (d === 'R') {
                 b = validaruc();
                 
                 if (b=== false & c==="" ){
                     return true;
                 }
             }
             if (d === 'P') {
                 b = true;
             }
             }
                   
             if (b === true ) {
                
                 return true;
             } else {
                 return false;
             }
            }
            function habilitar(){
                 document.getElementById("dni").disabled=false;
            }

        </script>


    </head>
    <body>
        <form action="Rep_Cliente_Pdf.jsp" target="_blank" onsubmit="return validar()">
            <center>
                <font color="white">
                <h1>Instituto Tecnológico Superior "Cordillera"<br>
                    Sistema de Registro y Control de Inventarios</h1>
                <hr/>
                <br>
                <h2>
                    Reporte de Clientes
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
                    <tr>
                        <td>Tipo DNI:</td>
                        <td> <select name="tdni" id="tdni" style=" width:520px; " onchange = "tipodni()">
                                <option value="" onclick=" document.getElementById('dni').value=''; document.getElementById('dni').disabled=true" >--SELECCIONE--</option>
                                <option value="I" >CÉDULA DE IDENTIDAD</option>
                                <option value="C" >CÉDULA DE CIUDADANÍA</option>
                                <option value="R" >R.U.C</option>
                                <option value="P" >PASAPORTE</option>

                            </select> </td>

                    </tr>
                    <tr>
                        <td>DNI:</td>
                        <td><input type="text" name="dni" id="dni" size="40" maxlength="13"disabled> </td>
                    </tr>


                </table>
                <br>
                <br>
                <table cellspacing="8">
                    <tr>
                        <td><input type="reset" value="Limpiar" size="80"  class="botones"></td>
                        <td align="center">
                            <input type="submit" value="Enviar"  class="botones" onmousedown="habilitar()" size="80" >
                        </td>
                        <td><input type="button" name="volver" value="Menu Principal"  onclick="window.location.href = 'Men_MenúPrincipal.jsp'" class="botones" ></td>
                    </tr>
                </table>
                </font>
            </center>
        </form>
    </body>
</html>
