$(document).ready(function () {
    //NUMEROS DE FACTURA DE COMPRA GENERADAS CON EL PROVEEDOR SELECCIONADO
    $('select[name =bod]').on('change', function () {

        var y = document.getElementById("pro").value;
        var x = document.getElementById("bod").value;

        var data = "";
        var data = {'codigoprov': y, 'codigobodega': x};

        if (x !== "0") {
            $.ajax({
                type: 'GET',
                url: 'Con_Facturas_Compra',
                data: data,
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


                    var separar = dados.split(":");
                    $('select[name =num] option').remove();

                    $('select[name =num]').append('<option value ="0">--SELECCIONE--</option>');
                    for (var i = 0; i < separar.length - 1; i++) {

                        var codigofactura = separar[i].split("-")[0];
                        var numero_factura = separar[i].split("-")[1];

                        $('select[name =num]').append('<option value ="' + codigofactura + '">' + numero_factura + '</option>');
                    }

                    if (document.getElementById("num").length === 1) {
                        alert("No existen facturas generadas con este proveedor.");
                        document.getElementById("num").disabled = true;
                    } else
                    {
                        document.getElementById("num").disabled = false;
                    }
                    
            document.getElementById("det").disabled = true;
            document.getElementById("can").value = "";
            document.getElementById("can").disabled = true;
            document.getElementById("lim").disabled = false;
            document.getElementById("uni").value = "";
            document.getElementById("totp").value = "";
            document.getElementById("ite").value = "";
            document.getElementById("tot").value = "";
            document.getElementById("sub").value = "";
            document.getElementById("iva").value = "";

            document.getElementById("gua").disabled = true;
            document.getElementById("can").disabled = true;
            document.getElementById("agr").disabled = true;
            var tbl1 = document.getElementById("detalle");
            while (tbl1.rows.length > 1) {
                tbl1.deleteRow();
            }


                }


            });
        } else {
            $('select[name =num] option').remove();
            $('select[name =num]').append('<option value ="0">--SELECCIONE--</option>');
            document.getElementById("num").disabled = true;
            
            document.getElementById("det").disabled = true;
            document.getElementById("can").value = "";
            document.getElementById("can").disabled = true;
            document.getElementById("lim").disabled = false;
            document.getElementById("uni").value = "";
            document.getElementById("totp").value = "";
            document.getElementById("ite").value = "";
            document.getElementById("tot").value = "";
            document.getElementById("sub").value = "";
            document.getElementById("iva").value = "";

            document.getElementById("gua").disabled = true;
            document.getElementById("can").disabled = true;
            document.getElementById("agr").disabled = true;
            var tbl1 = document.getElementById("detalle");
            while (tbl1.rows.length > 1) {
                tbl1.deleteRow();
            }

        }
    });

    //PRODUCTOS DE LA FACTURA DE COMPRA SELECCIONADA

    $('select[name =num]').on('change', function () {
        var x = document.getElementById("num").value;
        if (x !== "0") {
            $.ajax({
                type: 'GET',
                url: 'Con_Prod_Factura_Compra',
                data: 'codigofactura=' + $('select[name =num]').val(),
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


                    var separar = dados.split(":");
                    $('select[name =det] option').remove();
                    $('select[name =det]').append('<option value ="0">--SELECCIONE--</option>');
                    for (var i = 0; i < separar.length - 1; i++) {

                        var codigoproducto = separar[i].split("-")[0];
                        var codigo = separar[i].split("-")[1];
                        var detalle_producto = separar[i].split("-")[2];
                        var cantidad_producto = separar[i].split("-")[3];
                        var valor_unitario = separar[i].split("-")[4];

                        $('select[name =det]').append('<option value ="' + codigoproducto + '" onclick="auxiliar(' + cantidad_producto + ',' + valor_unitario +')">' + codigo + "  " + detalle_producto + '</option>');
                    }

                    if (document.getElementById("det").length === 1) {
                        alert("No existen productos en esta factura.");
                        document.getElementById("det").disabled = true;
                        document.getElementById("lim").disabled = true;
                        document.getElementById("gua").disabled = true;
                        document.getElementById("can").disabled = true;
                        document.getElementById("can").value = '';
                        document.getElementById("agr").disabled = true;
                    } else
                    {
                        document.getElementById("can").value = "";
                    
                        document.getElementById("lim").disabled = false;
                        document.getElementById("gua").disabled = false;
                        document.getElementById("can").disabled = false;
                        document.getElementById("agr").disabled = false;
                        document.getElementById("can").focus();
                    }
    


      
            document.getElementById("uni").value = "";
            document.getElementById("totp").value = "";
            document.getElementById("ite").value = "";
            document.getElementById("tot").value = "";
            document.getElementById("sub").value = "";
            document.getElementById("iva").value = "";


            var tbl1 = document.getElementById("detalle");
            while (tbl1.rows.length > 1) {
                tbl1.deleteRow();
            }




                }


            });
        } else {
            $('select[name =det] option').remove();
            $('select[name =det]').append('<option value ="0">--SELECCIONE--</option>');


            document.getElementById("det").disabled = true;
            document.getElementById("can").value = "";
            document.getElementById("can").disabled = true;
            document.getElementById("lim").disabled = false;
            document.getElementById("uni").value = "";
            document.getElementById("totp").value = "";
            document.getElementById("ite").value = "";
            document.getElementById("tot").value = "";
            document.getElementById("sub").value = "";
            document.getElementById("iva").value = "";

            document.getElementById("gua").disabled = true;
            document.getElementById("can").disabled = true;
            document.getElementById("agr").disabled = true;
            var tbl1 = document.getElementById("detalle");
            while (tbl1.rows.length > 1) {
                tbl1.deleteRow();
            }

        }
    });


//NUMEROS DE FACTURA DE VENTA GENERADAS CON EL CLIENTE SELECCIONADO
    $('select[name =cli]').on('change', function () {

        var y = document.getElementById("cli").value;
        if (y !== "0") {
            $.ajax({
                type: 'GET',
                url: 'Con_Facturas_Ventas',
                data: 'codigocliente=' + $('select[name =cli]').val(),
                statusCode: {
                    404: function () {
                        alert('Pagina no encontrada ');
                        console.log('404');
                    },
                    500: function () {
                        alert('Error en el servidor');
                        console.log('500');
                    }
                },
                success: function (dados) {


                    var separar = dados.split(":");
                    $('select[name =num1] option').remove();

                    $('select[name =num1]').append('<option value ="0">--SELECCIONE--</option>');
                    for (var i = 0; i < separar.length - 1; i++) {

                        var codigofactura = separar[i].split("-")[0];
                        var numero_factura = separar[i].split("-")[1];
                        var codigo_bodega = separar[i].split("-")[2];

                        $('select[name =num1]').append('<option value ="' + codigofactura + '" onclick="auxiliar2(' + codigo_bodega + ')">' + numero_factura + '</option>');
                    }

                    if (document.getElementById("num1").length === 1) {
                        alert("No existen facturas generadas con este cliente.");
                        document.getElementById("num1").disabled = true;
                    } else
                    {
                        document.getElementById("num1").disabled = false;
                    }

                    $('select[name =det] option').remove();
                    $('select[name =det]').append('<option value ="0">--SELECCIONE--</option>');
            
                    document.getElementById("det").disabled = true;
                    document.getElementById("can").value = "";
                    document.getElementById("can").disabled = true;
                    document.getElementById("lim").disabled = false;
                    document.getElementById("uni").value = "";
                    document.getElementById("totp").value = "";
                    document.getElementById("ite").value = "";
                    document.getElementById("tot").value = "";
                    document.getElementById("sub").value = "";
                    document.getElementById("iva").value = "";
           document.getElementById("obs").value = "";
                    document.getElementById("gua").disabled = true;
                    document.getElementById("can").disabled = true;
                    document.getElementById("agr").disabled = true;
                    var tbl1 = document.getElementById("detalle");
                    while (tbl1.rows.length > 1) {
                        tbl1.deleteRow();
                    }
                }


            });
        } else {
            $('select[name =det] option').remove();
            $('select[name =det]').append('<option value ="0">--SELECCIONE--</option>');
            document.getElementById("num1").disabled = true;
            document.getElementById("det").disabled = true;
            document.getElementById("can").value = "";
            document.getElementById("can").disabled = true;
            document.getElementById("lim").disabled = false;
            document.getElementById("uni").value = "";
            document.getElementById("totp").value = "";
            document.getElementById("ite").value = "";
            document.getElementById("tot").value = "";
            document.getElementById("sub").value = "";
            document.getElementById("iva").value = "";
                       document.getElementById("obs").value = "";

            document.getElementById("gua").disabled = true;
            document.getElementById("can").disabled = true;
            document.getElementById("agr").disabled = true;
            var tbl1 = document.getElementById("detalle");
            while (tbl1.rows.length > 1) {
                tbl1.deleteRow();
            }


        }
    });

    //PRODUCTOS DE LA FACTURA DE VENTA SELECCIONADA

    $('select[name =num1]').on('change', function () {
        var x = document.getElementById("num1").value;
        if (x !== "0") {
            $.ajax({
                type: 'GET',
                url: 'Con_Prod_Factura_Ventas',
                data: 'codigofactura=' + $('select[name =num1]').val(),
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


                    var separar = dados.split(":");
                    $('select[name =det] option').remove();
                    $('select[name =det]').append('<option value ="0">--SELECCIONE--</option>');
                    for (var i = 0; i < separar.length - 1; i++) {

                        var codigoproducto = separar[i].split("-")[0];
                        var codigo = separar[i].split("-")[1];
                        var detalle_producto = separar[i].split("-")[2];
                        var cantidad_producto = separar[i].split("-")[3];
                        var valor_unitario = separar[i].split("-")[4];
                        var valor_unitariog = separar[i].split("-")[5];
                        var valor_unitariob = separar[i].split("-")[6];

                        $('select[name =det]').append('<option value ="' + codigoproducto + '" onclick="auxiliar(' + cantidad_producto + ',' + valor_unitario + ','+valor_unitariog+','+valor_unitariob+')">' + codigo + "  " + detalle_producto + '</option>');
                    }

                    if (document.getElementById("det").length === 1) {
                        alert("No existen productos en esta factura.");
                        document.getElementById("det").disabled = true;
                        document.getElementById("lim").disabled = true;
                        document.getElementById("gua").disabled = true;
                        document.getElementById("can").disabled = true;
                        document.getElementById("can").value = '';
                        document.getElementById("agr").disabled = true;
                    } else
                    {
                        document.getElementById("can").value = "";
  
                        document.getElementById("lim").disabled = false;
                        document.getElementById("gua").disabled = false;
                        document.getElementById("can").disabled = false;
                        document.getElementById("agr").disabled = false;
                        document.getElementById("can").focus();
                    }
                    var tbl1 = document.getElementById("detalle");
                    while (tbl1.rows.length > 1) {
                        tbl1.deleteRow();
                    }
                     document.getElementById("obs").value = "";
                    document.getElementById("ite").value = "";
                    document.getElementById("sub").value = "";
                    document.getElementById("iva").value = "";
                    document.getElementById("tot").value = "";




                }


            });
        } else {
            $('select[name =det] option').remove();
            $('select[name =det]').append('<option value ="0">--SELECCIONE--</option>');

            document.getElementById("det").disabled = true;
            document.getElementById("can").value = "";
            document.getElementById("can").disabled = true;
            document.getElementById("lim").disabled = false;
            document.getElementById("uni").value = "";
            document.getElementById("totp").value = "";
            document.getElementById("ite").value = "";
            document.getElementById("tot").value = "";
            document.getElementById("sub").value = "";
            document.getElementById("iva").value = "";
             document.getElementById("obs").value = "";

            document.getElementById("gua").disabled = true;
            document.getElementById("can").disabled = true;
            document.getElementById("agr").disabled = true;
            var tbl1 = document.getElementById("detalle");
            while (tbl1.rows.length > 1) {
                tbl1.deleteRow();
            }


        }
    });


});