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
        <title>Clientes</title>
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
                if (a !== "" & b !== "" & c !== "0" & d !== "" & f !== "" & g !== "0" & lon === 0 || a !== "" & b !== "" & c !== "0" & d !== "" & f !== "" & g !== "0" & lon !== 0 & lon > 7) {
                
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
               
              
             var tab = document.getElementById("clientes").getElementsByTagName("tr").length;
             tab = tab - 1;
             var a = document.getElementById("dni").value;
             var b = document.getElementById("cor").value;
             var c = document.getElementById("mod").value;
             var d = document.getElementById("id").value;
             var aux = 0, aux1 = 0;
             var w = 0, x = 0, y = 0;
           
             while (tab !== 0) {
                 w = document.getElementById("clientes").rows[tab].cells[0].innerText;
                 x = document.getElementById("clientes").rows[tab].cells[6].innerText;
                 y = document.getElementById("clientes").rows[tab].cells[9].innerText;
                 if (a === x & d !== w & c === 'ACT' || a === x & c==='GUA' ) {
                     aux = aux + 1;
                 }
                 if (b !== null) {
                     if (b === y & d !== w & c === 'ACT' || b=== y & c==='GUA') {
                         aux1 = aux1 + 1;
                     }
                 }
                 tab = tab - 1;
             }
                    
             if (aux === 0 & aux1 === 0 & c === 'GUA' || aux === 0 & aux1 === 0 & c === 'ACT') {
                 return true;
             } else {

                    if (c === 'GUA' & aux !== 0 || c === 'ACT' & aux > 0) {
                     alert("Información duplicada, por favor ingrese un DNI válido");
                  
                    }
                    if (c === 'GUA' & aux1 !== 0 || c === 'ACT' & aux1 > 0) {
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
        
            
             if (a === true & b === true & c === true) {
                 return true;
             } else {
                 return false;
             }
            }

        </script>
    </head>


    <sql:query var="resul" dataSource="${con}">
        SELECT * FROM INVENTARIOSPI.INV_CLIENTES_PROVEEDORES WHERE CLP_TIPO = 'C'

    </sql:query>

    <body>
    <center>
        <font color="white">
        <h1>Instituto Tecnológico Superior "Cordillera"<br>
            Sistema de Registro y Control de Inventarios</h1>
        <hr/>

        <h2>
            Registro de clientes
        </h2>

        <c:if test="${param.modificar == null}">



            <form method="post" id="data" onSubmit="return validar();" >

                <table border="0" cellspacing="8" id="tabl">
                    <tr>
                        <td>Primer Apellido*:</td>
                        <td><input type="text" name="pra" id="pra" size="40" maxlength="50" disabled  onkeyup="mayusculas();" onkeypress="return letras(event);" /> </td>
                        <td>Segundo Apellido:</td>
                        <td><input type='text' name="sea" id="sea" size="40" maxlength="50" disabled onkeyup="mayusculas()" onkeypress="return letras(event);"></td>
                    </tr>
                    <tr>
                        <td>Primer Nombre*:</td>
                        <td><input type="text" name="prn" id="prn" size="40" maxlength="50" disabled  onkeyup="mayusculas()" onkeypress="return letras(event);"/> </td>
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
                    <td><input type="text" name="dni" id="dni" size="40" maxlength="13" disabled > </td>


                    </tr>
                    <tr>
                        <td>Teléfono:</td>
                        <td><input type="tel" name="tel" id="tel" size="40" maxlength="12" disabled onkeypress="return isNumberKey(event)"></td>
                        <td>Dirección*:</td>
                        <td><input type="text" name="dir" id="dir" size="40" maxlength="100" disabled onkeyup="mayusculas()"> </td>
                    </tr>
                    <tr>
                        <td>Correo Electrónico:</td>
                        <td><input type="email" name="cor" id="cor" size="40" maxlength="50" disabled  onkeyup="mayusculas()" > </td>

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
                        <td><input type="reset" value="Nuevo" size="80"  class="botones" onclick=" resetear();
                                nuevo();"/> </td>
                        <td><input type="button" value="Editar" size="80" onclick="editar()" class="botones" id="edi" disabled/> </td>
                        <td><input type="submit" name="modifica" value="Actualizar"  id="act" class="botones"  disabled /></td>
                        <td><input type="submit" name="guardar" value="Guardar"  id="gua" class="botones"  disabled /></td>
                        <td><input type="button" name="volver" value="Menu Principal" onclick="window.location.href = 'Men_MenúPrincipal.jsp'" class="botones" /></td>
                        <td><input type="hidden" name="modificar" id="mod" ></td>

                    </tr>
                    <tr height="100px">
                        <td colspan="2"><input type="search" results ="2" name="bus" id ="bus" class="bus"size="40" style="text-transform: uppercase"  onkeyup=" buscartabla();" placeholder="Buscar..." align="center"></td>

                    </tr> 
                </table>
                <br>

                <div>
                    <table border="1" bg-color="white" style="border-collapse:collapse;"  class="tab" id="clientes" cellspacing="8">
                        <thead>
                        <th >Clave</th>
                        <th>Primer Apellido</th>
                        <th>Segundo Apellido</th>
                        <th>Primer Nombre</th>
                        <th>Segundo Nombre</th>
                        <th>Tipo DNI</th>
                        <th>DNI</th>
                        <th>Teléfono </th>
                        <th>Dirección</th>
                        <th>Correo Electrónico</th>
                        <th>Estado </th>
                        </thead>
                        <tbody>
                            <c:forEach var="filas" items="${resul.rows}">
                                <c:set var="auxi" value="${auxi+1}" />
                                <tr style='cursor:pointer' onclick="recuperar(<c:out value="${auxi}"/>)" >
                                    <td width="80px" align="center">  <c:out value="${filas.CLP_ID}"/></td>
                                    <td width="200px" align="center">  <c:out value="${filas.CLP_PRIMER_APELLIDO}"/></td>
                                    <td align="center" width="200px">  <c:out value="${filas.CLP_SEGUNDO_APELLIDO}"/></td>
                                    <td  width="200 px" align="center">  <c:out value="${filas.CLP_PRIMER_NOMBRE}"/></td>
                                    <td align="center" width="200px">  <c:out value="${filas.CLP_SEGUNDO_NOMBRE}"/></td>
                                    <td align="center" width="100 px">  <c:out value="${filas.CLP_TIPODNI}"/></td>
                                    <td align="center" width="100 px">  <c:out value="${filas.CLP_DNI}"/></td>
                                    <td align="center" width="100 px">  <c:out value="${filas.CLP_TELEFONO}"/></td>
                                    <td align="center"  width="300 px">  <c:out value="${filas.CLP_DIRECCION}"/></td>        
                                    <td align="center" width="100 px">  <c:out value="${filas.CLP_CORREOELECTRONICO}"/></td>        
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

                    document.getElementById("pra").disabled = false;
                    document.getElementById("sea").disabled = false;
                    document.getElementById("prn").disabled = false;
                    document.getElementById("sen").disabled = false;
                    document.getElementById("tdni").disabled = false;

                    document.getElementById("tel").disabled = false;
                    document.getElementById("dir").disabled = false;
                    document.getElementById("cor").disabled = false;
                    document.getElementById("est").disabled = false;
                    document.getElementById("pra").focus();
                    var tab = document.getElementById("clientes").getElementsByTagName("tr").length;
                    tab = tab - 1;
                    while (tab > 0) {
                        document.getElementById("clientes").rows[tab].removeAttribute("bgcolor");
                        tab = tab - 1;
                    }

                }

                function editar() {
                    document.getElementById("mod").value = "ACT";
                    document.getElementById("gua").disabled = true;
                    document.getElementById("act").disabled = false;

                    document.getElementById("pra").disabled = false;
                    document.getElementById("sea").disabled = false;
                    document.getElementById("prn").disabled = false;
                    document.getElementById("sen").disabled = false;
                    document.getElementById("tdni").disabled = false;
                    document.getElementById("dni").disabled = false;
                    document.getElementById("tel").disabled = false;
                    document.getElementById("dir").disabled = false;
                    document.getElementById("cor").disabled = false;
                    document.getElementById("est").disabled = false;
                    document.getElementById("pra").focus();

                }
                
    function letras(event){
        var inputValue = event.which;
        // allow letters and whitespaces only.
        if(!(inputValue >= 65 && inputValue <= 120) && (inputValue != 32 && inputValue != 0)) { 
            event.preventDefault(); 
        }
    }
                function recuperar(fila) {

                    var a = document.getElementById("clientes").rows[fila].cells[0].innerText;
                    var b = document.getElementById("clientes").rows[fila].cells[1].innerText;
                    var c = document.getElementById("clientes").rows[fila].cells[2].innerText;
                    var d = document.getElementById("clientes").rows[fila].cells[3].innerText;
                    var e = document.getElementById("clientes").rows[fila].cells[4].innerText;
                    var f = document.getElementById("clientes").rows[fila].cells[5].innerText;
                    var g = document.getElementById("clientes").rows[fila].cells[6].innerText;
                    var h = document.getElementById("clientes").rows[fila].cells[7].innerText;
                    var i = document.getElementById("clientes").rows[fila].cells[8].innerText;
                    var j = document.getElementById("clientes").rows[fila].cells[9].innerText;
                    var k = document.getElementById("clientes").rows[fila].cells[10].innerText;
                    document.getElementById("id").value = a;
                    document.getElementById("pra").value = b;
                    document.getElementById("sea").value = c;
                    document.getElementById("prn").value = d;
                    document.getElementById("sen").value = e;
                    document.getElementById("tdni").value = f;
                    tipodni();
                    document.getElementById("dni").value = g;
                    document.getElementById("tel").value = h;
                    document.getElementById("dir").value = i;
                    document.getElementById("cor").value = j;
                    document.getElementById("est").value = k;
                    document.getElementById("pra").focus();
                    //SELECCIONAR
                    var tab = document.getElementById("clientes").getElementsByTagName("tr").length;
                    tab = tab - 1;
                    while (tab > 0) {
                        document.getElementById("clientes").rows[tab].removeAttribute("bgcolor");
                        tab = tab - 1;
                    }
                    document.getElementById("clientes").rows[fila].setAttribute("bgcolor", "#ffffb3");

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
                    var $tabla = $('#clientes tbody tr');
                    var $tabl = $('#tabl');
                    $tabla.show();
                    $tabl.show();
                    var tab = document.getElementById("clientes").getElementsByTagName("tr").length;
                    tab = tab - 1;
                    while (tab > 0) {
                        document.getElementById("clientes").rows[tab].removeAttribute("bgcolor");
                        tab = tab - 1;
                    }
                }
                function buscartabla() {

                    var $tabla = $('#clientes tbody tr');
                    var x = document.getElementById("bus");
                    var val = $.trim(x.value).replace(/ +/g, ' ').toLowerCase();
                    $tabla.show().filter(function () {
                        var text = $(this).text().replace(/\s+/g, ' ').toLowerCase();
                        return !~text.indexOf(val);
                    }).hide();

                    var b = document.getElementById("id").value;
                    var SearchFieldsTable = $("#clientes tbody");

                    var trows = SearchFieldsTable[0].rows;
                    var aux = 1;
                    $.each(trows, function (index, row) {
                        var ColumnName = $(row).attr("style");
                        if (ColumnName.charAt(0) === "d") {
                            var a = document.getElementById("clientes").rows[aux].cells[0].innerText;
                            document.getElementById("clientes").rows[aux].removeAttribute("bgcolor");
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
                                document.getElementById("est").selected;
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
                SET  
                CLP_PRIMER_APELLIDO = '${param.pra}'
                ,CLP_SEGUNDO_APELLIDO= '${param.sea}'
                ,CLP_PRIMER_NOMBRE= '${param.prn}'
                ,CLP_SEGUNDO_NOMBRE= '${param.sen}'
                ,CLP_TIPODNI= '${param.tdni}'
                ,CLP_DNI= '${param.dni}'
                ,CLP_DIRECCION= '${param.dir}'
                ,CLP_TELEFONO= '${param.tel}'
                ,CLP_CORREOELECTRONICO= '${param.cor}'
                ,CLP_TIPO= 'C'
                ,CLP_ESTADO= '${param.est}'
                WHERE CLP_ID = '${param.id}'
            </sql:update>

            </font>
            <form action="Man_Clientes.jsp">

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
                CLP_PRIMER_APELLIDO,
                CLP_SEGUNDO_APELLIDO,
                CLP_PRIMER_NOMBRE,
                CLP_SEGUNDO_NOMBRE,
                CLP_TIPODNI, 
                CLP_DNI, 
                CLP_DIRECCION,
                CLP_TELEFONO, 
                CLP_CORREOELECTRONICO,
                CLP_TIPO, CLP_ESTADO) 
                VALUES ('<%=count + 1%>', '${param.pra}', '${param.sea}', '${param.prn}', '${param.sen}', '${param.tdni}', '${param.dni}', '${param.dir}', '${param.tel}', '${param.cor}', 'C', '${param.est}');

            </sql:update>
            </font>
            <form action="Man_Clientes.jsp">
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
