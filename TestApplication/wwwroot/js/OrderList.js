(function () {
    var tblOrderList = "";
    var UnitPrice = 0;
    $(document).ready(function () {

        DrawTable();

        $("#Product").select2({
            ajax: {
                url: "/Home/GetDropDown",
                data: function (params) {
                    return {
                        q: params.term,
                        id: 'ID',
                        text: "Name",
                        table: 'ProductTable',
                        coldata: ', UnitPrice as ColData '
                    };
                },
            },
            placeholder: "Please Select",
            theme: 'bootstrap4',
            width: '100%',
            dropdownParent: $('#mdlOrderList')
        });

        $('#Product').on('select2:select', function (e) {
            var data = e.params.data;
            UnitPrice = data.colData;
            $("#Quantity").val("");
        });

        $("#Quantity").keyup(function () {
            if ($(this).val() == "")
                $("#Subtotal").val(0 * parseInt(UnitPrice));
            else
                $("#Subtotal").val(parseInt($(this).val()) * parseInt(UnitPrice));
        });

        $("#Customer").select2({
            ajax: {
                url: "/Home/GetDropDown",
                data: function (params) {
                    return {
                        q: params.term,
                        id: 'ID',
                        text: "FullName",
                        table: 'CustomerTable',
                    };
                },
            },
            placeholder: "Please Select",
            theme: 'bootstrap4',
            width: '100%'
        });

        var today = new Date();
        today = new Date(today.setDate(today.getDate() + 1)).toISOString().split('T')[0];
        $("#DeliveryDate").attr("min", today);

        $("#btnAdd").click(function () {
            $("#mdlOrderList").modal("show");
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
                    tblOrderList.ajax.reload(null, false);
                    $("#mdlOrder").modal("hide");
                }
                else
                    alert(result.msg)
            });
        });

        $("#btnSaveItem").click(function () {
            tblOrderList.row
                .add({
                    items: $("#Product").val(),
                    quantity: $("#Quantity").val(),
                    amount: $("#Subtotal").val()
                })
                .draw();
        });

    });

    function DrawTable() {
        var url = window.location.search;
        var urlParams = new URLSearchParams(url);
        var OrderID = urlParams.get("ID");
        var Col = [
            { title: "ID", data: "id", visible: false },
            { title: "Items", data: "items" },
            { title: "Quantity", data: "quantity" },
            { title: "Amount", data: "amount" },
            { title: "", render: function () { return "<button type='button' class='btn btn-success btnEdit'>Edit</button>" } }
        ];

        if (!$.fn.DataTable.isDataTable('#tblOrderList')) {
            tblOrderList = $('#tblOrderList').DataTable({
                searching: false,
                processing: true,
                ordering: false,
                //serverSide: true,
                "pageLength": 10,
                "ajax": {
                    "url": "/Order/GetOrderList",
                    "type": "POST",
                    "datatype": "json",
                    "data": { OrderID: OrderID}
                },
                dataSrc: "data",
                columns: Col,
                "initComplete": function () {
                    tblOrderList.on('click', '.btnEdit', function (e) {
                        let data = tblOrderList.row(e.target.closest('tr')).data();
                        $("#ID").val(data.id);
                        $("#FirstName").val(data.firstName);
                        $("#LastName").val(data.lastName);
                        $("#MobileNumber").val(data.mobileNumber);
                        $("#City").val(data.city);
                        $("#IsActive").val(data.isActive).trigger("change");
                        $("#mdlCustomer").modal("show");
                    });
                }

            })

        }
    }
})();