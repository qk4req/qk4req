var header, index = 0, max;
const signs = {
	RUB: "rub",
	USD: "usd",
	EUR: "eur"
};

setInterval(function() {
	header = {
		first: null,
		second: null,
		third: null
	};
	max = Object.keys(header).length - 1;

	//LAST DONATIONS, FOLLOWERS, SUBSCRIPTIONS
	switch (index) {
		case 0: {
			var donations = "", followers = "", subscriptions = "";

			$.ajax({
				type: "GET",
				url: "/api/donations/last",
				success: function(response) {
					if (response && Array.isArray(response)/* && response.length > 0*/) {
						/*header[0][0] = response;
						
						
						
						header[0][0].forEach(function(unit, i) {
							donations += `<p>${unit["name"]}<span>${unit["amount"]} <i class="fa fa-${(unit["currency"] in signs ? signs[unit["currency"]] : "rub")} fa-xs"></i></span></p>`;
						});*/
						header.first = response;
						header.first.forEach(function(unit, i) {
							donations += `<p>${unit["from"]}<span>${unit["amount"]} <i class="fa fa-${(unit["currency"] in signs ? signs[unit["currency"]] : "rub")} fa-xs"></i></span></p>`;
						});
					}
				}
			});

			$.ajax({
				type: "GET",
				url: "/api/followers",
				success: function(response) {
					if (response && Array.isArray(response)/* && response.length > 0*/) {
						/*header[0][1] = response;
						
						
						
						header[0][1].forEach(function(unit, p) {
							followers += `<p>${unit["name"]}<span><i class="fa fa-twitch fa-sm"></i></i></span></p>`; 
						});*/
						header.second = response;
						header.second.forEach(function(unit, p) {
							followers += `<p>${unit["name"]}<span><i class="fa fa-twitch fa-xs"></i></i></span></p>`; 
						});
					}
				}
			});

			$.ajax({
				type: "GET",
				url: "/api/subscriptions",
				success: function(response) {
					if (response && Array.isArray(response)/* && response.length > 0*/) {
						/*header[0][2] = response;
						
						
						
						header[0][2].forEach(function(unit, j) {
							subscriptions += `<p>${unit["name"]}<span><i class="fa fa-twitch fa-sm"></i></i></span></p>`; 
						});*/
						header.third = response;
						header.third.forEach(function(unit, j) {
							subscriptions += `<p>${unit["name"]}<span><i class="fa fa-twitch fa-xs"></i></i></span></p>`; 
						});
						$(".header").empty().append(`
							<div class="last">
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
							</div>
						`);
						show();
					}
				}
			});
			break;
		}
		case 1: {
			var topDay = "", topMonth = "", topAllTime = "";

			//var start = moment({h:0, m:0, s:0, ms:0}), end = moment({h:23, m:59, s:59, ms:59});
			$.ajax({
				type: "GET",
				url: `/api/donations/top?start=${moment().startOf('day').utc().toISOString()}&end=${moment().endOf('day').utc().toISOString()}`,
				success: function(response) {
					if (response && Array.isArray(response)) {
						header.first = response;
						header.first.forEach(function(unit, i) {
							//topDay += `<p>${unit["from"]}<span>${unit["total"]} <i class="fa fa-${(unit["currency"] in signs ? signs[unit["currency"]] : "rub")} fa-xs"></i></span></p>`;
							topDay += `<p>${unit["from"]}<span>${unit["total"]} <i class="fa fa-rub fa-xs"></i></span></p>`;
						});
					}
				}
			});


			$.ajax({
				type: "GET",
				url: `/api/donations/top?start=${moment().startOf('month').utc().toISOString()}&end=${moment().endOf('month').utc().toISOString()}`,
				success: function(response) {
					if (response && Array.isArray(response)) {
						header.second = response;
						header.second.forEach(function(unit, i) {
							//topMonth += `<p>${unit["from"]}<span>${unit["amount"]} <i class="fas fa-${(unit["currency"] in signs ? signs[unit["currency"]] : "rub")} fa-xs"></i></span></p>`;
							topMonth += `<p>${unit["from"]}<span>${unit["total"]} <i class="fa fa-rub fa-xs"></i></span></p>`;
						});
					}
				}
			});


			$.ajax({
				type: "GET",
				url: `/api/donations/top?start=${moment().subtract(100, 'year').utc().toISOString()}&end=${moment().utc().toISOString()}`,
				success: function(response) {
					if (response && Array.isArray(response)) {
						header.third = response;
						header.third.forEach(function(unit, i) {
							//topAllTime += `<p>${unit["from"]}<span>${unit["total"]} <i class="fa fa-${(unit["currency"] in signs ? signs[unit["currency"]] : "rub")} fa-xs"></i></span></p>`;
							topAllTime += `<p>${unit["from"]}<span>${unit["total"]} <i class="fa fa-rub fa-xs"></i></span></p>`;
						});
						$(".header").empty().append(`
							<div class="top">
								<div class="block" style="display: none;">
									<div class="roof"></div>
									<div class="units">${topDay}</div>
									<div class="cellar"></div>
								</div>
								<div class="block" style="display: none;">
									<div class="roof"></div>
									<div class="units">${topMonth}</div>
									<div class="cellar"></div>
								</div>
								<div class="block" style="display: none;">
									<div class="roof"></div>
									<div class="units">${topAllTime}</div>
									<div class="cellar"></div>
								</div>
							</div>
						`);
						show();
					}
				}
			});
			break;
		}
	};
	index = (index >= max) ? 0 : index + 1;
}, 300000);//interval

function add() {
}
function show() {
	if (
		header.first !== null
		||
		header.second !== null
		||
		header.third !== null
		) {
		$(`.header .block`).each(function(i, block) {
			var e = $(block);
			setTimeout(function() {
				e.jAnimate("slideInDown", function() {
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
				}, 20000);//show time
			}, 1000 * i);//interval between block appearances
		});
	}
}