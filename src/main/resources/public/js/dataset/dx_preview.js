$(function () {
    loadData(_idfile);
});

function loadData(idFile) {
    $.ajax({
        url: _ctx + "/rest/getDatasetDx/" + idFile,
        type: "GET",
        datatype: "JSON",
        success: function (result) {
            $("#gridContainer").dxDataGrid({
                dataSource: result.data,
                rowAlternationEnabled: true,
                showBorders: true,
                showRowLines: true,
                columnWidth: 150,
                selection: {
                    mode: "multiple"
                },
                groupPanel: {
                    visible: true
                },
                export: {
                    enabled: true,
                    fileName: "data",
                    allowExportSelectedData: true
                },
                columns: result.columns,
                //columnsAutoWidth: true,
                filterRow: {
                    visible: true,
                    applyFilter: "auto"
                },
                searchPanel: {
                    visible: true,
                    width: 240,
                    placeholder: "Search..."
                },
                headerFilter: {
                    visible: true
                },
                paging: {
                    enabled: false
                },
                scrolling: {
                    mode: "virtual",
                    columnRenderingMode: "virtual"
                }
            });
            $(".sk-wave").hide();
            $("#gridContainer").show();
        },
        error: function (jqXHR, textStatus, errorThrown) {
            alert('Error loading data');
        }
    });
}