<%-- 
    Document   : Man_Empresa
    Created on : 03-jun-2016, 21:27:41
    Author     : Andesign
--%>

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
        <title>Informacion Empresa</title>
        <link href="Seg_Validación.css" rel="stylesheet" type="text/css">
        <script src="jquery-3.1.0.min.js"></script>
        <script src="ajax.js"></script>
        <script type="text/javascript">


            function validaruc(num) {

                nombre = $('#ruc').val();
                ruc = nombre.split('');
                if (nombre.length > 12 & ruc[10] == '0' & ruc[11] == '0' & ruc[12] == '1') {

                    return true;
                } else {
                    if (nombre.length != 0) {
                        alert('Por favor, ingrese un número de RUC válido');
                    }
                    return false;

                }
            }
            function validapagina() {
                var aux = 0;
                pag = $('#pagina').val();
                pagi = pag.split('');
                for (var i = 0; i < pag.length; i++) {
                    if (pagi[i] == ".") {
                        aux = aux + 1;
                    }
                }
                if (pagi[0] == 'w' & pagi[1] == 'w' & pagi[2] == 'w' & pagi[3] == '.' & aux >= 2) {
                    return true;
                } else {
                    if (pag.length != 0) {
                        alert('Por favor, ingrese una página web válida');
                    }
                    return false;
                }
            }

            function campos() {
                var a = document.getElementById("razon");
                var b = document.getElementById("nom");
                var c = document.getElementById("ruc");
                var d = document.getElementById("direc");
                var e = document.getElementById("tel");
                var f = document.getElementById("correo");
                var g = document.getElementById("pagina");
                var h = document.getElementById("mision");
                var i = document.getElementById("vision");
                var j = document.getElementById("cant");
                var k = document.getElementById("pro");

                if (a.value != "" & b.value != "" & d.value != "" & c.value != "" & e.value != "" & f.value != "" & g.value != "" & h.value != "" & i.value != "" & j.value != "0" & k.value != "0") {

                    return true;


                } else {

                    alert('Por favor, complete todos los campos');
                    return false;

                }
            }
            function validar() {
                var a = null;
                var b = null;
                var c = null;
                a = campos();
                b = validaruc();
                c = validapagina();
                if (a == true & b == true & c == true) {
                    return true;
                } else {

                    return false;
                }
            }

        </script>
    </head>


    <sql:query var="resultado" dataSource="${con}">
        SELECT * FROM INVENTARIOSPI.INV_EMPRESA 

    </sql:query>
    <sql:query var="provincias" dataSource="${con}">
        SELECT * FROM INVENTARIOSPI.INV_PROVINCIAS 
    </sql:query>   

    <sql:query var="cantones" dataSource="${con}">
        SELECT * FROM INVENTARIOSPI.INV_CANTONES C, INVENTARIOSPI.INV_PROVINCIAS P WHERE C.PRV_ID = P.PRV_ID AND P.PRV_ID = 
        <c:forEach var="rev" items="${resultado.rows}">
            <c:out value="${rev.PRV_ID}"/>
            <c:set var="num" value="${rev.PRV_ID}" />
        </c:forEach>
        ORDER BY CAN_DESCRIPCION
    </sql:query>     


    <body onload="cargar()">
    <center>
        <font color="white">
        <h1>Instituto Tecnológico Superior "Cordillera"<br>
            Sistema de Registro y Control de Inventarios</h1>
        <hr/>

        <h2>
            Registro de datos de la empresa
        </h2>

        <c:if test="${param.modificar == null}">



            <form method="post" id="data" onSubmit="return validar();" >

                <table border="0" cellspacing="8">
                    <tr>
                        <td>Razón Social*:</td>
                        <td><input type="text" name="razon" id="razon" size="40" maxlength="50" disabled  onkeyup="mayusculas()"/> </td>
                        <td>Nombre de Fantasía*:</td>
                        <td><input type='text' name="nom" id="nom" size="40" maxlength="50" disabled onkeyup="mayusculas()" ></td>
                    </tr>
                    <tr>
                    <br/>
                    <td>R.U.C*:</td>

                    <td><input type="text" name="ruc" id="ruc" size="40" maxlength="13" disabled onkeypress="return isNumberKey(event)" /></td>
                    <td>Dirección*:</td>
                    <td><input type="text" name="dir" id="direc" size="40" maxlength="100" disabled onkeyup="mayusculas()"> </td>


                    </tr>
                    <tr>
                    <br>
                    <td>Provincia*:</td>
                    <td> <select name="pro" id="pro" style=" width:520px; " disabled>
                            <option value="0" >--SELECCIONE--</option>
                            <c:forEach var="col" items="${provincias.rows}"> 
                                <option value="${col.PRV_ID}"  >${col.PRV_DESCRIPCION}  </option>
                            </c:forEach>
                        </select> 
                    </td>

                    <td>Cantón*:</td>
                    <td> <select name="cant" id="cant" style=" width:520px; " disabled>
                            <option value="0" >--SELECCIONE--</option>
                            <c:forEach var="cant" items="${cantones.rows}">
                                <option value="${cant.CAN_ID}"> ${cant.CAN_DESCRIPCION} </option>
                            </c:forEach>

                        </select> 
                    </td>

                    </tr>
                    <tr>
                        <td>Teléfono*:</td>
                        <td><input type="tel" name="tel" id="tel" size="40" maxlength="20" disabled onkeypress="return isNumberKey(event)"></td>
                        <td>Correo Electrónico*:</td>
                        <td><input type="email" name="correo" id="correo" size="40" maxlength="50" disabled  onkeyup="mayusculas()" > </td>
                    </tr>
                    <tr>

                        <td>Página Web*:</td>
                        <td><input type="text" name="pagina" id="pagina" size="40" maxlength="40"  disabled onkeyup="mayusculas()"> </td>
                        <td> <input type="hidden" name="i_opc" id="i_opc" ></td>
                    </tr>

                    <tr>
                        <td>Misión*:</td>
                        <td><textarea cols="46" rows="5"  name="mision"  class="mis" id="mision" maxlength="1500" disabled style="text-transform: initial;" onkeyup="mayusculas()"> </textarea> </td>
                        <td>Visión*:</td>
                        <td><textarea cols="46" rows="5"  name="vision" class="mis" id="vision" maxlength="1500" disabled style="text-transform: initial;" onkeyup="mayusculas()"></textarea> </td>
                    </tr>
                    <tr><td colspan="2"><br>Los datos con (*) son obligatorios.</td></tr>
                </table>
                </font>
                <br>
                <br/>
                <table >
                    <tr>
                        <td></td>
                        <td></td>

                        <td><input type="reset" value="Limpiar" size="80"  class="botones" id="limpiar" disabled onclick="resetear()" /> </td>
                        <td><input type="button" value="Editar" size="80" onclick="editar();
                                cargar();" class="botones" /> </td>
                        <td><input type="submit" name="modifica" value="Actualizar"  id="act" class="botones" disabled></td>
                        <td><input type="button" name="volver" value="Menu Principal" onclick="window.location.href = 'Men_MenúPrincipal.jsp'" class="botones" ></td>
                        <td><input type="hidden" name="modificar" value="SI"></td>

                    </tr>

                </table>
                <br><br>
                <div>
                    <table border="1" bg-color="white"  id="num" style="border-collapse:collapse;" class="tab" cellspacing="8">
                        <thead>

                        <th>Razón Social</th>
                        <th>Nombre de Fantasía</th>
                        <th>R.U.C:</th>
                        <th>Provincia</th>
                        <th>Cantón</th>
                        <th>Dirección:</th>
                        <th>Teléfono</th>
                        <th>Correo Electrónico</th>
                        <th>Página Web</th>
                        <th width='80px'>Misión</th>
                        <th width='80px'>Visión</th>

                        </thead>
                        <tbody>
                            <c:forEach var="filas" items="${resultado.rows}">
                                <tr>
                                    <td >  <c:out value="${filas.emp_razonsocial}"/></td>
                                    <td>  <c:out value="${filas.emp_nombrefantasia}"/></td>
                                    <td>  <c:out value="${filas.emp_RUC}"/></td>
                                    <c:forEach var="fila" items="${cantones.rows}">

                                        <c:if test="${filas.PRV_ID == fila.PRV_ID and aux!=1}">
                                            <td align="center" width='80px' id="recu1" value="${fila.prv_id}">  <c:out value="${fila.PRV_DESCRIPCION}"/></td>
                                            <c:set var="aux" value="1"/>
                                        </c:if>
                                        <c:if test="${filas.CAN_ID == fila.CAN_ID}">    
                                            <td align="center" id="recu2" value="${fila.CAN_ID}">  <c:out value="${fila.CAN_DESCRIPCION}"/></td>
                                        </c:if> 
                                    </c:forEach>
                                    <td>  <c:out value="${filas.emp_direccion}"/></td>
                                    <td>  <c:out value="${filas.emp_telefono}"/></td>
                                    <td>  <c:out value="${filas.emp_correoelectronico}"/></td>
                                    <td>  <c:out value="${filas.emp_paginaweb}"/></td>
                                    <td width='100px'>  <c:out value="${filas.emp_mision}"/></td>
                                    <td width='100px'>  <c:out value="${filas.emp_vision}"/></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <br>

            </form>

            <script >

                function resetear() {
                    $('select[name =cant] option').remove();
                    $('select[name =cant]').append('<option value ="0">--SELECCIONE--</option>');
                    document.getElementById("est").selectedIndex = "0";
                }

                function editar() {
                    document.getElementById("razon").disabled = false;
                    document.getElementById("nom").disabled = false;
                    document.getElementById("ruc").disabled = false;
                    document.getElementById("direc").disabled = false;
                    document.getElementById("tel").disabled = false;
                    document.getElementById("pro").disabled = false;
                    document.getElementById("cant").disabled = false;
                    document.getElementById("correo").disabled = false;
                    document.getElementById("pagina").disabled = false;
                    document.getElementById("mision").disabled = false;
                    document.getElementById("vision").disabled = false;
                    document.getElementById("act").disabled = false;
                    document.getElementById("limpiar").disabled = false;

                    //  var a = document.getElementById("num").rows[1].cells[0].innerText;
                    // document.getElementById("pro").value = a;
                <%--<c:forEach var="cols" items="${cantones.rows}"> 
             // document.getElementById("cant").a ('<option value ="' ${cols.can_id}'">${cols.can_descripcion} </option>');       
                // </c:forEach> --%>
                }

                function cargar() {
                <c:forEach var="fila" items="${resultado.rows}">
                    <c:forEach var="filas" items="${cantones.rows}">

                        <c:if test="${filas.PRV_ID == fila.PRV_ID and aux2!=1}">
                    document.getElementById("pro").value = "${filas.PRV_ID}";
                            <c:set var="aux2" value="1"/>
                        </c:if>
                        <c:if test="${filas.CAN_ID == fila.CAN_ID}">
                    document.getElementById("cant").value = "${filas.CAN_ID}";
                        </c:if>
                    </c:forEach>
                    document.getElementById("razon").value = "${fila.emp_razonsocial}";
                    document.getElementById("nom").value = "${fila.emp_nombrefantasia}";
                    document.getElementById("ruc").value = "${fila.emp_ruc}";
                    document.getElementById("direc").value = "${fila.emp_direccion}";
                    document.getElementById("tel").value = "${fila.emp_telefono}";
                    document.getElementById("correo").value = "${fila.emp_correoelectronico}";
                    document.getElementById("pagina").value = "${fila.emp_paginaweb}";
                    document.getElementById("mision").value = "${fila.emp_mision}";
                    document.getElementById("vision").value = "${fila.emp_vision}";

                </c:forEach>


                }

                function mayusculas() {
                    var a = document.getElementById("razon");
                    var b = document.getElementById("nom");
                    var d = document.getElementById("direc");
                    var f = document.getElementById("correo");
                    var g = document.getElementById("pagina");
                    var h = document.getElementById("mision");
                    var i = document.getElementById("vision");
                    a.value = a.value.toUpperCase();
                    b.value = b.value.toUpperCase();
                    d.value = d.value.toUpperCase();
                    f.value = f.value.toLowerCase();
                    g.value = g.value.toLowerCase();
                    h.value = h.value.toUpperCase();
                    i.value = i.value.toUpperCase();

                }
                function isNumberKey(evt)
                {
                    var charCode = (evt.which) ? evt.which : event.keyCode;
                    if (charCode > 31 && (charCode < 48 || charCode > 57))
                        return false;

                    return true;
                }



            </script>


        </c:if>

        <c:if test="${param.modificar != null}">
            <sql:update var="act" dataSource="${con}">
                UPDATE INVENTARIOSPI.INV_EMPRESA
                SET PRV_ID = '${param.pro}'
                ,CAN_ID ='${param.cant}'
                ,EMP_RAZONSOCIAL = '${param.razon}'
                ,EMP_NOMBREFANTASIA = '${param.nom}'
                ,EMP_RUC = '${param.ruc}'
                ,EMP_DIRECCION ='${param.dir}'
                ,EMP_TELEFONO ='${param.tel}'
                ,EMP_CORREOELECTRONICO ='${param.correo}'
                ,EMP_PAGINAWEB ='${param.pagina}'
                ,EMP_MISION ='${param.mision}'
                ,EMP_VISION ='${param.vision}'                                           
                WHERE EMP_ID = '1'
            </sql:update>
            </font>
            <form action="Man_Empresa.jsp">

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




    </center>
</body>

</html>
