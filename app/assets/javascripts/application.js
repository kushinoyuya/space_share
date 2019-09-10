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
//= require turbolinks
//= require jquery
//= require bootstrap-sprockets
//= require select2
//= require_tree .







// メニュークリック画面遷移
$(document).on("turbolinks:load",function(){
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
$(document).ready(function() {
$('.mySelect2').select2({
    maximumSelectionLength: 3,
    width: 300,
    placeholder: 'This is my placeholder',
    allowClear: true
});
});
