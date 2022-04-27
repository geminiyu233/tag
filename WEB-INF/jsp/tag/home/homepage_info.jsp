<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/jsp/_common/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh">
	<head>
	    <title>环境标签服务系统【首页】</title>
		<%@ include file="/WEB-INF/jsp/_common/commonCSS.jsp"%>
		<link rel="stylesheet" type="text/css" href="${ctx }/tag/home/css/base.css" />
		<link rel="stylesheet" type="text/css" href="${ctx }/tag/home/css/style.css" />
		<link rel="stylesheet" type="text/css" href="${ctx }/tag/home/css/index.css" />
		
	  	<!--页面自定义的CSS，请放在这里 -->
	    <style type="text/css">
	    	.blue{
	    		color: #2edbff !important;
	    	}
	    	.top_margin_17{
	    		margin-top:17px;
	    	}
	    	.block_background{
	    		background-color: #112c67;
	    		border-radius: 8px;
	    	}
/* 	    	.min_width_220{
	    		min-width:150px;
	    	} */
	    	.textes_1 {
   			   margin-top: 5px;
			   margin-left: 114px;
			   line-height: 26px;
			   text-align: right;
	    	}
	    		.textes_2{
   			   margin-top: 5px;
			   margin-left: 74px;
			   line-height: 26px;
			   text-align: right;
	    		}
	    		.tagpic-label{
	    		margin-left: 29px;
  				margin-top: 10px;
    			margin-bottom: 5px;
	    		}
				.border{
					margin-top:0px;
					height:200px;
					padding:0px 0px;
				}
				/*  ul .on{
					border:1px solid #3a8696;
				} */
		</style>
	</head>
	
	<body class="no-skin">
		<div class="main-container background" id="main-container">
		    <div class="main-content">
		         <!-- 内容部分 -->
		        <div class="main-content-inner padding-page-content">
            		<div class="page-content background">
                		<div class="row">
                    		<div class="col-xs-12">
                        		<form id="mainForm" name="mainForm" action="" class="form-horizontal" role="form" method="post" autocomplete="off">
		                        	<!-- 重点特征 -->
		                        	<div id="count" class=" headlines label padding-r-10" style="padding-left:0px">
											标签统计
		                        	</div>
		                        	<div class="form-group" style="margin-bottom: 0px;margin-top:5px;border-radius: 6px;">
										<div class="width-70 fl padding-r-10   border" style="padding: 10px 10px 5px 10px;right:5px">
												<div class="col-xs-4" style="padding-bottom:15px">
													<p class="num-bg" style="font-size:16px">标签数量</p>
													<p class="font-size-12 blue">Number of labels</P>
													<p class="number" style="font-size:50px;margin-top:0px">
														${sumTagMap.SUMTAG}
														<span class="blue" style="font-size:20px;margin-left:10px">个</span></p>
													<ul style="list-style:none;margin-left:0px;min-width:230px">
														<li class="fl block_background  width-90" style="margin-top:-3px;padding-bottom:12px">
															<span class="fl" style="margin-top:8px;">
																<img src="${ctx }/tag/home/img/images/02_22.png" style="margin-left:20px">
																<img src="${ctx }/tag/home/img/images/02_31.png" style="margin-left:20px">
															</span>
															<span class="fl textes_2">
																<span class="font-size-20">${sumTagMap.TY_TAG}</span>
																<span class="blue">个</span><br/>
																<span class="blue">停用标签</span>
															</span>
														</li>
													</ul>
												</div>
												<div class="col-xs-8" style="padding-bottom:15px">
													<ul style="list-style:none">
														<li class="fl width-48 block_background top_margin_17 min_width_220" style="padding-bottom:12px">
															<span class="fl"><img src="${ctx }/tag/home/img/images/02_14.png" class="tagpic-label"></span>
															<span class="fl textes_1">
																<span class="font-size-20">${sumTagMap.ZM_TAG}</span>
																<span class="blue">个</span><br>
																<span class="blue">正面标签</span>
															</span>
														</li>
														<li class="fr width-48 block_background top_margin_17 min_width_220" style="padding-bottom:12px">
															<span class="fl"><img src="${ctx }/tag/home/img/images/02_17.png" class="tagpic-label"></span>
															<span class="fl textes_1">
																<span class="font-size-20">${sumTagMap.FM_TAG}</span>
																<span class="blue">个</span><br>
																<span class="blue">负面标签</span>
															</span>
														</li>
														<li class="fl width-48 block_background top_margin_17 min_width_220" style="padding-bottom:12px">
															<span class="fl "><img src="${ctx }/tag/home/img/images/02_25.png" class="tagpic-label"></span>
															<span class="fl  textes_1">
																<span class="font-size-20">${sumTagMap.ZX_TAG}</span>
																<span class="blue">个</span><br>
																<span class="blue">中性标签</span></span>
														</li>
														<li class="fr width-48 block_background top_margin_17 min_width_220" style="padding-bottom:12px">
															<span class="fl"><img src="${ctx }/tag/home/img/images/02_27.png" class="tagpic-label"></span>
															<span class="fl  textes_1">
																<span class="font-size-20">${sumTagMap.ST_TAG}</span>
																<span class="blue">个</span><br>
																<span class="blue">实体统计</span>
															</span>
														</li>
													</ul>
											</div>
										</div>
										<div class="width-30 fl padding-l-10 ">
												<div class="border" style="padding-left:20px">
													<p class="num-bg" style="font-size:16px">标签任务监控<span style="font-size:12px">(近一周)</span></p>
													<p class="font-size-12 blue">Label job monitoring</P>
													<div id="pie-a" style="height:140px;width:155px;margin-top:-8px"></div>
													<ul class="pos-absolute leng" style="padding-left:30px">
														<li class="four" style="font-size:12px">异常状态
															<span class="margin-left-8">
															 	${sumTagMap.YCZB}%
															</span>
														</li>
														<li class="five" style="font-size:12px">正常状态
															<span class="margin-left-8">
																<c:if test="${empty sumTagMap.YC_STATUS}">100%</c:if>
																<c:if test="${not empty sumTagMap.YC_STATUS and empty sumTagMap.ZC_STATUS}">0%</c:if>
																<c:if test="${not empty sumTagMap.YC_STATUS and not empty sumTagMap.ZC_STATUS}">${sumTagMap.ZCZB}%</c:if>
															</span>
														</li>
													</ul>
												</div>
										 </div>
									</div>
		            				<div class="width-100 fl pos-relative">
										<div class="label-c padding-r-10">
											实体标签概况
										</div>
										<div class="border-a" id="tagDescribe" style="height:450px">
										<div id="list" style="overflow: auto;height:100%;padding:0px;" class="nav width-35 fl"  >
											<ul>
												 <c:forEach items="${entityTotalList}" var="entity" varStatus="status">
					        						<li style="height:90px;<c:if test="${status.index eq 0}">border-left:0px;border-top:0px;</c:if>" id="${entity.ENTITY_CODE}" class="nav-list <c:if test="${status.index eq 0}">on</c:if>" >
														<div class="nav-list-l fl" style="border:0px;height:90px;width:70px">
															<img style="padding-left:19px;padding-top:22px" src="${ctx }/tag/home/img/images/02_42.png" />
														</div>
														<div class="nav-list-r" style="width:auto;height:90px">
															<p>
																<span style="font-size:14px">标签实体：${entity.ENTITY_NAME}</span>
																<span style="font-size:14px;margin-left:50px">标签数量：${entity.SUMTAG} (个)</span>
															</p>
															<p>
																<span class="green" style="font-size:13px;padding: 5px 8px;">正面标签</span>
																<span style="font-size:13px;margin-left:5px">${entity.ZM_TAG}</span>
																<span class="red-v" style="font-size:13px;margin-left:20px;padding: 5px 8px;">负面标签</span>
																<span style="font-size:13px;margin-left:5px">${entity.FM_TAG}</span>
														    	<span class="yellow-b" style="font-size:13px;margin-left:20px;padding: 5px 8px;">中性标签</span>
														    	<span style="font-size:13px;margin-left:5px">${entity.ZX_TAG}</span>
															 </p>
														</div>
													</li>
					    						  </c:forEach>
					    						<!--   测试超出5个实体滚动条情况 -->
					    						<%--  <c:forEach items="${entityTotalList}" var="entity" varStatus="status">
					        						<li style="height:90px;<c:if test="${status.index eq 1}">border-left:0px;border-top:0px;</c:if>" id="${entity.ENTITY_CODE}" class="nav-list <c:if test="${status.index eq 1}">on</c:if>" >
														<div class="nav-list-l fl" style="border:0px;height:90px;width:70px">
															<img style="padding-left:19px;padding-top:22px" src="${ctx }/tag/home/img/images/02_42.png" />
														</div>
														<div class="nav-list-r" style="width:auto;height:90px">
															<p>
																<span style="font-size:14px">标签实体：${entity.ENTITY_NAME}</span>
																<span style="font-size:14px;margin-left:50px">标签数量：${entity.SUMTAG} (个)</span>
															</p>
															<p>
																<span>
																	<span class="green" style="font-size:13px;padding: 5px 8px;">正面标签</span>
																	<span style="font-size:12px;margin-left:5px">${entity.ZM_TAG}</span>
																</span>
																<span class="">
																	<span class="red-v" style="font-size:13px;margin-left:20px;padding: 5px 8px;">负面标签</span>
																	<span style="font-size:12px;margin-left:5px">${entity.FM_TAG}</span>
																</span>
															    <span class="">
															    	<span class="yellow-b" style="font-size:13px;margin-left:20px;padding: 5px 8px;">中性标签</span>
															    	<span style="margin-left:5px" style="font-size:12px">${entity.ZX_TAG}</span>
															    </span>
															 </p>
														</div>
													</li>
					    						  </c:forEach>
					    						 <c:forEach items="${entityTotalList}" var="entity" varStatus="status">
					        						<li style="height:90px;<c:if test="${status.index eq 1}">border-left:0px;border-top:0px;</c:if>" id="${entity.ENTITY_CODE}" class="nav-list <c:if test="${status.index eq 1}">on</c:if>" >
														<div class="nav-list-l fl" style="border:0px;height:90px;width:70px">
															<img style="padding-left:19px;padding-top:22px" src="${ctx }/tag/home/img/images/02_42.png" />
														</div>
														<div class="nav-list-r" style="width:auto;height:90px">
															<p>
																<span style="font-size:14px">标签实体：${entity.ENTITY_NAME}</span>
																<span style="font-size:14px;margin-left:50px">标签数量：${entity.SUMTAG} (个)</span>
															</p>
															<p>
																<span>
																	<span class="green" style="font-size:13px;padding: 5px 8px;">正面标签</span>
																	<span style="font-size:12px;margin-left:5px">${entity.ZM_TAG}</span>
																</span>
																<span class="">
																	<span class="red-v" style="font-size:13px;margin-left:20px;padding: 5px 8px;">负面标签</span>
																	<span style="font-size:12px;margin-left:5px">${entity.FM_TAG}</span>
																</span>
															    <span class="">
															    	<span class="yellow-b" style="font-size:13px;margin-left:20px;padding: 5px 8px;">中性标签</span>
															    	<span style="margin-left:5px" style="font-size:12px">${entity.ZX_TAG}</span>
															    </span>
															 </p>
														</div>
													</li>
					    						  </c:forEach>
					    						  <c:forEach items="${entityTotalList}" var="entity" varStatus="status">
					        						<li style="height:90px;<c:if test="${status.index eq 1}">border-left:0px;border-top:0px;</c:if>" id="${entity.ENTITY_CODE}" class="nav-list <c:if test="${status.index eq 1}">on</c:if>" >
														<div class="nav-list-l fl" style="border:0px;height:90px;width:70px">
															<img style="padding-left:19px;padding-top:22px" src="${ctx }/tag/home/img/images/02_42.png" />
														</div>
														<div class="nav-list-r" style="width:auto;height:90px">
															<p>
																<span style="font-size:14px">标签实体：${entity.ENTITY_NAME}</span>
																<span style="font-size:14px;margin-left:50px">标签数量：${entity.SUMTAG} (个)</span>
															</p>
															<p>
																<span>
																	<span class="green" style="font-size:13px;padding: 5px 8px;">正面标签</span>
																	<span style="font-size:12px;margin-left:5px">${entity.ZM_TAG}</span>
																</span>
																<span class="">
																	<span class="red-v" style="font-size:13px;margin-left:20px;padding: 5px 8px;">负面标签</span>
																	<span style="font-size:12px;margin-left:5px">${entity.FM_TAG}</span>
																</span>
															    <span class="">
															    	<span class="yellow-b" style="font-size:13px;margin-left:20px;padding: 5px 8px;">中性标签</span>
															    	<span style="margin-left:5px" style="font-size:12px">${entity.ZX_TAG}</span>
															    </span>
															 </p>
														</div>
													</li>
					    						  </c:forEach>
					    						 <c:forEach items="${entityTotalList}" var="entity" varStatus="status">
					        						<li style="height:90px;<c:if test="${status.index eq 1}">border-left:0px;border-top:0px;</c:if>" id="${entity.ENTITY_CODE}" class="nav-list <c:if test="${status.index eq 1}">on</c:if>" >
														<div class="nav-list-l fl" style="border:0px;height:90px;width:70px">
															<img style="padding-left:19px;padding-top:22px" src="${ctx }/tag/home/img/images/02_42.png" />
														</div>
														<div class="nav-list-r" style="width:auto;height:90px">
															<p>
																<span style="font-size:14px">标签实体：${entity.ENTITY_NAME}</span>
																<span style="font-size:14px;margin-left:50px">标签数量：${entity.SUMTAG} (个)</span>
															</p>
															<p>
																<span>
																	<span class="green" style="font-size:13px;padding: 5px 8px;">正面标签</span>
																	<span style="font-size:12px;margin-left:5px">${entity.ZM_TAG}</span>
																</span>
																<span class="">
																	<span class="red-v" style="font-size:13px;margin-left:20px;padding: 5px 8px;">负面标签</span>
																	<span style="font-size:12px;margin-left:5px">${entity.FM_TAG}</span>
																</span>
															    <span class="">
															    	<span class="yellow-b" style="font-size:13px;margin-left:20px;padding: 5px 8px;">中性标签</span>
															    	<span style="margin-left:5px" style="font-size:12px">${entity.ZX_TAG}</span>
															    </span>
															 </p>
														</div>
													</li>
					    						  </c:forEach>  --%>
											</ul>
											<div id="backBlock" style="height:336px;background: #031845;border-right: 1px solid #1b7da9;border-radius:0px;">
											</div>
										</div>
										<!-- 切换模态框的内容 -->
										<div class="width-65 fl model-box">
											<div class="model-boxlist">
												<div class="width-55 fl">
													<p class="num-bg margin-top-8 margin-left-25" style="font-size:16">标签分布</p>
													<p class="font-size-12 blue margin-left-25">Label Distribution of Enterprise Entities</P>													
													<div id="radar-a" class="chart-h" style="height:310px;width:auto"></div>
												</div>
												<div class="width-45 fr padding-lr-20 pos-relative">
													<p class="pos-absolute time-list">
														<span text="1" class="blue">本周</span>
														<span text="2" class="border-line">本月</span>
														<span text="3">本年</span>
													</p>
													<p class="num-bg margin-top-8" style="float:none;">标签使用频率排名</p>
												 	<p class="font-size-12 blue">Usage frequency ranking</P>
												 	<ul id="rank" class="table-l margin-top-5">
													</ul> 
													<div class="pos-absolute line-s" style="right:380px;left:0px"><img src="${ctx }/tag/home/img/images/line-s.png" /></div>
												</div>
											</div>
										</div>
									</div>
								</div>
		                        </form>
							</div>
						</div>
					</div>
				</div>          	
			</div>              	
		</div> 
		
		<script src="${ctx }/tag/home/js/jquery-3.3.1.min.js"></script>
		<script src="${ctx }/tag/home/js/index.js"></script>
		<script src="${ctx }/tag/home/js/echarts.min.js"></script>
		<script src="${ctx}/assets/components/jquery-nicescroll/jquery.nicescroll.min.js"></script>
	    <script src="${ctx}/assets/components/jquery-nicescroll/jquery.nicescroll.plus.js"></script>
				
		<%-- <%@ include file="/WEB-INF/jsp/_common/commonJS.jsp"%>
		<script src="${ctx }/tag/home/js/jquery-3.3.1.min.js"></script>
		<script src="${ctx }/tag/home/js/index.js"></script>
		<script src="${ctx }/tag/home/js/echarts.min.js"></script> --%>
		<%-- <script type="text/javascript" src="${ctx}/assets/components/echarts/2.x/echarts-all.js"></script> --%>
		<!-- 自己写的JS，请放在这里 -->
		<script type="text/javascript">
			jQuery(function($){
				//加载滚动条
				$("#list").niceScroll();
				//设置高度
				setDivHeight();
				//加载echat
				echat_monitor();
				//初始化企业标签分布
				getInitializeDistribution();
				//初始化企业标签使用频率排名(perid:1代表本周(默认))
				getInitializeRank(1);
				//限制实体标签文字
				setFontNumber();
				
			});
			//基础图环图
			function echat_monitor(){
				var pieChart = echarts.init(document.getElementById("pie-a"));
				var option = {
					tooltip: {
						trigger: 'item',
						formatter: "{b}:{d}%",
						position: function (pos, params, dom, rect, size) {
						// 鼠标在左侧时 tooltip 显示到右侧，鼠标在右侧时 tooltip 显示到左侧。
							var obj = {top: 60};
							obj[['left', 'right'][+(pos[0] < size.viewSize[0] / 2)]] = 5;
							return obj;
						}
					},
				  /*   legend: {
				        orient: 'vertical',
				        x: 'right',
				        data:['异常状态24%','正常状态76%'],
				        textStyle: { //text样式 
							fontSize: 14,
							color: '#fff',
							fontWeight: "normal",
							fontFamily: "attriumviratecondensed"
						}
				    }, */
					title: {
						text: "${sumTagMap.SUM_STATUS}"+"个",
						subtext: "任务数",
						left: "48%",
						textAlign: "center",
						top: "30%",
						textStyle: { //text样式 
							fontSize: 20,
							color: '#fff',
							fontWeight: "normal",
							fontFamily: "attriumviratecondensed"
						},
						subtextStyle: { //subtext样式 
							color: '#fff',
							fontSize: 14,

						}
					},
					color: [
						"#00fccc",
						"#144687",
					],
					series: [{
						type: 'pie',
						radius: ['60%', '83%'],
						// avoidLabelOverlap: false,
						/* itemStyle: {
							normal: {  //扇形区域加间隔
								borderColor: "#081f52",
								borderWidth: 4,
							}
						}, */
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
							value:'${sumTagMap.YC_STATUS}' == ''?0:'${sumTagMap.YC_STATUS}',
							name: '异常状态'
						},
						{
							value:'${sumTagMap.YC_STATUS}' == ''?100:('${sumTagMap.ZC_STATUS}' == ''?0:'${sumTagMap.ZC_STATUS}'),
							name: '正常状态'
						},
						]
					}]

				};
				pieChart.setOption(option);
				window.onresize = pieChart.resize; //想要实现自适应添加上的语句
			}
			
			/**
			 * 雷达图
			 */
			 function echat_radar(data){
				var radarChart = echarts.init(document.getElementById("radar-a"));
				//雷达图区域填充值
				var echat_data=[];
				//雷达最大值
				var echat_count=0;
				if(data != null){
					//定义标签列
					var indicatorArray = ['模型标签', '事实标签', '手工标签', '预测标签'];
					var dataMap = {};
					for(var i=0,len=data.length;i<len;i++){
						dataMap[data[i].DICTIONARYNAME] = data[i].NUM_;
						echat_count+=data[i].NUM_;
					}
					//获取标签对应的数据
					$.each(indicatorArray,function(n, value){
						 echat_data.push(dataMap[value]?dataMap[value]:0);
					});
					
					//当echat_count为0时,让雷达图区域填充值和最大值不重合
					if(echat_count == 0){
						echat_count=10
					}
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
							radius: 100, //雷达图形大小
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
							indicator:  [{
									name: '模型标签',
									  max: echat_count
								},
								{
									name: '事实标签',
									 max: echat_count
								},
								{
									name: '手工标签',
									 max: echat_count
								},
								{
									name: '预测标签',
									 max: echat_count
								}
							 ] 
						},
						series: [{
							name: '企业标签分布',
							type: 'radar',
						/* 	radius: ["10%", "10%"], */
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
								/*  emphasis: {                    // 鼠标移入高亮时的样式
								     lineStyle: {
								         width: 1
								     },
								     opacity: 1
								 } */
							},
	
							areaStyle: {
								normal: {
									opacity: 0.5,
									color: 'rgba(255, 204, 0, 1)',
								}
							}, //雷达图区域填充颜色
							data: [{
									value: /* [10, 20, 30, 40] */echat_data,
									name: '标签分布（Label Distribution ）'
								}
	
							]
						}]
					};
					// 使用刚指定的配置项和数据显示图表。  
					radarChart.setOption(radaroption);
					window.onresize = radarChart.resize; //想要实现自适应添加上的语句
				}
			}
				//获取企业分布
				function getEnterDistribution(entity_code){
					$.ajax({
						type:"GET",
						url:"${ctx}/home/homepage_enterDistribution.vm?entity_code="+entity_code,
						dataType:"json",
						success:function(data){
							 echat_radar(data); 
						},
						error:function(msg){
						}
					})			
				}
				//获取标签使用频率
				function getTagFrequency(entityCode,period){
					if(entityCode == undefined){
						entityCode="";
					}
					//时期默认本周
					if(period == undefined){
						period=1;
						$(".time-list>span[text='1']").addClass("blue").siblings().removeClass("blue");
					}
					$.ajax({
						type:"GET",
						url:"${ctx}/home/homepage_TagFrequency.vm?entityCode="+entityCode+"&period="+period,
						dataType:"json",
						success:function(data){
							
							var content="<li class='blue'><span class='fl ranking-a' style='font-size:12px;width:46px'>排名</span><span class='label-name' style='font-size:12px;width:180px'>标签名称</span><span class='usage fr' style='font-size:12px;width:auto;padding-right:20px'>使用频率 (次)</span></li>";
							if(data.length == 0){
								content+="<li class='blue' style='font-size:14px;text-align:center;margin-top:10px'><span style='color:white'>暂无数据</span></li>"
							}
							for(var i=0,len=data.length;i<len;i++){
								if(i == 10){
									break;
								}
								switch(i)
								{
								case 0:
									content+="<li><span class='fl ranking red-g bold' style='width:46px'><img  src='${ctx }/tag/home/img/images/01_19.png' /></span>"
								  break;
								case 1:
									content+="<li><span class='fl ranking cheng  bold' style='width:46px'><img  src='${ctx }/tag/home/img/images/01_22.png' /></span>"
								  break;
								case 2:
									content+="<li><span class='fl ranking tuh  bold' style='width:46px'><img  src='${ctx }/tag/home/img/images/01_24.png' /></span>"
								   break;
								default:
									content+="<li><span class='fl ranking-b' style='font-size:12px;width:46px;text-indent:20px'>"+(i+1)+"</span>"
								}
								content+="<span class='label-name' style='font-size:12px;width:180px' title='"+data[i].tagName+"'>"+data[i].tagName+"</span><span class='usage fr' style='font-size:12px;width:auto;padding-right:20px'>"+data[i].visitCount+"</span></li>"
							}
							 $("#rank").html(content); 
						},
						error:function(msg){
						}
					})		
				}
				//初始化企业分布
				function getInitializeDistribution(){
					$("#list").find(".nav-list").each(function(){
						if($(this).is('.on')){
							getEnterDistribution($(this).attr("id"));
						}
					})
				}
				//初始化排名
				function getInitializeRank(value){
					$("#list").find(".nav-list").each(function(){
						if($(this).is('.on')){
							getTagFrequency($(this).attr("id"),value);
						}
					})
				}
				
				//设置背景颜色
				function setDivHeight(){
					$("#tagDescribe").height(document.body.clientHeight - 315);
					var height=$("#tagDescribe").height()-$("#list ul").height();
					$("#backBlock").height(height);
				}
				
				//设置标签实体字数
				function setFontNumber(){
					$("#list ul li div p:first-child span:first-child").each(function(){
						if($(this).text().length>12){
							$(this).attr("title",$(this).text());
							$(this).text($(this).text().substring(0,12)+"...");
						}
					})
				}
			
		</script>    	
	</body>
</html>