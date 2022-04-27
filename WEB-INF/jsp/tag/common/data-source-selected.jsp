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
			radioType: "all",
			chkStyle: "radio"
		},
		data: {
			simpleData: {
				enable: true
			}
		}
	};
	$.ajax({
		type : "POST",
		url : "${ctx}/tag-common/datasourceZtreeStr.vm",
		dataType : "text",
		success : function(treeJson) {
			$.fn.zTree.init($("#directoryTree"), setting, eval('('+treeJson+')'));
			//回显已选节点
			var treeObj = $.fn.zTree.getZTreeObj("directoryTree");
			var dicCodeId = '${queryMap.dicCodeId}';
			var dicNameId = '${queryMap.dicNameId}';
			var selectedIds = $('#'+dicCodeId,window.parent.document).val();
			if(selectedIds != ''){
				var idArray = selectedIds.split(",");
				for(var i = 0;i < idArray.length;i++){
					var node = treeObj.getNodesByParam("id", idArray[i], null);
					if(node != null && node.length > 0){
						treeObj.checkNode(node[0], true, true);
					}
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
	         content: '请选择数据源！',
	         wraperstyle:'alert-info',
	         ok: function () {}
	     }).showModal();
		return;
	}
	var result = ['',''];
	for(var i = 0;i < nodes.length;i++){
		result[0] = result[0] + nodes[i].id;
		result[1] = result[1] + nodes[i].name;
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
		closeMyWindow();
	}
}

function closeMyWindow(){
	if(window.parent){
		window.parent.closeDialog('datasource-select-window');
	} else {
		window.close();
	}
}
</script>
</head>

<body style="overflow: hidden;">
<ul id="directoryTree" class="ztree" style="overflow-x: auto;overflow-y:auto;height: 420px;">

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