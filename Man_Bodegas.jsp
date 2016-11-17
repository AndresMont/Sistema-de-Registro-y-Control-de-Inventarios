<%-- 
    Document   : Man_Sucursales
    Created on : 05-jul-2016, 16:17:29
    Author     : Andesign
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Bodegas</title>
        <link href="Seg_Validación.css" rel="stylesheet" type="text/css">
    </head>
    <sql:setDataSource driver="com.mysql.jdbc.Driver"
                       url="jdbc:mysql://localhost:3306/inventariospi?zeroDateTimeBehavior=convertToNull"
                       user="root"
                       password="System19"
                       var="con"
                       />
    <script src="jquery-3.1.0.min.js"></script>
    <script type="text/javascript">
        function campos() {
            var a = document.getElementById("des");
            var b = document.getElementById("dir");

            var c = document.getElementById("suc");
            var d = document.getElementById("est");

            if (a.value !== "" & b.value !== "" & c.value !== "0" & d.value !== "0") {

                return true;


            } else {

                alert('Por favor, complete todos los campos obligatorios');
                return false;

            }
        }

        function redundancia() {


            var tab = document.getElementById("bodegas").getElementsByTagName("tr").length;
            tab = tab - 1;
            var a = document.getElementById("des").value;
            var b = document.getElementById("dir").value;
            var c = document.getElementById("val").value;
            var d = document.getElementById("id").value;
            var aux = 0, aux1 = 0;
            var w = 0, x = 0, y = 0;

            while (tab !== 0) {
                w = document.getElementById("bodegas").rows[tab].cells[0].innerText;
                x = document.getElementById("bodegas").rows[tab].cells[2].innerText;
                y = document.getElementById("bodegas").rows[tab].cells[3].innerText;
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
                    alert("Información duplicada, por favor ingrese una descripción válida");

                }
                if (c === 'GUA' & aux1 !== 0 || c === 'ACT' & aux1 > 0) {
                    alert("Información duplicada, por favor ingrese una dirección válida");

                }
                return false;
            }

        }

        function validar() {
            $('.hab').removeAttr('disabled');
            var a = null;
            var b = null;
            a = campos();
            b = redundancia();
            if (a === true & b === true) {
                return true;
            } else {
                return false;
            }

        }
    </script>

    <sql:query var="resultado" dataSource="${con}">
        SELECT * FROM INVENTARIOSPI.V_BODEGAS

    </sql:query>

    <sql:query var="resul" dataSource="${con}">
        SELECT * FROM INVENTARIOSPI.INV_SUCURSALES WHERE SUC_ESTADO = 'A'
    </sql:query>
    <body>

    <center>
        <font color="white">
        <h1>Instituto Tecnológico Superior "Cordillera"<br>
            Sistema de Registro y Control de Inventarios</h1>
        <hr/>

        <h2>
            Registro de Bodegas
        </h2>
        <c:if test="${param.modificar == null}">



            <form method="post" onSubmit="return validar();">


                <table border="0" cellspacing="8">
                    <tbody>
                        <tr>
                            <td>Descripción*:</td>
                            <td><input type="text" name="des" size="40" id="des" maxlength="50" disabled onkeyup="mayusculas()"></td>
                            <td>Dirección*:</td>
                            <td><input type="text" name="dir" size="40" id="dir" maxlength="50" disabled onkeyup="mayusculas()"></td>
                        </tr>

                        <tr>

                            <td>Sucursal*:</td>
                            <td>
                                <select name="suc" id="suc" style=" width:520px; " disabled >
                                    <option value="0" >--SELECCIONE--</option>
                                    <c:forEach var="col" items="${resul.rows}"> 
                                        <option value="${col.SUC_ID}">${col.SUC_DESCRIPCION}</option>
                                    </c:forEach>
                                </select>
                            </td>
                            <td>Estado*:</td>
                            <td> <select name="est" id="est" style=" width:520px; " disabled>
                                    <option value="0" >--SELECCIONE--</option>
                                    <option value="A" selected>ACTIVO</option>
                                    <option value="I">INACTIVO</option>

                                </select> </td>
                    <input type="hidden" name="id" id="id">
                    </tr>
                    <tr><td colspan="2"><br>Los datos con (*) son obligatorios.</td></tr>

                    </tbody>
                </table>
                </font>
                <BR>
                <BR>
                <table >
                    <tr>
                        <td><input type="reset" value="Nuevo" size="80"  class="botones" onclick="nuevo();
                                resetear();"/> </td>
                        <td><input type="button" value="Editar" size="80" onclick="editar()" class="botones" id="edi" disabled/> </td>
                        <td><input type="submit" name="modifica" value="Actualizar"  id="act" class="botones"  disabled /></td>
                        <td><input type="submit" name="guardar" value="Guardar"  id="gua" class="botones"  disabled /></td>
                        <td><input type="button" name="volver" value="Menu Principal" onclick="window.location.href = 'Men_MenúPrincipal.jsp'" class="botones" /></td>
                        <td><input type="hidden" name="modificar" id="val" ></td>

                    </tr>
                    <tr height="100px">
                        <td colspan="2"><input type="search" results ="2" name="bus" id ="bus" class="bus"  size="40"  onkeyup="mayusculas();buscartabla();" placeholder="Buscar..." align="center"></td>

                    </tr>  
                </table>
                <br>
                <br>
                <table border="1" bg-color="white" style="border-collapse:collapse;" class="tab" id="bodegas" cellspacing="8">
                    <thead>
                    <th width='70px'>Clave</th>
                    <th>Sucursal</th>
                    <th>Descripción</th>
                    <th>Ubicación</th>
                    <th>Estado</th>
                    </thead>
                    <tbody>
                        <c:forEach var="columnas" items="${resultado.rows}">
                            <tr  style='cursor:pointer;' onclick="recuperar(${columnas.BOD_ID},${columnas.SUC_ID})">
                                <td align="center">  <c:out value="${columnas.BOD_ID}"/> </td>
                                <td align="center">  <c:out value="${columnas.SUC_DESCRIPCION}"/></td>
                                <td align="center" width="500px" >  <c:out value="${columnas.BOD_DESCRIPCION}"/></td>
                                <td align="center" width="500px" >  <c:out value="${columnas.BOD_UBICACION}"/></td>
                                <td aling="center">  <c:out value="${columnas.BOD_ESTADO}"/></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

            </form>
            <script>
                function nuevo() {
                    document.getElementById("des").disabled = false;
                    document.getElementById("suc").disabled = false;
                    document.getElementById("dir").disabled = false;
                    document.getElementById("est").disabled = false;
                    document.getElementById("gua").disabled = false;

                    document.getElementById("edi").disabled = true;
                    document.getElementById("des").focus();
                    document.getElementById("val").value = "GUA";

                }
                function editar() {
                    document.getElementById("des").disabled = false;
                    document.getElementById("dir").disabled = false;
                    document.getElementById("suc").disabled = false;
                    document.getElementById("est").disabled = false;

                    document.getElementById("act").disabled = false;
                    document.getElementById("gua").disabled = true;
                    document.getElementById("val").value = "ACT";
                }
                function recuperar(fila, sucu) {
                    var a = document.getElementById("bodegas").rows[fila].cells[0].innerText;
                    var b = document.getElementById("bodegas").rows[fila].cells[1].innerText;
                    var c = document.getElementById("bodegas").rows[fila].cells[2].innerText;
                    var d = document.getElementById("bodegas").rows[fila].cells[3].innerText;
                    var e = document.getElementById("bodegas").rows[fila].cells[4].innerText;

                    document.getElementById("id").value = a;

                    //  var x = $('#suc option:disabled').value;
                    // alert(x);
                    //  document.getElementById("suc").remove(x);
                    document.getElementById("suc").value = sucu;
                    if (document.getElementById("suc").value === "") {
                        $('select[name =suc]').append('<option value ="' + sucu + '" class="hab" disabled>' + b + '(INACTIVO)</option>');
                    }

                    document.getElementById("suc").value = sucu;
                    var tab = document.getElementById("bodegas").getElementsByTagName("tr").length;
                    tab = tab - 1;
                    while (tab > 0) {
                        document.getElementById("bodegas").rows[tab].removeAttribute("bgcolor");
                        tab = tab - 1;
                    }
                    document.getElementById("bodegas").rows[fila].setAttribute("bgcolor", "#ffffb3");

                    document.getElementById("des").value = "" + c;
                    document.getElementById("dir").value = "" + d;

                    document.getElementById("est").value = e;
                    document.getElementById("des").disabled = true;
                    document.getElementById("dir").disabled = true;
                    document.getElementById("suc").disabled = true;
                    document.getElementById("est").disabled = true;
                    document.getElementById("edi").disabled = false;
                    document.getElementById("gua").disabled = true;

                }
                function mayusculas() {
                    var a = document.getElementById("des");
                    var b = document.getElementById("dir");
                    var c = document.getElementById("bus");
                    a.value = a.value.toUpperCase();
                    b.value = b.value.toUpperCase();
                    c.value = c.value.toUpperCase();
                }
                function resetear() {
                    document.getElementById("bus").value = "";
                    var $bodegas = $('#bodegas tbody tr');
                    var $tabl = $('#tabl');
                    $bodegas.show();
                    $tabl.show();
                    var tab = document.getElementById("bodegas").getElementsByTagName("tr").length;
                    tab = tab - 1;
                    while (tab > 0) {
                        document.getElementById("bodegas").rows[tab].removeAttribute("bgcolor");
                        tab = tab - 1;
                    }
                }
                function buscartabla() {

                    var $bodegas = $('#bodegas tbody tr');
                    var x = document.getElementById("bus");
                    var val = $.trim(x.value).replace(/ +/g, ' ').toLowerCase();
                    $bodegas.show().filter(function () {
                        var text = $(this).text().replace(/\s+/g, ' ').toLowerCase();
                        return !~text.indexOf(val);
                    }).hide();

                    var b = document.getElementById("id").value;
                    var SearchFieldsTable = $("#bodegas tbody");

                    var trows = SearchFieldsTable[0].rows;
                    var aux = 1;
                    $.each(trows, function (index, row) {
                        var ColumnName = $(row).attr("style");
                        if (ColumnName.charAt(0) === "d") {
                            var a = document.getElementById("bodegas").rows[aux].cells[0].innerText;
                            document.getElementById("bodegas").rows[aux].removeAttribute("bgcolor");
                            if (a === b) {
                                document.getElementById("des").disabled = true;
                                document.getElementById("dir").disabled = true;
                                document.getElementById("suc").disabled = true;
                                document.getElementById("est").disabled = true;
                                document.getElementById("edi").disabled = true;
                                   document.getElementById("act").disabled = true;
                                document.getElementById("gua").disabled = true;
                                document.getElementById("suc").value = "0";
                                document.getElementById("des").value = "";
                                document.getElementById("dir").value = "";
                                document.getElementById("est").value = "A";
                            }

                        }
                        aux = aux + 1;
                    });
                }



            </script>

        </c:if>

        <c:if test="${param.modificar == 'ACT'}">



            </font>
            <form action="Man_Bodegas.jsp" method='post' onload="habilitar()">
                <sql:update var="act" dataSource="${con}">
                    UPDATE INVENTARIOSPI.INV_BODEGAS SET
                    EMP_ID = '1'
                    ,SUC_ID ='${param.suc}'
                    ,BOD_DESCRIPCION ='${param.des}'
                    ,BOD_UBICACION='${param.dir}'
                    ,BOD_ESTADO='${param.est}'
                    WHERE BOD_ID='${param.id}'
                </sql:update> 
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


            </font>
            <form action="Man_Bodegas.jsp" method='post' >
                <sql:query var="count" dataSource="${con}">
                    SELECT COUNT(*) CON FROM INVENTARIOSPI.INV_BODEGAS
                </sql:query>

                <c:forEach var="columnas" items="${count.rows}">
                    <c:set var="cont" value="${columnas.CON}"/>
                </c:forEach>

                <sql:update var="gua" dataSource="${con}">
                    INSERT INTO INVENTARIOSPI.INV_BODEGAS (
                    BOD_ID
                    ,EMP_ID
                    ,SUC_ID
                    ,BOD_DESCRIPCION 
                    ,BOD_UBICACION 
                    ,BOD_ESTADO)
                    VALUES ('${cont+1}','1','${param.suc}','${param.des}','${param.dir}','${param.est}')
                </sql:update>
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
