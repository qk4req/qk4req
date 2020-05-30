var sockets = {}, votings = [];

(function () {
	"use strict";
	const symbols = [
	"①", "②", "③", "④", "⑤", "⑥", "⑦", "⑧", "⑨", "⑩", "⑪", "⑫", "⑬", "⑭", "⑮", "⑯", "⑰", "⑱", "⑲", "⑳",
	];
	sockets["votings"] = io("http://sockets.qk4req.ru/votings", {
		reconnection: true,
		reconnectionDelayMax: 5000,
		reconnectionDelay: 1000,
	});

	sockets["votings"].on("connect", function() {
		sockets["votings"].emit("read");

		sockets["votings"].on("readed", function(data) {
			if (data["success"] && data["payload"].length > 0) {
				votings = data["payload"];
				sockets["vote"] = io("http://sockets.qk4req.ru/vote", {
					reconnection: true,
					reconnectionDelayMax: 5000,
					reconnectionDelay: 1000,
				});

				for (const [id, voting] of votings) {
					if (voting["end"] >= Date.now()/1000) {
						var w = $(".swiper-wrapper"), t = "", p = "", selected = voting["votingPoints"]["list"].find(function(v) {return(v["selected"] === true);});

						voting["title"].split("").forEach(function(letter) {
							t += `<span>${letter}</span>`;
						});
						voting["votingPoints"]["list"].forEach(function(votingPoint, i) {
							let percent = Math.round(votingPoint["num"]/voting["vote"]["total"]*100);
							if (selected) {
								p += `<button onclick="return(false);" type="button" class="btn btn-light btn-lg btn-block" style="font-size: 25px;" ${votingPoint["selected"] ? "" : "disabled"}><span style="float: left;">${symbols[i] + " " + votingPoint["title"]}</span><span style="float: right;">${percent}%</span></button>`;
							} else {
								p += `<button onclick="sockets['vote'].emit('create', ${votingPoint["id"]});" type="button" class="btn btn-light btn-lg btn-block"><span style="float: left;">${symbols[i] + " " + votingPoint["title"]}</span><span style="float: right;">${percent}%</span></button>`;
							}
						});
						$(".swiper-wrapper").append(
											`\
											<div class="voting swiper-slide">\
												<h2><div class="title">${t}</div></h2>
												<div class="voting-points row align-items-center justify-content-between">\
													<div class="d-block mx-auto col-md-5 col-lg-5">\
														${p}
													</div>\
												</div>\
											</div>\
											`
											);			
						var swiper = new Swiper (".swiper-container", {
							direction: "horizontal",
							loop: true,
							pagination: {
								el: ".swiper-pagination",
							},
							navigation: {
								nextEl: ".swiper-button-next",
								prevEl: ".swiper-button-prev",
							},
						});
					} else {

					}
				}
			}
		});
	});
	/*

	var review = $(".player_info_item");
	if (review.length) {
		review.owlCarousel({
			items: 1,
			loop: true,
			dots: false,
			autoplay: true,
			margin: 40,
			autoplayHoverPause: true,
			autoplayTimeout: 5000,
			nav: true,
			navText: [
				"<img src="img/icon/left.svg" alt="">",
				"<img src="img/icon/right.svg" alt="">"

			],
			responsive: {
				0: {
					margin: 15,
				},
				600: {
					margin: 10,
				},
				1000: {
					margin: 10,
				}
			}
		});
	}
	if (document.getElementById("default-select")) {
		$("select").niceSelect();
	}
	$(".popup-youtube, .popup-vimeo").magnificPopup({
		// disableOn: 700,
		type: "iframe",
		mainClass: "mfp-fade",
		removalDelay: 160,
		preloader: false,
		fixedContentPos: false
	});

	// menu fixed js code
	$(window).scroll(function () {
		var window_top = $(window).scrollTop() + 1;
		if (window_top > 50) {
			$(".main_menu_iner").addClass("menu_fixed animated fadeInDown");
		} else {
			$(".main_menu_iner").removeClass("menu_fixed animated fadeInDown");
		}
	});

	/*$(".slider").slick({
		slidesToShow: 1,
		slidesToScroll: 1,
		arrows: false,
		speed: 300,
		infinite: true,
		asNavFor: ".slider-nav-thumbnails",
		autoplay:true,
		pauseOnFocus: true,
		dots: true,
	});
 
	$(".slider-nav-thumbnails").slick({
		slidesToShow: 3,
		slidesToScroll: 1,
		asNavFor: ".slider",
		focusOnSelect: true,
		infinite: true,
		prevArrow: false,
		nextArrow: false,
		centerMode: true,
		responsive: [
			{
				breakpoint: 480,
				settings: {
					centerMode: false,
				}
			}
		]
	});
	const accordionItem = document.querySelectorAll(".accordion-item");
														 
	const onClickAccordionHeader = e => {
		if (e.currentTarget.parentNode.classList.contains("active")) {
			e.currentTarget.parentNode.classList.remove("active");
		} else {
			Array.prototype.forEach.call(accordionItem, (e) => {
				e.classList.remove("active");
			});
			e.currentTarget.parentNode.classList.add("active");
		}
	};
	
	const init = () => {
		Array.prototype.forEach.call(accordionItem, (e) => {
			e.querySelector(".accordion-header").addEventListener("click", onClickAccordionHeader, false);
		});
	};
	
	document.addEventListener("DOMContentLoaded", init);
	//remove active class from all thumbnail slides
	$(".slider-nav-thumbnails .slick-slide").removeClass("slick-active");
 
	//set active class to first thumbnail slides
	$(".slider-nav-thumbnails .slick-slide").eq(0).addClass("slick-active");
 
	// On before slide change match active thumbnail to current slide
	$(".slider").on("beforeChange", function (event, slick, currentSlide, nextSlide) {
		var mySlideNumber = nextSlide;
		$(".slider-nav-thumbnails .slick-slide").removeClass("slick-active");
		$(".slider-nav-thumbnails .slick-slide").eq(mySlideNumber).addClass("slick-active");
 });
 
 //UPDATED 
	 
 $(".slider").on("afterChange", function(event, slick, currentSlide){	 
		$(".content").hide();
		$(".content[data-id=" + (currentSlide + 1) + "]").show();
 }); 

 //------- Mailchimp js --------//	
function mailChimp() {
	$("#mc_embed_signup").find("form").ajaxChimp();
}
mailChimp();*/
}(jQuery));