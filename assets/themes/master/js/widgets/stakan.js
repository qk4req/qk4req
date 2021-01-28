const s = io("http://localhost:3000/stakans", {
	reconnection: false,
	//reconnectionDelayMax: 5000,
	//reconnectionDelay: 1000,
});
s.on("connect", () => {
	connected = true;
	const sl = io("http://localhost:3000/stakanLevels", {
		reconnection: false,
		//reconnectionDelayMax: 5000,
		//reconnectionDelay: 1000,
	});

	sl.on("connect", () => {
		var repo = new Map(), el = $(".levels"),
		stakanLevels = new Proxy(repo, {
			get: (target, prop) => {
				const val = target[prop];
				if (typeof val === 'function') {
					if (['set'].includes(prop)) {
						return function (k, v) {
							if (target.has(k)) {
								v = Object.assign(target.get(k), v);
								var l = el.find(`.level[data-key='${k}']`);
								l.replaceWith(`
									<div
										class="level"
										data-key="${k}"
										style="margin-top: ${v.indent};"
									>
										<div class="level-content">${v.title}</div>
										<div class="level-arrow"></div>
									</div>
								`);
								target.set(k, v);
							} else {
								el.append(`
									<div
										class="level"
										data-key="${k}"
										style="margin-top: ${v.indent};"
									>
										<div class="level-content">${v.title}</div>
										<div class="level-arrow"></div>
									</div>
								`);
								target.set(k, v);
							}
						}
					}
					return val.bind(target);
				}
				return val;
			}
		});

		sl.on("inited", (data) => {
			if (data.success) {
				el.empty();
				data.payload.forEach((level) => {
					stakanLevels.set(level.title, level);
				});
			}
		});

		sl.on("updated", (data) => {
			if (data.success) {
				data.payload.forEach((level) => {
					if (stakanLevels.has(level.title)) stakanLevels.set(level.title, level);
				});
			}
		});

		sl.on("created", (data) => {
			if (data.success) {
				data.payload.forEach((level) => {
					if (!stakanLevels.has(level.title)) stakanLevels.set(level.title, level);
				});
			}
		});
	});
	sl.on("error", () => {
		sl.removeAllListeners();
	});
	sl.on("reconnect_error", () => {
		sl.removeAllListeners();
	});





	/*const sp = io("http://localhost:3000/stakanPoints", {
		reconnection: false,
		//reconnectionDelayMax: 5000,
		//reconnectionDelay: 1000,
	});

	sp.on("connect", () => {
		class StakanPointsRepo extends Map {
			total = 0.00;

			set total(t) {
				if (t < 0) throw new Error;

				this.total = t;
			}

			add (a) {
				this.total += a;
			}
		}
		var repo = new StakanPointsRepo(), el = $(".levels"),
		stakanPoints = new Proxy(repo, {
			get: (target, prop) => {
				const val = target[prop];
				if (typeof val === 'function') {
					if (['set'].includes(prop)) {
						return function (k, v) {
							target.add(v.amount);
							if (target.has(k)) {
								v = Object.assign(target.get(k), v);
								target.set(k, v);
							} else {
								target.set(k, v);
							}
						}
					}
					return val.bind(target);
				}
				return val;
			}
		});
		sp.on("inited", (data) => {
			if (data.success) {
				stakanPoints.total = data.payload.total;
			}
		});

		sp.on("created", (data) => {
			if (data.success) {
				data.payload.forEach((point) => {
					if (!stakanPoints.has(point.id)) stakanPoints.set(point.id, point);
				});
			}
		})
	});
	sp.on("error", () => {
		sp.removeAllListeners();
	});
	sp.on("reconnect_error", () => {
		sp.removeAllListeners();
	});*/
});
s.on("error", () => {
	s.removeAllListeners();
});
s.on("reconnect_error", () => {
	s.removeAllListeners();
});