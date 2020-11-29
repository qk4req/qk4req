			const e = io("http://localhost:3000/events", {
				reconnection: true,
				reconnectionDelayMax: 5000,
				reconnectionDelay: 1000,
			});
			e.on("connect", (socket) => {
				var repo = new Map(), el = $(".events .table tbody"),
				events = new Proxy(repo, {
					get: (target, prop) => {
						const val = target[prop];
						if (typeof val === 'function') {
							if (['set'].includes(prop)) {
								return function (k, v) {
									if (target.has(k)) {
										v = Object.assign(target.get(k), v);
										var p = el.find(`tr[data-key='${k}']`);
										if (v.status === 'shown') {
											p.remove();
											return;
										} else {
											if (["donation", "easter_egg"].indexOf(v.notification.type) !== -1) {
												p.replaceWith(`
												<tr data-key="${k}" data-type="donation" data-created-at="${v.created_at}" data-status=${v.status}>
													<th scope="row">
														<a onclick="e.emit('update', 'donation', {status: ${v.status === 'hidden' ? null : "\'hidden\'"}}, ${v.id});">
															${v.status === 'hidden' ?  '<i class="fa fa-eye"></i>' : '<i class="fa fa-eye-slash"></i>'}
														</a>
													</th>
													<td>${v.id}</td>
													<td>donation</td>
													<td>${v.from}</td>
													<td>${v.comment}</td>
													<td>${v.amount} <i class="fa fa-ruble fa-xs"></i></td>
													<td>${v.created_at}</td>
												</tr>`);
											} else if (v.notification.type === 'follower') {
												p.replaceWith(`
												<tr data-key="${k}" >
													<th scope="row">
														<a onclick="e.emit('update', 'follower', {status: ${v.status === 'hidden' ? null : "\'hidden\'"}}, ${v.id});">
															${v.status === 'hidden' ?  '<i class="fa fa-eye"></i>' : '<i class="fa fa-eye-slash"></i>'}
														</a>
													</th>
													<td>${v.id}</td>
													<td>follower</td>
													<td>${v.name}</td>
													<td>${v.created_at}</td>
												</tr>`);
											} else if (v.notification.type === 'subscription') {
											}
										}
										target.set(k, v);
									} else {
										//console.log(v);
										if (["donation", "easter_egg"].indexOf(v.notification.type) !== -1) {
											el.append(`
											<tr data-key="${k}" data-type="donation" data-created-at="${v.created_at}" data-status=${v.status}>
												<th scope="row">
													<a onclick="e.emit('update', 'donation', {status: ${v.status === 'hidden' ? null : "\'hidden\'"}}, ${v.id});">
														${v.status === 'hidden' ?  '<i class="fa fa-eye"></i>' : '<i class="fa fa-eye-slash"></i>'}
													</a>
												</th>
												<td>${v.id}</td>
												<td>donation</td>
												<td>${v.from}</td>
												<td>${v.comment}</td>
												<td>${v.amount} <i class="fa fa-ruble fa-xs"></i></td>
												<td>${v.created_at}</td>
											</tr>`);
										} else if (v.notification.type === 'follower') {
											el.append(`
											<tr data-key="${k}" >
												<th scope="row">
													<a onclick="e.emit('update', 'follower', {status: ${v.status === 'hidden' ? null : "\'hidden\'"}}, ${v.id});">
														${v.status === 'hidden' ?  '<i class="fa fa-eye"></i>' : '<i class="fa fa-eye-slash"></i>'}
													</a>
												</th>
												<td>${v.id}</td>
												<td>follower</td>
												<td>${v.name}</td>
												<td>${v.created_at}</td>
											</tr>`);
										} else if (v.notification.type === 'subscription') {
										}
										target.set(k, v);
									}
								}
							}
							return val.bind(target);
						}
						return val;
					}
				});


				e.on("inited", (data) => {
					if (data.success) {
						el.empty();
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
					if (data.success) {
						var event = data.payload[0];
						events.set(CryptoJS.MD5(`${event.id}+${event.notification.type}`).toString(), event);
					}
				});
			});