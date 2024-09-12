(function () {
    var tblCustomer = "";
    $(document).ready(function () {

        DrawTable();

        $("#btnAdd").click(function () {
            $("#ID").val("0");
            $("#FirstName").val("");
            $("#LastName").val("");
            $("#MobileNumber").val("");
            $("#City").val("");
            $("#mdlCustomer").modal("show");
        });

        $(".number").on("input change paste", function () {
            var newVal = $(this).val().replace(/[^0-9\.-]/g, '');
            $(this).val(newVal.replace(/,/g, ''));
        });

        $("#btnSave").click(function () {
            var data = {
                "id": $("#ID").val(),
                "firstName": $("#FirstName").val(),
                "LastName": $("#LastName").val(),
                "MobileNumber": $("#MobileNumber").val(),
                "City": $("#City").val(),
                "IsActive": $("#IsActive").val()
            }
            
            $.post("/Customer/SaveCustomer", { data: data}, function (result) {
                if (result.success) {
                    tblCustomer.ajax.reload(null, false);
                    $("#mdlCustomer").modal("hide");
                }
                    
                else
                    alert(result.msg)
            });
        });

    });

    function DrawTable() {
        var Col = [
            { title: "ID", data: "id", visible: false },
            { title: "FirstName", data: "firstName", visible: false },
            { title: "LastName", data: "lastName", visible: false },
            { title: "FullName" , data: "fullName"},
            { title: "MobileNumber", data: "mobileNumber" },
            { title: "City", data: "city" },
            { title: "IsActive", data: function (meta, row, data) { return meta.isActive ? "Yes" : "No"}},
            { title: "", render: function () { return "<button type='button' class='btn btn-success btnEdit'>Edit</button>" }}
        ];

        if (!$.fn.DataTable.isDataTable('#tblCustomer')) {
            tblCustomer = $('#tblCustomer').DataTable({
                searching: false,
                processing: true,
                ordering: false,
                //serverSide: true,
                "pageLength": 10,
                "ajax": {
                    "url": "/Customer/GetCustomer",
                    "type": "GET",
                    "datatype": "json",
                    "data": ""
                },
                dataSrc: "data",
                columns: Col,
                "initComplete": function () {
                    tblCustomer.on('click', '.btnEdit', function (e) {
                        let data = tblCustomer.row(e.target.closest('tr')).data();
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