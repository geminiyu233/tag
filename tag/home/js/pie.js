$(function() {
	//基础雷达图
	var pieChart = echarts.init(document.getElementById("pie-a"));
	var option = {
		tooltip: {
			trigger: 'item',
			formatter: "{a} <br/>{b}: {c} ({d}%)"
		},
		title: {
			text: "2800个",
			subtext: "任务数",
			left: "50%",
			textAlign: "center",
			top: "38%",
			textStyle: { //text样式 
				fontSize: 24,
				color: '#fff',
				fontWeight: "normal",
				fontFamily: "attriumviratecondensed"
			},
			subtextStyle: { //subtext样式 
				color: '#fff',
				fontSize: 16,

			}
		},
		
		color: [
			"#00fccc",
			"#144687",
		],
		series: [{
			name: '访问来源',
			type: 'pie',
			radius: ['50%', '70%'],
			// avoidLabelOverlap: false,
			itemStyle: {
				normal: {  //扇形区域加间隔
					borderColor: "#081f52",
					borderWidth: 4,
				}
			},
			label: {
				normal: {
					show: false,
					position: 'center'
				},
				emphasis: {
					show: false,
					textStyle: {
						fontSize: '30',
						fontWeight: 'bold'
					}
				}
			},
			labelLine: {
				normal: {
					show: false
				}
			},
			data: [{
					value: 335,
					name: '直接访问'
				},
				{
					value: 310,
					name: '邮件营销'
				},

			]
		}]

	};

	pieChart.setOption(option);
	window.onresize = pieChart.resize; //想要实现自适应添加上的语句
});
