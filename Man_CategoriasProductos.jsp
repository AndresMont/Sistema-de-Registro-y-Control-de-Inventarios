<%-- 
    Document   : Man_CategoriasProductos
    Created on : 03-jul-2016, 19:26:15
    Author     : Andesign
--%>

<%@page import="java.util.ArrayList"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="Seg_Validación.css" type="text/css" rel="stylesheet" >
        <title>Categorías Productos</title>
        <script src="jquery-3.1.0.min.js"></script>
        <script type="text/javascript">

            function campos() {
                var a = document.getElementById("gen");
                var b = document.getElementById("uso");
                var c = document.getElementById("des");
                var d = document.getElementById("est");

                if (a.value !== "" & b.value !== "-" & d.value !== "" & c.value !== "0") {

                    return true;

                } else {

                    alert('Por favor, complete los campos obligatorios');
                    return false;

                }
            }
            function redundancia() {


                var tab = document.getElementById("categorias").getElementsByTagName("tr").length;
                tab = tab - 1;
                var a = document.getElementById("gen").value;
                var b = document.getElementById("des").value;
                var c = document.getElementById("mod").value;
                var d = document.getElementById("id").value;
                var aux = 0, aux1 = 0;
                var w = 0, x = 0, y = 0;

                while (tab !== 0) {
                    w = document.getElementById("categorias").rows[tab].cells[0].innerText;
                    x = document.getElementById("categorias").rows[tab].cells[1].innerText;
                    y = document.getElementById("categorias").rows[tab].cells[3].innerText;
                    if (a === x & d !== w & c === 'ACT' || a === x & c === 'GUA') {
                        aux = aux + 1;
                    }

                    if (b === y & d !== w & c === 'ACT' || b === y & c === 'GUA') {
                        aux1 = aux1 + 1;
                    }

                    tab = tab - 1;
                }

                if (aux === 0 & aux1 === 0 & c === 'GUA' || aux === 0 & aux1 === 0 & c === 'ACT') {
                    return true;
                } else {

                    if (c === 'GUA' & aux !== 0 || c === 'ACT' & aux > 0) {
                        alert("Información duplicada, por favor ingrese un detalle válido");

                    }
                    if (c === 'GUA' & aux1 !== 0 || c === 'ACT' & aux1 > 0) {
                        alert("Información duplicada, por favor ingrese una descripción válida");

                    }
                    return false;
                }

            }

            function validar() {
     
                var a = null;
                var b = null;
                a = campos();
                b = redundancia();

       
                if (a === true & b === true) {
                    return true;
                } else {
                    return false;
                }
                        return false;
            }
                function letras(event){
        var inputValue = event.which;
        // allow letters and whitespaces only.
        if(!(inputValue >= 65 && inputValue <= 120) && (inputValue != 32 && inputValue != 0)) { 
            event.preventDefault(); 
        }
    }
        </script>

    </head>
    <sql:setDataSource driver="com.mysql.jdbc.Driver"
                       url="jdbc:mysql://localhost:3306/inventariospi?zeroDateTimeBehavior=convertToNull"
                       user="root"
                       password="System19"
                       var="con"
                       />
    <sql:query var="resul" dataSource="${con}">
        SELECT * FROM INVENTARIOSPI.INV_CATEGORIAS
    </sql:query>
    <body>
    <center>
        <font color="white"> 

        <h1>Instituto Tecnológico Superior "Cordillera"<br>
            Sistema de Registro y Control de Inventarios</h1>
        <hr>
        <h2>Registro de Categorías de Productos </h2> 

        <c:if test="${param.modificar == null}">
            <form method="post" onSubmit="return validar();">

                <table border='0' cellspacing="8">
                    <tr>
                        <td>Detalle*:</td>
                        <td><input type='text' size='40' name='gen' ID="gen" onkeyup="mayusculas()" disabled  maxlength="100" onkeypress="return letras(event);"></td>
                        <td>Campo de uso:</td>
                        <td><select name="uso" id="uso" style="width:520px; " disabled>
                                <option value="-" >--SELECCIONE--</option>
                                <option value="D">DOMESTICO</option>
                                <option value="I">INDUSTRIAL</option>

                            </select></td>

                    </tr>

                    <tr>

                        <td>Descripción:</td>
                        <td><textarea cols="46" rows="5"  name="des"  class="mis" id="des" maxlength="1500" disabled style="text-transform: initial;" onkeyup="mayusculas()"> </textarea></td>
                        <td>Estado*:</td>
                        <td> <select name="est" id="est" style=" width:520px; " disabled>
                                <option value="0" >--SELECCIONE--</option>
                                <option value="A" selected>ACTIVO</option>
                                <option value="I">INACTIVO</option>

                            </select> </td>
                    </tr>
                    <tr>

                        <td><input type='hidden' size='40' name='id' id="id"  /></td>
                    </tr>
                    <tr><td colspan="2"><br>Los datos con (*) son obligatorios.</td></tr>
                </table>
                </font>
                <br>
                <br>
                <table border="0">
                    <tr>
                        <td><input type="reset" value="Nuevo" size="80"  class="botones" onclick="nuevo();
                                resetear()"/> </td>
                        <td><input type="button" value="Editar" size="80" onclick="editar()" class="botones" id="edi" disabled/> </td>
                        <td><input type="submit" name="modifica" value="Actualizar"  id="act" class="botones" disabled /></td>
                        <td><input type="submit" name="guardar" value="Guardar"  id="gua" class="botones" disabled /></td>
                        <td><input type="button" name="volver" value="Menu Principal" onclick="window.location.href = 'Men_MenúPrincipal.jsp'" class="botones" /></td>
                        <td><input type="hidden" name="modificar" id="mod"></td>
                    </tr>
                    <tr height="100px">
                        <td colspan="2"><input type="search" results ="2" name="bus" id ="bus" class="bus"size="40"  onkeyup=" buscartabla();
                                mayusculas();" placeholder="Buscar..." align="center"></td>

                    </tr> 
                </table>
                <br>
                <br>
                <div>
                    <table border="1" bg-color="white" style="border-collapse:collapse;" class="tab" id="categorias" cellspacing="8">
                        <thead>
                        <th >Clave</th>
                        <th>Detalle</th>
                        <th>Campo de uso</th>
                        <th>Descripción</th>
                        <th>Estado</th>
                        </thead>
                        <tbody>
                            <c:forEach var="filas" items="${resul.rows}">
                                <tr style='cursor:pointer' onclick="recuperar(${filas.CAT_ID})" >
                                    <td width="80px" align="center">  <c:out value="${filas.CAT_ID}"/></td>
                                    <td width="250px">  <c:out value="${filas.CAT_DETALLE}"/></td>
                                    <td align="center">  <c:out value="${filas.CAT_CAMPOUSO}"/></td>
                                    <td  width="600">  <c:out value="${filas.CAT_DESCRIPCION}"/></td>
                                    <td align="center">  <c:out value="${filas.CAT_ESTADO}"/></td>
                                </tr>
                            </c:forEach>


                        </tbody>
                    </table>
                </div>

            </form>
            <script >

                function recuperar(fila) {
                    var v = document.getElementById("categorias").rows[fila].cells[0].innerText;
                    var w = document.getElementById("categorias").rows[fila].cells[1].innerText;
                    var x = document.getElementById("categorias").rows[fila].cells[2].innerText;
                    var y = document.getElementById("categorias").rows[fila].cells[3].innerText;

                    document.getElementById("id").value = v;
                    document.getElementById("gen").value = w;
                    document.getElementById("uso").value = x;
                    document.getElementById("des").value = y;

                    var tab = document.getElementById("categorias").getElementsByTagName("tr").length;
                    tab = tab - 1;
                    while (tab > 0) {
                        document.getElementById("categorias").rows[tab].removeAttribute("bgcolor");
                        tab = tab - 1;
                    }
                    document.getElementById("categorias").rows[fila].setAttribute("bgcolor", "#ffffb3");


                    document.getElementById("edi").disabled = false;
                    document.getElementById("act").disabled = true;
                    document.getElementById("gen").disabled = true;
                    document.getElementById("uso").disabled = true;
                    document.getElementById("des").disabled = true;
                    document.getElementById("est").disabled = true;
                    document.getElementById("gua").disabled = true;
                    document.getElementById("mod").value = "ACT";
                }

                function editar() {
                    document.getElementById("est").disabled = false;
                    document.getElementById("mod").value = "ACT";
                    document.getElementById("act").disabled = false;
                    document.getElementById("gen").disabled = false;
                    document.getElementById("uso").disabled = false;
                    document.getElementById("des").disabled = false;
                    document.getElementById("nue").disabled = false;
                    document.getElementById("gua").disabled = true;

                }

                function nuevo() {
                    document.getElementById("mod").value = "GUA";
                    document.getElementById("gua").disabled = false;
                    document.getElementById("act").disabled = true;
                    document.getElementById("edi").disabled = true;
                    document.getElementById("gen").disabled = false;
                    document.getElementById("est").disabled = false;
                    document.getElementById("uso").disabled = false;
                    document.getElementById("des").disabled = false;
                    document.getElementById("gen").focus();

                }

                function mayusculas() {
                    var a = document.getElementById("gen");
                    var b = document.getElementById("des");
                    var c = document.getElementById("bus");
                    a.value = a.value.toUpperCase();
                    b.value = b.value.toUpperCase();
                    c.value = c.value.toUpperCase();

                }
                function resetear() {
                    document.getElementById("bus").value = "";
                    var $tabla = $('#categorias tbody tr');
                    var $tabl = $('#tabl');
                    $tabla.show();
                    $tabl.show();
                    var tab = document.getElementById("categorias").getElementsByTagName("tr").length;
                    tab = tab - 1;
                    while (tab > 0) {
                        document.getElementById("categorias").rows[tab].removeAttribute("bgcolor");
                        tab = tab - 1;
                    }
                }
                function buscartabla() {

                    var $tabla = $('#categorias tbody tr');
                    var x = document.getElementById("bus");
                    var val = $.trim(x.value).replace(/ +/g, ' ').toLowerCase();
                    $tabla.show().filter(function () {
                        var text = $(this).text().replace(/\s+/g, ' ').toLowerCase();
                        return !~text.indexOf(val);
                    }).hide();

                    var b = document.getElementById("id").value;
                    var SearchFieldsTable = $("#categorias tbody");

                    var trows = SearchFieldsTable[0].rows;
                    var aux = 1;
                    $.each(trows, function (index, row) {
                        var ColumnName = $(row).attr("style");
                        if (ColumnName.charAt(0) === "d") {
                            var a = document.getElementById("categorias").rows[aux].cells[0].innerText;
                            document.getElementById("categorias").rows[aux].removeAttribute("bgcolor");
                            if (a === b) {

                                document.getElementById("gua").disabled = true;
                                document.getElementById("act").disabled = true;
                                document.getElementById("edi").disabled = true;
                                document.getElementById("gen").disabled = true;
                                document.getElementById("est").disabled = true;
                                document.getElementById("uso").disabled = true;
                                document.getElementById("des").disabled = true;
                                document.getElementById("id").value = "";
                                document.getElementById("gen").value = "";
                                document.getElementById("uso").value = "-";
                                document.getElementById("des").value = "";
                                document.getElementById("est").value = "A";
                            }

                        }
                        aux = aux + 1;
                    }
                    );
                }

            </script>


        </c:if>

        <c:if test="${param.modificar == 'ACT'}">

            <sql:update var="act" dataSource="${con}">
                UPDATE INVENTARIOSPI.INV_CATEGORIAS
                SET  EMP_ID = '1'
                ,CAT_DETALLE= '${param.gen}'
                ,CAT_CAMPOUSO= '${param.uso}'
                ,CAT_DESCRIPCION= '${param.des}'
                ,CAT_ESTADO= '${param.est}'
                WHERE CAT_ID = '${param.id}'
            </sql:update>

            </font>
            <form action="Man_CategoriasProductos.jsp">

                <div class='exito'>             
                    <table border="0" >
                        <br><br>
                        <tr>
                            <td><h1>Actualización Exitosa</h1></td>
                        </tr>
                        <br>
                        <br>
                        <tr>
                            <td> <input value='Aceptar' type='submit' class="botones"> </input> </td>
                        <tr>

                    </table>
                </div>
            </form>
        </c:if>

        <c:if test="${param.modificar == 'GUA'}">

            <% int count = 0; %>
            <c:forEach var="columnas" items="${resul.rows}">
                <%count = count + 1;%>
            </c:forEach>

            <sql:update var="gua" dataSource="${con}">
                INSERT INTO INVENTARIOSPI.INV_CATEGORIAS 
                (CAT_ID
                ,EMP_ID
                ,CAT_DETALLE 
                ,CAT_CAMPOUSO 
                ,CAT_DESCRIPCION
                ,CAT_ESTADO)
                VALUES ('<%=count + 1%>','1','${param.gen}','${param.uso}','${param.des}','${param.est}')
            </sql:update>
            </font>
            <form action="Man_CategoriasProductos.jsp" method='post'>
                <div class='exito'>             
                    <table border="0" >
                        <br>
                        <tr>
                            <td><center><h1>Registro guardado <br>
                                con éxito</h1></center></td>
                        </tr>
                        <br>
                        <br>
                        <tr>
                            <td> <input value='Aceptar' type='submit' class="botones"> </input> </td>
                        </tr>

                    </table>
                </div>
            </form>
        </c:if>

    </center>

</body>
</html>
