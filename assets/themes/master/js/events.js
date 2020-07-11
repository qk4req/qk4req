var events = [], playing = false, signs = {
	RUB: "ruble",
	USD: "dollar",
	EUR: "euro"
};

const socket = io("http://sockets.qk4req.ru/events", {
	reconnection: true,
	reconnectionDelayMax: 5000,
	reconnectionDelay: 1000,
});

socket.on("connect", function() {
	socket.on("created", function(data) {
		if (data['success'] && data['payload'].length === 1) {
			events.push(data.payload[0]);
		}
	});
});


setInterval(function() {
	if (events.length === 0 || playing !== false) return;
	var event = events[0], announcement = (event['notification'] !== undefined || event['notification'] !== null) ? event['notification'] : event['easter_egg'];//notification = event['notification'], easterEgg = event['eas'];
	announcement['type'] = (announcement['type'] !== undefined || announcement['type'] !== null) ? announcement['type'] : 'easter_egg';
	playing = true;
	if ($(".right-sidebar .event.bounceInRight").length > 3) {
		var first = $(".right-sidebar .event.bounceInRight").first();
		first.jAnimate("rotateOutUpRight", function() {
			//first.remove();
			first.hide();
		});
	}
	$(".right-sidebar").append(`<div class="event ${announcement["type"]}"><span>${
		(["donation", "easter_egg"].indexOf(announcement["type"]) !== -1 ? `${event["from"]} - ${event["amount"]} <i class="fas fa-${(event["currency"] in signs ? signs[event["currency"]] : "ruble")}-sign fa-xs"></i>` : `${event["name"]}`)
	}</span></div>`).find(".event").last().jAnimate("bounceInRight").show();

	soundManager.createSound({
		id: "ne-"+event["_id"],
		url: announcement["src"],
		autoLoad: true,
		volume: Number.parseInt(announcement["volume"]*100),
		onload: function() {
			this.play();
		},
		onfinish: function() {
			if (["donation", "easter_egg"].indexOf(announcement["type"]) !== -1) {
				setTimeout(function() {
					soundManager.createSound({
						id: "de-"+event["_id"],
						url: event["dubbing"]["src"],
						autoLoad: true,
						volume: Number.parseInt(event["dubbing"]["volume"]*100),
						onload: function() {
							this.play();
						},
						onfinish: function() {
							playing = false;
						},
						onerror: function(code) {
							this.stop();
							events.splice(0, 1);
							playing = false;
						}
					});
				}, 1000);
			} else {
				playing = false;
			}
			events.splice(0, 1);
		},
		onerror: function(code) {
			this.stop();
			events.splice(0, 1);
			playing = false;
		}
	});
}, 1000);