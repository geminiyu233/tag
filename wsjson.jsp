<%@page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/_common/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh">
<head>
<title>标签接口</title>
<meta name="renderer" content="webkit">
<%@ include file="/WEB-INF/jsp/_common/commonCSS.jsp"%>

<style>
	 pre {outline: 1px solid #ccc; padding: 5px; margin: 5px; }
	 .string { color: green; }
	 .number { color: darkorange; }
	 .boolean { color: blue; }
	 .null { color: magenta; }
	 .key { color: red; }
</style>


<script type="text/javascript">
	function test(wsUrl) {
		var pageSize='${param.pageSize}';
		if(pageSize==''){
			pageSize=100;
		}
		$.ajax({
			type : 'POST',
			url : wsUrl,
			dataType : "json",
			data:{"pageSize":pageSize,"ENTITY_CODE":"tag_yyssgdm_1622451385555"
				,"sourcefields":"POINT_CODE,POINT_NAME,LONGITUDE,LATITUDE,C3BE380B58DB5967E0538500A8C00303,C3BE380B58D75967E0538500A8C00303"
				,"REGION_CODE":"520000000000"
				//,"keyword":"巨野华元"
				},
			success : function(data) {
				showGeoJsonTxt(data);
			},
			error : function(e) {
				console.log(e);
			}
		});
	}
	function test2(wsUrl) {
		$.ajax({
			type : 'POST',
			url : wsUrl,
			dataType : "json",
			data:{"ENTITY_CODE":"tag_wry_1544595182754"
				//,"57591AE78FDFAED51301D675434C4534":"371724000000"
				//,"keyword":"巨野华元"
				,"countfields":"LATITUDE,CODE_REGION,ENTERNAME,CE6F181616B921FDBA6BE0D8B0DDBF41"
				},
			success : function(data) {
				showGeoJsonTxt(data);
			},
			error : function(e) {
				console.log(e);
			}
		});
	}
	function test3(wsUrl) {
		var pageSize='${param.pageSize}';
		if(pageSize==''){
			pageSize=100;
		}
		$.ajax({
			type : 'POST',
			url : wsUrl,
			dataType : "json",
			data:{"pageSize":pageSize,"ENTITY_CODE":"tag_cs_1573700210086"
				,"sourcefields":"STANDENTERID,REGION_CODE,ENTER_NAME"
				,"distance":"1100km","locationField":"location","pointValue":"[110.28702, 39.41219]"
				,"gisType":"geo_distance"
				//,"keyword":"巨野华元"
			},
			success : function(data) {
				showGeoJsonTxt(data);
			},
			error : function(e) {
				console.log(e);
			}
		});
	}
	function test4(wsUrl) {
		var pageSize='${param.pageSize}';
		if(pageSize==''){
			pageSize=100;
		}
		$.ajax({
			type : 'POST',
			url : wsUrl,
			dataType : "json",
			// data:{"pageSize":pageSize,"ENTITY_CODE":"tag_cs_1573700210086"
			// 	,"sourcefields":"STANDENTERID,REGION_CODE,ENTER_NAME,location"
			// 	,"locationField":"location","pointValue":"[{\"lat\":33.109278,\"lon\":97.70180},{\"lat\":40.7646,\"lon\":114.919},{\"lat\":40.7646,\"lon\":114.919}]"
			// 	,"gisType":"geo_polygon"
			// },
			data:{"pageSize":pageSize,"ENTITY_CODE":"tag_cs_1573700210086"
				,"sourcefields":"STANDENTERID,REGION_CODE,ENTER_NAME,location"
				,"REGION_CODE":"150121000000"
				,"locationField":"location"
				,"pointValue":"[[111.59638, 40.79327],[107.41485, 40.8013],[111.73887, 40.5257]]"
				,"gisType":"geo_polygon"
			},
			success : function(data) {
				showGeoJsonTxt(data);
			},
			error : function(e) {
				console.log(e);
			}
		});
	}

	function test5(wsUrl) {
		var pageSize='${param.pageSize}';
		if(pageSize==''){
			pageSize=100;
		}
		$.ajax({
			type : 'POST',
			url : wsUrl,
			dataType : "json",
			data:{"pageSize":pageSize,"ENTITY_CODE":"tag_cs_1573700210086"
				,"sourcefields":"STANDENTERID,REGION_CODE,ENTER_NAME,location"
				,"locationField":"location"
				,"pointValue":"{\"top\" : 40.73,\"left\" : -74.1,\"bottom\" : 40.01,\"right\" : -71.12}"
				,"gisType":"geo_bounding_box"
			},
			success : function(data) {
				showGeoJsonTxt(data);
			},
			error : function(e) {
				console.log(e);
			}
		});
	}


	function test6(wsUrl) {
		$.ajax({
			type : 'POST',
			url : wsUrl,
			dataType : "json",
			data:{"ENTITY_CODE":"tag_yztgdy_1615269827902"
				,"groupFields":"REGION_CODE_12,REGION_NAME"
				,"groupSize":"100"
			},
			success : function(data) {
				showGeoJsonTxt(data);
			},
			error : function(e) {
				console.log(e);
			}
		});
	}
	
	function showGeoJsonTxt(json){
		$('#progressBarParent').hide();
		$('#socket').hide();
		$('#content').show();
		$('#content').html(JsonFormat(json));
	}
	function showGeoTxt(data){
		$('#progressBarParent').hide();
		$('#socket').hide();
		$('#content').show();
		$('#content').html(data);
	}
	 
	function JsonFormat(json) {
		if (typeof json != 'string') {
			json = JSON.stringify(json, undefined, 2);
		}
			json = json.replace(/&/g, '&').replace(/</g, '<').replace(/>/g, '>');
			return json.replace(/("(\\u[a-zA-Z0-9]{4}|\\[^u]|[^\\"])*"(\s*:)?|\b(true|false|null)\b|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?)/g, function (match) {
				 var cls = 'number';
				 	if (/^"/.test(match)) {
				 			if (/:$/.test(match)) {
				 				cls = 'key';
				 			} else {
				 				cls = 'string';
				 			}
				 	} else if (/true|false/.test(match)) {
				 		cls = 'boolean';
				 	} else if (/null/.test(match)) {
				 		cls = 'null';
				 	}
				 	return '<span class="' + cls + '">' + match + '</span>';
			 });
	}
	jQuery(function($){
		//$('#btn01').click();
		$('#progressBarParent').hide();
		$('#socket').hide();
		$('#content').show();
		ths.initSocket('execJob',listLog);
	});


</script>
</head>
<!-- 自己写的JS，请放在这里 -->

<body>
	<div>
	<button id="btn01" onclick="test('${ctx}/ws/entity/searchEntityData.vm')">实体标签数据接口</button>
	<button id="btn02" onclick="test2('${ctx}/ws/entity/searchEntityFieldValueCount.vm')">实体标签数据接口</button>

	<button id="btn02" onclick="test6('${ctx}/ws/entity/searchEntityCountByGroupFields.vm')">实体标签分组统计数量-多字段数据接口</button>
	<button id="btn03" onclick="test3('${ctx}/ws/entity/searchEntityData.vm')">实体gis点</button>
	<button id="btn04" onclick="test4('${ctx}/ws/entity/searchEntityData.vm')">实体gis多边形</button>
	<button id="btn05" onclick="test5('${ctx}/ws/entity/searchEntityData.vm')">实体gis矩形</button>
	</div>
	<div>
	<button id="btn07" onclick="evictAll('${ctx}/ws/cache/evictAll')">清理缓存</button>
		实体编码：<input type="text" name="entityId" id="entityId" placeholder="单实体执行需要输入"/>
	<button id="btn06" onclick="test7('${ctx}/ws/api/ws-job/execAllJobs')">一次性执行所有实体、标签和汇聚实体任务</button>
	</div>
	<span style="color: red; font: 20px;"></span>
	<!-- 进度条 -->
	<div id="progressBarParent" class="progress" style="display:none; width: 500px; margin-top: 30px;margin-left: 15px; margin-right: 15px;">
		<div id="progressBar" class="progress-bar" style="width: 0%;">0%</div>
	</div>
	<pre id="content" type="display:none;"></pre>
	<pre id="socket" style="display:none;"></pre>
	<%@ include file="/WEB-INF/jsp/_common/commonJS.jsp"%>
	<%@ include file="/common/socket/socket_client.jsp"%>
<script>

	function evictAll(wsUrl) {
		$.ajax({
			type : 'GET',
			url : wsUrl,
			dataType : "text",
			success : function(data) {
				showGeoTxt(data);
			},
			error : function(e) {
				console.log(e);
			}
		});
	}
let isRun = false;
	function test7(wsUrl) {
		let entityId = $("#entityId").val();
		if(entityId){
			wsUrl = wsUrl+'?entityId='+entityId;
		}
		$('#progressBarParent').show();
		$('#socket').show();
		$('#content').hide();
		if(!isRun){
			isRun = true;
			$('#socket').text('');
		}else{
			return ;
		}
		$.ajax({
			type : 'POST',
			url : wsUrl,
			dataType : "json",
			success : function(data) {
			},
			error : function(e) {
				console.log(e);
			}
		});
	}
	function listLog(socketMap){
		let data = JSON.parse(socketMap);
		// 接收服务端的实时日志并添加到HTML页面中
		$("#progressBar").css("width",data.per + "%").html(data.per +"%");
		if(data.data!==''){
			$('#socket').append(data.data + "<p> </p>");
		}
		if(data.per==100){
			isRun = false;
			$('#progressBarParent').hide();
		}
	}
</script>
</body>
</html>
