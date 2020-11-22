// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//= require jquery
//= require jquery_ujs
//= require cable
//= require vendor.min
//= require plugins.min
//= require bs-stepper.min
//= require cocoon
//= require select2
//= require bootstrap-datepicker
//= require chartkick
//= require Chart.bundle
//= require_self

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

function get_origin_address_suggestions() {
  let country = $('#select2-select2-origin-country-location-container')[0].getAttribute('title');
  let address = $('#inquiry_origin_address').val();
  $.get("/inquiries/get_address_suggestions", {country: country, address: address}, function(data){
    console.log(data);
  });
}

function get_dest_address_suggestions() {
  let country = $('#select2-select2-dest-country-location-container')[0].getAttribute('title');
  let address = $('#inquiry_dest_address').val();
  $.get("/inquiries/get_address_suggestions", {country: country, address: address}, function(data){
    console.log(data);
  });
}

 $("input.date_picker").datepicker();

 $(document).ready(function(){
    $("#profileImage").click(function(e) {
        $("#user_profile_picture").click();
    });

    function fasterPreview( uploader ) {
        if ( uploader.files && uploader.files[0] ){
            $('#profileImage').attr('src',
                window.URL.createObjectURL(uploader.files[0]) );
        }
    }

    $("#user_profile_picture").change(function(){
        fasterPreview( this );
    });

  });

  $(document).ready(function(){
     $("#coverImage").click(function(e) {
         $("#user_cover_photo").click();
     });

     function fasterPreview( uploader ) {
         if ( uploader.files && uploader.files[0] ){
             $('#coverImage').attr('src',
                 window.URL.createObjectURL(uploader.files[0]) );
         }
     }

     $("#user_cover_photo").change(function(){
         fasterPreview( this );
     });

   });

$( document ).ready(function() {
    window.jQuery = $;
    window.$ = $;
    $('[data-toggle="tooltip"]').tooltip();

    (function() {
        $(document).on('click', '.toggle-window', function(e) {
            e.preventDefault();
            var panel = $(this).parent().parent();
            var messages_list = panel.find('.messages-list');

            panel.find('.panel-body').toggle();
            // panel.attr('class', 'panel panel-default');
            //
            // if (panel.find('.panel-body').is(':visible')) {
            //     var height = messages_list[0].scrollHeight;
            //     messages_list.scrollTop(height);
            // }
        });
    })();

    $('.users-tabs > li').on('click',function () {
        $(this).removeClass('user-box-message');
        var ref = $(this).attr("id");
        var con_id = ref.substr(ref.lastIndexOf('-')+1);
        var conversation = $('#conversations-list').find("[data-conversation-id='" + con_id + "']");
        $('.users-tabs > li').removeClass("active show");


        var allConversations = $('#conversations-list > div').removeClass("show");
        // console.log(allConversations);
        // for (var i = 0, len = allConversations.length; i < len; i++) {
        //     //work with element
        //     allConversations[i].addClass("tab-pane fade");
        // }

        //conversation.removeClass("tab-pane fade");


        var ul = conversation.find('.commentList');
        var abc = conversation.find('.commentList li:last');

        jQuery(ul).animate({scrollTop: 1000000 + 30}, "slow");
    });


    $('[data-toggle=offcanvas]').click(function() {
        $('.row-offcanvas').toggleClass('active');
    });
    $( ".select2-dropdown" ).select2({
        theme: "bootstrap"
    });

    $('#quote-form').on('cocoon:after-insert', function() {
      let dropdown = $('.select2-dropdown').last();
      dropdown.select2({
          theme: "bootstrap"
      });
    });

    (function ($) {
        "use strict";

        $(".msg-trigger-btn").on("click", function (event) {
            event.stopPropagation();
            event.preventDefault();
            var $this = $(this);
            var $prevTartget = $(this).parent().siblings().children(".msg-trigger-btn").attr('href');
            var target = $this.attr('href');
            $(target).slideToggle();
            $($prevTartget).slideUp();

        });

        //Close When Click Outside
        $('body').on('click', function(e){
            var $target = e.target;
            if (!$($target).is('.message-dropdown') && !$($target).parents().is('.message-dropdown')) {
                $(".message-dropdown").slideUp("slow");
            }
        });

        //Background Image JS start
        var bgSelector = $(".bg-img");
        bgSelector.each(function (index, elem) {
            var element = $(elem),
                bgSource = element.data('bg');
            element.css('background-image', 'url(' + bgSource + ')');
        });

        // video player active js
        var plyrVideo = new Plyr('.plyr-video'),
            plyrAudio = new Plyr('.plyr-audio'),
            plyrYoutube = new Plyr('.plyr-youtube'),
            plyrVimeo = new Plyr('.plyr-vimeo');

        // active profile carousel js
        $('.active-profile-carousel').slick({
            speed: 800,
            slidesToShow: 10,
            prevArrow: '<button type="button" class="slick-prev"><i class="bi bi-arrow-left-rounded"></i></button>',
            nextArrow: '<button type="button" class="slick-next"><i class="bi bi-arrow-right-rounded"></i></button>',
            responsive: [{
                breakpoint: 1200,
                settings: {
                    slidesToShow: 5,
                }
            },
                {
                    breakpoint: 992,
                    settings: {
                        slidesToShow: 8,
                    }
                }]
        });

        // active profile carousel js
        $('.active-profile-mobile').slick({
            speed: 800,
            slidesToShow: 6,
            arrows: false,
            responsive: [{
                breakpoint: 480,
                settings: {
                    slidesToShow: 4,
                }
            }]
        });

        // active profile carousel js
        $('.favorite-item-carousel').slick({
            autoplay: true,
            speed: 800,
            slidesToShow: 5,
            arrows: false,
            responsive: [{
                breakpoint: 992,
                settings: {
                    slidesToShow: 3,
                }
            },
                {
                    breakpoint: 576,
                    settings: {
                        slidesToShow: 2,
                    }
                }]
        });

        // live chat box and friend search box active js
        $(".profile-active").on('click', function(){
            $(".chat-output-box").addClass('show');
        })
        $(".search-field").on('click', function(){
            $(".friend-search-list").addClass('show');
        })
        $(".close-btn").on('click', function(){
            var $this = $(this),
                $target = $this.data('close');
            $('.'+$target).removeClass('show');
        })

        // mobile header seach box active
        $(".search-trigger").on('click', function(){
            $('.search-trigger, .mob-search-box').toggleClass('show');
        })

        $(".chat-trigger, .close-btn").on('click', function(){
            $('.mobile-chat-box').toggleClass('show');
        })
        $(".request-trigger").on('click', function(){
            $('.frnd-request-list').toggleClass('show');
        })

        // mobile friend search active js
        $(".search-toggle-btn").on('click', function(){
            $('.mob-frnd-search-inner').toggleClass('show');
        })

        // profile dropdown triger js
        $('.profile-triger').on('click', function(event){
            event.stopPropagation();
            $(".profile-dropdown").slideToggle();
        })

        //Close When Click Outside
        $('body').on('click', function(e){
            var $target = e.target;
            if (!$($target).is('.profile-dropdown') && !$($target).parents().is('.profile-dropdown')) {
                $(".profile-dropdown").slideUp("slow");
            }
        });

        // perfect scroll bar js
        $('.custom-scroll').each(function(){
            var ps = new PerfectScrollbar($(this)[0]);
        });


        // light gallery active js
        $(document).ready(function() {
            $(".img-popup").lightGallery();

            // light gallery images
            $(".img-gallery").lightGallery({
                selector: ".gallery-selector",
                hash: false
            });
        });

        $('.gallery-toggle').on('click', function () {

            var productThumb = $(this).find(".product-thumb-large-view img"),
                imageSrcLength = productThumb.length,
                images = [];
            for (var i = 0; i < imageSrcLength; i++) {
                images[i] = {"src": productThumb[i].src, "thumb": productThumb[i].src};
            }

            $(this).lightGallery({
                dynamic: true,
                actualSize: false,
                hash: false,
                index: 0,
                dynamicEl: images
            });

        });

        // photo filter active js
        $('.photo-filter').imagesLoaded( function() {
            var $grid = $('.photo-filter, .friends-list').isotope({
            });
            // filter items on button click
            $('.filter-menu').on( 'click', 'button', function() {
                var filterValue = $(this).attr('data-filter');
                $grid.isotope({ filter: filterValue });
                $(this).siblings('.active').removeClass('active');
                $(this).addClass('active');
            });

        });

        // nice select active js
        $('select').niceSelect();

        // Scroll to top active js
        $(window).on('scroll', function () {
            if ($(this).scrollTop() > 600) {
                $('.scroll-top').removeClass('not-visible');
            } else {
                $('.scroll-top').addClass('not-visible');
            }
        });
        $('.scroll-top').on('click', function (event) {
            $('html,body').animate({
                scrollTop: 0
            }, 1000);
        });


        $('#email').bind("cut copy paste",function(e) {
            e.preventDefault();
        });

    })(jQuery);


















    // Chart.js scripts
// -- Set new default font family and font color to mimic Bootstrap's default styling
    Chart.defaults.global.defaultFontFamily = '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
    Chart.defaults.global.defaultFontColor = '#292b2c';
// -- Area Chart Example
    var ctx = document.getElementById("myAreaChart");
    var myLineChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: ["Mar 1", "Mar 2", "Mar 3", "Mar 4", "Mar 5", "Mar 6", "Mar 7", "Mar 8", "Mar 9", "Mar 10", "Mar 11", "Mar 12", "Mar 13"],
            datasets: [{
                label: "Sessions",
                lineTension: 0.3,
                backgroundColor: "rgba(2,117,216,0.2)",
                borderColor: "rgba(2,117,216,1)",
                pointRadius: 5,
                pointBackgroundColor: "rgba(2,117,216,1)",
                pointBorderColor: "rgba(255,255,255,0.8)",
                pointHoverRadius: 5,
                pointHoverBackgroundColor: "rgba(2,117,216,1)",
                pointHitRadius: 20,
                pointBorderWidth: 2,
                data: [10000, 30162, 26263, 18394, 18287, 28682, 31274, 33259, 25849, 24159, 32651, 31984, 38451],
            }],
        },
        options: {
            scales: {
                xAxes: [{
                    time: {
                        unit: 'date'
                    },
                    gridLines: {
                        display: false
                    },
                    ticks: {
                        maxTicksLimit: 7
                    }
                }],
                yAxes: [{
                    ticks: {
                        min: 0,
                        max: 40000,
                        maxTicksLimit: 5
                    },
                    gridLines: {
                        color: "rgba(0, 0, 0, .125)",
                    }
                }],
            },
            legend: {
                display: false
            }
        }
    });
// -- Bar Chart Example
    var ctx = document.getElementById("myBarChart");
    var myLineChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: ["January", "February", "March", "April", "May", "June"],
            datasets: [{
                label: "Revenue",
                backgroundColor: "rgba(2,117,216,1)",
                borderColor: "rgba(2,117,216,1)",
                data: [4215, 5312, 6251, 7841, 9821, 14984],
            }],
        },
        options: {
            scales: {
                xAxes: [{
                    time: {
                        unit: 'month'
                    },
                    gridLines: {
                        display: false
                    },
                    ticks: {
                        maxTicksLimit: 6
                    }
                }],
                yAxes: [{
                    ticks: {
                        min: 0,
                        max: 15000,
                        maxTicksLimit: 5
                    },
                    gridLines: {
                        display: true
                    }
                }],
            },
            legend: {
                display: false
            }
        }
    });
// -- Pie Chart Example
    var ctx = document.getElementById("myPieChart");
    var myPieChart = new Chart(ctx, {
        type: 'pie',
        data: {
            labels: ["Blue", "Red", "Yellow", "Green"],
            datasets: [{
                data: [12.21, 15.58, 11.25, 8.32],
                backgroundColor: ['#007bff', '#dc3545', '#ffc107', '#28a745'],
            }],
        },
    });

    $(document).ready(function() {
        $('#dataTable').DataTable();
    });

    (function($) {
        "use strict"; // Start of use strict
        // Configure tooltips for collapsed side navigation
        $('.navbar-sidenav [data-toggle="tooltip"]').tooltip({
            template: '<div class="tooltip navbar-sidenav-tooltip" role="tooltip" style="pointer-events: none;"><div class="arrow"></div><div class="tooltip-inner"></div></div>'
        })
        // Toggle the side navigation
        $("#sidenavToggler").click(function(e) {
            e.preventDefault();
            $("body").toggleClass("sidenav-toggled");
            $(".navbar-sidenav .nav-link-collapse").addClass("collapsed");
            $(".navbar-sidenav .sidenav-second-level, .navbar-sidenav .sidenav-third-level").removeClass("show");
        });
        // Force the toggled class to be removed when a collapsible nav link is clicked
        $(".navbar-sidenav .nav-link-collapse").click(function(e) {
            e.preventDefault();
            $("body").removeClass("sidenav-toggled");
        });
        // Prevent the content wrapper from scrolling when the fixed side navigation hovered over
        $('body.fixed-nav .navbar-sidenav, body.fixed-nav .sidenav-toggler, body.fixed-nav .navbar-collapse').on('mousewheel DOMMouseScroll', function(e) {
            var e0 = e.originalEvent,
                delta = e0.wheelDelta || -e0.detail;
            this.scrollTop += (delta < 0 ? 1 : -1) * 30;
            e.preventDefault();
        });
        // Scroll to top button appear
        $(document).scroll(function() {
            var scrollDistance = $(this).scrollTop();
            if (scrollDistance > 100) {
                $('.scroll-to-top').fadeIn();
            } else {
                $('.scroll-to-top').fadeOut();
            }
        });
        // Configure tooltips globally
        $('[data-toggle="tooltip"]').tooltip()
        // Smooth scrolling using jQuery easing
        $(document).on('click', 'a.scroll-to-top', function(event) {
            var $anchor = $(this);
            $('html, body').stop().animate({
                scrollTop: ($($anchor.attr('href')).offset().top)
            }, 1000, 'easeInOutExpo');
            event.preventDefault();
        });
    })(jQuery); // End of use strict
});
