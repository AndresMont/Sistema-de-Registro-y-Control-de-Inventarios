<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<!DOCTYPE html>
<html>
    <head>
        <sql:setDataSource driver="com.mysql.jdbc.Driver"
                           url="jdbc:mysql://localhost:3306/inventariospi?zeroDateTimeBehavior=convertToNull"
                           user="root"
                           password="System19"
                           var="con"
                           />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>Proveedores</title>
        <link href="Seg_Validación.css" rel="stylesheet" type="text/css">
        <script src="jquery-3.1.0.min.js"></script>
        <script src="ajax.js"></script>
        <script type="text/javascript">


            function validaruc() {

                nombre = $('#ruc').val();
                ruc = nombre.split('');
                if (nombre.length > 12 & ruc[10] === '0' & ruc[11] === '0' & ruc[12] === '1') {

                    return true;
                } else {
                    if (nombre.length !== 0) {
                        alert('Por favor, ingrese un número de RUC válido');
                    }
                    return false;

                }
            }

            function campos() {
                var a = document.getElementById("raz").value;
                var b = document.getElementById("nom").value;
                var c = document.getElementById("ruc").value;
                var d = document.getElementById("dir").value;
                var e = document.getElementById("tel").value;
                var f = document.getElementById("cor").value;
                var lon = e.length;

                if (a !== "" & b !== "" & d !== "" & c !== "" & e !== "" & f !== "0" & lon >= 7) {
                    return true;
                } else {
                    if (lon > 0 & lon < 7) {
                        alert('Por favor, ingrese un número de teléfono válido');
                    } else {
                        alert('Por favor, complete todos los campos');
                    }
                    return false;
                }
            }
            function redundancia() {

                var tab = document.getElementById("tbl").getElementsByTagName("tr").length;
                tab = tab - 1;
                var a = document.getElementById("raz").value;
                var b = document.getElementById("nom").value;
                var c = document.getElementById("ruc").value;
                var d = document.getElementById("dir").value;
                var e = document.getElementById("tel").value;
                var f = document.getElementById("cor").value;
                  var g = document.getElementById("mod").value;
                var aux = 0, aux1 = 0, aux2 = 0, aux3 = 0, aux4 = 0, aux5 = 0;
                var x = null;
                var y = null;

                while (tab !== 0) {

                    var t = document.getElementById("tbl").rows[tab].cells[1].innerText;
                    var u = document.getElementById("tbl").rows[tab].cells[2].innerText;
                    var v = document.getElementById("tbl").rows[tab].cells[3].innerText;
                    var w = document.getElementById("tbl").rows[tab].cells[4].innerText;
                    var x = document.getElementById("tbl").rows[tab].cells[5].innerText;
                    var y = document.getElementById("tbl").rows[tab].cells[6].innerText;
                    
                    if (a === t) {
                        aux = aux + 1;
                    }
                    if (b === u) {
                        aux1 = aux1 + 1;
                    }
                      if (c === v) {
                        aux2 = aux2 + 1;
                    }
                      if (d === w) {
                        aux3 = aux3 + 1;
                    }
                      if (e === x) {
                        aux4 = aux4 + 1;
                    }
                      if (f === y) {
                        aux5 = aux5 + 1;
                    }
                    tab = tab - 1;
                }
                if (aux === 0 & aux1 === 0 & aux2===0 &aux3===0 & aux4 ===0 &aux5 === 0 & g === 'GUA' || aux <= 1 & aux1 <= 1 & aux2 <= 1& aux3 <= 1& aux4 <= 1& aux5 <= 1 & g === 'ACT') {
                    return true;
                } else {
                    alert("Información duplicada, por favor ingrese datos válidos");
                    return false;
                }

            }
            function validar() {
                var a = null;
                var b = null;
                var c = null;
                a = campos();
                b = validaruc();
                c = redundancia();

                if (a === true & b === true & c=== true) {
                    return true;
                } else {

                    return false;
                }
            }

        </script>
    </head>


    <sql:query var="resul" dataSource="${con}">
        SELECT * FROM INVENTARIOSPI.INV_CLIENTES_PROVEEDORES WHERE CLP_TIPO = 'P'

    </sql:query>

    <body onload="cargar()">
    <center>
        <font color="white">
        <h1>Instituto Tecnológico Superior "Cordillera"<br>
            Sistema de Registro y Control de Inventarios</h1>
        <hr/>

        <h2>
            Registro de Proveedores
        </h2>

        <c:if test="${param.modificar == null}">



            <form method="post" id="data" onSubmit="return validar();" >

                <table border="0" cellspacing="8">
                    <tr>
                        <td>Razón Social*:</td>
                        <td><input type="text" name="raz" id="raz" size="40" maxlength="50" disabled  onkeyup="mayusculas()"/> </td>
                        <td>Nombre de Fantasía*:</td>
                        <td><input type='text' name="nom" id="nom" size="40" maxlength="50" disabled onkeyup="mayusculas()" ></td>
                    </tr>
                    <tr>
                    <br/>
                    <td>R.U.C*:</td>

                    <td><input type="text" name="ruc" id="ruc" size="40" maxlength="13" disabled onkeypress="return isNumberKey(event)" /></td>
                    <td>Dirección*:</td>
                    <td><input type="text" name="dir" id="dir" size="40" maxlength="100" disabled onkeyup="mayusculas()"> </td>


                    </tr>
                    <tr>
                        <td>Teléfono*:</td>
                        <td><input type="tel" name="tel" id="tel" size="40" maxlength="20" disabled onkeypress="return isNumberKey(event)"></td>
                        <td>Correo Electrónico*:</td>
                        <td><input type="email" name="cor" id="cor" size="40" maxlength="50" disabled  onkeyup="mayusculas()" > </td>
                        <td><input type="hidden" id="id" name="id"></td>
                    </tr>
                    <tr>

                        <td>Estado*:</td>
                        <td> <select name="est" id="est" style=" width:520px; " disabled>
                                <option value="0" >--SELECCIONE--</option>
                                <option value="A"selected>ACTIVO</option>
                                <option value="I">INACTIVO</option>

                            </select> </td>
                    </tr>
                    <tr><td colspan="2"><br>Los datos con (*) son obligatorios.</td></tr>
                </table>
                </font>
                <br>
                <br>
                <table >
                    <tr>
                        <td><input type="reset" value="Nuevo" size="80"  class="botones" onclick="nuevo(); resetear();"/> </td>
                        <td><input type="button" value="Editar" size="80" onclick="editar()" class="botones" id="edi" disabled/> </td>
                        <td><input type="submit" name="modifica" value="Actualizar"  id="act" class="botones"  disabled /></td>
                        <td><input type="submit" name="guardar" value="Guardar"  id="gua" class="botones" onclick="gua()" disabled /></td>
                        <td><input type="button" name="volver" value="Menu Principal" onclick="window.location.href = 'Men_MenúPrincipal.jsp'" class="botones" /></td>
                        <td><input type="hidden" name="modificar" id="mod" ></td>

                    </tr>
                    <tr height="100px">
                        <td colspan="2"><input type="search" results ="2" name="bus" id ="bus" class="bus"size="40"  onkeyup=" buscartabla(); mayusculas();" placeholder="Buscar..." align="center"></td>

                    </tr> 
                </table>
                <br>

                <div>
                    <table border="1" bg-color="white" style="border-collapse:collapse;"  class="tab" id="tbl" cellspacing="8">
                        <thead>
                        <th width="80px">Clave</th>
                        <th  width="300px">Razón Social</th>
                        <th  width="300px">Nombre de Fantasia</th>
                        <th  width="200px">R.U.C</th>
                        <th  width="300px">Direccion </th>
                        <th  width="100px">Telefono </th>
                        <th  width="200px">Correo Electrónico</th>
                        <th   width="70px">Estado </th>
                        </thead>
                        <tbody>
                            <c:forEach var="filas" items="${resul.rows}">
                                <c:set var="aux" value="${aux}+1" />
                                <tr style='cursor:pointer' onclick="recuperar(<c:out value="${aux}" />)" >
                                    <td width="80px" align="center">  <c:out value="${filas.CLP_ID}"/></td>
                                    <td width="300px" align="center">  <c:out value="${filas.CLP_RAZON_SOCIAL}"/></td>
                                    <td align="center" width="300px">  <c:out value="${filas.CLP_NOMBRE_FANTASIA}"/></td>
                                    <td  width="200 px" align="center">  <c:out value="${filas.CLP_DNI}"/></td>
                                    <td align="center"  width="300 px">  <c:out value="${filas.CLP_DIRECCION}"/></td>
                                    <td align="center" width="100 px">  <c:out value="${filas.CLP_TELEFONO}"/></td>        
                                    <td align="center" width="200 px">  <c:out value="${filas.CLP_CORREOELECTRONICO}"/></td>        
                                    <td align="center" width = '70px'>  <c:out value="${filas.CLP_ESTADO}"/></td>
                                </tr>
                            </c:forEach>


                        </tbody>
                    </table>
                </div>

            </form>

            <script>

                function nuevo() {

                    document.getElementById("mod").value = "GUA";
                    document.getElementById("gua").disabled = false;
                    document.getElementById("act").disabled = true;
                    document.getElementById("edi").disabled = true;

                    document.getElementById("raz").disabled = false;
                    document.getElementById("nom").disabled = false;
                    document.getElementById("ruc").disabled = false;
                    document.getElementById("dir").disabled = false;
                    document.getElementById("tel").disabled = false;
                    document.getElementById("cor").disabled = false;
                    document.getElementById("est").disabled = false;
                    document.getElementById("raz").focus();
                }

                function editar() {
                    document.getElementById("mod").value = "ACT";
                    document.getElementById("gua").disabled = true;
                    document.getElementById("act").disabled = false;

                    document.getElementById("raz").disabled = false;
                    document.getElementById("nom").disabled = false;
                    document.getElementById("ruc").disabled = false;
                    document.getElementById("dir").disabled = false;
                    document.getElementById("tel").disabled = false;
                    document.getElementById("cor").disabled = false;
                    document.getElementById("est").disabled = false;
                    document.getElementById("raz").focus();

                }
                function recuperar(fila) {

                    var a = document.getElementById("tbl").rows[fila].cells[0].innerText;
                    var b = document.getElementById("tbl").rows[fila].cells[1].innerText;
                    var c = document.getElementById("tbl").rows[fila].cells[2].innerText;
                    var d = document.getElementById("tbl").rows[fila].cells[3].innerText;
                    var e = document.getElementById("tbl").rows[fila].cells[4].innerText;
                    var f = document.getElementById("tbl").rows[fila].cells[5].innerText;
                    var g = document.getElementById("tbl").rows[fila].cells[6].innerText;
                    var h = document.getElementById("tbl").rows[fila].cells[7].innerText;

                    document.getElementById("id").value = a;
                    document.getElementById("raz").value = b;
                    document.getElementById("nom").value = c;
                    document.getElementById("ruc").value = d;
                    document.getElementById("dir").value = e;
                    document.getElementById("tel").value = f;
                    document.getElementById("cor").value = g;
                    document.getElementById("est").value = h;
                    var tab = document.getElementById("tbl").getElementsByTagName("tr").length;
                    tab = tab - 1;
                    while (tab > 0) {
                        document.getElementById("tbl").rows[tab].removeAttribute("bgcolor");
                        tab = tab - 1;
                    }
                    document.getElementById("tbl").rows[fila].setAttribute("bgcolor", "#ffffb3");

                    document.getElementById("raz").disabled = true;
                    document.getElementById("nom").disabled = true;
                    document.getElementById("ruc").disabled = true;
                    document.getElementById("dir").disabled = true;
                    document.getElementById("tel").disabled = true;
                    document.getElementById("cor").disabled = true;
                    document.getElementById("est").disabled = true;
                    document.getElementById("gua").disabled = true;
                    document.getElementById("edi").disabled = false;
                    document.getElementById("act").disabled = true;

                }

                function mayusculas() {
                    var a = document.getElementById("raz");
                    var b = document.getElementById("nom");
                    var c = document.getElementById("dir");
                    var d = document.getElementById("cor");
                    var e = document.getElementById("bus");

                    a.value = a.value.toUpperCase();
                    b.value = b.value.toUpperCase();
                    c.value = c.value.toUpperCase();
                    d.value = d.value.toLowerCase();
                    e.value = e.value.toUpperCase();
                }
                function isNumberKey(evt)
                {
                    var charCode = (evt.which) ? evt.which : event.keyCode;
                    if (charCode > 31 && (charCode < 48 || charCode > 57))
                        return false;

                    return true;
                }
                function resetear() {
                    document.getElementById("bus").value = "";
                    var $tabla = $('#tbl tbody tr');
                    var $tabl = $('#tabl');
                    $tabla.show();
                    $tabl.show();
                    var tab = document.getElementById("tbl").getElementsByTagName("tr").length;
                    tab = tab - 1;
                    while (tab > 0) {
                        document.getElementById("tbl").rows[tab].removeAttribute("bgcolor");
                        tab = tab - 1;
                    }
                }
                function buscartabla() {

                    var $tabla = $('#tbl tbody tr');
                    var x = document.getElementById("bus");
                    var val = $.trim(x.value).replace(/ +/g, ' ').toLowerCase();
                    $tabla.show().filter(function () {
                        var text = $(this).text().replace(/\s+/g, ' ').toLowerCase();
                        return !~text.indexOf(val);
                    }).hide();

                    var b = document.getElementById("id").value;
                    var SearchFieldsTable = $("#tbl tbody");

                    var trows = SearchFieldsTable[0].rows;
                    var aux = 1;
                    $.each(trows, function (index, row) {
                        var ColumnName = $(row).attr("style");
                        if (ColumnName.charAt(0) === "d") {
                            var a = document.getElementById("tbl").rows[aux].cells[0].innerText;
                            document.getElementById("tbl").rows[aux].removeAttribute("bgcolor");
                            if (a === b) {
                                document.getElementById("act").disabled = true;
                                document.getElementById("edi").disabled = true;
                                document.getElementById("id").value = "";
                                document.getElementById("raz").value = "";
                                document.getElementById("nom").value = "";
                                document.getElementById("ruc").value = "";
                                document.getElementById("dir").value = "";
                                document.getElementById("tel").value = "";
                                document.getElementById("cor").value = "";
                                document.getElementById("est").selected;
                                document.getElementById("raz").disabled = true;
                                document.getElementById("nom").disabled = true;
                                document.getElementById("ruc").disabled = true;
                                document.getElementById("dir").disabled = true;
                                document.getElementById("tel").disabled = true;
                                document.getElementById("cor").disabled = true;
                                document.getElementById("est").disabled = true;
                                document.getElementById("gua").disabled = true;
                            }

                        }
                        aux = aux + 1;
                    });
                }
            </script>
        </c:if>

        <c:if test="${param.modificar == 'ACT'}">

            <sql:update var="act" dataSource="${con}">
                UPDATE INVENTARIOSPI.INV_CLIENTES_PROVEEDORES
                SET  CLP_RAZON_SOCIAL = '${param.raz}'
                ,CLP_NOMBRE_FANTASIA= '${param.nom}'
                ,CLP_TIPODNI= 'R'
                ,CLP_DNI= '${param.ruc}'
                ,CLP_DIRECCION= '${param.dir}'
                ,CLP_TELEFONO= '${param.tel}'
                ,CLP_CORREOELECTRONICO= '${param.cor}'
                ,CLP_TIPO= 'P'
                ,CLP_ESTADO= '${param.est}'
                WHERE CLP_ID = '${param.id}'
            </sql:update>

            </font>
            <form action="Man_Proveedores.jsp">

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


            <sql:query var="resultado" dataSource="${con}">
                SELECT * FROM INVENTARIOSPI.INV_CLIENTES_PROVEEDORES 

            </sql:query>
            <% int count = 0; %>
            <c:forEach var="columnas" items="${resultado.rows}">
                <%count = count + 1;%>
            </c:forEach>

            <sql:update var="gua" dataSource="${con}">
                INSERT INTO INVENTARIOSPI.INV_CLIENTES_PROVEEDORES (
                CLP_ID,
                CLP_RAZON_SOCIAL, 
                CLP_NOMBRE_FANTASIA, 
                CLP_TIPODNI, 
                CLP_DNI, 
                CLP_DIRECCION, 
                CLP_TELEFONO,
                CLP_CORREOELECTRONICO, 
                CLP_TIPO, 
                CLP_ESTADO) 
                VALUES ('<%=count + 1%>', '${param.raz}', '${param.nom}', 'R', '${param.ruc}', '${param.dir}', '${param.tel}', '${param.cor}', 'P', '${param.est}');

            </sql:update>
            </font>
            <form action="Man_Proveedores.jsp" method='post'>
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
