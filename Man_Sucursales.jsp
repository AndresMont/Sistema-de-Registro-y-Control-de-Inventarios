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
        <sql:setDataSource driver="com.mysql.jdbc.Driver"
                           url="jdbc:mysql://localhost:3306/inventariospi?zeroDateTimeBehavior=convertToNull"
                           user="root"
                           password="System19"
                           var="con"
                           />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sucursales</title>
        <link href="Seg_Validación.css" rel="stylesheet" type="text/css">
        <script src="jquery-3.1.0.min.js"></script>
        <script src="ajax.js"></script>
        <script type="text/javascript">
            function campos() {

                var a = document.getElementById("des");
                var b = document.getElementById("pro");
                var c = document.getElementById("cant");
                var d = document.getElementById("dir");
                var e = document.getElementById("tel");
                var f = document.getElementById("cor");
                var h = document.getElementById("est");
                var lon = e.value.length;

                if (a.value !== "" & b.value !== "0" & c.value !== "0" & d.value !== "" & e.value !== "" & lon >= 7 & f.value !== "" & h.value !== "0") {

                    return true;
                } else {
                    if (lon > 0 & lon < 7) {
                        alert('Por favor, ingrese un número de teléfono válido');
                    } else {
                        alert('Por favor, complete los campos obligatorios');
                    }
                    return false;
                }
            }
            function redundancia() {

                var tab = document.getElementById("sucursales").getElementsByTagName("tr").length;
                tab = tab - 1;
                var a = document.getElementById("des").value;
                var b = document.getElementById("dir").value;
                var c = document.getElementById("tel").value;
                var d = document.getElementById("cor").value;
                var e = document.getElementById("val").value;
                var f = document.getElementById("id").value;
                var aux = 0, aux1 = 0, aux2 = 0, aux3 = 0;
                var v = 0, x = 0, y = 0, w = 0, z = 0;


                while (tab !== 0) {
                    v = document.getElementById("sucursales").rows[tab].cells[0].innerText;
                    w = document.getElementById("sucursales").rows[tab].cells[1].innerText;
                    x = document.getElementById("sucursales").rows[tab].cells[4].innerText;
                    y = document.getElementById("sucursales").rows[tab].cells[6].innerText;
                    z = document.getElementById("sucursales").rows[tab].cells[7].innerText;
                    if (a === w & e === 'ACT' & f !== v || a === w & e === 'GUA') {
                        aux = aux + 1;
                    }
                    if (b === x & e === 'ACT' & f !== v || b === x & e === 'GUA') {
                        aux1 = aux1 + 1;
                    }
                    if (c === y & e === 'ACT' & f !== v || c === y & e === 'GUA') {
                        aux2 = aux2 + 1;
                    }
                    if (d === z & e === 'ACT' & f !== v || d === z & e === 'GUA') {
                        aux3 = aux3 + 1;
                    }
                    tab = tab - 1;

                }
   
                if (aux === 0 & aux1 === 0 & aux2 === 0 & aux3 === 0 & e === 'GUA' || aux === 0 & aux1 === 0 & aux2 === 0 & aux3 === 0 & e === 'ACT') {
                    return true;
                } else {
                    if (aux !== 0 & e === 'GUA' || aux > 0 & e === 'ACT') {
                        alert("Información duplicada, por favor ingrese una descripción válida");
                    }
                    if (aux1 !== 0 & e === 'GUA' || aux1 > 0 & e === 'ACT') {
                        alert("Información duplicada, por favor ingrese una dirección válida");
                    }
                    if (aux2 !== 0 & e === 'GUA' || aux2 > 0 & e === 'ACT') {
                        alert("Información duplicada, por favor ingrese un número de teléfono válido");
                    }
                    if (aux3 !== 0 & e === 'GUA' || aux3 > 0 & e === 'ACT') {
                        alert("Información duplicada, por favor ingrese  un correo electrónico válido");
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
            }
        </script>
    </head>

    <sql:query var="resultado" dataSource="${con}">
        SELECT * FROM INVENTARIOSPI.INV_SUCURSALES

    </sql:query>
    <sql:query var="cantones" dataSource="${con}">
        SELECT * FROM INVENTARIOSPI.INV_CANTONES
    </sql:query>  
    <sql:query var="provincias" dataSource="${con}">
        SELECT * FROM INVENTARIOSPI.INV_PROVINCIAS 
    </sql:query>     

    <% int aux = 0, aux2 = 0; %>
    <c:forEach var="colu" items="${resultado.rows}"  >
        <% aux = aux + 1;%>
    </c:forEach>

    <sql:query var="provi" dataSource="${con}">
        SELECT * FROM INVENTARIOSPI.INV_PROVINCIAS P, INVENTARIOSPI.INV_CANTONES C WHERE P.PRV_ID = C.PRV_ID AND(
        <c:forEach var="colum" items="${resultado.rows}">
            <%aux2 = aux2 + 1;%>    

            (C.PRV_ID = '${colum.PRV_ID}' AND
            P.PRV_ID = '${colum.PRV_ID}')
            <%if (aux != aux2) {%>
            OR
            <%}%>

        </c:forEach>)
    </sql:query>     

    <body>

    <center>
        <font color="white">
        <h1>Instituto Tecnológico Superior "Cordillera"<br>
            Sistema de Registro y Control de Inventarios</h1>
        <hr/>

        <h2>
            Registro de Sucursales
        </h2>
        <c:if test="${param.modificar == null}">

            <form method="post" id="data" onSubmit="return validar();" >


                <table border="0" cellspacing="8">
                    <tbody>
                        <tr>
                            <td>Descripción*:</td>
                            <td><input type="text" name="desc" size="40" id="des" maxlength="50" disabled onkeyup="mayusculas()"></td>
                            <td>Provincia*:</td>
                            <td> <select name="pro" id="pro" style=" width:520px; " disabled>
                                    <option value="0" selected>--SELECCIONE--</option>
                                    <c:forEach var="col" items="${provincias.rows}"> 
                                        <option value="${col.PRV_ID}"  >${col.PRV_DESCRIPCION}  </option>
                                    </c:forEach>
                                </select> 
                            </td>
                        </tr>

                        <tr>
                            <td>Cantón*:</td>
                            <td> <select name="cant" id="cant"  style=" width:520px; " disabled>
                                    <option value="0" selected>--SELECCIONE--</option>


                                </select> 
                            </td>
                            <td>Sector:</td>
                            <td><select name="sect" id="sec" style="width:520px; " disabled>
                                    <option value="-" selected>--SELECCIONE--</option>
                                    <option value="N">NORTE</option>
                                    <option value="S">SUR</option>
                                    <option value="C">CENTRO</option>

                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>Dirección*:</td>
                            <td><input type="text" name="dire" size="40" id="dir" maxlength="200" disabled onkeyup="mayusculas()"></td>
                            <td>Teléfono*:</td>
                            <td><input type="text" name="telf" size="40" id="tel" maxlength="12" disabled onkeypress="return isNumberKey(event)"></td>

                        </tr>
                        <tr>
                            <td>Correo Electrónico *:</td>
                            <td><input type="email" name="corr" size="40" id="cor" maxlength="50" disabled onkeyup="mayusculas()"></td>
                            <td>Estado*:</td>
                            <td> <select name="est" id="est" style=" width:520px; " disabled>
                                    <option value="0" >--SELECCIONE--</option>
                                    <option value="A" selected>ACTIVO</option>
                                    <option value="I">INACTIVO</option>

                                </select> </td>
                            <td><input type="hidden" name="id" id="id" /></td>
                            <td><input type="hidden" name="aux" id="aux" /></td>
                        </tr>
                        <tr><td colspan="2"><br>Los datos con (*) son obligatorios.</td></tr>
                    </tbody>
                </table>
                </font>
                <br>
                <br>
                <table >
                    <tr>
                        <td><input type="reset" value="Nuevo" size="80"  class="botones" onclick="nuevo();
                                resetear();"/> </td>
                        <td><input type="button" value="Editar" size="80" onclick="editar()" class="botones" id="edi" disabled/> </td>
                        <td><input type="submit" name="modifica" value="Actualizar"  id="act" class="botones"  disabled /></td>
                        <td><input type="submit" name="guardar" value="Guardar"  id="gua" class="botones" onclick="gua()" disabled /></td>
                        <td><input type="button" name="volver" value="Menu Principal" onclick="window.location.href = 'Men_MenúPrincipal.jsp'" class="botones" /></td>
                        <td><input type="hidden" name="modificar" id="val" ></td>

                    </tr>

                    <tr height="100px">
                        <td colspan="2"><input type="search" results ="2" name="bus" id ="bus" class="bus"size="40"  onkeyup="mayusculas();
                                buscartabla();" placeholder="Buscar..." align="center"></td>

                    </tr>                
                </table>

                <br>

                <table border="1" bg-color="white" style="border-collapse:collapse;" class="tab" id="sucursales" cellspacing="8" >
                    <thead>
                    <th width='70px'>Clave</th>

                    <th>Descripción</th>
                    <th>Provincia</th>
                    <th>Cantón</th>         
                    <th>Dirección</th>
                    <th>Sector</th>
                    <th width='70px'>Teléfono</th>
                    <th>Correo Electrónico</th>
                    <th>Estado</th>
                    </thead>
                    <tbody>
                        <c:forEach var="columnas" items="${resultado.rows}">
                            <c:set var="aux" value="0"/>     <c:set var="aux2" value="0"/>
                            <tr  style='cursor:pointer'  onmousedown="cantones(${columnas.PRV_ID});
                                    recuperar(${columnas.suc_id});" onmouseup="canton(${columnas.CAN_ID})">

                                <td align="center">  <c:out value="${columnas.suc_id}"/></td>
                                <td width='200px'>  <c:out value="${columnas.suc_descripcion}"/></td>
                                <c:forEach var="cols" items="${provi.rows}">
                                    <c:if test="${columnas.PRV_ID == cols.PRV_ID and aux!=1}"  >
                                        <td align="center">  <c:out value="${cols.PRV_DESCRIPCION}"/></td>
                                        <c:set var="aux" value="1"/>
                                    </c:if>
                                    <c:if test="${columnas.CAN_ID == cols.CAN_ID and aux2!=1}"  >
                                        <td align="center">  <c:out value="${cols.CAN_DESCRIPCION}"/></td>
                                        <c:set var="aux2" value="1"/>
                                    </c:if> 
                                </c:forEach>
                                <td width='400px'>  <c:out value="${columnas.suc_direccion}"/></td>
                                <td align="center">  <c:out value="${columnas.suc_sector}"/></td>

                                <td width='100px'>  <c:out value="${columnas.suc_telefono}"/></td>
                                <td width='200px'>  <c:out value="${columnas.suc_correoelectronico}"/></td>
                                <td align="center">  <c:out value="${columnas.suc_estado}"/></td>
                            </tr>

                        </c:forEach>
                    </tbody>
                </table>

            </form>
            <script>

                function nuevo() {
                    document.getElementById("des").disabled = false;
                    document.getElementById("pro").disabled = false;
                    document.getElementById("cant").disabled = false;
                    document.getElementById("sec").disabled = false;
                    document.getElementById("dir").disabled = false;
                    document.getElementById("tel").disabled = false;
                    document.getElementById("cor").disabled = false;
                    document.getElementById("des").focus();
                    document.getElementById("act").disabled = true;
                    document.getElementById("edi").disabled = true;
                    document.getElementById("gua").disabled = false;
                    document.getElementById("est").disabled = false;
                    document.getElementById("val").value = "GUA";
                    $('select[name =cant] option').remove();
                    $('select[name =cant]').append('<option value ="0">--SELECCIONE--</option>');
                    document.getElementById("est").selectedIndex = "0";
                }
                function editar() {
                    document.getElementById("des").disabled = false;
                    document.getElementById("pro").disabled = false;
                    document.getElementById("cant").disabled = false;
                    document.getElementById("sec").disabled = false;
                    document.getElementById("dir").disabled = false;
                    document.getElementById("tel").disabled = false;
                    document.getElementById("cor").disabled = false;
                    document.getElementById("act").disabled = false;
                    document.getElementById("est").disabled = false;
                    document.getElementById("gua").disabled = true;
                    document.getElementById("val").value = "ACT";
                }


                function recuperar(fila, can) {
                    var a = document.getElementById("sucursales").rows[fila].cells[0].innerText;
                    var b = document.getElementById("sucursales").rows[fila].cells[1].innerText;
                    var e = document.getElementById("sucursales").rows[fila].cells[5].innerText;
                    var f = document.getElementById("sucursales").rows[fila].cells[4].innerText;
                    var g = document.getElementById("sucursales").rows[fila].cells[6].innerText;
                    var h = document.getElementById("sucursales").rows[fila].cells[7].innerText;
                    var i = document.getElementById("sucursales").rows[fila].cells[8].innerText;
                <c:set value="fila" var="fila" />
                <c:forEach var="colus" items="${resultado.rows}">
                    if (${colus.SUC_ID} === ${fila}) {
                        var c = "${colus.PRV_ID}";
                    }
                </c:forEach>

                    //alert(can);
                    document.getElementById("pro").value = c;

                    document.getElementById("id").value = a;
                    document.getElementById("des").value = b;
                    document.getElementById("sec").value = e;
                    document.getElementById("est").value = i;
                    document.getElementById("dir").value = f;
                    document.getElementById("tel").value = g;
                    document.getElementById("cor").value = h;

                    var tab = document.getElementById("sucursales").getElementsByTagName("tr").length;
                    tab = tab - 1;
                    while (tab > 0) {
                        document.getElementById("sucursales").rows[tab].removeAttribute("bgcolor");
                        tab = tab - 1;
                    }
                    document.getElementById("sucursales").rows[fila].setAttribute("bgcolor", "#ffffb3");

                    document.getElementById("edi").disabled = false;
                    document.getElementById("des").disabled = true;
                    document.getElementById("pro").disabled = true;
                    document.getElementById("cant").disabled = true;
                    document.getElementById("sec").disabled = true;
                    document.getElementById("dir").disabled = true;
                    document.getElementById("tel").disabled = true;
                    document.getElementById("cor").disabled = true;
                    document.getElementById("gua").disabled = true;
                    document.getElementById("est").disabled = true;

                }

                function cantones(PRO) {
                    $.ajax({
                        type: 'GET',
                        url: 'Con_Man_Empresa',
                        data: 'codigoprovincia=' + PRO,
                        statusCode: {
                            404: function () {
                                alert('Pagina no encontrada');
                                console.log('404');
                            },
                            500: function () {
                                alert('Error en el servidor');
                                console.log('500');
                            }
                        },
                        success: function (dados) {
                            $('select[name =cant] option').remove();
                            var separar = dados.split(":");

                            for (var i = 0; i < separar.length - 1; i++) {
                                var codigocanton = separar[i].split("-")[0];
                                var nombrecanton = separar[i].split("-")[1];
                                $('select[name =cant]').append('<option value ="' + codigocanton + '">' + nombrecanton + '</option>');
                            }
                        }
                    });
                }
                function canton(can) {
                    document.getElementById("aux").value = can;
                    document.getElementById("cant").value = document.getElementById("aux").value;
                }


                function mayusculas() {
                    var a = document.getElementById("des");
                    var b = document.getElementById("dir");
                    var c = document.getElementById("cor");
                    var d = document.getElementById("bus");
                    a.value = a.value.toUpperCase();
                    b.value = b.value.toUpperCase();
                    c.value = c.value.toLowerCase();
                    d.value = d.value.toUpperCase();

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
                    var $sucursales = $('#sucursales tbody tr');
                    var $tabl = $('#tabl');
                    $sucursales.show();
                    $tabl.show();
                    var tab = document.getElementById("sucursales").getElementsByTagName("tr").length;
                    tab = tab - 1;
                    while (tab > 0) {
                        document.getElementById("sucursales").rows[tab].removeAttribute("bgcolor");
                        tab = tab - 1;
                    }
                }
                function buscartabla() {

                    var $sucursales = $('#sucursales tbody tr');
                    var x = document.getElementById("bus");
                    var val = $.trim(x.value).replace(/ +/g, ' ').toLowerCase();
                    $sucursales.show().filter(function () {
                        var text = $(this).text().replace(/\s+/g, ' ').toLowerCase();
                        return !~text.indexOf(val);
                    }).hide();

                    var b = document.getElementById("id").value;
                    var SearchFieldsTable = $("#sucursales tbody");

                    var trows = SearchFieldsTable[0].rows;
                    var aux = 1;
                    $.each(trows, function (index, row) {
                        var ColumnName = $(row).attr("style");
                        if (ColumnName.charAt(0) === "d") {
                            var a = document.getElementById("sucursales").rows[aux].cells[0].innerText;
                            document.getElementById("sucursales").rows[aux].removeAttribute("bgcolor");
                            if (a === b) {
                                document.getElementById("edi").disabled = false;
                                document.getElementById("des").disabled = true;
                                document.getElementById("pro").disabled = true;
                                document.getElementById("cant").disabled = true;
                                document.getElementById("sec").disabled = true;
                                document.getElementById("dir").disabled = true;
                                document.getElementById("tel").disabled = true;
                                document.getElementById("cor").disabled = true;
                                document.getElementById("gua").disabled = true;
                                document.getElementById("est").disabled = true;
                                document.getElementById("pro").value = "0";
                                $('select[name =cant] option').remove();
                                $('select[name =cant]').append('<option value ="0">--SELECCIONE--</option>');
                                document.getElementById("cant").value = "0";
                                document.getElementById("id").value = "";
                                document.getElementById("des").value = "";
                                document.getElementById("sec").value = "-";
                                document.getElementById("est").value = "A";
                                document.getElementById("dir").value = "";
                                document.getElementById("tel").value = "";
                                document.getElementById("cor").value = "";
                                document.getElementById("cant").value = "0";

                            }

                        }
                        aux = aux + 1;
                    });
                }



            </script>

        </c:if>

        <c:if test="${param.modificar == 'ACT'}">



            <sql:update var="act" dataSource="${con}">
                UPDATE INVENTARIOSPI.INV_SUCURSALES SET
                EMP_ID = '1'
                ,PRV_ID ='${param.pro}'
                ,CAN_ID ='${param.cant}'
                ,SUC_DESCRIPCION ='${param.desc}'
                ,SUC_SECTOR = '${param.sect}'
                ,SUC_DIRECCION='${param.dire}'
                ,SUC_TELEFONO='${param.telf}'
                ,SUC_CORREOELECTRONICO='${param.corr}'
                ,SUC_ESTADO='${param.est}'
                WHERE SUC_ID='${param.id}'
            </sql:update> 
            </font>
            <form action="Man_Sucursales.jsp" method='post'>

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
            <% int cont = 0;%>

            <c:forEach var="cols" items="${resultado.rows}">
                <%cont = cont + 1;%>
            </c:forEach>

            <sql:update dataSource="${con}" var="gua" >
                INSERT INTO inventariospi.inv_sucursales (SUC_ID, EMP_ID, PRV_ID, CAN_ID, SUC_DESCRIPCION, SUC_SECTOR, SUC_DIRECCION, SUC_TELEFONO, SUC_CORREOELECTRONICO, SUC_ESTADO) 
                VALUES ('<%=cont + 1%>','1','${param.pro}','${param.cant}','${param.desc}','${param.sect}','${param.dire}','${param.telf}','${param.corr}','${param.est}')
            </sql:update> 

            </font>
            <form action="Man_Sucursales.jsp" method='post' onload="alert(${con});">
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
