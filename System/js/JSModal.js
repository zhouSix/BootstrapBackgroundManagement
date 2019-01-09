function SetModalsCenter(ids) {
    //modal出现在页面的水平垂直居中位置
    function centerModals() {
        $('#' + ids).each(function (i) {
            var $clone = $(this).clone().css('display', 'block').appendTo('body');
            var top = Math.round(($clone.height() - $clone.find('.modal-content').height()) / 2);
            top = top > 0 ? top : 0;
            $clone.remove();
            $(this).find('.modal-content').css("margin-top", top);
        });
    };
    //在触发modal显示的时候，modal出现在页面的水平垂直居中位置
    $('#' + ids).on('show.bs.modal', centerModals);
    //页面大小变化是仍然保证模态框水平垂直居中
    $(window).on('resize', centerModals);
 }