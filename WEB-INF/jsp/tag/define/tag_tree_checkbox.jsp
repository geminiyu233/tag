<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/jsp/_common/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh">
<head>
    <title></title>
	<%@ include file="/WEB-INF/jsp/_common/commonCSS.jsp"%>
  	<!--页面自定义的CSS，请放在这里 -->
    <!-- page plugin css -->
    <!--zTree-->
    <link rel="stylesheet" href="${ctx}/assets/components/zTree/css/metroStyle/metroStyle.css"/>
    
    <style type="text/css">    
		.ztree li span.button.ico_open,.ztree li span.button.ico_close,.ztree li span.button.ico_docu,
		.ztree li span.button.group_ico_open,
		.ztree li span.button.group_ico_close,
		.ztree li span.button.group_ico_docu,
		.ztree li span.button.tag_ico_open,
		.ztree li span.button.tag_ico_close,
		.ztree li span.button.tag_ico_docu
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
		
		.ztree li span.button.ico_open:after,
		.ztree li span.button.ico_close:after,
		.ztree li span.button.ico_docu:after
		{
			content: "  \f114";
		}
		.ztree li span.button.group_ico_open:after,
		.ztree li span.button.group_ico_close:after,
		.ztree li span.button.group_ico_docu:after
		{
			content: "  \f114";
		}
		.ztree li span.button.tag_ico_open:after,
		.ztree li span.button.tag_ico_close:after,
		.ztree li span.button.tag_ico_docu:after
		{
			content: "  \f02b";
		}
		
    </style>
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

<%@ include file="/WEB-INF/jsp/_common/commonJS.jsp"%>
<!--zTree-->
<script src="${ctx}/assets/components/zTree/js/jquery.ztree.all.min.js"></script>
<script src="${ctx}/assets/components/zTree/js/jquery.ztree.exhide.min.js"></script>
<script src="${ctx }/assets/components/zTree/js/fuzzysearch.js"></script>
<!-- 自己写的JS，请放在这里 -->
<script type="text/javascript">
	function refreshData(catalogid){
		
	}
	
	jQuery(function ($) {
		//zTree
		var setting = {
			check: {
				enable: true,
				${checkType == 'checkbox' ? '' : 'radioType: "all",'}
				chkStyle: "${checkType == 'checkbox' ? 'checkbox' : 'radio'}"
			},
			data: {
				simpleData: {
					enable: true
				}
			}
		};

		var data = eval(${treeJsonData});
		console.log(data);
		//如果是单选，设置只有tag可以选择
		if('${checkType}' == 'radio'){
			for(var i = 0;i < data.length;i++){
				if(data[i].iconSkin != 'tag'){
					data[i].chkDisabled = true;
				}
			}
		}
		$.fn.zTree.init($("#directoryTree"), setting, data);
		fuzzySearch('directoryTree','#key',null,true); //初始化模糊搜索方法
		//回显已选节点
		var treeObj = $.fn.zTree.getZTreeObj("directoryTree");
		var dicCodeId = '${dicCodeId}';
		var dicNameId = '${dicNameId}';
		var selectedIds = $('#'+dicCodeId,window.parent.document).val();
		if(selectedIds && selectedIds != ''){
			var idArray = selectedIds.split(",");
			for(var i = 0;i < idArray.length;i++){
				var node = treeObj.getNodesByParam("tagCode", idArray[i], null);
				if(node != null && node.length > 0){
					treeObj.checkNode(node[0], true, true);
				}
			}
		}
	
	});
	
	
	function selectCatalog(){
		var treeObj = $.fn.zTree.getZTreeObj("directoryTree");
		var nodes = treeObj.getCheckedNodes(true);
		if(nodes.length == 0){
		 	dialog({
		         title: '提示',
		         width: '300px',
		         content: '请选择标签！',
		         wraperstyle:'alert-info',
		         ok: function () {}
		     }).showModal();
			return;
		}
		var result = ['',''];
		var codes = new Array();
		var names = new Array();
		for(var i = 0;i < nodes.length;i++){
			if(nodes[i].iconSkin == 'tag'){
				result[0] = result[0] + nodes[i].tagCode;
				result[1] = result[1] + getNoHighLightName(nodes[i].name);
				codes.push(nodes[i].tagCode);
				names.push(nodes[i].name);
				if(i != nodes.length - 1){
					result[0] = result[0] + ',';
					result[1] = result[1] + ',';
				}
			}
		}
		if(codes.length == 0){
		 	dialog({
		         title: '提示',
		         width: '300px',
		         content: '请选择标签！',
		         wraperstyle:'alert-info',
		         ok: function () {}
		     }).showModal();
			return;
		}		
		var dicCodeId = '${dicCodeId}';
		var dicNameId = '${dicNameId}';
		if(dicCodeId != '' && window.parent){
			$('#'+dicNameId,window.parent.document).val(result[1]);
			$('#'+dicCodeId,window.parent.document).val(result[0]);
		}
		//调用回调函数
		if('${callback}' != '' && '${callback}' != 'undefined'){
			window.parent.${callback}(codes,names);
		}
		closeMyWindow();
	}
	
	function closeMyWindow(){
		if(window.parent){
			window.parent.closeDialog('tag-select-window');
		} else {
			window.close();
		}
	}
</script>
</body>
</html>
