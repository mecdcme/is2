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
                showBorders: true,
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
                summary: {
                    totalItems: [{
                            column: "citta",
                            summaryType: "count"
                        }, {
                            column: "variati",
                            summaryType: "sum"

                        }]
                },
                columnsAutoWidth: true,
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
                    pageSize: 10
                },
                pager: {
                    showPageSizeSelector: true,
                    allowedPageSizes: [5, 10, 15, 20, 25],
                    showInfo: true
                }
            });

        },
        error: function (jqXHR, textStatus, errorThrown) {
            alert('Error loading data');
        }
    });
}