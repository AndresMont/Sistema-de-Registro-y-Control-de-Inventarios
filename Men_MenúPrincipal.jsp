<%-- 
    Document   : Men_MenúPrincipal
    Created on : 31-may-2016, 15:09:42
    Author     : Andesign
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sistema de Registro y Control de Inventarios</title>
        <link href="Seg_Validación.css" type="text/css" rel="stylesheet"> 

        <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1, maximun-scale=1, minium-scale=1 ">
        <link rel="stylesheet" href="estilos.css">
        <link href="Men_MenúPrincipal.css" type="text/css" rel="stylesheet"> 
        <%
            String usua = "", tip = "";
            usua = (String) session.getAttribute("usu");
            tip = (String) session.getAttribute("tip");
            String tipo = "";
            if (tip.equals("A")) {
                tipo = "Administrador";
            }
            if (tip.equals("G")) {
                tipo = "Gerente";
            }
            if (tip.equals("S")) {
                tipo = "Supervisor";
            }
            if (tip.equals("C")) {
                tipo = "Cajero";
            }
            if (tip.equals("B")) {
                tipo = "Bodeguero";
            }
        %> 
        <script>
            function roles() {

                var a = '<%=tip%>';

                var x = 1;

                if (a === 'G')
                {
                    document.getElementById("man").style.display = 'none';
                    document.getElementById("tra").style.display = 'none';
                }
                if (a === 'S')
                {
                    document.getElementById("1").style.display = 'none';
                    document.getElementById("2").style.display = 'none';
                    document.getElementById("11").style.display = 'none';
                    document.getElementById("12").style.display = 'none';
                    document.getElementById("13").style.display = 'none';
                    document.getElementById("16").style.display = 'none';
                    document.getElementById("18").style.display = 'none';
                    document.getElementById("tra").style.display = 'none';
                    document.getElementById("rep").style.display = 'none';
                }
                if (a === 'C')
                {
                    document.getElementById("1").style.display = 'none';
                    document.getElementById("2").style.display = 'none';
                    document.getElementById("3").style.display = 'none';
                    document.getElementById("11").style.display = 'none';
                    document.getElementById("12").style.display = 'none';
                    document.getElementById("13").style.display = 'none';
                    document.getElementById("14").style.display = 'none';
                    document.getElementById("15").style.display = 'none';
                    document.getElementById("17").style.display = 'none';
                    document.getElementById("18").style.display = 'none';
                    document.getElementById("21").style.display = 'none';
                    document.getElementById("22").style.display = 'none';
                    document.getElementById("25").style.display = 'none';
                    document.getElementById("26").style.display = 'none';
                    document.getElementById("27").style.display = 'none';
                    document.getElementById("a").style.display = 'none';
                    document.getElementById("b").style.display = 'none';
                    document.getElementById("c").style.display = 'none';
                    document.getElementById("rep").style.display = 'none';
                }
                         if (a === 'B')
                {
                    document.getElementById("man").style.display = 'none';
                    document.getElementById("rep").style.display = 'none';
                    document.getElementById("22").style.display = 'none';
                    document.getElementById("23").style.display = 'none';
                    document.getElementById("24").style.display = 'none';
                    document.getElementById("a").style.display = 'none';

                }
            }

        </script>


    </head>
    <body onload="roles()"  >
        <header><h1><center><br>Instituto Tecnológico Superior "Cordillera"<br>Sistema de Registro y Control de Inventarios</center></h1></header>
        <hr/>
        <br>
        <div id="header">

            <ul class="nav">
                <li><p align="center">Mantenimiento</p>
                    <br>
                    <ul id="man">

                        <form action="Man_Empresa.jsp" method="post"><li><input type="submit" id="11" class="men"value="Datos de la empresa" ></input></li></form>
                        <hr id="1"/>
                        <form action="Man_Sucursales.jsp" method="post"><li><input type="submit" id="12" class="men"value="Sucursales" ></input></li></form>

                        <form action="Man_Bodegas.jsp" method="post"><li><input type="submit" id="13" class="men"value="Bodegas"></input></li></form>
                        <hr id="2"/>
                        <form action="Man_CategoriasProductos.jsp" method="post"><li><input id="14" type="submit" class="men"value="Categorías de productos"></input></li></form>
                        <form action="Man_Productos.jsp" method="post"><li><input type="submit" id="15" class="men"value="Productos nuevos"></input></li></form>
                        <hr id="3"/>
                        <form action="Man_Clientes.jsp" method="post"><li><input type="submit" id="16"class="men"value="Creación Clientes"></input></li></form>
                        <form action="Man_Proveedores.jsp       " method="post"><li><input type="submit" id="17" class="men"value="Creación Proveedores"></input></li></form>
                        <form action="Man_Usuarios.jsp" method="post"><li><input type="submit" id="18" class="men"value="Creación de Usuarios"></input></li></form>
                    </ul>
                </li>


                <li><p  align="center">Transacciones</p>
                    <br>
                    <ul id="tra">
                        <form action="Tra_Compras.jsp" method="post"><li><input type="hidden" name ="usuario" value="<%=usua%>"><input id="21" type="submit" class="men"value="Compras"></input></li></form>
                        <form action="Tra_Devolucion_Compras.jsp" method="post"><li><input type="hidden" name ="usuario" value="<%=usua%>"><input id="22" type="submit" class="men"value="Devolución en compras"></input></li></form>
                        <hr ID="a"/>
                        <form action="Tra_Ventas.jsp" method="post"><li><input type="hidden" name ="usuario" value="<%=usua%>"><input type="submit" id="23"  class="men"value="Ventas"></input></li></form>
                        <form action="Tra_Devolucion_Ventas.jsp" method="post"><li><input type="hidden" name ="usuario" value="<%=usua%>"><input type="submit" id="24"  class="men"value="Devolución en ventas"></input></li></form>
                        <hr id="b"/>
                        <form action="Tra_Transferencias.jsp" method="post"><li><input type="hidden" name ="usuario" value="<%=usua%>"><input type="submit" id="25"  class="men"value="Transferencias"></input></li></form>
                        <hr id="c"/>
                        <form action="Tra_Consumo_Interno.jsp" method="post"><li><input type="hidden" name ="usuario" value="<%=usua%>"><input type="submit" id="26"  class="men"value="Consumo interno"></input></li></form>
                        <form action="Tra_Desperdicios.jsp" method="post"><li><input type="hidden" name ="usuario" value="<%=usua%>"><input type="submit" id="27"  class="men"value="Desperdicios"></input></li></form>
                    </ul>
                </li>
                <li><p  align="center">Reportes</p>
                    <br>
                    <ul id="rep">
                        <form action="Rep_Kardex.jsp" method="post"><li><input type="submit" class="men"value="Kardex"></input></li></form>

                        <hr/>
                        <form action="Rep_Ventas.jsp" method="post"><li><input type="submit" class="men"value="Ventas por Fechas"></input></li></form>
                        <hr/>
                        <li><a type ="button" href = "Rep_Clientes.jsp"  class="men" >Clientes</a></li>
                        <form action="Rep_Proveedores.jsp" method="post"><li><input type="submit" class="men"value="Proveedores"></input></li></form>


                    </ul>
                </li>

                <li><p align="center">Sesión</p>
                    <br>
                    <ul>
                        <li><input class="men" value="<%=  usua%>" type="button" enabled="false"></input></li>
                        <li><input class="men" value="<%=  tipo%>" type="button" enabled="false"></input></li>
                        <form action="index.jsp" method="post"><li><input type="submit" class="men"value="Salir"></input></li></form>
                    </ul> 
                </li>

            </ul>


        </div> <br><br><br><br>

        <div class="slider" width="20px" style="border-radius: 25px;  border: 5px solid white;" >
            <ul>
                <li><img src="img/4.jpg" alt=""></li>
                <li><img src="img/6.jpg" alt=""></li>
                <li><img src="img/3.jpg" alt=""></li>
                <li><img src="img/2.jpg" alt=""></li>
                <li><img src="img/5.jpg" alt=""></li>
                <li><img src="img/1.jpg" alt=""></li>
            </ul>
        </div>

    </body>
</html>
