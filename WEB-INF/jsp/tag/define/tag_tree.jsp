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
    <link rel="stylesheet" href="${ctx}/assets//components/zTree/css/metroStyle/metroStyle.css"/>
    
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

<body class="no-skin">

    <div class="main-container" id="main-container">
        <div class="main-content">
             <div class="main-content-inner padding-page-content">
                <div style="padding-top: 5px">
                    <div class="col-xs-12  padding5">
                           <div class="widget-box transparent">
                               <div id="divTreeWidget" class="widget-body" style="margin-right: -1px;overflow: auto">
                                   <div class="widget-main padding-2" id="treeDiv" style="overflow-y:auto; width:345px;">
                                       <ul id="treeTag" class="ztree no-padding"></ul>
                                   </div>
                               </div>
                           </div>
                    </div>
                </div>
        </div><!--/.main-content-inner-->
            
        </div><!-- /.main-content -->
    </div><!-- /.main-container -->

<%@ include file="/WEB-INF/jsp/_common/commonJS.jsp"%>
<!--zTree-->
<script src="${ctx}/assets/components/zTree/js/jquery.ztree.all.min.js"></script>
<script src="${ctx}/assets/components/zTree/js/jquery.ztree.exhide.min.js"></script>
<!-- 自己写的JS，请放在这里 -->
<script type="text/javascript">
		var zTreeObj;
		var zTreeSetting={
				data: {
					simpleData: {
						enable: true
					}
				},
				callback: {
					onClick: treeNodeClick
				}
			};
		
		//初始化标签树
		function initTree(zNodes)
		{
			zTreeObj = $.fn.zTree.init($("#treeTag"), zTreeSetting, zNodes);

			var hideId = ths.getUrlParam("HIDE_ID");
			if(hideId != null){
				zTreeObj.hideNode(zTreeObj.getNodeByParam("id", hideId));
			}
		}
		
		//节点点击事件
		function treeNodeClick(event, treeId, treeNode)
		{
			var cNodeId = treeNode.id;
			var cNodeType = treeNode.iconSkin;
			var type = "${TYPE}";
			//设置节点全路径
			var path = "";
			var paths = treeNode.getPath().map(function(item){
				return item.name;
				});
			if(paths.length>0){
				path="/"+paths.join("/");
			}
			treeNode.path=path;
			// 仅响应指定节点类型的点击事件
			if(type == "" || cNodeType == type) {
				var callback = ths.getUrlParam("callback");
				callback = callback == null ? "treeCallBack" : callback;//没有默认为treeCallBack
				var closeCallback = ths.getUrlParam("closeCallback ");
				closeCallback = closeCallback == null ? "closeCallback" : closeCallback;//没有默认为closeTreeDialog
				//标签树点击节点回调
				eval("if(window.parent."+ callback  + "){window.parent."+ callback + "(treeNode);}");
				eval("if(window.parent."+ closeCallback + "){window.parent."+ closeCallback + "();}");
			}
		}
		
		jQuery(function ($) {
		    $(document).ready(function() {
		    	var zNodes = eval(${treeJsonData});
		    	initTree(zNodes);
		    });
		});
</script>
</body>
</html>
