window.exportDashboardToExcel = (filename, rows) => {
    // rows: array of arrays, first row is header
    var ws = XLSX.utils.aoa_to_sheet(rows);
    var wb = XLSX.utils.book_new();
    XLSX.utils.book_append_sheet(wb, ws, "Dashboard");
    XLSX.writeFile(wb, filename);
};