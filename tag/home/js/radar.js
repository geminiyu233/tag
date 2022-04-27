/**
 * 雷达图
 */
$(function() {
	//基础雷达图
	var radarChart = echarts.init(document.getElementById("radar-a"));
	// 指定图表的配置项和数据  
	var radaroption = {
		// backgroundColor: '#000', //更改大背景颜色
		title: {
			// text: '基础雷达图'
		},
		 grid: {
        position: 'center', //图表的位置
     },
		tooltip: {}, //工具栏
		// legend: {  // 图列
		//     data: ['预算分配（Allocated Budget）', '实际开销（Actual Spending）']
		// },
		radar: {
			radius: 180, //雷达图形大小
			shape: 'circle', //雷达图圆型
			splitArea: { // 坐标轴在 grid 区域中的分隔区域，默认不显示。
				show: false,
				areaStyle: { // 分隔区域的样式设置。
					color: [
						'rgba(250,250,250,0)',
						'rgba(200,200,200,0.3)',
					], // 分隔区域颜色。分隔区域会按数组中颜色的顺序依次循环设置颜色。默认是一个深浅的间隔色。
				}
			},
			name: {
				textStyle: {
					color: '#fff',
					// backgroundColor: '#999',//name名字的背景颜色
					borderRadius: 3,
					padding: [3, 5],
					fontSize: 16,
				}
			},
			indicator: [{
					name: '销售',
					max: 6500
				},
				{
					name: '管理',
					max: 16000
				},
				{
					name: '信息技术',
					max: 30000
				},
				{
					name: '客服',
					max: 38000
				}
			]
		},
		series: [{
			name: '预算 vs 开销',
			type: 'radar',
			radius: ["10%", "10%"],
			lineStyle: { //雷达图区域边沿线颜色
				color: 'rgba(255, 204, 0, 1)',
			},
			itemStyle: { // 折线拐点标志的样式。
				normal: { // 普通状态时的样式
					lineStyle: {
						width: 1,
						color: 'rgba(255, 204, 0, 1)', //雷达图区域边沿线颜色
					},
					opacity: 0 //为0时不会绘制拐点
				},
				// emphasis: {                    // 鼠标移入高亮时的样式
				//     lineStyle: {
				//         width: 5
				//     },
				//     opacity: 1
				// }
			},

			areaStyle: {
				normal: {
					opacity: 0.5,
					color: 'rgba(255, 204, 0, 1)',
				}
			}, //雷达图区域填充颜色
			data: [{
					value: [4300, 10000, 28000, 35000, 50000, 19000],
					name: '预算分配（Allocated Budget）'
				}

			]
		}]
	};
	// 使用刚指定的配置项和数据显示图表。  
	radarChart.setOption(radaroption);
	window.onresize = radarChart.resize; //想要实现自适应添加上的语句
});
