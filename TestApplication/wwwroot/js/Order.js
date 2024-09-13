(function () {
    var tblOrder = "";
    $(document).ready(function () {

        DrawTable();

        $("#btnAdd").click(function () {
     
            window.location.href = '/Home/OrderList'
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

            $.post("/Order/SaveOrder", { data: data }, function (result) {
                if (result.success) {
                    tblOrder.ajax.reload(null, false);
                    $("#mdlOrder").modal("hide");
                }

                else
                    alert(result.msg)
            });
        });

    });

    function DrawTable() {
        var Col = [
            { title: "ID", data: "id", visible: false },
            { title: "CustomerID", data:"customerID", visible: false},
            { title: "Customer", data: "fullName" },
            { title: "Delivery Date", data: "deliveryDate" },
            { title: "Status", data: "status" },
            { title: "Amount", data: "amount" },
            { title: "", render: function (meta,row,data) { return "<button type='button' class='btn btn-success btnEdit'>Edit</button>" } }
        ];

        if (!$.fn.DataTable.isDataTable('#tblOrder')) {
            tblOrder = $('#tblOrder').DataTable({
                searching: false,
                processing: true,
                ordering: false,
                //serverSide: true,
                "pageLength": 10,
                "ajax": {
                    "url": "/Order/GetOrder",
                    "type": "GET",
                    "datatype": "json",
                    "data": ""
                },
                dataSrc: "data",
                columns: Col,
                "initComplete": function () {
                    tblOrder.on('click', '.btnEdit', function (e) {
                        let data = tblOrder.row(e.target.closest('tr')).data();
                        window.location.href = "/Home/OrderList?ID=" + data.id + "&CID=" + data.customerID + "&C=" + data.fullName + "&DD=" + data.deliveryDate + "&S=" + data.status;
                    });
                }

            })

        }

    }
})();