var tops = [
	[[/*donations*/], [/*followers*/], [/*subscriptions*/]]
], index = 0;
const signs = {
	RUB: "ruble",
	USD: "dollar",
	EUR: "euro"
};

setInterval(function() {
	$.ajax({
		type: "GET",
		url: "/api.donations",
		success: function(response) {
			if (response && Array.isArray(response)/* && response.length > 0*/) {
				var d = "";
				tops[0][0] = response;
				
				
				
				tops[0][0].forEach(function(unit, i) {
					d += `<p>${unit["name"]}<span>${unit["amount"]} <i class="fas fa-${(unit["currency"] in signs ? signs[unit["currency"]] : "ruble")}-sign fa-xs"></i></span></p>`;
				});
				$.ajax({
					type: "GET",
					url: "/api.followers",
					success: function(response) {
						if (response && Array.isArray(response)/* && response.length > 0*/) {
							var f = "";
							tops[0][1] = response;
							
							
							
							tops[0][1].forEach(function(unit, p) {
								f += `<p>${unit["name"]}<span><i class="fab fa-twitch fa-sm"></i></i></span></p>`; 
							});
							$.ajax({
								type: "GET",
								url: "/api.subscriptions",
								success: function(response) {
									if (response && Array.isArray(response)/* && response.length > 0*/) {
										var s = "";
										tops[0][2] = response;
										
										
										
										tops[0][1].forEach(function(unit, j) {
											s += `<p>${unit["name"]}<span><i class="fab fa-twitch fa-sm"></i></i></span></p>`; 
										});
										$(".header").empty().append(`\
											<div class="top">\
												<div class="block" style="display: none;">\
													<div class="roof"></div>\
													<div class="units">${d}</div>\
													<div class="cellar"></div>\
												</div>
												<div class="block" style="display: none;">\
													<div class="roof"></div>\
													<div class="units">${f}</div>\
													<div class="cellar"></div>\
												</div>
												<div class="block" style="display: none;">\
													<div class="roof"></div>\
													<div class="units">${s}</div>\
													<div class="cellar"></div>\
												</div>
											</div>\
										`);
										if (tops.length > 0) {
											index = (index >= tops.length) ? 0 : index + 1;
											$(`.header .top:nth-child(${index}) .block`).each(function(i, block)  {
												var e = $(block);
												setTimeout(function() {
													e.jAnimateOnce("slideInDown", function() {
														var u = e.find(".units");
														if (u.find("p").length > 0) {
															u.slideDown("slow");
														}
													}).show();
													setTimeout(function() {
														e.find(".units").slideUp("slow", function() {
															e.jAnimateOnce("slideOutUp", function() {
																e.hide();
															});
														});
													}, 15000);//show time
												}, 2000 * i);//interval between block appearances
											});
										}
									}
								}
							});
						}
					}
				});
			}
		}
	});
}, 300000);//interval
