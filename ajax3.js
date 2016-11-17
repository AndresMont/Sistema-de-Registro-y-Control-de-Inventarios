$(document).ready(function () {

    $('select[name =bod1]').on('change', function () {
        var x = document.getElementById("bod1").value;
        if (x !== "0") {
            $.ajax({
                type: 'GET',
                url: 'Con_Prod_Transferencias',
                data: 'codigo=' + $('select[name =bod1]').val(),
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
                        var valor_total = separar[i].split("-")[5];
           
                        $('select[name =det]').append('<option value ="' + codigoproducto + '" onclick="auxiliar(' + cantidad_producto + ',' + valor_unitario + ',' + valor_total + ')">' + codigo + "  " + detalle_producto + '</option>');
                    }

                    if (document.getElementById("det").length === 1) {
                        alert("No existen productos en esta bodega.");
                        document.getElementById("bod2").disabled = true;
                        document.getElementById("det").disabled = true;
                        document.getElementById("lim").disabled = true;
                        document.getElementById("gua").disabled = true;
                        document.getElementById("can").disabled = true;
                        document.getElementById("can").value = '';
                        document.getElementById("agr").disabled = true;
                    } else
                    {
                        document.getElementById("can").value = "";
                        document.getElementById("bod2").value = "0";
                        document.getElementById("bod2").disabled = false;
                    
                    }




                    document.getElementById("uni").value = "";
                    document.getElementById("totp").value = "";
                    document.getElementById("ite").value = "";


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