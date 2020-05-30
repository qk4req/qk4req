var sockets = {}, levels = [], points = 0, max, playing = false;

var progressBar = {
	update: function() {
		var percent = points/max*100,
		level = levels.filter(level => points>=level["points"]).reverse()[0],
		bar = $(".progress>.bar");

		percent = percent > 100 ? 100 : percent;
		bar.css({
			width: percent.toString()+"%"
		}).animate({"background-color": level["color"]});
	}
};

sockets["progressBarLevels"] = io("http://sockets.qk4req.ru/progressBarLevels", {
	reconnection: true,
	reconnectionDelayMax: 5000,
	reconnectionDelay: 1000,
});
sockets["progressBarLevels"].on("connect", function() {
	sockets["progressBarLevels"].emit("read");

	sockets["progressBarLevels"].on("readed", function(data) {
		if (data["success"] && data["payload"].length > 0) {
			var e = $(".footer .levels");
			levels = data["payload"];
			max = levels[levels.length - 1]["points"];

			e.empty();
			levels.forEach(function(level, i) {
				level["lost"] = false;
				e.append(`<label id="${level["id"]}">${level["points"]/max*100}%</label>`);
			});

			sockets["progressBarPoints"] = io("http://sockets.qk4req.ru/progressBarPoints", {
				reconnection: true,
				reconnectionDelayMax: 5000,
				reconnectionDelay: 1000,
			});

			sockets["progressBarPoints"].on("connect", function() {
				sockets["progressBarPoints"].emit("read");
				
				sockets["progressBarPoints"].on("readed", function(data) {
					if (data["success"] && data["payload"].length === 1) {
						points = data["payload"][0]["amount"];
						progressBar.update();
					}

					$(".preloader").jAnimateOnce("fadeOut", function() {
						$(".preloader").hide();
						$(".footer").jAnimateOnce("fadeIn").show();
					});
				});
				sockets["progressBarPoints"].on("created", function(data) {
					if (data["success"] && data["payload"].length === 1) {
						points += data["payload"][0]["amount"];
						progressBar.update();
					}
				});
			});
		}
	});

	sockets["progressBarLevels"].on("updated", function(data) {
		if (data["success"] && data["payload"].length === 1) {
			levels.some(function(level, i) {
				if (level["id"] === data["payload"][0]["id"]) {
					Object.assign(level, data["payload"][0]);
					progressBar.update();
					return true;
				}
			});
		}
	});
});

setInterval(function() {
	if (levels.length > 0) {
		levels.some(function(level, i) {
			var e = $(`.footer .levels label#${i+1}`);
			if (points >= level["points"]) {
				if (!level["end"] || level["end"] <= 0) {
					var attr = e.attr("style");
					if (typeof attr !== typeof undefined && attr !== false) {
						e.removeAttr("style");
					} else {
						e.css({"background-color": level["color"]});
					}


					if (!playing && level["lost"] === false) {
						playing = true;
						soundManager.createSound({
							id: "npb-"+level["id"],
							url: level["notification"]["src"],
							autoLoad: true,
							volume: Number.parseInt(level["notification"]["volume"]*100),
							onload: function() {
								this.play();
							},
							onfinish: function() {
								level["lost"] = true;
								playing = false;
							},
							onerror: function(code) {
								this.stop();
								playing = false;
							}
						});
					}
					return true;
				} else {
					e.css({"background-color": level["color"]});
				}
			}
		});
	}
}, 1000);