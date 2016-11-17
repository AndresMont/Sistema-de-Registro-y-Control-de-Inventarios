<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Productos</title>
        <link href="Seg_Validación.css" rel="stylesheet" type="text/css">
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
        <script src="ajax.js"></script>
    </head>
    <sql:setDataSource driver="com.mysql.jdbc.Driver"
                       url="jdbc:mysql://localhost:3306/inventariospi?zeroDateTimeBehavior=convertToNull"
                       user="root"
                       password="System19"
                       var="con"
                       />
    <script>
        function campos() {
            var a = document.getElementById("des").value;
            var b = document.getElementById("mar").value;
            var c = document.getElementById("mat").value;
            var d = document.getElementById("vau").value;
            var e = document.getElementById("est").value;
            var f = document.getElementById("cat").value;
            var g = document.getElementById("cod").value;

            if (a !== "" & b !== "" & c !== "0" & d !== "" & e !== "" & f !== "" & g !== "0") {
                return true;
            } else {
                alert('Por favor, complete los campos obligatorios');
                return false;
            }
        }
        function redundancia() {

            var tab = document.getElementById("productos").getElementsByTagName("tr").length;
            tab = tab - 1;
            var a = document.getElementById("des").value;
            var b = document.getElementById("cod").value;
            var c = document.getElementById("val").value;
            var d = document.getElementById("id").value;
            var aux = 0, aux1 = 0;
            var w = 0, x = 0, y = 0;

            while (tab !== 0) {
                w = document.getElementById("productos").rows[tab].cells[0].innerText;
                x = document.getElementById("productos").rows[tab].cells[2].innerText;
                y = document.getElementById("productos").rows[tab].cells[1].innerText;
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
                    alert("Información duplicada, por favor ingrese un código válido");

                }
                return false;
            }
        }

        function validar() {
            //$('.hab').removeAttr('disabled');
            var a = null;
            var b = null;
            a = campos();
            b = redundancia();

            
            if (a === true & b === true) {
                document.getElementById("cod").disabled= false;
                return true;
            } else {
                return false;
            }

        }
    </script>
    <body>

    <center>
        <font color="white">
        <h1>Instituto Tecnológico Superior "Cordillera"<br>
            Sistema de Registro y Control de Inventarios</h1>
        <hr/>

        <h2>
            Registro de Productos
        </h2>
        <c:if test="${param.modificar == null}">


            <sql:query var="resul" dataSource="${con}">
                SELECT * FROM INVENTARIOSPI.INV_CATEGORIAS WHERE CAT_ESTADO = 'A'
            </sql:query>

            <sql:query var="resultado" dataSource="${con}">
                SELECT * FROM INVENTARIOSPI.V_PRODUCTOS
            </sql:query>
            <sql:query var="marcas" dataSource="${con}">
 SELECT * FROM inventariospi.inv_marcas ORDER BY MAR_DESCRIPCION;
            </sql:query>

            <form method="post" onSubmit="return validar();">


                <table border="0" cellspacing="8">
                    <tbody>
                        <tr>
                            <td>Descripción*:</td>
                            <td><input type="text" name="des" size="40" id="des" maxlength="50" disabled onkeyup="mayusculas()" autocomplete="off"></td>
                            <td>Marca*:</td>
                            <td>
                                <select name="mar" id="mar" style=" width:520px; " disabled>
                                    <option value="0"selected>--SELECCIONE--</option>
                                    <c:forEach var="col" items="${marcas.rows}"> 
                                        <option value="${col.MAR_ID}" onclick="generacodigo()"> ${col.MAR_DESCRIPCION}</option>
                                    </c:forEach>
                              
                                </select> 
                            </td>
                        </tr>

                        <tr>
                            <td>Código*:</td>
                            <td><input type="text" name="cod" size="40" id="cod" maxlength="50" disabled onkeyup="mayusculas()"></td>
                            <td>Categoría*:</td>
                            <td> <select name="cat" id="cat" style=" width:520px; " disabled>
                                    <option value="0" >--SELECCIONE--</option>
                                    <c:forEach var="col" items="${resul.rows}"> 
                                        <option value="${col.CAT_ID}">${col.CAT_DETALLE}  (${col.CAT_CAMPOUSO})</option>
                                    </c:forEach>
                                </select> 
                            </td>
                        </tr>
                        <tr>

                            <td>Material*:</td>
                            <td><select name="mat" id="mat" style=" width:520px; " disabled>
                                    <option value="0" selected >--SELECCIONE--</option>
                                    <option value="P">PLÁSTICO</option>
                                    <option value="M">METAL</option>
                                    <option value="V">VIDRIO</option>
                                    <option value="O">OTROS</option>
                            </td>
                            <td>Dimensión:</td>
                            <td><input type="text" name="dim1" size="9" id="dim1" maxlength="4" disabled onkeypress="return isNumberKey(event)" placeholder="Ancho"/> X
                                <input type="text" name="dim2" size="9" id="dim2" maxlength="4" disabled onkeypress="return isNumberKey(event)" placeholder="Alto"/> X
                                <input type="text" name="dim3" size="9" id="dim3" maxlength="4" disabled onkeypress="return isNumberKey(event)" placeholder="Largo"/> 
                                CM
                            </td>
                        </tr>
                        <tr>
                            <td>Valor Unitario(P.V.P)*:</td>
                            <td><input type="text" name="vau" size="40" id="vau" maxlength="50" disabled oninput=" this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1'); " onblur="redondear();"/>
                            </td>
                            <td>Estado*:</td>
                            <td> <select name="est" id="est" style=" width:520px; " disabled>
                                    <option value="0" >--SELECCIONE--</option>
                                    <option value="A" selected>ACTIVO</option>
                                    <option value="I">INACTIVO</option>

                                </select> </td>
                            <td><input type="hidden" name="id" id="id" /></td>
                        </tr>
                        <tr><td colspan="2"><br>Los datos con (*) son obligatorios.</td></tr>
                    </tbody>
                </table>
                </font>
                <br>
                <br>
                <table >
                    <tr>
                        <td><input type="reset" value="Nuevo" size="80"  class="botones" onclick="nuevo(); resetear();"/> </td>
                        <td><input type="button" value="Editar" size="80" onclick="editar()" class="botones" id="edi" disabled/> </td>
                        <td><input type="submit" name="modifica" value="Actualizar"  id="act" onmousedown="habilitar()" class="botones"  disabled /></td>
                        <td><input type="submit" name="guardar" value="Guardar"  id="gua" class="botones" onclick="gua()" disabled /></td>
                        <td><input type="button" name="volver" value="Menu Principal" onclick="window.location.href = 'Men_MenúPrincipal.jsp'" class="botones" /></td>
                        <td><input type="hidden" name="modificar" id="val" ></td>

                    </tr>
                    <tr height="100px">
                        <td colspan="2"><input type="search" results ="2" name="bus" id ="bus" class="bus"size="40"  onkeyup=" buscartabla(); mayusculas();" placeholder="Buscar..." align="center"></td>

                    </tr> 
                </table>
                <br>
                <br>
                <table border="1" bg-color="white" style="border-collapse:collapse;" class="tab" id="productos" cellspacing="8">
                    <thead>
                    <th width='70px'>Clave</th>
                    <th>Código</th>
                    <th>Detalle</th>
                    <th>Categoría</th>
                    <th>Marca</th>
                    <th>Material</th>
                    <th>Dimensión</th>
                    <th>Valor Unitario</th>
                    <th>Estado</th>
                    </thead>
                    <tbody>
                        <c:forEach var="columnas" items="${resultado.rows}">
                            <tr style='cursor:pointer' onclick="recuperar(${columnas.PRO_ID},${columnas.MAR_ID},${columnas.CAT_ID});">
                                <td align="center">  <c:out value="${columnas.PRO_ID}"/></td>
                                <td align="center">  <c:out value="${columnas.PRO_CODIGO}"/></td>
                                <td align="center" width='300px'>  <c:out value="${columnas.PRO_DETALLE}"/></td>
                                <td align="center" width='150px'>  <c:out value="${columnas.CAT_DESCRIPCION}"/></td>
                                <td width='200px' align="center">  <c:out value="${columnas.PRO_MARCA}"/></td>
                                <td width='100px' align="center">  <c:out value="${columnas.PRO_MATERIAL}"/></td>
                                <td align="center" width='100px'>  <c:out value="${columnas.PRO_DIMENSION}"/></td>
                                <td width='200px' align="center">  <c:out value="${columnas.PRO_VALOR_UNITARIO}"/></td>
                                <td  width='100px' aling="center">  <c:out value="${columnas.PRO_ESTADO}"/></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </form>
            <script>
                function nuevo() {
                    document.getElementById("des").disabled = false;
                    document.getElementById("dim1").disabled = false;
                    document.getElementById("dim2").disabled = false;
                    document.getElementById("dim3").disabled = false;
                    document.getElementById("mar").disabled = false;
                    document.getElementById("mat").disabled = false;
                    document.getElementById("vau").disabled = false;
                    document.getElementById("est").disabled = false;
                    document.getElementById("cat").disabled = false;
                 
                    document.getElementById("des").focus();

                    document.getElementById("act").disabled = true;
                    document.getElementById("edi").disabled = true;
                    document.getElementById("gua").disabled = false;

                    document.getElementById("val").value = "GUA";
                }
                function editar() {
                    document.getElementById("des").disabled = false;
                    document.getElementById("dim1").disabled = false;
                    document.getElementById("dim2").disabled = false;
                    document.getElementById("dim3").disabled = false;
                    document.getElementById("mar").disabled = false;
                    document.getElementById("mat").disabled = false;
                    document.getElementById("vau").disabled = false;
                    document.getElementById("est").disabled = false;
                    document.getElementById("cat").disabled = false;

                    document.getElementById("act").disabled = false;
                    document.getElementById("gua").disabled = true;
                    document.getElementById("val").value = "ACT";
                }
                     function redondear (){
                    var c=document.getElementById('vau').value;
            var t = (c*1).toFixed(2);
                    document.getElementById('vau').value = t;
                }
                function recuperar(fila, mar, cat) {

                    document.getElementById("des").disabled = true;
                    document.getElementById("dim1").disabled = true;
                    document.getElementById("dim2").disabled = true;
                    document.getElementById("dim3").disabled = true;
                    document.getElementById("mar").disabled = true;
                    document.getElementById("mat").disabled = true;
                    document.getElementById("vau").disabled = true;
                    document.getElementById("est").disabled = true;
                    document.getElementById("cat").disabled = true;

                    document.getElementById("act").disabled = true;
                    document.getElementById("edi").disabled = false;
                    document.getElementById("gua").disabled = true;

                    var a = document.getElementById("productos").rows[fila].cells[0].innerText;
                    var b = document.getElementById("productos").rows[fila].cells[1].innerText;
                    var c = document.getElementById("productos").rows[fila].cells[2].innerText;
                    var d = document.getElementById("productos").rows[fila].cells[3].innerText;
                    var f = document.getElementById("productos").rows[fila].cells[5].innerText;
                    var g = document.getElementById("productos").rows[fila].cells[6].innerText;
                    var h = document.getElementById("productos").rows[fila].cells[7].innerText;
                    var i = document.getElementById("productos").rows[fila].cells[8].innerText;
                    document.getElementById("id").value = "" + a;
                    document.getElementById("cod").value = "" + b;
                    document.getElementById("des").value = "" + c;
                    f = f.charAt(0);
                    document.getElementById("mat").value = f;
                    document.getElementById("mar").value = mar;
                    document.getElementById("cat").value = cat;

                    if (document.getElementById("cat").value === "") {
                        $('select[name =cat]').append('<option value ="' + cat + '" class="hab" disabled>' + b + ' (INACTIVO)</option>');
                    }
                    document.getElementById("cat").value = cat;
                    var tab = document.getElementById("productos").getElementsByTagName("tr").length;
                    tab = tab - 1;
                    while (tab > 0) {
                        document.getElementById("productos").rows[tab].removeAttribute("bgcolor");
                        tab = tab - 1;
                    }
                    document.getElementById("productos").rows[fila].setAttribute("bgcolor", "#ffffb3");

                    var x = 0, y = 0;
                    var aux = 0;
                    while (aux <= 2) {
                        y = x;
                        x = g.indexOf("X", x + 1);
                        if (aux !== 0) {
                            y = y + 1;
                        } else {
                            y = 0;
                        }
                        if (aux === 2) {
                            x = g.length;
                        }
                        var dim = g.substring(y, x);
                        aux = aux + 1;
                        document.getElementById("dim" + aux).value = dim;
                    }
                    document.getElementById("vau").value = h;
                    i = i.charAt(0);
                    document.getElementById("est").value = i;



                }
                function isNumberKey(evt)
                {
                    var charCode = (evt.which) ? evt.which : event.keyCode;
                    if (charCode > 31 && (charCode < 48 || charCode > 57))
                        return false;

                    return true;
                }
                
                
                function generacodigo(COD){
                    
      
                    var x = document.getElementById("mar").options[document.getElementById("mar").selectedIndex].text;
                    x = x.substring(0,3);
                    var aleatorio =Math.floor((Math.random() * 9999) + 1);
                    
                    var y = document.getElementById("cod").value=x+"0"+aleatorio;
                }
                

                function mayusculas() {
                    var a = document.getElementById("des");
                          var c = document.getElementById("bus");

                    a.value = a.value.toUpperCase();
                    c.value = c.value.toUpperCase();

                }
                function resetear() {
                    document.getElementById("bus").value = "";
                    var $tabla = $('#productos tbody tr');
                    var $tabl = $('#tabl');
                    $tabla.show();
                    $tabl.show();
                    var tab = document.getElementById("productos").getElementsByTagName("tr").length;
                    tab = tab - 1;
                    while (tab > 0) {
                        document.getElementById("productos").rows[tab].removeAttribute("bgcolor");
                        tab = tab - 1;
                    }
                }
                function buscartabla() {

                    var $tabla = $('#productos tbody tr');
                    var x = document.getElementById("bus");
                    var val = $.trim(x.value).replace(/ +/g, ' ').toLowerCase();
                    $tabla.show().filter(function () {
                        var text = $(this).text().replace(/\s+/g, ' ').toLowerCase();
                        return !~text.indexOf(val);
                    }).hide();

                    var b = document.getElementById("id").value;
                    var SearchFieldsTable = $("#productos tbody");

                    var trows = SearchFieldsTable[0].rows;
                    var aux = 1;
                    $.each(trows, function (index, row) {
                        var ColumnName = $(row).attr("style");
                        if (ColumnName.charAt(0) === "d") {
                            var a = document.getElementById("productos").rows[aux].cells[0].innerText;
                            document.getElementById("productos").rows[aux].removeAttribute("bgcolor");
                            if (a === b) {
                                document.getElementById("edi").disabled = true;
                                document.getElementById("des").disabled = true;
                                document.getElementById("dim1").disabled = true;
                                document.getElementById("dim2").disabled = true;
                                document.getElementById("dim3").disabled = true;
                                document.getElementById("mar").disabled = true;
                                document.getElementById("mat").disabled = true;
                                document.getElementById("vau").disabled = true;
                                document.getElementById("est").disabled = true;
                                document.getElementById("cat").disabled = true;
                                document.getElementById("cod").disabled = true;
                                document.getElementById("id").value = "";
                                document.getElementById("cod").value = "";
                                document.getElementById("des").value = "";
                                document.getElementById("mat").value = "";
                                document.getElementById("mar").value = "";
                                document.getElementById("cat").value = "";
                                document.getElementById("dim1").value = "";
                                document.getElementById("dim2").value = "";
                                document.getElementById("dim3").value = "";
                                document.getElementById("vau").value = "";
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

            <form action="Man_Productos.jsp" method='post'>

                <sql:update var="act" dataSource="${con}">
                    UPDATE inventariospi.inv_productos SET 

                    CAT_ID='${param.cat}',
                    MAR_ID='${param.mar}', 
                    PRO_CODIGO='${param.cod}', 
                    PRO_DETALLE='${param.des}', 
                    PRO_MATERIAL='${param.mat}', 
                    PRO_DIMENSION='${param.dim1} X ${param.dim2} X ${param.dim3}', 
                    PRO_VALOR_UNITARIO='${param.vau}', 
                    PRO_ESTADO='${param.est}' 
                    WHERE PRO_ID='${param.id}';


                </sql:update> 
                </font>


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

            </c:if>



            <c:if test="${param.modificar == 'GUA'}">
                <sql:query var="count" dataSource="${con}">
                    SELECT * FROM INVENTARIOSPI.INV_PRODUCTOS 
                </sql:query>
                <% int cont = 0;%>
                <c:forEach var="columnas" items="${count.rows}">
                    <%cont = cont + 1;%>
                </c:forEach>

                <sql:update var="GUA" dataSource="${con}">
                    INSERT INTO INVENTARIOSPI.INV_PRODUCTOS (
                    PRO_ID,
                    CAT_ID, 
                    MAR_ID, 
                    PRO_CODIGO, 
                    PRO_DETALLE, 
                    PRO_MATERIAL, 
                    PRO_DIMENSION, 
                    PRO_VALOR_UNITARIO, 
                    PRO_ESTADO) VALUES ('<%=cont + 1%>', '${param.cat}', '${param.mar}', '${param.cod}', '${param.des}', '${param.mat}',  '${param.dim1} X ${param.dim2} X ${param.dim3}', '${param.vau}', '${param.est}');


                </sql:update>
                <sql:query var="conteo" dataSource="${con}">
                    SELECT * FROM INVENTARIOSPI.INV_SALDOS_GENERALES
                </sql:query>
                <% int conteo = 0;%>
                <c:forEach var="columns" items="${conteo.rows}">
                    <%conteo = conteo + 1;%>
                </c:forEach>
                <sql:update var="GUA" dataSource="${con}">
                    INSERT INTO INVENTARIOSPI.INV_SALDOS_GENERALES (
                    SAL_ID,
                    PRO_ID,
                    SAL_STOCK,
                    SAL_VALOR_UNITARIO,
                    SAL_VALOR_TOTAL) VALUES ('<%=conteo + 1%>','<%=cont + 1%>', '0', '0', '0');
                </sql:update>

                </font>
                <form>
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
