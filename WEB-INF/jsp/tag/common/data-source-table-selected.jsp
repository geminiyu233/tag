<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/_common/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh">
	<head>
		<title>公共树</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<!-- CSS 公共文件 -->
		<%@ include file="/WEB-INF/jsp/_common/commonCSS.jsp"%>

		<link type="text/css" href="${ctx}/assets/components/zTree/css/zTreeStyle/zTreeStyle.css" rel="stylesheet">
		<link type="text/css" href="${ctx}/assets/components/zTree/css/metroStyle/metroStyle.css" rel="stylesheet"/>
		
		<!--页面自定义的CSS，请放在这里 -->
		<style type="text/css">
			.widget-box {
				margin: 0px !important;
				margin-top: -3px !important;
			}
			
			.tab-content {
				border: none !important;
			}
			
			.widget-box.transparent>.widget-header {
				border-bottom: 1px solid #C5D0DC !important;
			}
			
			.widget-box.transparent>.widget-header {
				border-bottom: 1px solid #C5D0DC !important;
			}
			
			.ztree li span.button.chk.checkbox_false_part {background-position: -5px -5px !important;}
			.ztree li span.button.chk.checkbox_false_part_focus {background-position: -5px -26px !important;}
			.ztree li span.button.chk.checkbox_true_part {background-position: -26px -5px !important;}
			.ztree li span.button.chk.checkbox_true_part_focus {background-position: -26px -26px !important;}
			
			.ztree li span.button.org_ico_open,
			.ztree li span.button.org_ico_close,
			.ztree li span.button.org_ico_docu,
			.ztree li span.button.ico_open,
			.ztree li span.button.ico_close,
			.ztree li span.button.ico_docu
				{
				background-image: none !important;
				*background-image: none !important;
			}
			
			.ztree li span.button:after,.ztree li span.button:after,.ztree li span.button:after
				{
				width: 1.25em;
				margin-top:3px;
				text-align: center;
				display: inline-block;
				font: normal normal normal 14px/1 FontAwesome;
				font-size: 15px;
				text-rendering: auto;
				-webkit-font-smoothing: antialiased;
				-moz-osx-font-smoothing: grayscale;
			}
			
			.ztree li span.button.org_ico_open:after,.ztree li span.button.org_ico_close:after,.ztree li span.button.org_ico_docu:after
				{
				content: "  \f0e8";
			}
			
			.ztree li span.button.ico_close:after,.ztree li span.button.ico_docu:after
				{
				content: "  \f114";
			}
			
			.ztree li span.button.ico_open:after {
				content: "  \f115";
			}
			#loadding_div{
			    position: fixed;
			    width: 100%;
			    height: 26px;
			    top:40%;
			    text-align: center;
			    z-index: 999999;
			}
		</style>
	</head>

	<!-- 内容部分 -->
	<body class="no-skin" style="overflow-x: auto;">
		<div class="main-container" id="main-container">
		    <div class="main-content">
		        <div class="main-content-inner padding-page-content">
					<div class="col-xs-12 " style="padding: 5px 5px 0px;position: fixed;z-index: 999;background: #fff; display: none;" id="query_div">
						<div class="widget-box transparent">
							<div class="widget-header" style="padding: 5px;min-height:26px;">
								<label class="pos-rel" style="width: 100%;margin-bottom:0px;">
									<span class="lbl grey">关键字</span>
									<input type="text"  style="height: 26px;width: 100px;" id="keyword" name="keyword" value="${keyword}" />
									<input id="ztree_query_search" type="button" class="btn btn-xs btn-info btn-xs-ths"  style="min-width:27px; height: 26px;vertical-align:top;" value="搜索">
									<input type="button" type="button" class="btn btn-xs btn-primary btn-xs-ths"  style="min-width:27px; height: 26px; float:right;"  onclick="saveSub();" value="确认" class="submit" />
								</label>
							</div>
						</div>
					</div>
					<div class="col-xs-12 " style="padding: 39px 5px 0px;">
						<ul id="tree_ul" class="ztree" style="display: none;"></ul>
					</div>
					<div id="loadding_div">
						<i id="loading" class="ace-icon fa fa-spinner fa-spin orange bigger-200"></i>
						<span>正在载入，请稍候……</span>
					</div>
					
				</div>
			</div>
		</div>
		
		<!-- JS 公共文件 -->
		<%@ include file="/WEB-INF/jsp/_common/commonJS.jsp"%>
		<!--zTree-->
		<script src="${ctx}/assets/components/zTree/js/jquery.ztree.all.min.js" type="text/javascript"></script>
		<script src="${ctx}/assets/components/zTree/js/jquery.ztree.exhide.min.js" type="text/javascript"></script>
		<script src="${ctx}/assets/components/zTree/js/fuzzysearch.js" type="text/javascript"></script>
	
		<!-- 自己写的JS，请放在这里 -->
		<script type="text/javascript">
			var zTreeObj;
			var serverNodeArray=[];//服务器端返回的节点数组
			var setting = {
				check : {
					enable: true,
					chkStyle: "radio",
					radioType: "all",
					autoCheckTrigger : true
				},
				data : {
					simpleData : {
						enable : true
					}
				},
				async: {
					enable: true,
					url: "${ctx}/tag-common/getDataSourceTable.vm",
					autoParam:["id"],
					otherParam:{"pkid":"${queryMap.pkid}"},
					dataFilter: datafilter
				},
				view : {
					showTitle : false
				}
			};
			
			//异步加载树时的数据过滤
			function datafilter(treeId, parentNode, childNodes){
				if (!childNodes) return null;
				var zNodes = [];
				for (var i=0; i<childNodes.length; i++) {
					zNodes[i] = childNodes[i];
				}
				return zNodes;
			}
			
			$(document).ready(function() {
				loadTreeAjax();
				
			});
			
			//Ajax 请求tree
			function loadTreeAjax(){
				var dicCodeId = '${queryMap.dicCodeId}';
				var selectedIds = $('#'+dicCodeId,window.parent.document).val();
				$("#tree_ul").hide();
				$("#loadding_div").show();
				$("#query_div").hide();
				 $.ajax({  
					type : "POST",
					url : "${ctx}/tag-common/getDataSourceSchema.vm",
			        cache: false,  
			        data : {"pkid":"${queryMap.pkid}", "tablename":selectedIds},
					dataType : "json", 
			        success:function(treeJson) { 
						if(treeJson && treeJson.Status=="500"){
							treeJson = eval('([{name:"暂无数据！",chkDisabled:true}])');
						}
			        	zTreeObj = $.fn.zTree.init($("#tree_ul"), setting, treeJson);
						// 返显节点
						if(selectedIds != ''){
							var idArray = selectedIds.split(",");
							for(var i = 0;i < idArray.length;i++){
								var node = zTreeObj.getNodesByParam("id", idArray[i], null);
								if(node != null && node.length > 0){
									zTreeObj.checkNode(node[0], true, true);
									zTreeObj.expandNode(node[0].getParentNode(), true, true);
								}
							}
						}
						fuzzySearch('tree_ul','#keyword',null,false);
						$("#tree_ul").show();
						$("#loadding_div").hide();
						$("#query_div").show();
			         },  
			         error : function(msg) {  
			        	 console.log(msg);
			         }  
			    });
			}
			
			function saveSub(){
				var nodes = zTreeObj.getCheckedNodes(true);
				if(nodes.length == 0){
				 	dialog({
				         title: '提示',
				         content: '请选择相关数据！',
				         wraperstyle:'alert-info',
				         width:320
				     }).showModal();
					return;
				}
				var result = ['',''];
				for(var i = 0;i < nodes.length;i++){
					result[0] = result[0] + nodes[i].id;

					var tname = nodes[i].name;
					var schema = result[0].split(".")[0];
					if(schema!=''){
						tname = schema+"."+tname;
					}
					result[1] = result[1] + tname;
					if(i != nodes.length - 1){
						result[0] = result[0] + ',';
						result[1] = result[1] + ',';
					}
				}
				var tablename = '${queryMap.dicNameId}';
				var tablecode = '${queryMap.dicCodeId}';
				if(tablename != '' && window.parent){
					$('#'+tablename, parent.document).val(result[0]);
					resultname = result[1].replace(new RegExp('<span style="color: whitesmoke;background-color: #6ce26c;">','g'),'').replace(new RegExp('</span>','g'),'');
					//如果名称字段也存在
					if($('#'+tablename, parent.document).length == 1){
						$('#'+tablename, parent.document).val(resultname);
						$('#'+tablecode, parent.document).val(result[0]);
					}
					closeMyWindow();
				}
			}
			
			function closeMyWindow(){
				if(window.parent){
					parent.closeDialog('datasource-table-select-window');
				} else {
					window.close();
				}
			}
		</script>
		
	</body>
</html>