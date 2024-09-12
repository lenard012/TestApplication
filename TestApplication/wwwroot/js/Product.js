(function () {
    var tblProduct = "";
    $(document).ready(function () {

        DrawTable();

        $("#btnAdd").click(function () {
            $("#ID").val("0");
            $("#Name").val("");
            $("#Code").val("");
            $("#UnitPrice").val("");
            $("#mdlProduct").modal("show");
        });

        $(".number").on("input change paste", function () {
            var newVal = $(this).val().replace(/[^0-9\.-]/g, '');
            $(this).val(newVal.replace(/,/g, ''));
        });

        $("#btnSave").click(function () {
            var data = {
                "id": $("#ID").val(),
                "name": $("#Name").val(),
                "code": $("#Code").val(),
                "unitPrice": $("#UnitPrice").val(),
                "IsActive": $("#IsActive").val()
            }

            $.post("/Product/SaveProduct", { data: data }, function (result) {
                if (result.success) {
                    tblProduct.ajax.reload(null, false);
                    $("#mdlProduct").modal("hide");
                }

                else
                    alert(result.msg)
            });
        });

    });

    function DrawTable() {
        var Col = [
            { title: "ID", data: "id", visible: false },
            { title: "Name", data: "name" },
            { title: "Code", data: "code" },
            { title: "UnitPrice", data: "unitPrice" },
            { title: "IsActive", data: function (meta, row, data) { return meta.isActive ? "Yes" : "No" } },
            { title: "", render: function () { return "<button type='button' class='btn btn-success btnEdit'>Edit</button>" } }
        ];

        if (!$.fn.DataTable.isDataTable('#tblProduct')) {
            tblProduct = $('#tblProduct').DataTable({
                searching: false,
                processing: true,
                ordering: false,
                //serverSide: true,
                "pageLength": 10,
                "ajax": {
                    "url": "/Product/GetProduct",
                    "type": "GET",
                    "datatype": "json",
                    "data": ""
                },
                dataSrc: "data",
                columns: Col,
                "initComplete": function () {
                    tblProduct.on('click', '.btnEdit', function (e) {
                        let data = tblProduct.row(e.target.closest('tr')).data();
                        $("#ID").val(data.id);
                        $("#Name").val(data.name);
                        $("#Code").val(data.code);
                        $("#UnitPrice").val(data.unitPrice);
                        $("#IsActive").val(data.isActive).trigger("change");
                        $("#mdlProduct").modal("show");
                    });
                }

            })

        }

    }
})();