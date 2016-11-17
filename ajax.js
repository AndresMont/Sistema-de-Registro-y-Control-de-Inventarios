$(document).ready(function () {
    $('select[name =pro]').on('change', function () {
        var val = $('select[name =pro]').val();

        if (val === "0") {

            $('select[name =cant] option').remove();
            $('select[name =cant]').append('<option value ="0">--SELECCIONE--</option>');
            $('select[name =pro]').prop('0');
        } else {
            $.ajax({
                type: 'GET',
                url: 'Con_Man_Empresa',
                data: 'codigoprovincia=' + $('select[name =pro]').val(),
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
    });
//VALIDACION SIN PROVINCIA
    $('select[name =cant]').on('click', function () {
        var val = $('select[name =pro]').val();
        if (val === "0") {
            alert("No ha seleccionado una provincia");
        }
    });
//VALIDACION DE PRODUCTOS Y VALORES
    $('select[name =det]').on('change', function () {

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

                $("#uni").val(dados);
                var x = ($("#can").val() * dados).toFixed(2);
                $("#totp").val(x);
            }

        });
    });
    
    $('select[name =bod]').on('change', function () {
        var k = document.getElementById("bod").value;
        if (k !== "0") {
            $.ajax({
                type: 'GET',
                url: 'Con_Productos_Bodega',
                data: 'codigobodega=' + $('select[name =bod]').val(),
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
                        var nombreproducto = separar[i].split("-")[1];
                        var salg_stock = separar[i].split("-")[2];
                        var salg_valor_unitario = separar[i].split("-")[3];
                        var salg_valor_total = separar[i].split("-")[4];
                        var salb_stock = separar[i].split("-")[5];
                        var salb_valor_unitario = separar[i].split("-")[6];
                        var salb_valor_total = separar[i].split("-")[7];
                        var codigo = separar[i].split("-")[8];
                       console.log(codigoproducto +"  "+ nombreproducto +"  "+ salg_stock +"  "+salg_valor_unitario +"  " + salg_valor_total +"  "+ salb_stock +"  "+salb_valor_unitario +"  "+ salb_valor_total);
                        $('select[name =det]').append('<option value ="' + codigoproducto + '" onclick="auxiliar('+salg_stock+','+salg_valor_unitario+','+ salg_valor_total +','+salb_stock +','+salb_valor_unitario+','+salb_valor_total+')">'+codigo+" " + nombreproducto + '</option>');
                    
                    }


                    if (document.getElementById("det").length === 1) {

                        document.getElementById("lim").disabled = true;
                        document.getElementById("det").disabled = true;
                        document.getElementById("gua").disabled = true;
                        document.getElementById("agr").disabled = true;
                        document.getElementById("can").disabled = true;
                        document.getElementById("can").value = "";
                        document.getElementById("det").value = "0";
                        document.getElementById("uni").value = "";
                        document.getElementById("totp").value = "";
                        alert("Esta bodega no contiene productos con saldo diferente de 0");
                    } else {
                        document.getElementById("lim").disabled = false;
                        document.getElementById("gua").disabled = false;
                        document.getElementById("agr").disabled = false;
                        document.getElementById("can").disabled = false;
                        document.getElementById("can").focus();

                    }


                }

            });
        } else {
            $('select[name =det]').append('<option value ="0">--SELECCIONE--</option>');
        }
    });

});