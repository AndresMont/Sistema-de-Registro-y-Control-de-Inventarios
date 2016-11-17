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
        <title>Usuarios</title>
        <link href="Seg_Validación.css" rel="stylesheet" type="text/css">
        <script src="jquery-3.1.0.min.js"></script>

        <script type="text/javascript">


            function validaruc() {

                nombre = $('#dni').val();
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

            function campos() {
                var a = document.getElementById("pra").value;
                var b = document.getElementById("prn").value;
                var c = document.getElementById("tdni").value;
                var d = document.getElementById("dni").value;
                var e = document.getElementById("tel").value;
                var f = document.getElementById("dir").value;
                var g = document.getElementById("est").value;
                var lon = e.length;
                if (a !== "" & b !== "" & c !== "0" & d !== "" & e !== "" & f !== "" & g !== "0" & lon >= 7) {
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

                var tab = document.getElementById("usuarios").getElementsByTagName("tr").length;
                tab = tab - 1;
                var a = document.getElementById("dni").value;
                var b = document.getElementById("usu").value;
                var c = document.getElementById("mod").value;
                var d = document.getElementById("cor").value;
                 var aux = 0;
                var aux1 = 0;
                var aux2 = 0;
                               
                var x = null;
                var y = null;
var z = null;

                while (tab !== 0) {
                    x = document.getElementById("usuarios").rows[tab].cells[7].innerText;
                    y = document.getElementById("usuarios").rows[tab].cells[11].innerText;
                         z = document.getElementById("usuarios").rows[tab].cells[10].innerText;
                    if (a === x  & c === 'ACT' || a === x & c === 'GUA') {
                        aux = aux + 1;
                    }
                    if (b !== null) {
                        if (b === y & c === 'ACT' || b === y & c === 'GUA') {
                            aux1 = aux1 + 1;
                        }
                    }
                    if (d !== null) {
                        if (d === z & c === 'ACT' || z === d & c === 'GUA') {
                            aux2 = aux2 + 1;
                        }
                    }
                    tab = tab - 1;
                }

    if (aux === 0 & aux1 === 0 & aux2 ===0 & c === 'GUA' || aux === 0 & aux1 === 0& aux2===0 & c === 'ACT'  ) {
                    return true;
                } else {

                    if (c === 'GUA' & aux !== 0 || c === 'ACT' & aux > 0) {
                        alert("Información duplicada, por favor ingrese un DNI válido");

                    }
                    if (c === 'GUA' & aux1 !== 0 || c === 'ACT' & aux1 > 0) {
                        alert("Información duplicada, por favor ingrese  un nombre de usuario distinto");

                    }
                   if (c === 'GUA' & aux2 !== 0 || c === 'ACT' & aux2 > 0) {
                        alert("Información duplicada, por favor ingrese  un correo electrónico válido");

                    }
                    return false;
                }
                       

            }

            function validar() {
                var a = null;
                var b = null;
                var c = null;
                var d = document.getElementById("tdni").value;
                a = campos();
                if (d === 'I' || d === 'C') {
                    b = validacedula();
                }
                if (d === 'R') {
                    b = validaruc();
                }
                if (d === 'P') {
                    b = true;
                }
                c = redundancia();
       
          if(a===true & b===true &c===true){
              return true;
          }else{
              return false;
          }
            }
            function habilitar(){
                document.getElementById("usu").disabled =false;
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


    <sql:query var="resul" dataSource="${con}">
        SELECT  * FROM INVENTARIOSPI.V_USUARIOS
    </sql:query>

    <sql:query var="sucursales" dataSource="${con}">
        SELECT * FROM INVENTARIOSPI.INV_SUCURSALES WHERE SUC_ESTADO = 'A'
    </sql:query>
    <body>
    <center>
        <font color="white">
        <h1>Instituto Tecnológico Superior "Cordillera"<br>
            Sistema de Registro y Control de Inventarios</h1>
        <hr/>

        <h2>
            Registro de Usuarios
        </h2>

        <c:if test="${param.modificar == null}">



            <form method="post" id="data" onSubmit="return validar();" >

                <table border="0" cellspacing="8" id="tabl">
                    <tr>
                        <td>Primer Apellido*:</td>
                        <td><input type="text" name="pra" id="pra" size="40" maxlength="50" disabled  onkeyup="mayusculas();" onkeypress="return letras(event);" onblur="generarusuario()"/> </td>
                        <td>Segundo Apellido:</td>
                        <td><input type='text' name="sea" id="sea" size="40" maxlength="50" disabled onkeyup="mayusculas()" onkeypress="return letras(event);" ></td>
                    </tr>
                    <tr>
                        <td>Primer Nombre*:</td>
                        <td><input type="text" name="prn" id="prn" size="40" maxlength="50" disabled onblur="generarusuario()" onkeypress="return letras(event);" onkeyup="mayusculas()"/> </td>
                        <td>Segundo Nombre:</td>
                        <td><input type='text' name="sen" id="sen" size="40" maxlength="50" disabled onkeyup="mayusculas()" onkeypress="return letras(event);"></td>
                    </tr>
                    <tr>
                    <br/>
                    <td>Tipo DNI*:</td>
                    <td> <select name="tdni" id="tdni" style=" width:520px; " onchange = "tipodni()" disabled>
                            <option value="0" >--SELECCIONE--</option>
                            <option value="I" >CÉDULA DE IDENTIDAD</option>
                            <option value="C" >CÉDULA DE CIUDADANÍA</option>
                            <option value="R" >R.U.C</option>
                            <option value="P" >PASAPORTE</option>

                        </select> </td>
                    <td>DNI*:</td>
                    <td><input type="text" name="dni" id="dni" size="40" maxlength="13" onblur="generarusuario()"disabled > </td>


                    </tr>
                    <tr>

                        <td>Sucursal*:</td>
                        <td>
                            <select name="suc" id="suc" style=" width:520px; " disabled >
                                <option value="0" >--SELECCIONE--</option>
                                <c:forEach var="col" items="${sucursales.rows}"> 
                                    <option value="${col.SUC_ID}">${col.SUC_DESCRIPCION}</option>
                                </c:forEach>
                            </select>
                        </td>
                        <td>Teléfono*:</td>
                        <td><input type="tel" name="tel" id="tel" size="40" maxlength="12" disabled onkeypress="return isNumberKey(event)"></td>

                    </tr>
                    <tr>
                        <td>Dirección*:</td>
                        <td><input type="text" name="dir" id="dir" size="40" maxlength="100" disabled onkeyup="mayusculas()"> </td>
                        <td>Correo Electrónico:</td>
                        <td><input type="email" name="cor" id="cor" size="40" maxlength="50" disabled  onkeyup="mayusculas()" > </td>
                    </tr>
                    <tr>
                        <td>Nombre Usuario*:</td>
                        <td><input type="text" name="usu" id="usu" size="40" maxlength="100" disabled onkeyup="mayusculas()"> </td>
                        <td>Contraseña*:</td>
                        <td><input type="password" name="con" id="con" size="40" maxlength="50" disabled  > </td>
                    </tr>

                    <tr>
                        <td>Tipo de Usuario*:</td>
                        <td> <select name="tus" id="tus" style=" width:520px; " disabled>
                                <option value="0" selected>--SELECCIONE--</option>
                                <option value="A">ADMINISTRADOR</option>
                                <option value="B">BODEGUERO</option>
                                <option value="C">CAJERO</option>
                                <option value="G">GERENTE</option>
                                <option value="S">SUPERVISOR</option>                        
                                <option value="V">VENDEDOR</option>
                            </select> </td>

                        <td>Estado*:</td>
                        <td> <select name="est" id="est" style=" width:520px; " disabled>
                                <option value="0" >--SELECCIONE--</option>
                                <option value="A"selected>ACTIVO</option>
                                <option value="I">INACTIVO</option>

                            </select> </td>
                    </tr>
                    <tr><td colspan="2"><br>Los datos con (*) son obligatorios.</td></tr>
                    <td><input type="hidden" id="id" name="id"></td>
                </table>
                </font>
                <br>
                <br>
                <table >
                    <tr>
                        <td><input type="reset" value="Nuevo" size="80"  class="botones" onclick=" resetear();  nuevo();"/> </td>
                        <td><input type="button" value="Editar" size="80" onclick="editar()" class="botones" id="edi" disabled/> </td>
                        <td><input type="submit" name="modifica" value="Actualizar"  id="act" onmousedown="habilitar()" class="botones"  disabled /></td>
                        <td><input type="submit" name="guardar" value="Guardar"  id="gua" onmousedown="habilitar()" class="botones" onclick="gua()" disabled /></td>
                        <td><input type="button" name="volver" value="Menu Principal" onclick="window.location.href = 'Men_MenúPrincipal.jsp'" class="botones" /></td>
                        <td><input type="hidden" name="modificar" id="mod" ></td>

                    </tr>
                    <tr height="100px">
                        <td colspan="2"><input type="search" results ="2" name="bus" id ="bus" class="bus"size="40"  onkeyup=" buscartabla(); mayusculas();" placeholder="Buscar..." align="center"></td>

                    </tr> 
                </table>
                <br>

                <div>
                    <table border="1" bg-color="white" style="border-collapse:collapse;"  class="tab" id="usuarios" cellspacing="8">
                        <thead>
                        <th >Clave</th>
                        <th>Primer Apellido</th>
                        <th>Segundo Apellido</th>
                        <th>Primer Nombre</th>
                        <th>Segundo Nombre</th>
                        <th>Sucursal</th>
                        <th>Tipo DNI</th>
                        <th>DNI</th>
                        <th>Telefono </th>
                        <th>Direccion</th>
                        <th>Correo Electrónico</th>
                        <th>Nombre Usuario</th>
                        <th>Contraseña</th>
                        <th>Tipo usuario</th>
                        <th>Estado </th>
                        </thead>
                        <tbody>
                            <c:forEach var="filas" items="${resul.rows}">
                                <c:set var="auxi" value="${auxi+1}" />
                                <tr style='cursor:pointer' onclick="recuperar(<c:out value="${auxi}"/>, <c:out value="${filas.SUC_ID}"/>)" >
                                    <td width="80px" align="center">  <c:out value="${filas.USU_ID}"/></td>
                                    <td width="120px" align="center">  <c:out value="${filas.USU_PRIMER_APELLIDO}"/></td>
                                    <td align="center" width="120px">  <c:out value="${filas.USU_SEGUNDO_APELLIDO}"/></td>
                                    <td  width="120px" align="center">  <c:out value="${filas.USU_PRIMER_NOMBRE}"/></td>
                                    <td align="center" width="120px">  <c:out value="${filas.USU_SEGUNDO_NOMBRE}"/></td>
                                    <td align="center" width="120px">  <c:out value="${filas.SUC_DESCRIPCION}"/></td>
                                    <td align="center" width="100 px">  <c:out value="${filas.USU_TIPODNI}"/></td>
                                    <td align="center" width="100 px">  <c:out value="${filas.USU_DNI}"/></td>
                                    <td align="center" width="100 px">  <c:out value="${filas.USU_TELEFONO}"/></td>
                                    <td align="center"  width="300 px">  <c:out value="${filas.USU_DIRECCION}"/></td>        
                                    <td align="center" width="100 px">  <c:out value="${filas.USU_CORREOELECTRONICO}"/></td>  
                                    <td align="center" width="100 px">  <c:out value="${filas.USU_NOMBRE_USUARIO}"/></td>  
                                    <td align="center" width="100 px">  <c:out value="${filas.USU_CONTRASENA}"/></td>
                                    <td align="center" width="100 px">  <c:out value="${filas.USU_TIPO_USUARIO}"/></td>  
                                    <td align="center" width = '70px'>  <c:out value="${filas.USU_ESTADO}"/></td>
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

                    document.getElementById("pra").disabled = false;
                    document.getElementById("sea").disabled = false;
                    document.getElementById("suc").disabled = false;
                    document.getElementById("prn").disabled = false;
                    document.getElementById("sen").disabled = false;
                    document.getElementById("tdni").disabled = false;
                    document.getElementById("tel").disabled = false;
                    document.getElementById("dir").disabled = false;
                    document.getElementById("cor").disabled = false;

                    document.getElementById("con").disabled = false;
                    document.getElementById("tus").disabled = false;
                    document.getElementById("est").disabled = false;
                    document.getElementById("pra").focus();
                    var tab = document.getElementById("usuarios").getElementsByTagName("tr").length;
                    tab = tab - 1;
                    while (tab > 0) {
                        document.getElementById("usuarios").rows[tab].removeAttribute("bgcolor");
                        tab = tab - 1;
                    }
                <%--     document.getElementById("tabl").rows.removeAttribute("disabled");--%>

                }

                function editar() {
                    document.getElementById("mod").value = "ACT";
                    document.getElementById("gua").disabled = true;
                    document.getElementById("act").disabled = false;

                    document.getElementById("pra").disabled = false;
                    document.getElementById("sea").disabled = false;
                    document.getElementById("suc").disabled = false;
                    document.getElementById("prn").disabled = false;
                    document.getElementById("sen").disabled = false;
                    document.getElementById("tdni").disabled = false;
                    document.getElementById("dni").disabled = false;
                    document.getElementById("tel").disabled = false;
                    document.getElementById("dir").disabled = false;
                    document.getElementById("cor").disabled = false;

                    document.getElementById("con").disabled = false;
                    document.getElementById("tus").disabled = false;
                    document.getElementById("est").disabled = false;
                    document.getElementById("pra").focus();

                }
                function recuperar(fila, suc) {

                    var a = document.getElementById("usuarios").rows[fila].cells[0].innerText;
                    var b = document.getElementById("usuarios").rows[fila].cells[1].innerText;
                    var c = document.getElementById("usuarios").rows[fila].cells[2].innerText;
                    var d = document.getElementById("usuarios").rows[fila].cells[3].innerText;
                    var e = document.getElementById("usuarios").rows[fila].cells[4].innerText;
                    var f = document.getElementById("usuarios").rows[fila].cells[5].innerText;
                    var g = document.getElementById("usuarios").rows[fila].cells[6].innerText;
                    var h = document.getElementById("usuarios").rows[fila].cells[7].innerText;
                    var i = document.getElementById("usuarios").rows[fila].cells[8].innerText;
                    var j = document.getElementById("usuarios").rows[fila].cells[9].innerText;
                    var k = document.getElementById("usuarios").rows[fila].cells[10].innerText;
                    var l = document.getElementById("usuarios").rows[fila].cells[11].innerText;
                    var m = document.getElementById("usuarios").rows[fila].cells[12].innerText;
                    var n = document.getElementById("usuarios").rows[fila].cells[13].innerText;
                    var o = document.getElementById("usuarios").rows[fila].cells[14].innerText;
                    document.getElementById("id").value = a;
                    document.getElementById("pra").value = b;
                    document.getElementById("sea").value = c;
                    document.getElementById("prn").value = d;
                    document.getElementById("sen").value = e;
                    document.getElementById("suc").value = suc;
                    document.getElementById("tdni").value = g;
                    tipodni();
                    document.getElementById("dni").value = h;
                    document.getElementById("tel").value = i;
                    document.getElementById("dir").value = j;
                    document.getElementById("cor").value = k;
                    document.getElementById("usu").value = l;
                    document.getElementById("con").value = m;
                    document.getElementById("tus").value = n;
                    document.getElementById("est").value = o;
                    document.getElementById("pra").focus();
                    //SELECCIONAR
                    var tab = document.getElementById("usuarios").getElementsByTagName("tr").length;
                    tab = tab - 1;
                    while (tab > 0) {
                        document.getElementById("usuarios").rows[tab].removeAttribute("bgcolor");
                        tab = tab - 1;
                    }
                    document.getElementById("usuarios").rows[fila].setAttribute("bgcolor", "#ffffb3");

                    document.getElementById("pra").disabled = true;
                    document.getElementById("sea").disabled = true;
                    document.getElementById("suc").disabled = true;
                    document.getElementById("prn").disabled = true;
                    document.getElementById("sen").disabled = true;
                    document.getElementById("tdni").disabled = true;
                    document.getElementById("dni").disabled = true;
                    document.getElementById("tel").disabled = true;
                    document.getElementById("dir").disabled = true;
                    document.getElementById("cor").disabled = true;
                    document.getElementById("usu").disabled = true;
                    document.getElementById("con").disabled = true;
                    document.getElementById("tus").disabled = true;
                    document.getElementById("est").disabled = true;

                    document.getElementById("est").disabled = true;
                    document.getElementById("gua").disabled = true;
                    document.getElementById("act").disabled = true;
                    document.getElementById("edi").disabled = false;

                }

                function mayusculas() {
                    var a = document.getElementById("pra");
                    var b = document.getElementById("sea");
                    var c = document.getElementById("prn");
                    var d = document.getElementById("sen");
                    var e = document.getElementById("dir");
                    var f = document.getElementById("cor");
                    var g = document.getElementById("dni");
                    var h = document.getElementById("bus");


                    a.value = a.value.toUpperCase();
                    b.value = b.value.toUpperCase();
                    c.value = c.value.toUpperCase();
                    d.value = d.value.toUpperCase();
                    e.value = e.value.toUpperCase();
                    f.value = f.value.toLowerCase();
                    g.value = g.value.toUpperCase();
                    h.value = h.value.toUpperCase();

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
                function resetear() {
                    document.getElementById("bus").value = "";
                    var $tabla = $('#usuarios tbody tr');
                    var $tabl = $('#tabl');
                    $tabla.show();
                    $tabl.show();
                    var tab = document.getElementById("usuarios").getElementsByTagName("tr").length;
                    tab = tab - 1;
                    while (tab > 0) {
                        document.getElementById("usuarios").rows[tab].removeAttribute("bgcolor");
                        tab = tab - 1;
                    }
                }
                function buscartabla() {

                    var $tabla = $('#usuarios tbody tr');
                    var x = document.getElementById("bus");
                    var val = $.trim(x.value).replace(/ +/g, ' ').toLowerCase();
                    $tabla.show().filter(function () {
                        var text = $(this).text().replace(/\s+/g, ' ').toLowerCase();
                        return !~text.indexOf(val);
                    }).hide();

                    var b = document.getElementById("id").value;
                    var SearchFieldsTable = $("#usuarios tbody");

                    var trows = SearchFieldsTable[0].rows;
                    var aux = 1;
                    $.each(trows, function (index, row) {
                        var ColumnName = $(row).attr("style");
                        if (ColumnName.charAt(0) === "d") {
                            var a = document.getElementById("usuarios").rows[aux].cells[0].innerText;
                            document.getElementById("usuarios").rows[aux].removeAttribute("bgcolor");
                            if (a === b) {
                                document.getElementById("pra").disabled = true;
                                document.getElementById("sea").disabled = true;
                                document.getElementById("prn").disabled = true;
                                document.getElementById("sen").disabled = true;
                                document.getElementById("tdni").disabled = true;
                                document.getElementById("dni").disabled = true;
                                document.getElementById("tel").disabled = true;
                                document.getElementById("dir").disabled = true;
                                document.getElementById("cor").disabled = true;
                                document.getElementById("est").disabled = true;
                                document.getElementById("act").disabled = true;
                                document.getElementById("edi").disabled = true;
                                document.getElementById("id").value = "";
                                document.getElementById("pra").value = "";
                                document.getElementById("sea").value = "";
                                document.getElementById("prn").value = "";
                                document.getElementById("sen").value = "";
                                document.getElementById("tdni").value = "0";
                                document.getElementById("dni").value = "";
                                document.getElementById("tel").value = "";
                                document.getElementById("dir").value = "";
                                document.getElementById("cor").value = "";
                                 document.getElementById("con").value = "";
                                  document.getElementById("usu").value = "";
                                   document.getElementById("tus").value = "0";
                                    document.getElementById("suc").value = "0";
                                document.getElementById("est").selected;
                            }

                        }
                        aux = aux + 1;
                    });
                }
                function generarusuario() {
                    var a = document.getElementById("pra").value;
                    var b = document.getElementById("prn").value;
                    var c = document.getElementById("dni").value;
                    if (a !== "" & b !== "" & c !== "") {
                        document.getElementById("usu").value = b.charAt(0) + a + c.slice(-2);
                    }
                }

            </script>

        </c:if>

        <c:if test="${param.modificar == 'ACT'}">

            <sql:update var="act" dataSource="${con}">
                UPDATE INVENTARIOSPI.INV_USUARIOS
                SET  
                SUC_ID='${param.suc}'
                ,EMP_ID='1'
                ,USU_PRIMER_APELLIDO = '${param.pra}'
                ,USU_SEGUNDO_APELLIDO= '${param.sea}'
                ,USU_PRIMER_NOMBRE= '${param.prn}'
                ,USU_SEGUNDO_NOMBRE= '${param.sen}'
                ,USU_TIPODNI= '${param.tdni}'
                ,USU_DNI= '${param.dni}'
                ,USU_DIRECCION= '${param.dir}'
                ,USU_TELEFONO= '${param.tel}'
                ,USU_CORREOELECTRONICO= '${param.cor}'
                ,USU_NOMBRE_USUARIO= '${param.usu}'
                ,USU_TIPO_USUARIO= '${param.tus}'
                ,USU_CONTRASENA= '${param.con}'
                ,USU_ESTADO= '${param.est}'
                WHERE USU_ID = '${param.id}'
                
                
            </sql:update>

            </font>
            <form action="Man_Usuarios.jsp">

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
                SELECT * FROM INVENTARIOSPI.INV_USUARIOS
            </sql:query>
            <% int count = 0; %>
            <c:forEach var="columnas" items="${resultado.rows}">
                <%count = count + 1;%>
            </c:forEach>
            <sql:update var="gua" dataSource="${con}">
                INSERT INTO INVENTARIOSPI.INV_USUARIOS (
                USU_ID,
                EMP_ID, 
                SUC_ID,
                USU_PRIMER_APELLIDO, 
                USU_SEGUNDO_APELLIDO, 
                USU_PRIMER_NOMBRE, 
                USU_SEGUNDO_NOMBRE, 
                USU_TIPODNI, 
                USU_DNI,
                USU_CORREOELECTRONICO,
                USU_TELEFONO,
                USU_DIRECCION, 
                USU_NOMBRE_USUARIO, 
                USU_CONTRASENA, 
                USU_TIPO_USUARIO, 
                USU_ESTADO) 
                VALUES ('<%=count + 1%>', '1', '${param.suc}', '${param.pra}', '${param.sea}', '${param.prn}', '${param.sen}', '${param.tdni}', '${param.dni}', '${param.cor}', '${param.tel}', '${param.dir}', '${param.usu}', '${param.con}', '${param.tus}', '${param.est}');


            </sql:update>
            </font>
            <form action="Man_Usuarios.jsp">
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
