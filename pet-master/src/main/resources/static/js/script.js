/**
 * @function      Include
 * @description   Includes an external scripts to the page
 * @param         {string} scriptUrl
 */
function include(scriptUrl) {
  document.write('<script src="' + scriptUrl + '"></script>');
}

/**
* @description  Search Box
*/
;
(function ($) {
  $(document).on("click", "#searchboxBtn", function (e) {
      if ($(document).scrollTop() != 0) {
          $(document).scrollTop(0)
          $("#searchboxDiv").show('fade');
      } else {
          $("#searchboxDiv").toggle('fade');
      }
  })
  $(document).on("click", "#searchboxCloseBtn", function (e) {
      $("#searchboxDiv").hide('fade');
  })
})(jQuery);


/**
* @function      isIE
* @description   checks if browser is an IE
* @returns       {number} IE Version
*/
function isIE() {
  var myNav = navigator.userAgent.toLowerCase();
  return (myNav.indexOf('msie') != -1) ? parseInt(myNav.split('msie')[1]) : false;
};


/**
* @module       Copyright
* @description  Evaluates the copyright year
*/
;
(function ($) {
  var currentYear = (new Date).getFullYear();
  $(document).ready(function () {
      $("#copyright-year").text((new Date).getFullYear());
  });
})(jQuery);


/**
* @module       IE Fall&Polyfill
* @description  Adds some loosing functionality to old IE browsers
*/
;
(function ($) {
  if (isIE() && isIE() < 11) {
      $('html').addClass('lt-ie11');
  }
  if (isIE() && isIE() < 10) {
      $('html').addClass('lt-ie10');
  }
})(jQuery);



//  @module       ToTop
//  @description  Enables ToTop Plugin

// ;
// (function ($) {
//     var o = $('html');
//     if (o.hasClass('desktop')) {
//         include('../../../vendors/jquery.ui.totop-1.2.0/js/jquery.ui.totop.min.js');

//         $(document).ready(function () {
//             $().UItoTop({
//                 easingType: 'easeOutQuart',
//                 containerClass: 'ui-to-top fa fa-angle-up',
// 				min:0
//             });
//         });
//     }
// })(jQuery);





/**
* @module       Swiper Slider
* @description  Enables Swiper Plugin
*/
;
/*
(function ($, undefined) {
  var o = $(".swiper-container");
  if (o.length) {
      include('../../../vendors/swiper-3.4.1/dist/js/swiper.jquery.min.js');

      function toggleSwiperInnerVideos(swiper) {
          var prevSlide = $(swiper.slides[swiper.previousIndex]),
              nextSlide = $(swiper.slides[swiper.activeIndex]),
              videos;

          prevSlide.find("video").each(function () {
              this.pause();
          });

          videos = nextSlide.find("video");
          if (videos.length) {
              videos.get(0).play();
          }
      }

      function toggleSwiperCaptionAnimation(swiper) {
          var prevSlide = $(swiper.container),
              nextSlide = $(swiper.slides[swiper.activeIndex]);

          prevSlide
              .find("[data-caption-animate]")
              .each(function () {
                  var $this = $(this);
                  $this
                      .removeClass("animated")
                      .removeClass($this.attr("data-caption-animate"))
                      .addClass("not-animated");
              });

          nextSlide
              .find("[data-caption-animate]")
              .each(function () {
                  var $this = $(this),
                      delay = $this.attr("data-caption-delay");

                  setTimeout(function () {
                      $this
                          .removeClass("not-animated")
                          .addClass($this.attr("data-caption-animate"))
                          .addClass("animated");
                  }, delay ? parseInt(delay) : 0);
              });
      }

      $(document).ready(function () {
          o.each(function () {
              var s = $(this);
              var pag = s.find(".swiper-pagination"),
                  next = s.find(".swiper-button-next"),
                  prev = s.find(".swiper-button-prev"),
                  bar = s.find(".swiper-scrollbar");
              s.find(".swiper-slide")
              .each(function () {
                  var $this = $(this),
                      url;
                  if (url = $this.attr("data-slide-bg")) {
                      $this.css({
                          "background-image": "url(" + url + ")",
                          "background-size": "cover"
                      })
                  }
              })
              .end()
              .find("[data-caption-animate]")
              .addClass("not-animated")
              .end()
              .swiper({
                  autoplay: s.attr('data-autoplay') ? s.attr('data-autoplay') === "false" ? undefined : s.attr('data-autoplay') : 5000,
                  direction: s.attr('data-direction') ? s.attr('data-direction') : "horizontal",
                  effect: s.attr('data-slide-effect') ? s.attr('data-slide-effect') : "slide",
                  speed: s.attr('data-slide-speed') ? s.attr('data-slide-speed') : 600,
                  keyboardControl: s.attr('data-keyboard') === "true",
                  mousewheelControl: s.attr('data-mousewheel') === "true",
                  mousewheelReleaseOnEdges: s.attr('data-mousewheel-release') === "true",
                  nextButton: next.length ? next.get(0) : null,
                  prevButton: prev.length ? prev.get(0) : null,
                  pagination: pag.length ? pag.get(0) : null,
                  paginationClickable: pag.length ? pag.attr("data-clickable") !== "false" : false,
                  paginationBulletRender: pag.length ? pag.attr("data-index-bullet") === "true" ? function (index, className) {
                      return '<span class="' + className + '">' + (index + 1) + '</span>';
                  } : null : null,
                  scrollbar: bar.length ? bar.get(0) : null,
                  scrollbarDraggable: bar.length ? bar.attr("data-draggable") !== "false" : true,
                  scrollbarHide: bar.length ? bar.attr("data-draggable") === "false" : false,
                  loop: s.attr('data-loop') !== "false",
                  onTransitionStart: function (swiper) {
                      toggleSwiperInnerVideos(swiper);
                  },
                  onTransitionEnd: function (swiper) {
                      toggleSwiperCaptionAnimation(swiper);
                  },
                  onInit: function (swiper) {
                      toggleSwiperInnerVideos(swiper);
                      toggleSwiperCaptionAnimation(swiper);
                  }
              });
          });
      });
  }
})(jQuery);
*/




/**
* @module       RD Navbar
* @description  Enables RD Navbar Plugin
*/
;
(function ($) {
  "use strict";
  var o = $('.rd-navbar');
  if (o.length > 0) {
      include('../../../vendors/rd-navbar-2.1.8/dist/js/jquery.rd-navbar.js');

      $(document).ready(function () {
          o.RDNavbar({
              stickUpClone: false
          });

      });
  }
  $(document).on("keyup", ".setComma", function (e) {
      $(this).val($(this).val().setComma());
  });
  $(document).on("keyup", ".setNumberPhone", function (e) {
      $(this).val($(this).val().setNumberPhone());
  });
  $(document).on("keyup", ".setNumberDate", function (e) {
      $(this).val($(this).val().setNumberDate());
  });
  $(document).on("keyup", ".setdotComma", function (e) {
      $(this).val($(this).val().setdotComma());
  });
  $(document).on("keyup", ".setNumberSSN", function (e) {
      $(this).val($(this).val().setNumberSSN(1));
  });
  $(document).on("keyup", ".setNumber", function (e) {
      $(this).val($(this).val().setNumber());
  });


  //order 페이지
  $(function () {
      //체크박스 전체선택 전체해제
      $(".order_list_allchk").click(function () {

          $(this).toggleClass("pro_check")
          if ($(this).hasClass("pro_check")) {
              $(this).parent().parent().parent().parent().find("input[name='od_idx[]']").prop({ checked: true });
              $(this).text("전체해제");
          } else {
              $(this).parent().parent().parent().parent().find("input[name='od_idx[]']").prop({ checked: false });
              $(this).text("전체선택");
          }
      });
      //모두펼침 모두닫힘
      $(".type-title .icon-open").click(function () {
          $(this).parent().parent().parent().next("table").find(".pro_open_view").find(".order-product").show();
          $(this).parent().parent().parent().next("table").find(".pro_open_view").show();

          $(this).parent().parent().parent().next("table").find(".pro_open_list .txt-left span:odd").removeClass("icon-open");
          $(this).parent().parent().parent().next("table").find(".pro_open_list .txt-left span:odd").addClass("icon-close");
          $(this).parent().parent().parent().next("table").find(".pro_open_list .txt-left span:odd").text("닫기");
      });
      $(".type-title .icon-close").click(function () {
          $(this).parent().parent().parent().next("table").find(".pro_open_view").find(".order-product").hide();
          $(this).parent().parent().parent().next("table").find(".pro_open_view").hide();

          $(this).parent().parent().parent().next("table").find(".pro_open_list .txt-left span:odd").removeClass("icon-close");
          $(this).parent().parent().parent().next("table").find(".pro_open_list .txt-left span:odd").addClass("icon-open");
          $(this).parent().parent().parent().next("table").find(".pro_open_list .txt-left span:odd").text("열기");
      });
      //하나씩 열고 닫기
      $(".order-list .pro_open_list .icon-open").click(function () {
          var selectedEffect = "drop";
          var options = {};
          $(this).parent().parent().next(".pro_open_view").find(".order-product").toggle(selectedEffect, options, 1);
          $(this).parent().parent().next(".pro_open_view").toggle(selectedEffect, options, 1);

          if ($(this).hasClass("icon-open")) {
              $(this).removeClass("icon-open");
              $(this).addClass("icon-close");
              $(this).text("닫기");
          } else {
              $(this).removeClass("icon-close");
              $(this).addClass("icon-open");
              $(this).text("열기");
          }
      });

  });
  //공통

})(jQuery);



;
(function ($) {
  var checkbox = $('.ui-checkbox');
  if (checkbox.length > 0) {
      $(document).ready(function () {
          checkbox.button();
      });
  }
})(jQuery);

;
(function ($) {
  $(document).ready(function () {
      $(".tabmenuBtn li").click(function (e) {
          $(".tabmenuBtn li").removeClass("active")
          $(this).addClass("active")

          $(".tabmenuView > div").removeClass("active")
          $(".tabmenuView > div").eq($(this).index()).addClass("active")
      });
  });

  $(document).on("keyup", ".setComma", function (e) {
      $(this).val($(this).val().setComma());
  });

})(jQuery);
