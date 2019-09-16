// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery.slick
//= require activestorage

//= require jquery
//= require bootstrap-sprockets

//= require pickadate/picker
//= require pickadate/picker.date
//= require pickadate/picker.time

//= require select2
//= require_tree .







// メニュークリック画面遷移
$(function(){
    $("a[href^='#']").on('click', function() {
        let href = $(this).attr('href');
        let offset = $(href).offset();
        if(typeof offset === 'undefined') {
            return false;
        }
        let top = offset.top;
        $('html, body').animate({
            scrollTop: top
        }, 1000);
        return false;
    });
});

// トップ画面スライドショー
$(document).ready(function(){
    $('#theTarget').slick({
    dots: true,
    slidesToShow: 1,
    slidesToScroll: 1,
    autoplay: true,
    autoplaySpeed: 3000,
    });
});

// 飲食店一覧画面スライドショー
$(document).ready(function(){
    $('.restaurant-image').slick({
        dots: true,
        slidesToShow: 1,
        slidesToScroll: 1,
        autoplay: true,
        autoplaySpeed: 3000,
    });
});

$(document).ready(function(){
    $('.restaurant-image-show').slick({
        dots: true,
        slidesToShow: 1,
        slidesToScroll: 1,
        autoplay: true,
        autoplaySpeed: 3000,
    });
});

// 定休日複数選択
// $(document).ready(function() {
// $('.mySelect2').select2({
//     maximumSelectionLength: 3,
//     width: 300,
//     placeholder: 'This is my placeholder',
//     allowClear: true
// });
// });

$(function() {
    // datepicker表示イベント
    $('#use_day').pickadate();
    // timepicker表示イベント
    $('#use_start_time').pickatime({
        format: 'HH:i', // 24時間表記
        interval: 30,   // 表示間隔
        min: [00,00],   // 予約開始時間
        max: [23,00]    // 予約終了時間
    });
    $('#use_end_time').pickatime({
        format: 'HH:i', // 24時間表記
        interval: 30,   // 表示間隔
        min: [00,00],   // 予約開始時間
        max: [23,00]    // 予約終了時間
    });
});



// クレジットカードのチェックボックス(jquery)
$(document).ready(function(){
    $(".pay-check").click(function(){
        // クリックイベントstart
        if ($("pay-check").prop("checked") == true){
            // pay.jpを表示させる
            $(".pay").erb("display", "block");
        }
        // クリックイベントEND
    });
}
);

// 都道府県選択
$(".select2.js").select2({
    placeholder: "都道府県を選択",
    multiple: true
  });
  $(".select2.js").select2({
    placeholder: "都道府県を選択"
  });




$(function() {
    // datepicker表示イベント
    $('#rest_day').pickadate();
    // timepicker表示イベント
});
