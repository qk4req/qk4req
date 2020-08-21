var header = [
	//last donations, followers, subscriptions
	[[], [], []]
], index = 0, loaded = false;
const signs = {
	RUB: "ruble",
	USD: "dollar",
	EUR: "euro"
};

setInterval(function() {
	loaded = false;
	if (index === 0) {
		var donations = "", followers = "", subscriptions = "";

		$.ajax({
			type: "GET",
			url: "/api/donations/last",
			success: function(response) {
				if (response && Array.isArray(response)/* && response.length > 0*/) {
					header[0][0] = response;
					
					
					
					header[0][0].forEach(function(unit, i) {
						donations += `<p>${unit["name"]}<span>${unit["amount"]} <i class="fas fa-${(unit["currency"] in signs ? signs[unit["currency"]] : "ruble")}-sign fa-xs"></i></span></p>`;
					});
				}
			}
		});

		$.ajax({
			type: "GET",
			url: "/api/followers",
			success: function(response) {
				if (response && Array.isArray(response)/* && response.length > 0*/) {
					header[0][1] = response;
					
					
					
					header[0][1].forEach(function(unit, p) {
						followers += `<p>${unit["name"]}<span><i class="fab fa-twitch fa-sm"></i></i></span></p>`; 
					});
				}
			}
		});

		$.ajax({
			type: "GET",
			url: "/api/subscriptions",
			success: function(response) {
				if (response && Array.isArray(response)/* && response.length > 0*/) {
					header[0][2] = response;
					
					
					
					header[0][2].forEach(function(unit, j) {
						subscriptions += `<p>${unit["name"]}<span><i class="fab fa-twitch fa-sm"></i></i></span></p>`; 
					});
					$(".header").empty().append(`
						<div class="block" style="display: none;">
							<div class="roof"></div>
							<div class="units">${donations}</div>
							<div class="cellar"></div>
						</div>
						<div class="block" style="display: none;">
							<div class="roof"></div>
							<div class="units">${followers}</div>
							<div class="cellar"></div>
						</div>
						<div class="block" style="display: none;">
							<div class="roof"></div>
							<div class="units">${subscriptions}</div>
							<div class="cellar"></div>
						</div>
					`);
					loaded = true;
				}
			}
		});
	}
	show();
}, 300000);//interval


function show() {
	if (header.length > 0 && loaded === true) {
		index = (index >= header.length) ? 0 : index + 1;
		$(`.header .block`).each(function(i, block)  {
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