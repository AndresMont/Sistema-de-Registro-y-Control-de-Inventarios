<%-- 
    Document   : index
    Created on : 23-may-2016, 20:55:17
    Author     : Andesign
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset=UTF-8">
        <title>Sistema de Control de Inventarios</title>
        <link href="Seg_Validación.css" type="text/css" rel="stylesheet">
    </head>
    <body onload="foco()" >
    <center>
        <h1><font color ="white">Instituto Tecnológico Superior ¨Cordillera¨
            <br>Sistema de Registro y Control de Inventarios</font></h1></center>
    <hr/>
    <br/>
    <br/>
    <center>
        <form action="Con_Login" method="post">
            <div class="login">             

                <table border="0" >

                    <tbody>
                        <tr><br>
                    <td><h2>Usuario:</h2></td>
                    <td></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td> <input class="intento" type="text" name="ind_usuario" id="user"  maxlength="20" onkeyup="mayusculas()"> </input> </td>
                    </tr>
                    <tr>
                        <td><h2>Contraseña:</h2></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td> <input class="intento" type="password" name="ind_contra" maxlength="20" ></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td><br/><br/><input type="submit" class="botones" name="ind_boton" value="Entrar" ></td>
                    </tr>
                    </tbody>


                </table>
            </div>
        </form>
    </center>
    <script>
        function mayusculas() {
            var a = document.getElementById("user");
            a.value = a.value.toUpperCase();
        }
        function foco(){
            document.getElementById("user").focus();
        }
    </script>
</body>
</html>
