const v = io("http://localhost:3000/volumes", {
	reconnection: true,
	reconnectionDelayMax: 5000,
	reconnectionDelay: 1000,
});
v.on("connect", () => {
	var volumes, nSound, dSound;

	v.on("inited", (data) => {
		if (data.success && data.payload) {
			volumes = data.payload;

			const e = io("http://localhost:3000/events", {
				reconnection: true,
				reconnectionDelayMax: 5000,
				reconnectionDelay: 1000,
			});
			e.on("connect", () => {
				var repo = new Map, playing = false, signs = {
					RUB: "ruble",
					USD: "dollar",
					EUR: "euro"
				};
				events = new Proxy(repo, {
					get: (target, prop) => {
						const val = target[prop];
						if (typeof val === "function") {
							if (["set"].includes(prop)) {
								return function (k, v) {
									if (target.has(k)) {
										_v = target.get(k);
										v = Object.assign(target.get(k), v);
									}
									target.set(k, v);
								}
							}
							if (["get"].includes(prop)) {
								return function (k = undefined) {
									var v = Array.from(target.values());
									v.sort((a, b) => {
										a = moment(a.created_at);
										b = moment(b.created_at);
										if (a.isAfter(b)) {
											return 1;
										}
										if (b.isAfter(a)) {
											return -1;
										}
										return 0;
									});
									return k === undefined ? v : target.get(k);
								}
							}

							return val.bind(target);
						}
						return val;
					}
				});

				e.on("inited", (data) => {
					if (data.success && Array.isArray(data.payload) && data.payload.length > 0) {
						data.payload.forEach((event) => {
							events.set(CryptoJS.MD5(`${event.id}+${event.notification.type}`).toString(), event);
						});
					}
				});

				e.on("updated", (data) => {
					if (data.success) {
						var event = data.payload[0], k = CryptoJS.MD5(`${event.id}+${event.notification.type}`).toString();
						
						if (events.has(k)) events.set(k, event);
					}
				});

				e.on("created", (data) => {
					if (data.success && data.payload.length === 1) {
						var event = data.payload[0];

						events.set(CryptoJS.MD5(`${event.id}+${event.notification.type}`).toString(), event);
					}
				});

				setInterval(() => {
					events.forEach((v, k) => {
						var el = $(`.right-sidebar .event[data-key=${k}]`);
						if (v.status === "hidden" && el.is(":visible")) {
							el.hide();
							if (playing) {
								if (nSound && nSound.id === `notification-${k}`) {
									nSound.stop();
									nSound = undefined;
								}

								if (dSound && dSound.id === `dubbing-${k}`) {
									dSound.stop();
									dSound = undefined;
								}
							}
						}

						if (v.status === null && el.is(":hidden")) {
							el.show();
						}

					});
					var event = Array.from(events).reverse().find((u) => {
						var k = u[0], v = u[1];
						if (v.status === null) return u;
					});
					if (event === undefined || playing === true) return;
					playing = true;
					if ($(".right-sidebar .event.bounceInRight").length > 3) {
						var first = $(".right-sidebar .event.bounceInRight").first();
						first.jAnimateOnce("rotateOutUpRight", () => {
							first.hide();
						});
					}
					var _el = $(".right-sidebar"), __el = $(`.right-sidebar .event[data-key=${event[0]}]`);
					if (__el.length === 0) {
						_el.append(`<div data-key="${event[0]}" class="event ${event[1].notification.type}"><span>${
							(
								["donation", "easter_egg"].indexOf(event[1].notification.type) !== -1
								?
									`${event[1].from} - 
									${
										(event[1].original_amount !== null && event[1].original_currency !== null)
										?
										`${event[1].original_amount.toFixed(2)} <i class="fa fa-${(event[1].original_currency in signs ? signs[event[1].original_currency] : event[1].original_currency)} fa-xs"></i>`
										:
										`${event[1].amount.toFixed(2)} <i class="fa fa-ruble fa-xs"></i>`	
									}`
								:
								`${event[1].name}`
							)
						}</span></div>`)
					} else {
						__el.replaceWith(`<div data-key="${event[0]}" class="event ${event[1].notification.type}"><span>${
							(
								["donation", "easter_egg"].indexOf(event[1].notification.type) !== -1
								?
									`${event[1].from} - 
									${
										(event[1].original_amount !== null && event[1].original_currency !== null)
										?
										`${event[1].original_amount.toFixed(2)} <i class="fa fa-${(event[1].original_currency in signs ? signs[event[1].original_currency] : event[1].original_currency)} fa-xs"></i>`
										:
										`${event[1].amount.toFixed(2)} <i class="fa fa-ruble fa-xs"></i>`	
									}`
								:
								`${event[1].name}`
							)
						}</span></div>`);
					}
					_el.find(".event").last().jAnimate("bounceInRight").show();

					nSound = soundManager.createSound({
						id: `notification-${event[0]}`,
						url: event[1].notification.src,
						autoLoad: true,
						autoPlay: true,
						volume: volumes.notification,
						onfinish: () => {
							var el = $(`.right-sidebar .event[data-key=${event[0]}]`);
							nSound = undefined;

							if (["donation", "easter_egg"].indexOf(event[1].notification.type) !== -1 && event[1].dubbing) {
								setTimeout(() => {
									dSound = soundManager.createSound({
										id: `dubbing-${event[0]}`,
										url: event[1].dubbing.src,
										autoLoad: true,
										autoPlay: true,
										volume: volumes.dubbing,
										onfinish: () => {
											dSound = undefined;
											e.emit("update", event[1].notification.type, {
												status: "shown"
											}, event[1].id);
											if (el.is(":visible")) {
												el.jAnimateOnce("rotateOutUpRight", () => {
													el.hide();
												});
											}

											playing = false;
										},
										onstop: () => {
											dSound = undefined;

											e.emit("update", event[1].notification.type, {
												status: "shown"
											}, event[1].id);

											playing = false;
										},
										onerror: (code) => {
											this.stop();
										}
									});
								}, 1000);
							} else {
								e.emit("update", event[1].notification.type, {
									status: "shown"
								}, event[1].id);
								if (el.is(":visible")) {
									el.jAnimateOnce("rotateOutUpRight", () => {
										el.hide();
									});
								}

								playing = false;
							}
						},
						onstop: () => {
							nSound = undefined;

							e.emit("update", event[1].notification.type, {
								status: "shown"
							}, event[1].id);

							playing = false;
						},
						onerror: (code) => {
							this.stop();
						}
					});
				}, 1000);
			});
		}
	});

	v.on("updated", (data) => {
		if (data.success && data.payload) {
			volumes = data.payload;

			if (nSound && volumes.notification) nSound.setVolume(volumes.notification);
			if (dSound && volumes.dubbing) nSound.setVolume(volumes.dubbing);
		}
	});
});