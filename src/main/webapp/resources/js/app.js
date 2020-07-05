$(function () {
    $(".slimscroll-menu").slimscroll({
        height: "auto",
        position: "right",
        size: "4px",
        color: "#9ea5ab",
        wheelStep: 5,
        touchScrollStep: 20
    });

    $('#menu-bar').metisMenu();
    $('[data-toggle="tooltip"]').tooltip();
})