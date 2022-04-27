<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/_common/taglib.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<title>角色选择</title>
<%@ include file="/WEB-INF/jsp/_common/commonCSS.jsp"%>
<%@ include file="/WEB-INF/jsp/_common/commonJS.jsp"%>
<!--zTree-->
<link rel="stylesheet" href="${ctx}/assets/components/zTree/css/metroStyle/metroStyle.css" type="text/css">
<script src="${ctx}/assets/components/zTree/js/jquery.ztree.all.min.js"></script>
<script src="${ctx }/assets/components/zTree/js/jquery.ztree.exhide.min.js"></script>
<script type="text/javascript" src="${ctx }/assets/components/zTree/js/fuzzysearch.js"></script>
<style type="text/css">
	*{margin:0;padding:0;}
	html{overflow:hidden;}
	#myGrid{overflow-y:auto;overflow-x:auto; }
</style>
<script>

function refreshData(catalogid){
	
}

jQuery(function ($) {
	
	//zTree
	var setting = {
		check: {
			enable: true,
			${checkType == 'checkbox' ? '' : 'radioType: "all",'}			
			chkStyle: "${queryMap.checkType == 'checkbox' ? 'checkbox' : 'radio'}"
		},
		data: {
			simpleData: {
				enable: true
			}
		}
	};

	var DATA_SQL = $('#DATA_SQL',window.parent.document).val();
	$.ajax({
		type : "POST",
		url : "${ctx}/tag-common/getDataSourceTableColumn.vm",
		data: {pkid:'${queryMap.pkid}',tablename:'${queryMap.tablename}',ENTITY_ID:'${queryMap.ENTITY_ID}',DATA_TYPE:'${queryMap.DATA_TYPE}',DATA_SQL:DATA_SQL},
		dataType : "text",
		success : function(treeJson) {
			var treeJson = eval('('+treeJson+')');
			if(treeJson && treeJson.Status=="500"){
				treeJson = eval('([{name:"暂无数据！",chkDisabled:true}])');
			}
			
			$.fn.zTree.init($("#directoryTree"), setting, treeJson);
			fuzzySearch('directoryTree','#key',null,true); //初始化模糊搜索方法
			//回显已选节点
			var treeObj = $.fn.zTree.getZTreeObj("directoryTree");
			var dicCodeId = '${queryMap.dicCodeId}';
			var dicNameId = '${queryMap.dicNameId}';
			var selectedIds = null;
			if($('#'+dicCodeId,window.parent.document).length == 0 ){
				var ids = $('input[name="'+dicCodeId+'"]',window.parent.document);
				if(ids){
					selectedIds = '';
					for(var i = 0;i < ids.length;i++){
						selectedIds = selectedIds + $(ids[i]).val() + ',';
					}
				}
			} else {
				selectedIds = $('#'+dicCodeId,window.parent.document).val();
			}
			if(selectedIds && selectedIds != ''){
				var idArray = selectedIds.split(",");
				for(var i = 0;i < idArray.length;i++){
					var node = treeObj.getNodesByParam("id", idArray[i], null);
					if(node != null && node.length > 0){
						treeObj.checkNode(node[0], true, true);
					}
				}
			}
			
			var noAllowChoseField = '${queryMap.noAllowChoseField}';
			var noAllowChoseValue = $('#' + noAllowChoseField,window.parent.document).val();
			if(noAllowChoseValue && noAllowChoseValue !=''){
				var node = treeObj.getNodeByParam("id", noAllowChoseValue, null);
				if(node){
					node.chkDisabled = true;
					treeObj.updateNode(node);
				}
			}
		}

	});
	


});


function selectCatalog(){
	var treeObj = $.fn.zTree.getZTreeObj("directoryTree");
	var nodes = treeObj.getCheckedNodes(true);
	if(nodes.length == 0){
	 	dialog({
	         title: '提示',
	         width: '300px',
	         content: '请选择数据表字段！',
	         wraperstyle:'alert-info',
	         ok: function () {}
	     }).showModal();
		return;
	}
	var result = ['',''];
	var codes = new Array();
	var names = new Array();
	for(var i = 0;i < nodes.length;i++){
		if(nodes[i].isParent){
			continue;
		}
		result[0] = result[0] + nodes[i].id;
		result[1] = result[1] + getNoHighLightName(nodes[i].name);
		codes.push(nodes[i].id);
		names.push(nodes[i].name);
		if(i != nodes.length - 1){
			result[0] = result[0] + ',';
			result[1] = result[1] + ',';
		}
	}
	var dicCodeId = '${queryMap.dicCodeId}';
	var dicNameId = '${queryMap.dicNameId}';
	if(dicCodeId != '' && window.parent){
		$('#'+dicNameId,window.parent.document).val(result[1]);
		$('#'+dicCodeId,window.parent.document).val(result[0]);
	}
	//调用回调函数
	if('${queryMap.callbackFun}' != '' && '${queryMap.callbackFun}' != 'undefined'){
		window.parent.${queryMap.callbackFun}(codes,names);
	}
	closeMyWindow();
}

function closeMyWindow(){
	if(window.parent){
		window.parent.closeDialog('datasource-table-column-select-window');
	} else {
		window.close();
	}
}
</script>
</head>

<body style="overflow: hidden;">
<ul style="margin-bottom:0px">搜索：<input type="text" id="key" value="" style="padding-bottom:0px"/></ul>
<ul id="directoryTree" class="ztree" style="overflow-x: auto;overflow-y:auto;height: 390px;">

</ul>

					<div style="text-align:center;margin-top: 10px;">
		                <button type="button" class="btn btn-xs btn-primary btn-xs-ths" id="btnSave" onclick="selectCatalog()">
		                    <i class="ace-icon fa fa-check"></i>确定
		                </button>
		                <button type="button" class="btn btn-xs btn-danger btn-xs-ths" id="btnReturn" onclick="closeMyWindow()">
			                <i class="ace-icon fa fa-close"></i>关闭
			            </button>
					</div>
</body>
</html>