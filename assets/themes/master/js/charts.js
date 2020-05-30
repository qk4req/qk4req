var ctx = document.getElementById("myChart").getContext('2d'),
symbols = [
	"➀", "➁", "➂", "➃", "➄", "➅", "➆", "➇", "➈", "➉"
],
myChart = new Chart(ctx, {
	type: 'bar',
	data: {
		labels: [],
		datasets: [
			{
				data: [],
				backgroundColor: [],
				borderColor: [],
				borderWidth: 1
			},
		]
	},
	options: {
		legend: {
			display: false
		},
		// Boolean - whether or not the chart should be responsive and resize when the browser does.
		responsive: true,
		// Boolean - whether to maintain the starting aspect ratio or not when responsive, if set to false, will take up entire container
		maintainAspectRatio: false,
		scales: {
			yAxes: [{
				ticks: {
					fontColor: "white",
					fontFamily: "'Roboto', sans-serif",
					fontSize: 25,
					steps: 20,
					stepValue: 1,
					max: 100,
					beginAtZero: true,
				},
				gridLines: {
					display: false,
				}
			}],
			xAxes: [{
				ticks: {
					fontColor: "white",
					fontFamily: "'Roboto', sans-serif",
					fontSize: 40,
				},
				gridLines: {
					display: false,
				}
			}]
		}
	}
});
setInterval(function() {
	$.ajax({
		type: "GET",
		url: "/api.votingPoints",
		success: function(response) {
			$.each(response, function(index, point) {
				myChart.data.labels[index] = `${symbols[index]}`;
				myChart.data.datasets[0].data[index] = `${point["percent"]}`;
				myChart.data.datasets[0].backgroundColor[index] = `${point["background_color"]}`;
				myChart.data.datasets[0].borderColor[index] = `${point["border_color"]}`;
			});
			//myChart.data.datasets[0].data[0] = 90;
			myChart.update();
		}
	});
}, 1000);