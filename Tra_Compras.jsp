
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="Seg_Validación.css" rel="stylesheet" type="text/css" >
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Compras</title>
        <sql:setDataSource driver="com.mysql.jdbc.Driver"
                           url="jdbc:mysql://localhost:3306/inventariospi?zeroDateTimeBehavior=convertToNull"
                           user="root"
                           password="System19"
                           var="con"
                           />

        <script src="jquery-3.1.0.min.js"></script>

        <script type="text/javascript">
            function campos() {


            var c = document.getElementById("pro");
            var d = document.getElementById("ite");
            var e = document.getElementById("sub");
            var f = document.getElementById("iva");
            var g = document.getElementById("tot");
            var h = document.getElementById("bod");
            if (c.value !== "0" & d.value !== "" & e.value !== "" & f.value !== "" & g.value !== "" & h.value !== "0") {
            return true;
            } else {
            if (c.value === "0") {
            alert('Por favor, Ingrese el nombre del proveedor');
            }
            if (g.value === "") {

            alert('Por favor, Ingrese al menos un producto.');
            }
            if (h.value === "0") {

            alert('Por favor, Ingrese la bodega a la que se ingresa el producto.');
            }

            return false;
            }
            }

            function habilitar() {
            var a = campos();
            if (a === true) {
            document.getElementById("fec").disabled = false;
            document.getElementById("hor").disabled = false;
            document.getElementById("num").disabled = false;
            document.getElementById("ite").disabled = false;
            document.getElementById("sub").disabled = false;
            document.getElementById("iva").disabled = false;
            document.getElementById("tot").disabled = false;
            var tab = document.getElementById("detalle").getElementsByTagName("tr").length;
            tab = tab - 1;
            var x = 0, a, b, c, d;
            while (tab !== x) {
            x = x + 1;
            a = document.getElementById("detalle").rows[x].cells[0].innerText;
            var cam = document.createElement("input");
            cam.setAttribute("type", "hidden");
            cam.setAttribute("name", "can" + x);
            cam.setAttribute("id", "can" + x);
            document.getElementById("bloque2").appendChild(cam);
            document.getElementById("can" + x).value = a;
            b = document.getElementById("detalle").rows[x].cells[1].innerText;
            b = b.charAt(0);
            var det = document.createElement("input");
            det.setAttribute("type", "hidden");
            det.setAttribute("name", "det" + x);
            det.setAttribute("id", "det" + x);
            document.getElementById("bloque2").appendChild(det);
            document.getElementById("det" + x).value = b;
            c = document.getElementById("detalle").rows[x].cells[2].innerText;
            var uni = document.createElement("input");
            uni.setAttribute("type", "hidden");
            uni.setAttribute("name", "uni" + x);
            uni.setAttribute("id", "uni" + x);
            document.getElementById("bloque2").appendChild(uni);
            document.getElementById("uni" + x).value = c;
            d = document.getElementById("detalle").rows[x].cells[3].innerText;
            var tot = document.createElement("input");
            tot.setAttribute("type", "hidden");
            tot.setAttribute("name", "tot" + x);
            tot.setAttribute("id", "tot" + x);
            document.getElementById("bloque2").appendChild(tot);
            document.getElementById("tot" + x).value = d;
            document.getElementById("contador").value = x;
            }


            }
            }


            function funcion1() {
            fecha = new Date();
            hora = fecha.getHours();
            if (hora <= 9) {
            hora = "0" + hora;
            }
            minuto = fecha.getMinutes();
            if (minuto <= 9) {
            minuto = "0" + minuto;
            }
            segundos = fecha.getSeconds();
            if (segundos <= 9) {
            segundos = "0" + segundos;
            }
            rel = hora + ":" + minuto + ":" + segundos;
            document.forma.hor.value = rel;
            setTimeout("funcion1()", 1000);
            }
            function float(){
            this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');
            }

        </script>
    </head>

    <sql:query var="resultado" dataSource="${con}">
        SELECT * FROM INVENTARIOSPI.INV_DOCUMENTOS WHERE DOC_TIPO_DOCUMENTO = 'FC'
    </sql:query>

    <sql:query var="clientes" dataSource="${con}">
        SELECT * FROM INVENTARIOSPI.INV_CLIENTES_PROVEEDORES WHERE CLP_TIPO = 'P'
    </sql:query> 
    <sql:query var="productos" dataSource="${con}">  
        SELECT * FROM INVENTARIOSPI.INV_PRODUCTOS
    </sql:query> 


    <body onload="funcion1()">

        <font color="white">
    <center>
        <h1>Instituto Tecnológico Superior "Cordillera"<br>
            Sistema de Registro y Control de Inventarios</h1>

        <hr/>
        <h2>
            Compras
        </h2>


        <br>
        <c:if test="${param.modificar == null}">


            <form method="post" id="form" name="forma" onSubmit="return campos();">


                <table border="0" cellspacing="8">
                    <tbody>
                        <tr>
                            <td>Fecha:</td>
                            <%
                                Date fecha = new Date();
                                SimpleDateFormat ft
                                        = new SimpleDateFormat("dd/MM/yyyy");
                                String fec = ft.format(fecha);
                            %>
                            <td><input type="text" value="<%=fec%>" name="fec" id="fec" size="40" disabled></td>
                            <td>Hora:</td>
                            <td><input type="text" name="hor" id="hor" size="40"disabled></td>
                        </tr>
                        <tr>
                            <td>Proveedor*:</td>
                            <td> <select name="pro" id="pro"  style=" width:520px; " disabled>
                                    <option value="0" >--SELECCIONE--</option>
                                    <c:forEach var="cols" items="${clientes.rows}"> 
                                        <option value="${cols.CLP_ID}"  >${cols.CLP_DNI} ${cols.CLP_RAZON_SOCIAL} </option>
                                    </c:forEach>
                                </select> 
                            </td>
                            <td>Bodega Ingresa*:</td>
                            <td> <select name="bod" id="bod"  style=" width:520px; " disabled>
                                    <option value="0" >--SELECCIONE--</option>
                                </select> 
                            </td>
                        </tr>
                        <tr> <td>Número de factura:</td>
                            <td> 
                                <input type="text" name="num" size="40" id="num" maxlength="200" disabled >
                            </td>
                            <td>Cantidad items:</td>
                            <td><input type="text" name="ite" size="40" id="ite"  disabled ></td>

                        </tr>
                        <tr>
                            <td>Subtotal:</td>
                            <td><input type="text" name="sub" size="40" id="sub" disabled></td>
                            <td>I.V.A:</td>
                            <td><input type="text" name="iva" size="40" id="iva"  disabled ></td>

                            <td><input type="hidden" name="id" id="id_tab" /></td>
                        </tr>
                        <tr><td colspan="2"><br>Los datos con (*) son obligatorios.</td>           <td>Total:</td>
                            <td><input type="text" name="tot" size="40" id="tot"  disabled ></td> <td>    <input type="hidden" value="${param.usuario}" name="usuar" id="usuar" ></td></tr>
                    </tbody>
                </table>
                </font>
                <br>
                <br>
                <table >
                    <tr>
                        <td><input type="button" value="Nuevo" size="80"  class="botones" onclick="nuevo()"/> </td>

                        <td><input type="submit" name="guardar" value="Guardar"  id="gua" class="botones" onmousedown="habilitar();"  onclick="gua()" disabled /></td>

                        <td><input type="button" name="volver" value="Menu Principal" onclick="window.location.href = 'Men_MenúPrincipal.jsp'" class="botones" /></td>

                        <td><input type="hidden" name="modificar" id="val"  ></td>

                    </tr>
                </table>
                <br>
                <br>
                <font color="white">
                <table cellspacing="8"  border="0" id="bloque2">
                    <tbody>
                        <tr>
                            <td>Cantidad*:</td>
                            <td><input type="number"  name="can" size="40" id="can" disabled onchange="calculototal()" onkeypress="return isNumberKey(event);" ></td>
                            <td>Detalle*:</td>
                            <td><select name="det" id="det"  style=" width:520px; " onclick="comprobar()" onchange="calculototal(); validacionvalor();" disabled >
                                    <option value="0"  selected>--SELECCIONE--</option>
                                    <c:forEach var="cols" items="${productos.rows}"> 
                                        <option value="${cols.PRO_ID}"  > ${cols.PRO_DETALLE} </option>
                                    </c:forEach> 
                                </select> </td>
                        </tr>
                        <tr>
                            <td>Valor Unitario:</td>

                            <td> <input type="text" name="uni" size="40" id="uni" oninput=" this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1'); " onblur="redondear();"  maxlength="200" onchange="calculototal()" disabled></td>
                            <td>Valor Total:</td>
                            <td><input type="text" name="totp" size="40" id="totp" maxlength="200" onchange="calculototal()" disabled ></td>
                    <input type="hidden" name="quitar" id="quitar" value="xyz">
                    <input type="hidden" name="filas" id="filas" >
                    <input type="hidden" name="contador" id="contador" >
                    <input type="hidden" name="aux" id="aux" >

                    </tr>
                    </tbody>
                </table>
                <br>
                <br>
                <table cellspacing="8"  border="0">
                    <tr>
                        <td><input type="button" value="Limpiar" size="80"  id="lim" class="botones"  onclick ="limpiar(); resetear();" disabled/></td>
                        <td><input type="button" value="Agregar" size="80"  id="agr" class="botones"  onclick ="agregar()" disabled/></td>
                        <td><input type="button" value="Quitar"  size="80" id="qui" class="botones" onclick="quit();" disabled /></td>
                    </tr>

                    <tr height="100px">
                        <td colspan="2"><input type="search" results ="2" name="bus" id ="bus" class="bus"size="40"  onkeyup="mayusculas(); buscartabla();" placeholder="Buscar..." align="center"></td>
                    </tr> 

                </table>

                </font>
                <table border="1" bg-color="white" style="border-collapse:collapse;" align="center" width="800" class="tab" id="detalle" cellspacing="8">
                    <thead>
                    <th width='100px' align="center">Cantidad</th>
                    <th  width='400px' align="center">Detalle</th>
                    <th  width='100px' align="center">Valor Unitario</th>
                    <th  width='100px' align="center">Valor Total</th>         
                    </thead>
                </table>

            </form>
            <script>

                function nuevo() {
                document.getElementById("form").reset();
                document.getElementById("pro").disabled = false;
                document.getElementById("bod").disabled = false;
                document.getElementById("lim").disabled = false;
                document.getElementById("gua").disabled = false;
                document.getElementById("can").disabled = false;
                document.getElementById("uni").disabled = false;
                document.getElementById("agr").disabled = false;
                document.getElementById("val").value = "GUA";
                <c:forEach var="cols" items="${resultado.rows}">
                    <c:set value="${cols.DOC_NUMERO_DOCUMENTO}" var="num"/>

                </c:forEach>
                document.getElementById("num").value = <c:out value="${num+1}"/>;
                var tbl1 = document.getElementById("detalle");
                while (tbl1.rows.length > 1) {
                tbl1.deleteRow();
                }

                while (document.getElementById("det").length > 1) {
                document.getElementById("det").remove(1);
                }

                <c:forEach var="colu" items="${productos.rows}">
                $('select[name =det]').append('<option value ="<c:out value="${colu.PRO_ID}"/>"> <c:out value="${colu.PRO_CODIGO}  ${colu.PRO_DETALLE}"/> </option>');
                </c:forEach>

                <sql:query var="bodegas" dataSource="${con}">
                SELECT
                        U.SUC_ID, B.BOD_ID, B.BOD_DESCRIPCION
                        FROM
                        INVENTARIOSPI.INV_USUARIOS
                        U, INVENTARIOSPI.INV_BODEGAS
                        B
                        WHERE U.SUC_ID = B.SUC_ID AND U.USU_NOMBRE_USUARIO = '${param.usuario}'
                </sql:query>
                $('#bod').find('option').remove().end().append('<option value="0">--SELECCIONE</option>');
                <c:forEach var="bods" items="${bodegas.rows}">
                $('select[name =bod]').append('<option value ="<c:out value="${bods.BOD_ID}"/>"> <c:out value="${bods.BOD_DESCRIPCION}"/> </option>');
                </c:forEach>
                }

                function comprobar() {

                if (document.getElementById("det").length === 1) {
                alert("No existen más productos que los ya añadidos.");
                <c:set value="3" var="x"/>
                }
                }
                function validacionvalor(){
                $.ajax({
                type: 'GET',
                        url: 'Con_Productos',
                        data: 'codigoproducto=' + $('select[name =det]').val(),
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

                        $("#aux").val(dados);
                        }

                });
                }
                function redondear (){
                var c = document.getElementById('uni').value;
                var t = (c * 1).toFixed(2);
                document.getElementById('uni').value = t;
                }
                function calculototal() {
                document.getElementById("det").disabled = false;
                var a = document.getElementById("can").value;
                var b = document.getElementById("uni").value;
                var t = (a * b).toFixed(2);
                document.getElementById("totp").value = t;
                }

                function agregar() {

                var valc = document.getElementById("aux").value;
                var c = document.getElementById("uni").value;
                var a = document.getElementById("can").value;
                if (c >= valc || a < 10){
                if (a < 10){
                alert("No se puede agregar el producto. \nPor favor ingrese una cantidad mayor a 10");
                }
                if (c >= valc){
                alert("El Valor Unitario no puede ser mayor o igual al P.V.P. \nPor favor ingrese una valor menor a " + valc);
                }
                } else{
                document.getElementById("val").value = "gua";
                var b = document.getElementById("det");
                var b = b.options[b.selectedIndex].text;
                b = document.getElementById("det").value + "  " + b;
                var d = document.getElementById("totp").value;
                document.getElementById("filas").value = document.getElementById("detalle").rows.length;
                if (a === "" || a < 1 || document.getElementById("det").value === "0" || c === "" || c < 1) {
                if (a < 1 && a !== "" || c === 0) {
                alert("Por favor, Ingrese una cantidad y/o valor unitario mayor/es a 0.");
                } else if (a === "" || document.getElementById("det").value === "0" || c === "") {
                alert("Cantidad, Producto y/o Valor Unitario no ingresado/s.");
                }
                } else {
                //AGREGAR A LA TABLA
                var tabla = document.getElementById("detalle");
                var row = tabla.insertRow();
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                cell1.innerHTML = a;
                cell2.innerHTML = b;
                cell3.innerHTML = c;
                cell4.innerHTML = d;
                var rows = document.getElementById("detalle").getElementsByTagName("tr").length;
                rows = rows - 1;
                row.id = rows;
                var aux = 0;
                while (rows > 0) {
                document.getElementById("detalle").rows[rows].removeAttribute("id");
                document.getElementById("detalle").rows[rows].setAttribute("id", rows);
                document.getElementById("detalle").rows[rows].removeAttribute("onclick");
                document.getElementById(rows).setAttribute("onclick", "recuperar(" + rows + ")");
                rows = rows - 1;
                aux = aux + 1;
                }
                row.id = aux;
                rows = document.getElementById("detalle").getElementsByTagName("tr").length - 1;
                document.getElementById(aux).setAttribute("style", "cursor:pointer");
                document.getElementById(aux).setAttribute("onclick", "recuperar(" + rows + ")");
                //CANTIDAD ITEMS
                var x = document.getElementById("ite").value;
                var t1 = (parseInt(x) || 0) + parseInt(a);
                document.getElementById("ite").value = t1;
                //SUBTOTAL
                var y = document.getElementById("sub").value;
                var t2 = (parseFloat(y) || 0) + parseFloat(d);
                document.getElementById("sub").value = t2;
                //I.V.A
                var z = document.getElementById("sub").value;
                var t3 = Math.round(((parseFloat(z) || 0) * 0.14) * 100) / 100;
                document.getElementById("iva").value = t3;
                //TOTAL
                var v = document.getElementById("iva").value;
                var w = document.getElementById("sub").value;
                var t4 = Math.round(((parseFloat(v) || 0) + (parseFloat(w) || 0)) * 100) / 100;
                document.getElementById("tot").value = t4;
                //ELIMINAR ELEMENTO
                document.getElementById("can").value = "";
                document.getElementById("uni").value = "";
                document.getElementById("totp").value = "";
                document.getElementById("det").disabled = true;
                document.getElementById("can").focus();
                //  document.getElementById("det").remove(document.getElementById("det").selectedIndex);
                var x = document.getElementById("det").selectedIndex;
                document.getElementById("det").options[x].disabled = true;
                document.getElementById("det").value = "0";
                }
                }
                }

                function isNumberKey(evt)
                {
                var charCode = (evt.which) ? evt.which : event.keyCode;
                if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                return false;
                } else {
                document.getElementById("det").disabled = false;
                return true;
                }
                }

                function recuperar(fila) {
                var a = document.getElementById("detalle").rows[fila].cells[0].innerText;
                var b = document.getElementById("detalle").rows[fila].cells[1].innerText;
                b = b.charAt();
                var c = document.getElementById("detalle").rows[fila].cells[2].innerText;
                var d = document.getElementById("detalle").rows[fila].cells[3].innerText;
                document.getElementById("quitar").value = "" + fila;
                document.getElementById("can").value = a;
                document.getElementById("det").value = "" + b;
                document.getElementById("uni").value = c;
                document.getElementById("totp").value = d;
                var tab = document.getElementById("detalle").getElementsByTagName("tr").length;
                tab = tab - 1;
                while (tab > 0) {
                document.getElementById("detalle").rows[tab].removeAttribute("bgcolor");
                tab = tab - 1;
                }
                document.getElementById("detalle").rows[fila].setAttribute("bgcolor", "#ffffb3");
                document.getElementById("can").disabled = true;
                document.getElementById("uni").disabled = true;
                document.getElementById("det").disabled = true;
                document.getElementById("agr").disabled = true;
                document.getElementById("qui").disabled = false;
                }
                function limpiar() {

                document.getElementById("can").value = "";
                document.getElementById("det").value = "0";
                document.getElementById("uni").value = "";
                document.getElementById("totp").value = "";
                document.getElementById("agr").disabled = false;
                document.getElementById("can").disabled = false;
                document.getElementById("uni").disabled = false;
                document.getElementById("qui").disabled = true;
                document.getElementById("can").focus();
                }

                function quit() {
                var x = document.getElementById("quitar").value;
                var y = document.getElementById("detalle").rows[x].cells[1].innerText;
                document.getElementById("det").options[y].disabled = false;
                document.getElementById("detalle").deleteRow(x);
                document.getElementById("agr").disabled = false;
                document.getElementById("can").disabled = false;
                document.getElementById("qui").disabled = true;
                document.getElementById("can").focus();
                var a = document.getElementById("can").value;
                var b = document.getElementById("totp").value;
                //CANTIDAD ITEMS
                var x = document.getElementById("ite").value;
                var t1 = (parseInt(x) || 0) - parseInt(a);
                document.getElementById("ite").value = t1;
                //SUBTOTAL
                var y = document.getElementById("sub").value;
                var t2 = Math.round(((parseFloat(y) || 0) - parseFloat(b)) * 100) / 100;
                document.getElementById("sub").value = t2;
                //I.V.A
                var z = document.getElementById("sub").value;
                var t3 = Math.round(((parseFloat(z) || 0) * 0.14) * 100) / 100;
                document.getElementById("iva").value = t3;
                //TOTAL
                var v = document.getElementById("iva").value;
                var w = document.getElementById("sub").value;
                var t4 = Math.round(((parseFloat(v) || 0) + (parseFloat(w) || 0)) * 100) / 100;
                document.getElementById("tot").value = t4;
                document.getElementById("can").value = "";
                document.getElementById("det").value = "0";
                document.getElementById("uni").value = "";
                document.getElementById("totp").value = "";
                var rows = document.getElementById("detalle").getElementsByTagName("tr").length;
                rows = rows - 1;
                while (rows > 0) {
                document.getElementById("detalle").rows[rows].removeAttribute("id");
                document.getElementById("detalle").rows[rows].setAttribute("id", rows);
                document.getElementById("detalle").rows[rows].removeAttribute("onclick");
                document.getElementById(rows).setAttribute("onclick", "recuperar(" + rows + ")");
                rows = rows - 1;
                }
                if (document.getElementById("tot").value === '0') {
                document.getElementById("ite").value = "";
                document.getElementById("sub").value = "";
                document.getElementById("iva").value = "";
                document.getElementById("tot").value = "";
                }
                }

                function resetear() {
                document.getElementById("bus").value = "";
                var $tabla = $('#detalle tbody tr');
                var $tabl = $('#tabl');
                $tabla.show();
                $tabl.show();
                var tab = document.getElementById("detalle").getElementsByTagName("tr").length;
                tab = tab - 1;
                while (tab > 0) {
                document.getElementById("detalle").rows[tab].removeAttribute("bgcolor");
                tab = tab - 1;
                }
                }

                function buscartabla() {

                var $tabla = $('#detalle tbody tr');
                var x = document.getElementById("bus");
                var val = $.trim(x.value).replace(/ +/g, ' ').toLowerCase();
                $tabla.show().filter(function () {
                var text = $(this).text().replace(/\s+/g, ' ').toLowerCase();
                return !~text.indexOf(val);
                }).hide();
                var SearchFieldsTable = $("#detalle tbody");
                var trows = SearchFieldsTable.rows;
                alert("alerta");
                var aux = 1;
                $.each(trows, function (index, row) {

                var ColumnName = $(row).attr("style");
                if (ColumnName.charAt(0) === "d") {
                var a = document.getElementById("detalle").rows[aux].cells[0].innerText;
                document.getElementById("detalle").rows[aux].removeAttribute("bgcolor");
                <%--   if (a === b) {
                                
                   }--%>
                }
                aux = aux + 1;
                }
                );
                }

                function mayusculas() {
                var a = document.getElementById("bus");
                a.value = a.value.toUpperCase();
                }

            </script>
        </c:if>

        <c:if test="${param.modificar != null}">


            <sql:query var="counts" dataSource="${con}">
                SELECT COUNT(*) CON FROM INVENTARIOSPI.INV_DOCUMENTOS
            </sql:query>
            <c:forEach var="columnas" items="${counts.rows}">
                <c:set var="cont" value="${columnas.CON}"/>
            </c:forEach> 

            <sql:query var="user" dataSource="${con}">
                SELECT USU_ID, SUC_ID FROM INVENTARIOSPI.INV_USUARIOS WHERE USU_NOMBRE_USUARIO ='${param.usuar}'
            </sql:query>
            <c:forEach var="usu" items="${user.rows}">

                <c:set var="usu_id" value="${usu.USU_ID}"/>
                <c:set var="suc_id" value="${usu.SUC_ID}"/>
            </c:forEach> 


            <sql:update var="gua" dataSource="${con}">
                INSERT INTO inventariospi.inv_documentos (
                DOC_ID,
                EMP_ID,
                BOD_ID,
                SUC_ID, 
                USU_ID, 
                CLP_ID, 
                DOC_NUMERO_DOCUMENTO, 
                DOC_FECHA, 
                DOC_HORA,
                DOC_CANTIDAD_ITEMS, 
                DOC_SUBTOTAL, 
                DOC_IVA, 
                DOC_TOTAL, 
                DOC_TIPO_DOCUMENTO) 
                VALUES ('${cont+1}', '1','${param.bod}', '${suc_id}', '${usu_id}','${param.pro}','${param.num}', STR_TO_DATE('${param.fec}', '%d/%m/%Y'), '${param.hor}', '${param.ite}', '${param.sub}', '${param.iva}', '${param.tot}', 'FC');
            </sql:update>
            <script>
                function extraer() {

                <sql:query var="counts" dataSource="${con}">
                SELECT
                        COUNT( * ) CON FROM INVENTARIOSPI.INV_DOCUMENTOS
                </sql:query>

                <c:forEach var="columnas" items="${counts.rows}">
                    <c:set var="conte" value="${columnas.CON}"/>
                </c:forEach>

                <sql:query var="cont" dataSource="${con}">
                SELECT
                        COUNT( * ) CON FROM INVENTARIOSPI.INV_DETALLE
                </sql:query>
                <c:forEach var="columna" items="${cont.rows}">
                    <c:set var="contar" value="${columna.CON}"/>
                </c:forEach>
                <c:set value="${param.contador}"  var="contador"/>
                <sql:update  var="det" dataSource="${con}">

                INSERT
                        INTO
                        inventariospi.inv_detalle(
                                DET_ID,
                                DOC_ID,
                                PRO_ID,
                                DET_CANTIDAD,
                                DET_VALOR_UNITARIO,
                                DET_VALOR_TOTAL
                                )
                        VALUES('${contar+1}', '${conte}', '${param.det1} ', '${param.can1}', '${param.uni1}', '${param.tot1}')
                    <c:if test="${contador>1}">
                , ('${contar+2}', '${conte}', '${param.det2} ', '${param.can2}', '${param.uni2}', '${param.tot2}')
                        <c:if test="${contador>2}">
                , ('${contar+3}', '${conte}', '${param.det3} ', '${param.can3}', '${param.uni3}', '${param.tot3}')
                            <c:if test="${contador>3}">
                , ('${contar+4}', '${conte}', '${param.det4} ', '${param.can4}', '${param.uni4}', '${param.tot4}')
                                <c:if test="${contador>4}">
                , ('${contar+5}', '${conte}', '${param.det5} ', '${param.can5}', '${param.uni5}', '${param.tot5}')
                                    <c:if test="${contador>5}">
                , ('${contar+6}', '${conte}', '${param.det6} ', '${param.can6}', '${param.uni6}', '${param.tot6}')
                                    </c:if>
                                </c:if>
                            </c:if>
                        </c:if>
                    </c:if>
                </sql:update>

//********************************SALDOS GENERALES*************************************//

                <sql:query var="CONTAR" dataSource="${con}">
                SELECT * FROM
                        INV_SALDOS_GENERALES
                </sql:query>
                <c:forEach var="CON" items="${CONTAR.rows}">
                    <c:set var="SAL_ID" value="${CON.SAL_ID}"/>
                </c:forEach>
                <sql:query var="SALDOSG" dataSource="${con}">
                SELECT * FROM
                        INV_SALDOS_GENERALES
                        S
                        WHERE
                        PRO_ID = '${param.det1}'
                        ORDER
                        BY
                        S.SAL_ID
                        DESC
                        LIMIT
                        1
                </sql:query>
                <c:forEach var="SALG" items="${SALDOSG.rows}">
                    <c:set var="SAL_CAN" value="${SALG.SAL_STOCK}"/>
                    <c:set var="SAL_VTOT" value="${SALG.SAL_VALOR_TOTAL}"/>
                </c:forEach>

//*******************************PONDERACION SALDOS GENEREALES*********************************//

                <c:set value="${param.tot1+SAL_VTOT}" var ='aux1'/>
                <c:set value="${param.can1+SAL_CAN}" var ='aux2'/>
                <c:set value="${aux1/aux2}" var ="unitario"/>

                <sql:update  var="det" dataSource="${con}">

                INSERT
                        INTO
                        INVENTARIOSPI.INV_SALDOS_GENERALES(
                                SAL_ID,
                                PRO_ID,
                                SAL_STOCK,
                                SAL_VALOR_UNITARIO,
                                SAL_VALOR_TOTAL)
                        VALUES('${SAL_ID+1}', '${param.det1}', '${param.can1+SAL_CAN}', '${unitario}', '${param.tot1+SAL_VTOT}')

                    <c:if test="${contador>1}">

                        <sql:query var="SALDOSG" dataSource="${con}">
                SELECT * FROM
                        INV_SALDOS_GENERALES
                        S
                        WHERE
                        PRO_ID = '${param.det2}'
                        ORDER
                        BY
                        S.SAL_ID
                        DESC
                        LIMIT
                        1
                        </sql:query>
                        <c:forEach var="SALG" items="${SALDOSG.rows}">
                            <c:set var="SAL_CAN" value="${SALG.SAL_STOCK}"/>
                            <c:set var="SAL_VTOT" value="${SALG.SAL_VALOR_TOTAL}"/>
                        </c:forEach>

                        <c:set value="${param.tot2+SAL_VTOT}" var ='aux1'/>
                        <c:set value="${param.can2+SAL_CAN}" var ='aux2'/>
                        <c:set value="${aux1/aux2}" var ="unitario1"/>

                , ('${SAL_ID+2}', '${param.det2}', '${param.can2+SAL_CAN}', '${unitario1}', '${param.tot2+SAL_VTOT}')
                        <c:if test="${contador>2}">

                            <sql:query var="SALDOSG" dataSource="${con}">
                SELECT * FROM
                        INV_SALDOS_GENERALES
                        S
                        WHERE
                        PRO_ID = '${param.det3}'
                        ORDER
                        BY
                        S.SAL_ID
                        DESC
                        LIMIT
                        1
                            </sql:query>
                            <c:forEach var="SALG" items="${SALDOSG.rows}">
                                <c:set var="SAL_CAN" value="${SALG.SAL_STOCK}"/>
                                <c:set var="SAL_VTOT" value="${SALG.SAL_VALOR_TOTAL}"/>
                            </c:forEach>

                            <c:set value="${param.tot3+SAL_VTOT}" var ='aux1'/>
                            <c:set value="${param.can3+SAL_CAN}" var ='aux2'/>
                            <c:set value="${aux1/aux2}" var ="unitario2"/>

                , ('${SAL_ID+3}', '${param.det3}', '${param.can3+SAL_CAN}', '${unitario2}', '${param.tot3+SAL_VTOT}')
                            <c:if test="${contador>3}">
                                <sql:query var="SALDOSG" dataSource="${con}">
                SELECT * FROM
                        INV_SALDOS_GENERALES
                        S
                        WHERE
                        PRO_ID = '${param.det4}'
                        ORDER
                        BY
                        S.SAL_ID
                        DESC
                        LIMIT
                        1
                                </sql:query>
                                <c:forEach var="SALG" items="${SALDOSG.rows}">
                                    <c:set var="SAL_CAN" value="${SALG.SAL_STOCK}"/>
                                    <c:set var="SAL_VTOT" value="${SALG.SAL_VALOR_TOTAL}"/>
                                </c:forEach>

                                <c:set value="${param.tot4+SAL_VTOT}" var ='aux1'/>
                                <c:set value="${param.can4+SAL_CAN}" var ='aux2'/>
                                <c:set value="${aux1/aux2}" var ="unitario3"/>

                , ('${SAL_ID+4}', '${param.det4}', '${param.can4+SAL_CAN}', '${unitario3}', '${param.tot4+SAL_VTOT}')
                                <c:if test="${contador>4}">
                                    <sql:query var="SALDOSG" dataSource="${con}">
                SELECT * FROM
                        INV_SALDOS_GENERALES
                        S
                        WHERE
                        PRO_ID = '${param.det5}'
                        ORDER
                        BY
                        S.SAL_ID
                        DESC
                        LIMIT
                        1
                                    </sql:query>
                                    <c:forEach var="SALG" items="${SALDOSG.rows}">
                                        <c:set var="SAL_CAN" value="${SALG.SAL_STOCK}"/>
                                        <c:set var="SAL_VTOT" value="${SALG.SAL_VALOR_TOTAL}"/>
                                    </c:forEach>

                                    <c:set value="${param.tot5+SAL_VTOT}" var ='aux1'/>
                                    <c:set value="${param.can5+SAL_CAN}" var ='aux2'/>
                                    <c:set value="${aux1/aux2}" var ="unitario4"/>

                , ('${SAL_ID+5}', '${param.det5}', '${param.can5+SAL_CAN}', '${unitario4}', '${param.tot5+SAL_VTOT}')
                                    <c:if test="${contador>5}">
                                        <sql:query var="SALDOSG" dataSource="${con}">
                SELECT * FROM
                        INV_SALDOS_GENERALES
                        S
                        WHERE
                        PRO_ID = '${param.det6}'
                        ORDER
                        BY
                        S.SAL_ID
                        DESC
                        LIMIT
                        1
                                        </sql:query>
                                        <c:forEach var="SALG" items="${SALDOSG.rows}">
                                            <c:set var="SAL_CAN" value="${SALG.SAL_STOCK}"/>
                                            <c:set var="SAL_VTOT" value="${SALG.SAL_VALOR_TOTAL}"/>
                                        </c:forEach>

                                        <c:set value="${param.tot6+SAL_VTOT}" var ='aux1'/>
                                        <c:set value="${param.can6+SAL_CAN}" var ='aux2'/>
                                        <c:set value="${aux1/aux2}" var ="unitario5"/>

                , ('${SAL_ID+6}', '${param.det6}', '${param.can6+SAL_CAN}', '${unitario5}', '${param.tot5+SAL_VTOT}')
                                    </c:if>
                                </c:if>
                            </c:if>
                        </c:if>
                    </c:if>
                </sql:update>


//*******************************SALDOS BODEGAS****************************************//

                <sql:query var="CONTAR" dataSource="${con}">
                SELECT * FROM
                        INV_SALDOS_POR_BODEGA
                </sql:query>
                <c:forEach var="CONTE" items="${CONTAR.rows}">
                    <c:set var="SPB_ID" value="${CONTE.SPB_ID}"/>
                </c:forEach>
                <sql:query var="SALDOSB" dataSource="${con}">
                SELECT * FROM
                        INV_SALDOS_POR_BODEGA
                        S
                        WHERE
                        PRO_ID = '${param.det1}' AND
                        BOD_ID = '${param.bod}'
                        ORDER
                        BY
                        S.SPB_ID
                        DESC
                        LIMIT
                        1
                </sql:query>
                <c:forEach var="SALB" items="${SALDOSB.rows}">
                    <c:set var="SAL_CAN" value="${SALB.SPB_STOCK}"/>
                    <c:set var="SAL_VTOT" value="${SALB.SPB_VALOR_TOTAL}"/>
                </c:forEach>

//**********************************PONDERACION BODEGAS**************************************

                <c:set value="${param.tot1+SAL_VTOT}" var ='aux1'/>
                <c:set value="${param.can1+SAL_CAN}" var ='aux2'/>
                <c:set value="${aux1/aux2}" var ="unitario"/>

                <sql:update  var="saldosb" dataSource="${con}">

                INSERT
                        INTO
                        INVENTARIOSPI.INV_SALDOS_POR_BODEGA(
                                SPB_ID,
                                BOD_ID,
                                PRO_ID,
                                SPB_STOCK,
                                SPB_VALOR_UNITARIO,
                                SPB_VALOR_TOTAL)
                        VALUES('${SPB_ID+1}', '${param.bod}', '${param.det1}', '${param.can1+SAL_CAN}', '${unitario}', '${param.tot1+SAL_VTOT}')

                    <c:if test="${contador>1}">

                        <sql:query var="SALDOSB" dataSource="${con}">
                SELECT * FROM
                        INV_SALDOS_POR_BODEGA
                        S
                        WHERE
                        PRO_ID = '${param.det2}'  AND
                        BOD_ID = '${param.bod}'
                        ORDER
                        BY
                        S.SPB_ID
                        DESC
                        LIMIT
                        1
                        </sql:query>
                        <c:forEach var="SALB" items="${SALDOSB.rows}">
                            <c:set var="SAL_CAN" value="${SALB.SPB_STOCK}"/>
                            <c:set var="SAL_VTOT" value="${SALB.SPB_VALOR_TOTAL}"/>
                        </c:forEach>

                        <c:set value="${param.tot2+SAL_VTOT}" var ='aux1'/>
                        <c:set value="${param.can2+SAL_CAN}" var ='aux2'/>
                        <c:set value="${aux1/aux2}" var ="unitario1"/>

                , ('${SPB_ID+2}', '${param.bod}', '${param.det2}', '${param.can2+SAL_CAN}', '${unitario1}', '${param.tot2+SAL_VTOT}')
                        <c:if test="${contador>2}">

                            <sql:query var="SALDOSB" dataSource="${con}">
                SELECT * FROM
                        INV_SALDOS_POR_BODEGA
                        S
                        WHERE
                        PRO_ID = '${param.det3}'  AND
                        BOD_ID = '${param.bod}'
                        ORDER
                        BY
                        S.SPB_ID
                        DESC
                        LIMIT
                        1
                            </sql:query>
                            <c:forEach var="SALB" items="${SALDOSB.rows}">
                                <c:set var="SAL_CAN" value="${SALB.SPB_STOCK}"/>
                                <c:set var="SAL_VTOT" value="${SALB.SPB_VALOR_TOTAL}"/>
                            </c:forEach>

                            <c:set value="${param.tot3+SAL_VTOT}" var ='aux1'/>
                            <c:set value="${param.can3+SAL_CAN}" var ='aux2'/>
                            <c:set value="${aux1/aux2}" var ="unitario2"/>

                , ('${SPB_ID+3}', '${param.bod}', '${param.det3}', '${param.can3+SAL_CAN}', '${unitario2}', '${param.tot3+SAL_VTOT}')
                            <c:if test="${contador>3}">
                                <sql:query var="SALDOSB" dataSource="${con}">
                SELECT * FROM
                        INV_SALDOS_POR_BODEGA
                        S
                        WHERE
                        PRO_ID = '${param.det4}'  AND
                        BOD_ID = '${param.bod}'
                        ORDER
                        BY
                        S.SPB_ID
                        DESC
                        LIMIT
                        1
                                </sql:query>
                                <c:forEach var="SALB" items="${SALDOSB.rows}">
                                    <c:set var="SAL_CAN" value="${SALB.SPB_STOCK}"/>
                                    <c:set var="SAL_VTOT" value="${SALB.SPB_VALOR_TOTAL}"/>
                                </c:forEach>

                                <c:set value="${param.tot4+SAL_VTOT}" var ='aux1'/>
                                <c:set value="${param.can4+SAL_CAN}" var ='aux2'/>
                                <c:set value="${aux1/aux2}" var ="unitario3"/>

                , ('${SPB_ID+4}', '${param.bod}', '${param.det4}', '${param.can4+SAL_CAN}', '${unitario3}', '${param.tot4+SAL_VTOT}')
                                <c:if test="${contador>4}">
                                    <sql:query var="SALDOSB" dataSource="${con}">
                SELECT * FROM
                        INV_SALDOS_POR_BODEGA
                        S
                        WHERE
                        PRO_ID = '${param.det5}'  AND
                        BOD_ID = '${param.bod}'
                        ORDER
                        BY
                        S.SPB_ID
                        DESC
                        LIMIT
                        1
                                    </sql:query>
                                    <c:forEach var="SALB" items="${SALDOSB.rows}">
                                        <c:set var="SAL_CAN" value="${SALB.SPB_STOCK}"/>
                                        <c:set var="SAL_VTOT" value="${SALB.SPB_VALOR_TOTAL}"/>
                                    </c:forEach>

                                    <c:set value="${param.tot5+SAL_VTOT}" var ='aux1'/>
                                    <c:set value="${param.can5+SAL_CAN}" var ='aux2'/>
                                    <c:set value="${aux1/aux2}" var ="unitario4"/>

                , ('${SPB_ID+5}', '${param.bod}', '${param.det5}', '${param.can5+SAL_CAN}', '${unitario4}', '${param.tot5+SAL_VTOT}')
                                    <c:if test="${contador>5}">
                                        <sql:query var="SALDOSB" dataSource="${con}">
                SELECT * FROM
                        INV_SALDOS_POR_BODEGA
                        S
                        WHERE
                        PRO_ID = '${param.det6}'  AND
                        BOD_ID = '${param.bod}' ORDER
                        BY
                        S.SPB_ID
                        DESC
                        LIMIT
                        1
                                        </sql:query>
                                        <c:forEach var="SALB" items="${SALDOSB.rows}">
                                            <c:set var="SAL_CAN" value="${SALB.SPB_STOCK}"/>
                                            <c:set var="SAL_VTOT" value="${SALB.SPB_VALOR_TOTAL}"/>
                                        </c:forEach>

                                        <c:set value="${param.tot6+SAL_VTOT}" var ='aux1'/>
                                        <c:set value="${param.can6+SAL_CAN}" var ='aux2'/>
                                        <c:set value="${aux1/aux2}" var ="unitario5"/>

                , ('${SPB_ID+6}', '${param.bod}', '${param.det6}', '${param.can6+SAL_CAN}', '${unitario5}', '${param.tot6+SAL_VTOT}')
                                    </c:if>
                                </c:if>
                            </c:if>
                        </c:if>
                    </c:if>
                </sql:update>

//****************************************************************RELACIONES**********************************************************// 

                <sql:update dataSource="${con}">
                INSERT
                        INTO
                        INVENTARIOSPI.INV_SALDOS_GENERALES_POR_DETALLE(
                                SAL_ID, DET_ID
                                )
                        VALUES('${SAL_ID+1}', '${contar+1}')

                </sql:update>
                <sql:update dataSource="${con}">
                INSERT
                        INTO
                        INVENTARIOSPI.INV_SALDOS_BODEGA_POR_DETALLE(
                                SPB_ID, DET_ID
                                )
                        VALUES('${SPB_ID+1}', '${contar+1}')

                </sql:update>

                <c:if test="${contador>1}">
                    <sql:update dataSource="${con}">
                INSERT
                        INTO
                        INVENTARIOSPI.INV_SALDOS_GENERALES_POR_DETALLE(
                                SAL_ID, DET_ID
                                )
                        VALUES('${SAL_ID+2}', '${contar+2}')

                        <sql:update dataSource="${con}">
                INSERT
                        INTO
                        INVENTARIOSPI.INV_SALDOS_BODEGA_POR_DETALLE(
                                SPB_ID, DET_ID
                                )
                        VALUES('${SPB_ID+2}', '${contar+2}')

                        </sql:update>

                    </sql:update>
                    <c:if test="${contador>2}">
                        <sql:update dataSource="${con}">
                INSERT
                        INTO
                        INVENTARIOSPI.INV_SALDOS_GENERALES_POR_DETALLE(
                                SAL_ID, DET_ID
                                )
                        VALUES('${SAL_ID+3}', '${contar+3}')

                        </sql:update>

                        <sql:update dataSource="${con}">
                INSERT
                        INTO
                        INVENTARIOSPI.INV_SALDOS_BODEGA_POR_DETALLE(
                                SPB_ID, DET_ID
                                )
                        VALUES('${SPB_ID+3}', '${contar+3}')

                        </sql:update>

                        <c:if test="${contador>3}">
                            <sql:update dataSource="${con}">
                INSERT
                        INTO
                        INVENTARIOSPI.INV_SALDOS_GENERALES_POR_DETALLE(
                                SAL_ID, DET_ID
                                )
                        VALUES('${SAL_ID+4}', '${contar+4}')

                                <sql:update dataSource="${con}">
                INSERT
                        INTO
                        INVENTARIOSPI.INV_SALDOS_BODEGA_POR_DETALLE(
                                SPB_ID, DET_ID
                                )
                        VALUES('${SPB_ID+4}', '${contar+4}')

                                </sql:update>

                            </sql:update>
                            <c:if test="${contador>4}">
                                <sql:update dataSource="${con}">
                INSERT
                        INTO
                        INVENTARIOSPI.INV_SALDOS_GENERALES_POR_DETALLE(
                                SAL_ID, DET_ID
                                )
                        VALUES('${SAL_ID+5}', '${contar+5}')

                                    <sql:update dataSource="${con}">
                INSERT
                        INTO
                        INVENTARIOSPI.INV_SALDOS_BODEGA_POR_DETALLE(
                                SPB_ID, DET_ID
                                )
                        VALUES('${SPB_ID+5}', '${contar+5}')

                                    </sql:update>
                                </sql:update>
                                <c:if test="${contador>5}">
                                    <sql:update dataSource="${con}">
                INSERT
                        INTO
                        INVENTARIOSPI.INV_SALDOS_GENERALES_POR_DETALLE(
                                SAL_ID, DET_ID
                                )
                        VALUES('${SAL_ID+6}', '${contar+6}')

                                    </sql:update>
                                    <sql:update dataSource="${con}">
                INSERT
                        INTO
                        INVENTARIOSPI.INV_SALDOS_BODEGA_POR_DETALLE(
                                SPB_ID, DET_ID
                                )
                        VALUES('${SPB_ID+6}', '${contar+6}')

                                    </sql:update>
                                </c:if>
                            </c:if>
                        </c:if>
                    </c:if>
                </c:if>

                }

            </script>

            </font>
            <form action="Tra_Compras.jsp" method='post' >
                <style onload="extraer();" >
                </style>

                <div class='exito' id="exi_div" > 

                    <input type ="hidden" value="${param.usuar}" name="usuario">
                    <input type="hidden" id="p1">
                    <table border="0" >
                        <br>
                        <tr>
                            <td><center><h1>Transacción realizada <br>
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

