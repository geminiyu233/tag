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

jQuery(function ($) {
	
	//加载标签值域
	$.ajax({
	   type: "GET",
	   url: "${ctx}/ws/tag/range.vm?tagCode=${tagCode}",
	   dataType: "json",
	   success: function(result){
		   console.log(result);
		   var nodes = new Array();
		   if(result && result.length > 0){
			   if(result.length == 1 && result[0].alias == 'service-url' && result[0].value != null && result[0].value != ''){
				   //服务接口类标签
					$.ajax({
						type : "GET",
						url : result[0].value,
						dataType : "json",
						success : function(treeJson) {
							$.fn.zTree.init($("#tagValueTree"), setting, treeJson);
						}

					});
			   } else {
				   //动态sql、静态数组标签
				   nodes.push({id:'root',pId:null,name:'标签定义值域范围',open:true,chkDisabled:true});
				   for(var i = 0;i < result.length;i++){
					   nodes.push({id:result[i].value,pId:'root',name:result[i].value});
				   }
				   $.fn.zTree.init($("#tagValueTree"), setting, nodes);
			   }
		   } else {
		   		dialog({
		 	        title: '提示',
		 	        content: "当前选择的标签值域为空或配置错误，请检查标签的值域配置！",
		 	        wraperstyle:'alert-info',
		 	        ok: function () {}
		 	    }).showModal();
		   }
	   },error: function(){
		   var nodes = new Array();
		   nodes.push({id:'root',pId:null,name:'标签值加载失败！',open:false,chkDisabled:true});
		   $.fn.zTree.init($("#tagValueTree"), setting, nodes);
		   dialog({
	 	        title: '提示',
	 	        content: '标签值加载失败，请联系管理员检查标签配置！',
	 	        wraperstyle:'alert-info',
	 	        ok: function () {}
	 	    }).showModal();
	   }
	});

	var setting = {
			check: {
				enable: true,
				chkboxType: {"Y":"", "N":""}
			},
			view: {
				dblClickExpand: false
			},
			data: {
				simpleData: {
					enable: true
				}
			}
		};

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
		window.parent.closeDialog('tag-range-window');
	} else {
		window.close();
	}
}
</script>
</head>

<body style="overflow: hidden;">
<ul id="tagValueTree" class="ztree" style="overflow-x: auto;overflow-y:auto;height: 420px;">

</ul>

					<div style="text-align:center;margin-top: 10px;">
<!-- 		                <button type="button" class="btn btn-xs btn-primary btn-xs-ths" id="btnSave" onclick="selectCatalog()"> -->
<!-- 		                    <i class="ace-icon fa fa-check"></i>确定 -->
<!-- 		                </button> -->
		                <button type="button" class="btn btn-xs btn-danger btn-xs-ths" id="btnReturn" onclick="closeMyWindow()">
			                <i class="ace-icon fa fa-close"></i>关闭
			            </button>
					</div>
</body>
</html>