

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset=UTF-8">
        <title>Sistema de Control de Inventarios</title>
        <link href="Seg_Validación.css" type="text/css" rel="stylesheet">
    </head>
    <body>
    <center>
        <font color ="white"><h1> Instituto Tecnológico Superior ¨Cordillera¨<br/>Sistema de Registro y Control de Inventarios</h2></font></center>
    <hr/>
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

                        <td> <input id="error1" type="text" name="ind_usuario" size="250px" maxlength="20" onfocus="funcion1()" onkeyup="mayusculas()"
                                    <%String codi = (String) session.getAttribute("codigo");
                                        System.out.println("" + codi);
                                        if (codi == "usu" || codi == "dos") {

                                    %>
                                    class="error"<%}%> 
                                    ><td>
                    </tr>
                    <tr>
                        <td><h2>Contraseña:</h2></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td><input type="password" name="ind_contra" maxlength="20" id="error2" onfocus="funcion2()"
                                   <%

                                       if (codi == "con" || codi == "dos") {

                                   %>
                                   class="error"<%}%> 
                                   ></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td><br/><br/><input type="submit" class="botones" name="ind_boton" value="Entrar" width="40" ></a></td>
                    </tr>
                    </tbody>
                    <script>
                        function funcion1() {
                            document.getElementById("error1").removeAttribute("class");
                        }
                        function funcion2() {
                            document.getElementById("error2").removeAttribute("class");
                        }
                        function mayusculas() {
                            var a = document.getElementById("error1");
                            a.value = a.value.toUpperCase();

                        }
                    </script>
                </table>
            </div>
        </form>
    </center>
</body>
</html>