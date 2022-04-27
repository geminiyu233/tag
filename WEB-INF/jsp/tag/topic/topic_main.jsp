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
    <link rel="stylesheet" href="${ctx}/assets/components/jquery-ui/jquery-ui.css"/>
    
    <style type="text/css">
    	 .widget-box{
            margin: 0px !important;
            margin-top: -3px !important;
        }
        .tab-content {
            border: none !important;
        }
        .widget-box.transparent > .widget-header {
             border-bottom: 1px solid #C5D0DC !important;
         }
        .widget-box.transparent > .widget-header {
            border-bottom: 1px solid #C5D0DC !important;
        }
        .widget-box.transparent > .widget-body{
            border-right: 1px solid #C5D0DC !important;
        }
        .tab-content{
            padding: 1px 1px !important;
        }

		        
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
        <input type="hidden" id="topicCode" name="topicCode" value="${topicCode }"/>
        <input type="hidden" id="managerNode" name="managerNode" value="${managerNode }"/>
                <div style="padding-top: 5px">
                    <div class="col-xs-12 no-padding">
                       <div class="col-xs-2 categorytree no-padding">
                           <div class="widget-box transparent">
                               
							  <div class="widget-header">
                                   <div class="widget-title no-padding" >
                                   		<span style="margin-left: 5px;">主题树</span>
                                   </div>
                                   <!-- <div class="widget-toolbar no-border">
                                    	<a href="#" data-action="reload" id="refreshTree"> <i class="ace-icon fa fa-refresh"></i></a>
                                   </div> -->
                               </div>
                               <div id="divTreeWidget" class="widget-body" style="margin-right: -1px;overflow: auto">
                                   <div class="widget-main padding-2">
                                       <ul id="treeTagNavi" class="ztree no-padding"></ul>
                                   </div>
                               </div>
                           </div>

                       </div>
                        <div class="col-xs-10 tabable no-padding">
                            <ul id="myTab" class="nav nav-tabs ">
                            	<li id="li-currentInfo">
                                    <a href="#currentInfo" data-toggle="tab">
                                        <i class=" ace-icon fa fa-file-o  bigger-120"></i>
                                       		节点信息</a>
                                </li>
                                <li id="li-tag">
                                    <a href="#tag" data-toggle="tab">
                                        <i class=" ace-icon fa fa-tag bigger-120"></i>
                                        	下级标签</a>
                                </li>

                            </ul>

                            <div id="tab-content" class="tab-content" >
                            	<div class="tab-pane" id="currentInfo">
                                    <iframe id="iframeCurrent" class="frmContent" data-origintagsrc="${ctx}/define/tag/edit.vm" src="${ctx}/define/tag/edit.vm?managerNode=${managerNode}" style="border: none" frameborder="0" width="100%"></iframe>
                                </div>
                                <div class="tab-pane in active" id="tag">
                                    <iframe id="iframeTag" class="frmContent" data-originsrc="${ctx}/topic/tag/list.vm" src="${ctx}/topic/tag/list.vm?topicCode=${topicCode}&managerNode=${managerNode}" style="border: none" frameborder="0" width="100%" ></iframe>
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
<script src="${ctx}/assets/components/jquery-ui/jquery-ui.js"></script>
<!-- 自己写的JS，请放在这里 -->
<script type="text/javascript">
	function resizeIframe() {
		var browser = navigator.appName;
		var height = document.documentElement.clientHeight;
		if (browser == "Microsoft Internet Explorer"){
			var trim_Version = navigator.appVersion.split(";")[1].replace(/[ ]/g, "");
			if(trim_Version == "MSIE6.0" || trim_Version == "MSIE7.0") {
				//不支持此IE版本，请升级浏览器
			}
		} else {
			height -= document.getElementById('tab-content').offsetTop;
		}
	
	    height -= 15;//边框的高度之和
	    /* whatever you set your body bottom margin/padding to be */
	    document.getElementById('iframeTag').style.height = height + "px";
	    document.getElementById('iframeCurrent').style.height = height + "px";
	    document.getElementById('divTreeWidget').style.height = height + "px";
	    
	
	}
	
	document.getElementById('iframeTag').onload = resizeIframe;
	window.onresize = resizeIframe;
	
	var zTreeObj;
	var zTreeSetting={
			data: {
				simpleData: {
					enable: true
				}
			},
			callback: {
				onClick: treeNodeClick
			},
			view: {
	            addDiyDom: addDiyDom
	        } 
		};
	//显示子节点数目
	function addDiyDom(treeId, treeNode){
	var count;
	/*判断是不是父节点,是的话找出子节点个数，加一是为了给新增节点*/
	if(treeNode.isParent) {
	count = treeNode.children.length ;
	} else {
	/*如果不是父节点,说明没有子节点,设置为1*/
	count = 0;
	}
	var aObj = $("#" + treeNode.tId + "_span");
			if(count>0){
	        	var editStr = "<span id='repairtypelist_" +treeNode.tId+ "_count' >("+count+")</span>";
				aObj.after(editStr);
			}
	}
	//当前节点ID
	var cNodeId="root";
	//当前节点类型
	var cNodeType = "group";
	var topicCode = $('#topicCode').val();
	var managerNode = $('#managerNode').val();
	//初始化标签树
	function initTree(zNodes)
	{
		//console.log(zNodes);
		//获得标签树目前选中的节点
		var nodes = null;
		var ztree = $.fn.zTree.getZTreeObj("treeTagNavi");
		if(ztree != null){
			nodes = ztree.getSelectedNodes();
			//console.log(nodes);
		}else{
			//重新初始化标签树
			zTreeObj = $.fn.zTree.init($("#treeTagNavi"), zTreeSetting, zNodes);
			if(zTreeObj != null){
				nodes = zTreeObj.getNodes();
			}
			//如果重新初始化前没有选中任何节点，则默认选中根节点
			if(nodes != null && nodes.length > 0){
				var node = zTreeObj.getNodeByParam("id", nodes[0].id)
				if(node != null && zTreeObj.getNodeIndex(node) != -1){
					zTreeObj.selectNode(node);
					treeNodeClick(null, node.id, node);
					return;
				}
			}
		}
	}
	function reLoadTree(){
		$.ajax({
			cache:false,
			url : "${ctx}/topic/treeJsonp.vm",
    		data : {"topicCode": topicCode},
    		dataType:'jsonp',
    		jsonp:"jsonpCallback",
			success : function(result) {
				var zNodes = result;
				//获得标签树目前选中的节点
				var nodes = null;
				var ztree = $.fn.zTree.getZTreeObj("treeTagNavi");
				if(ztree != null){
					nodes = ztree.getSelectedNodes();
					//console.log(nodes);
				}
				//重新初始化标签树
				zTreeObj = $.fn.zTree.init($("#treeTagNavi"), zTreeSetting, zNodes);
				//如果重新初始化前没有选中任何节点，则默认选中根节点
				if(nodes != null && nodes.length > 0){
					var node = zTreeObj.getNodeByParam("id", nodes[0].id)
					if(node != null && zTreeObj.getNodeIndex(node) != -1){
						zTreeObj.selectNode(node);
						return;
					}
				}
			},
			error : function(e) {
				console.log(e);
			}
		});	
	}
	//节点点击事件
	function treeNodeClick(event, treeId, treeNode)
	{
		cNodeId = treeNode.id;
		pkid = cNodeId;
		cNodeType = treeNode.iconSkin;
		//控制哪个TAB显示
		if(treeNode.iconSkin == "tag")
		{
			cNodeId=treeNode.tagId;
			$("#li-currentInfo").show();
			if(treeNode.pId==null){
				$("#li-tag").show();
			}else{
				$("#li-tag").hide();
			}
			
			$('#myTab a[href="#currentInfo"]').tab('show')
		}else{
			$("#li-currentInfo").hide();
			$("#li-tag").show();
			$('#myTab a[href="#tag"]').tab('show')
		}
		//控制当前展示的TAB下的Iframe的src地址
		$("#tab-content > div").each(function(i){
			if(!$(this).is(':hidden'))
			{
				$(this).find("iframe").attr("src",$(this).find("iframe").data("origin" + ($(this).attr("id") == "currentInfo"?cNodeType:"") + "src") + "?id="+cNodeId+"&type=" +cNodeType +"&pkid=" +pkid+"&topicCode=" +  topicCode +  "&managerNode="+managerNode);
			}
		});
	}
	
	
	function loadTree(){
		$.ajax({
			cache:false,
			url : "${ctx}/topic/treeJsonp.vm",
    		data : {"topicCode": topicCode},
    		dataType:'jsonp',
    		jsonp:"jsonpCallback",
    		success : function(data) {
    			initTree(data);
    		},
    		error : function(e) {
    			console.log(e);
    		}
		});
	}	
	
	jQuery(function ($) {
	    $(document).ready(function() {
	    	//加载目录树
	    	loadTree();

	    });
	    
	    /** 调整左树的宽度  **/
		$(".categorytree")._resizable({
			 minWidth: 200,
			 maxWidth: 500
		});

	});
</script>
</body>
</html>
