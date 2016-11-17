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
        <title>Desperdicios</title>
        <sql:setDataSource driver="com.mysql.jdbc.Driver"
                           url="jdbc:mysql://localhost:3306/inventariospi?zeroDateTimeBehavior=convertToNull"
                           user="root"
                           password="System19"
                           var="con"
                           />

        <script src="jquery-3.1.0.min.js"></script>
        <script src="ajax4.js"></script>
        <script type="text/javascript">
            function campos() {


                var d = document.getElementById("ite");
                var h = document.getElementById("bod");
                
                var i = document.getElementById("obs");
                if ( d.value !== "" & h.value !== "0" & i!=="") {
                    return true;
                } else {
       
                    if (g.value === "") {

                        alert('Por favor, Ingrese al menos un producto.');
                    }
                    if (h.value === "0") {

                        alert('Por favor, Ingrese la bodega de la que se extrae el producto.');
                    }
                     if (i.value === "") {

                        alert('Por favor, Ingrese la observación del desperdicio.');
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

        </script>
    </head>

    <sql:query var="resultado" dataSource="${con}">
        SELECT * FROM INVENTARIOSPI.INV_DOCUMENTOS WHERE DOC_TIPO_DOCUMENTO = 'DE'
    </sql:query>



    <body onload="funcion1()">

        <font color="white">
    <center>
        <h1>Instituto Tecnológico Superior "Cordillera"<br>
            Sistema de Registro y Control de Inventarios</h1>

        <hr/>
        <h2>
            Registro de Despedicios
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
                           
                            <td>Bodega*:</td>
                            <td> <select name="bod" id="bod"  style=" width:520px; "  disabled>
                                    <option value="0" >--SELECCIONE--</option>
                                </select> 
                            </td>
                             <td>Número de documento:</td>
                            <td> 
                                <input type="text" name="num" size="40" id="num" maxlength="200" disabled >
                            </td>

                        </tr>
                        <tr>
                           
                            <td>Cantidad items:</td>
                            <td><input type="text" name="ite" size="40" id="ite"  disabled ></td>
 <td>Observación*:</td>
                            <td><input type="text" name="obs" size="40" id="obs" onkeyup="mayusculas()"  autocomplete="off" disabled ></td>
                        </tr>
                     
                        <tr><td colspan="2"><br>Los datos con (*) son obligatorios.</td> 
                            <td><input type="hidden" name="id" id="id_tab" /></td>
                            <td> <input type="hidden" value="${param.usuario}" name="usuar" ></td></tr>
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
                            <td><input type="number"  name="can" size="40" id="can" disabled onchange="cantidad()" onkeypress="return isNumberKey(event);" ></td>
                            <td>Detalle*:</td>
                            <td><select name="det" id="det"  style=" width:520px; " disabled >
                                    <option value="0"  selected>--SELECCIONE--</option>

                                </select> </td>
                        </tr>
                        <tr>
                            <td>Valor Unitario:</td>

                            <td> <input type="text" name="uni" size="40" id="uni" maxlength="200" disabled ></td>
                            <td>Valor Total:</td>
                            <td><input type="text" name="totp" size="40" id="totp" maxlength="200" disabled ></td>
                    <input type="hidden" name="quitar" id="quitar" value="xyz">
                    <input type="hidden" name="filas" id="filas" >
                    <input type="hidden" name="aux1" id="aux1" >
                    <input type="hidden" name="aux2" id="aux2" >
                    <input type="hidden" name="aux3" id="aux3" >
                    <input type="hidden" name="aux4" id="aux4" >
                    <input type="hidden" name="aux5" id="aux5" >
                    <input type="hidden" name="aux6" id="aux6" >
                    <input type="hidden" name="contador" id="contador" >


                    </tr>
                    </tbody>
                </table>
                <br>
                <br>
                <table cellspacing="8"  border="0">
                    <tr>
                        <td><input type="button" value="Limpiar" size="80"  id="lim" class="botones"  onclick ="limpiar();
                                resetear();" disabled/></td>
                        <td><input type="button" value="Agregar" size="80"  id="agr" class="botones"  onclick ="agregar()" disabled/></td>
                        <td><input type="button" value="Quitar"  size="80" id="qui" class="botones" onclick="quit();" disabled /></td>
                    </tr>

                    <tr height="100px">
                        <td colspan="2"><input type="search" results ="2" name="bus" id ="bus" class="bus"size="40"  onkeyup=" mayusculas();buscartabla();" placeholder="Buscar..." align="center"></td>
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
                    document.getElementById("det").disabled = true;
                                        document.getElementById("obs").disabled = false;
                    document.getElementById("bod").disabled = false;
                               document.getElementById("can").disabled = true;
                                          document.getElementById("det").disabled = true;

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


            <sql:query var="bodegas" dataSource="${con}">
                SELECT
                U.SUC_ID, B.BOD_ID, B.BOD_DESCRIPCION
                FROM
                INVENTARIOSPI.INV_USUARIOS
                U, INVENTARIOSPI.INV_BODEGAS
                B
                WHERE
                U.SUC_ID = B.SUC_ID
                AND
                U.USU_NOMBRE_USUARIO = '${param.usuario}'
            </sql:query>
                $('#bod').find('option').remove().end().append('<option value="0">--SELECCIONE</option>');
            <c:forEach var="bods" items="${bodegas.rows}">
                $('select[name =bod]').append('<option value ="<c:out value="${bods.BOD_ID}"/>" ><c:out value="${bods.BOD_DESCRIPCION}"/> </option>');
            </c:forEach>
                }


                function auxiliar(salg, vaug, vatg, salb, vaub, vatb) {
                    document.getElementById("aux1").value = "";
                    document.getElementById("aux2").value = "";
                    document.getElementById("aux3").value = "";
                    document.getElementById("aux4").value = "";
                    document.getElementById("aux5").value = "";
                    document.getElementById("aux6").value = "";
                    document.getElementById("aux1").value = salg;
                    document.getElementById("aux2").value = vaug;
                    document.getElementById("aux3").value = vatg;
                    document.getElementById("aux4").value = salb;
                 
                    document.getElementById("aux5").value = vaub;
                    document.getElementById("aux6").value = vatb;
       document.getElementById("uni").value = vaub;
                }

                function cantidad() {
                document.getElementById("det").disabled = false;
                    var a = document.getElementById("can").value;
                    var b = document.getElementById("uni").value;
                    var t = (a*b).toFixed(2);
                    document.getElementById("totp").value = t;
                }

                function agregar() {
                    document.getElementById("val").value = "gua";
                     var a = document.getElementById("can").value;
                    var stock = document.getElementById("aux4").value;
              
                        stock = stock-5;
                    
                    if(a> stock){
                        alert("Stock Insuficiente.\nPor favor ingrese una cantidad menor o igual a "+stock+" .");
                    }else{
                        if(stock<=10 & stock>0){
                        alert("Stock próximo a agotarse.\nPor favor realize una nueva compra del producto.");
                         }
            
                    var b = document.getElementById("det");
                    var b = b.options[b.selectedIndex].text;
                    b = document.getElementById("det").value + "  " + b;
                    var c = document.getElementById("uni").value;
                    var d = document.getElementById("totp").value;
                    document.getElementById("filas").value = document.getElementById("detalle").rows.length;
                    if (a === "" || a < 1 || document.getElementById("det").value === "0") {
                        if (a < 1 && a !== "") {
                            alert("Por favor, Ingrese una cantidad mayor a 0.");
                        } else if (a === "" || document.getElementById("det").value === "0") {
                            alert("Cantidad y/o Producto no ingresados.");
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
                        var rows = rows - 1;
                        row.id = rows;
                        document.getElementById("" + rows).setAttribute("style", "cursor:pointer");
                        document.getElementById("" + rows).setAttribute("onclick", "recuperar(" + rows + ")");
                        //     row.onclick = 'recuperar(' + rows + ')';
                        //CANTIDAD ITEMS
                        var x = document.getElementById("ite").value;
                        var t1 = (parseInt(x) || 0) + parseInt(a);
                        document.getElementById("ite").value = t1;
                      
                        //ELIMINAR ELEMENTO
                        var q = document.getElementById("can").value;
                        document.getElementById("can").value = "";
                        document.getElementById("uni").value = "";
                        document.getElementById("totp").value = "";
                        document.getElementById("det").disabled = true;
                        document.getElementById("can").focus();
                        //  document.getElementById("det").remove(document.getElementById("det").selectedIndex);
                        var x = document.getElementById("det").selectedIndex;
                        document.getElementById("det").options[x].disabled = true;
                        document.getElementById("det").value = "0";

                        var p = document.getElementById("detalle").getElementsByTagName("tr").length;
                        p = p - 1;
                        var vus = document.createElement("input");
                        vus.setAttribute("type", "hidden");
                        vus.setAttribute("name", "vus" + p);
                        vus.setAttribute("id", "vus" + p);
                        document.getElementById("bloque2").appendChild(vus);
                        document.getElementById("vus" + p).value = document.getElementById("aux2").value;

                        var vts = document.createElement("input");
                        vts.setAttribute("type", "hidden");
                        vts.setAttribute("name", "vts" + p);
                        vts.setAttribute("id", "vts" + p);
                        document.getElementById("bloque2").appendChild(vts);

                        document.getElementById("vts" + p).value = document.getElementById("vus" + p).value * q;


                        var vusb = document.createElement("input");
                        vusb.setAttribute("type", "hidden");
                        vusb.setAttribute("name", "vusb" + p);
                        vusb.setAttribute("id", "vusb" + p);
                        document.getElementById("bloque2").appendChild(vusb);
                        document.getElementById("vusb" + p).value = document.getElementById("aux5").value;

                        var vtsb = document.createElement("input");
                        vtsb.setAttribute("type", "hidden");
                        vtsb.setAttribute("name", "vtsb" + p);
                        vtsb.setAttribute("id", "vtsb" + p);
                        document.getElementById("bloque2").appendChild(vtsb);

                        document.getElementById("vtsb" + p).value = document.getElementById("vusb" + p).value * q;

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
                    document.getElementById("aux2").value = fila;
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
                    document.getElementById("qui").disabled = true;
                    document.getElementById("can").focus();
                }

                function quit() {
                    var o = document.getElementById("aux2").value;
                 
                    var padre = document.getElementById("bloque2");
                    var p = document.getElementsByName("vus" + o)[0];
                    var q = document.getElementsByName("vts" + o)[0];
                      var r = document.getElementsByName("vusb" + o)[0];
                    var s = document.getElementsByName("vtsb" + o)[0];
                    padre.removeChild(p);
                    padre.removeChild(q);
                     padre.removeChild(r);
                      padre.removeChild(s);
                    o = parseInt(o);
                    while (o !== document.getElementById("detalle").getElementsByTagName("tr").length - 1) {
                        var qui = o + 1;

                        document.getElementById("vus" + qui).removeAttribute("name");
                        document.getElementById("vts" + qui).removeAttribute("name");
                        document.getElementById("vusb" + qui).removeAttribute("name");
                        document.getElementById("vtsb" + qui).removeAttribute("name");

                        document.getElementById("vus" + qui).setAttribute("name", "vus" + o);
                        document.getElementById("vts" + qui).setAttribute("name", "vts" + o);
                         document.getElementById("vusb" + qui).setAttribute("name", "vusb" + o);
                        document.getElementById("vtsb" + qui).setAttribute("name", "vtsb" + o);
                        
                        document.getElementsByName("vus" + o)[0].removeAttribute("id");
                        document.getElementsByName("vts" + o)[0].removeAttribute("id");
                          document.getElementsByName("vusb" + o)[0].removeAttribute("id");
                        document.getElementsByName("vtsb" + o)[0].removeAttribute("id");
                        
                        document.getElementsByName("vus" + o)[0].setAttribute("id", "vus" + o);
                        document.getElementsByName("vts" + o)[0].setAttribute("id", "vts" + o);
                                    document.getElementsByName("vusb" + o)[0].setAttribute("id", "vusb" + o);
                        document.getElementsByName("vtsb" + o)[0].setAttribute("id", "vtsb" + o);
                        o = o + 1;
                    }
                    var x = document.getElementById("quitar").value;
                    var y = document.getElementById("det").selectedIndex;
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
                    if (rows===0) {
                        document.getElementById("ite").value = "";
          
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
                    var trows = SearchFieldsTable[0].rows;
                    var aux = 1;
                    $.each(trows, function (index, row) {
                        var ColumnName = $(row).attr("style");
                        if (ColumnName.charAt(0) === "d") {
                            var a = document.getElementById("detalle").rows[aux].cells[0].innerText;
                            document.getElementById("detalle").rows[aux].removeAttribute("bgcolor");
                        }
                        aux = aux + 1;
                    });
                }
                function mayusculas() {
           var a = document.getElementById("bus");
                     var b = document.getElementById("obs");
                    a.value = a.value.toUpperCase();
                                 b.value = b.value.toUpperCase();
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
                DOC_OBSERVACIONES,
                DOC_TIPO_DOCUMENTO) 
                VALUES ('${cont+1}', '1','${param.bod}', '${suc_id}', '${usu_id}','1','${param.num}', STR_TO_DATE('${param.fec}', '%d/%m/%Y'), '${param.hor}', '${param.ite}','DESPERDICIO # ${param.num} ${param.obs}', 'DE');
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
                            DET_VALOR_TOTAL,
                            DET_VALOR_UNITARIO_SALDOG,
                            DET_VALOR_TOTAL_SALDOG,
                            DET_VALOR_UNITARIO_SALDOB,
                            DET_VALOR_TOTAL_SALDOB
                            )
                    VALUES('${contar+1}', '${conte}', '${param.det1} ', '${param.can1}', '${param.uni1}', '${param.tot1}', '${param.vus1}', '${param.vts1}', '${param.vusb1}', '${param.vtsb1}')
                    <c:if test="${contador>1}">
                    , ('${contar+2}', '${conte}', '${param.det2} ', '${param.can2}', '${param.uni2}', '${param.tot2}', '${param.vus2}', '${param.vts2}', '${param.vusb2}', '${param.vtsb2}')
                        <c:if test="${contador>2}">
                    , ('${contar+3}', '${conte}', '${param.det3} ', '${param.can3}', '${param.uni3}', '${param.tot3}', '${param.vus3}', '${param.vts3}', '${param.vusb3}', '${param.vtsb3}')
                            <c:if test="${contador>3}">
                    , ('${contar+4}', '${conte}', '${param.det4} ', '${param.can4}', '${param.uni4}', '${param.tot4}', '${param.vus4}', '${param.vts4}', '${param.vusb4}', '${param.vtsb4}')
                                <c:if test="${contador>4}">
                    , ('${contar+5}', '${conte}', '${param.det5} ', '${param.can5}', '${param.uni5}', '${param.tot5}', '${param.vus5}', '${param.vts5}', '${param.vusb5}', '${param.vtsb5}')
                                    <c:if test="${contador>5}">
                    , ('${contar+6}', '${conte}', '${param.det6} ', '${param.can6}', '${param.uni6}', '${param.tot6}', '${param.vus6}', '${param.vts6}', '${param.vusb6}', '${param.vtsb6}')
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

                <c:set value="${SAL_VTOT-param.vts1}" var ='aux1'/>
                <c:set value="${SAL_CAN-param.can1}" var ='aux2'/>
                <c:if test="${aux2 != 0}">
                    <c:set value="${aux1/aux2}" var ="unitario"/>
                </c:if>
                <c:if test="${aux2 == 0}">
                    <c:set value="0" var ="unitario"/>
                </c:if>
                <sql:update  var="det" dataSource="${con}">

                    INSERT
                    INTO
                    INVENTARIOSPI.INV_SALDOS_GENERALES(
                            SAL_ID,
                            PRO_ID,
                            SAL_STOCK,
                            SAL_VALOR_UNITARIO,
                            SAL_VALOR_TOTAL)
                    VALUES('${SAL_ID+1}', '${param.det1}', '${SAL_CAN-param.can1}', '${unitario}', '${SAL_VTOT-param.vts1}')

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

                        <c:set value="${SAL_VTOT-param.vts2}" var ='aux1'/>
                        <c:set value="${SAL_CAN-param.can2}" var ='aux2'/>
                        <c:if test="${aux2 != 0}">
                            <c:set value="${aux1/aux2}" var ="unitario1"/>
                        </c:if>
                        <c:if test="${aux2 == 0}">
                            <c:set value="0" var ="unitario1"/>
                        </c:if>
                    , ('${SAL_ID+2}', '${param.det2}', '${SAL_CAN-param.can2}', '${unitario1}', '${SAL_VTOT-param.vts2}')
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

                            <c:set value="${SAL_VTOT-param.vts3}" var ='aux1'/>
                            <c:set value="${SAL_CAN-param.can3}" var ='aux2'/>
                            <c:if test="${aux2 != 0}">
                                <c:set value="${aux1/aux2}" var ="unitario2"/>
                            </c:if>
                            <c:if test="${aux2 == 0}">
                                <c:set value="0" var ="unitario2"/>
                            </c:if>

                    , ('${SAL_ID+3}', '${param.det3}', '${SAL_CAN-param.can3}', '${unitario2}', '${SAL_VTOT-param.vts3}')
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

                                <c:set value="${SAL_VTOT-param.vts4}" var ='aux1'/>
                                <c:set value="${SAL_CAN-param.can4}" var ='aux2'/>
                                <c:if test="${aux2 != 0}">
                                    <c:set value="${aux1/aux2}" var ="unitario3"/>
                                </c:if>
                                <c:if test="${aux2 == 0}">
                                    <c:set value="0" var ="unitario3"/>
                                </c:if>

                    , ('${SAL_ID+4}', '${param.det4}', '${SAL_CAN-param.can4}', '${unitario3}', '${SAL_VTOT-param.vts4}')
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

                                    <c:set value="${SAL_VTOT-param.vts5}" var ='aux1'/>
                                    <c:set value="${SAL_CAN-param.can5}" var ='aux2'/>
                                    <c:if test="${aux2 != 0}">
                                        <c:set value="${aux1/aux2}" var ="unitario4"/>
                                    </c:if>
                                    <c:if test="${aux2 == 0}">
                                        <c:set value="0" var ="unitario4"/>
                                    </c:if>

                    , ('${SAL_ID+5}', '${param.det5}', '${SAL_CAN-param.can5}', '${unitario4}', '${SAL_VTOT-param.vts5}')
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

                                        <c:set value="${SAL_VTOT-param.vts6}" var ='aux1'/>
                                        <c:set value="${SAL_CAN-param.can6}" var ='aux2'/>
                                        <c:if test="${aux2 != 0}">
                                            <c:set value="${aux1/aux2}" var ="unitario5"/>
                                        </c:if>
                                        <c:if test="${aux2 == 0}">
                                            <c:set value="0" var ="unitario5"/>
                                        </c:if>

                    , ('${SAL_ID+6}', '${param.det6}', '${SAL_CAN-param.can6}', '${unitario5}', '${SAL_VTOT-param.vts6}')
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
                            PRO_ID = '${param.det1}'
                    AND
                            S.BOD_ID = '${param.bod}'
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

                <c:set value="${SAL_VTOT-param.vtsb1}" var ='aux1'/>
                <c:set value="${SAL_CAN-param.can1}" var ='aux2'/>
                <c:if test="${aux2 != 0}">
                    <c:set value="${aux1/aux2}" var ="unitario"/>
                </c:if>
                <c:if test="${aux2 == 0}">
                    <c:set value="0" var ="unitario"/>
                </c:if>
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
                    VALUES('${SPB_ID+1}', '${param.bod}', '${param.det1}', '${SAL_CAN-param.can1}', '${unitario}', '${SAL_VTOT-param.vtsb1}')

                    <c:if test="${contador>1}">

                        <sql:query var="SALDOSB" dataSource="${con}">
                    SELECT * FROM
                    INV_SALDOS_POR_BODEGA
                    S
                    WHERE
                    PRO_ID = '${param.det2}'
                            AND
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

                        <c:set value="${SAL_VTOT-param.vtsb2}" var ='aux1'/>
                        <c:set value="${SAL_CAN-param.can2}" var ='aux2'/>
                        <c:if test="${aux2 != 0}">
                            <c:set value="${aux1/aux2}" var ="unitario1"/>
                        </c:if>
                        <c:if test="${aux2 == 0}">
                            <c:set value="0" var ="unitario1"/>
                        </c:if>

                    , ('${SPB_ID+2}', '${param.bod}', '${param.det2}', '${SAL_CAN-param.can2}', '${unitario1}', '${SAL_VTOT-param.vtsb2}')
                        <c:if test="${contador>2}">

                            <sql:query var="SALDOSB" dataSource="${con}">
                    SELECT * FROM
                    INV_SALDOS_POR_BODEGA
                    S
                    WHERE
                    PRO_ID = '${param.det3}'
                            AND
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

                            <c:set value="${SAL_VTOT-param.vtsb3}" var ='aux1'/>
                            <c:set value="${SAL_CAN-param.can3}" var ='aux2'/>
                            <c:if test="${aux2 != 0}">
                                <c:set value="${aux1/aux2}" var ="unitario2"/>
                            </c:if>
                            <c:if test="${aux2 == 0}">
                                <c:set value="0" var ="unitario2"/>
                            </c:if>

                    , ('${SPB_ID+3}', '${param.bod}', '${param.det3}', '${SAL_CAN-param.can3}', '${unitario2}', '${SAL_VTOT-param.vtsb3}')
                            <c:if test="${contador>3}">

                                <sql:query var="SALDOSB" dataSource="${con}">
                    SELECT * FROM
                    INV_SALDOS_POR_BODEGA
                    S
                    WHERE
                    PRO_ID = '${param.det4}'
                            AND
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

                                <c:set value="${SAL_VTOT-param.vtsb4}" var ='aux1'/>
                                <c:set value="${SAL_CAN-param.can4}" var ='aux2'/>
                                <c:if test="${aux2 != 0}">
                                    <c:set value="${aux1/aux2}" var ="unitario3"/>
                                </c:if>
                                <c:if test="${aux2 == 0}">
                                    <c:set value="0" var ="unitario3"/>
                                </c:if>

                    , ('${SPB_ID+4}', '${param.bod}', '${param.det4}', '${SAL_CAN-param.can4}', '${unitario3}', '${SAL_VTOT-param.vtsb4}')
                                <c:if test="${contador>4}">

                                    <sql:query var="SALDOSB" dataSource="${con}">
                    SELECT * FROM
                    INV_SALDOS_POR_BODEGA
                    S
                    WHERE
                    PRO_ID = '${param.det5}'
                            AND
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

                                    <c:set value="${SAL_VTOT-param.vtsb5}" var ='aux1'/>
                                    <c:set value="${SAL_CAN-param.can5}" var ='aux2'/>
                                    <c:if test="${aux2 != 0}">
                                        <c:set value="${aux1/aux2}" var ="unitario4"/>
                                    </c:if>
                                    <c:if test="${aux2 == 0}">
                                        <c:set value="0" var ="unitario4"/>
                                    </c:if>

                    , ('${SPB_ID+5}', '${param.bod}', '${param.det5}', '${SAL_CAN-param.can5}', '${unitario4}', '${SAL_VTOT-param.vtsb5}')
                                    <c:if test="${contador>5}">

                                        <sql:query var="SALDOSB" dataSource="${con}">
                    SELECT * FROM
                    INV_SALDOS_POR_BODEGA
                    S
                    WHERE
                    PRO_ID = '${param.det6}'
                            AND
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

                                        <c:set value="${SAL_VTOT-param.vtsb6}" var ='aux1'/>
                                        <c:set value="${SAL_CAN-param.can6}" var ='aux2'/>
                                        <c:if test="${aux2 != 0}">
                                            <c:set value="${aux1/aux2}" var ="unitario5"/>
                                        </c:if>
                                        <c:if test="${aux2 == 0}">
                                            <c:set value="0" var ="unitario5"/>
                                        </c:if>
                    , ('${SPB_ID+6}', '${param.bod}', '${param.det6}', '${SAL_CAN-param.can6}', '${unitario5}', '${SAL_VTOT-param.vtsb6}')
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
            <form action="Tra_Desperdicios.jsp" method='post' >
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

