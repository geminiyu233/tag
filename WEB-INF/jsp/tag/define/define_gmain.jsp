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
                <div style="padding-top: 5px">
                    <div class="col-xs-12 no-padding">
                       <div class="col-xs-2 categorytree no-padding">
                           <div class="widget-box transparent">
                               <div class="widget-header">
                                   <div class="widget-title no-padding" >
                                   		<span style="margin-left: 5px;">实体：</span>
                                        <select  id="entitySelect" style="width: 70%;position: absolute;top: 4px;left: 47px;">
                                                <c:forEach var="entity" items="${entityList }">
                                                	<option value="${entity.GENTITY_ID }" <c:if test="${entity.GENTITY_ID == entitySelect }">selected</c:if>>${entity.GENTITY_NAME }</option>
                                                </c:forEach>
                                         </select>
                                   </div>
                               </div>

                               <div id="divTreeWidget" class="widget-body" style="margin-right: -1px;overflow: auto">
                               		<div class="widget-box transparent">
										<div class="widget-header" style="padding: 5px;min-height:26px;">
											<label class="pos-rel" style="width: 100%;margin-bottom:0px;">
												<span>关键字：</span>
												<input type="text"  style="height: 26px;width: 130px;" id="keyword" name="keyword" value="${keyword}" />
											</label>
										</div>
									</div>
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
                                <li id="li-group">
                                    <a href="#group" data-toggle="tab">
                                        <i class=" ace-icon fa fa-folder-o bigger-120"></i>下级分组
                                    </a>
                                </li>
                                <li id="li-tag">
                                    <a href="#tag" data-toggle="tab">
                                        <i class=" ace-icon fa fa-tag bigger-120"></i>
                                        	下级标签</a>
                                </li>
                                <div style="float:right;margin-right:25px">
                                <c:if test="${not empty entitySelect}">
					                <button type="button" class="btn btn-xs btn-danger btn-xs-ths" id="btnReturn" data-self-js="goBack()">
					                    <i class="ace-icon fa fa-reply"></i>
					                   	 返回
					                </button>
					            </c:if>
                                </div>

                            </ul>

                            <div id="tab-content" class="tab-content" >
                                <div class="tab-pane" id="currentInfo">
                                    <iframe id="iframeCurrent" class="frmContent" data-origintagsrc="${ctx }/define/tag/edit.vm" data-origingroupsrc="${ctx }/define/group/edit.vm" src="${ctx }/define/tag/edit.vm?readonly=${readonly}" style="border: none" frameborder="0" width="100%"></iframe>
                                </div>
                                <div class="tab-pane  in active" id="group">
                                    <iframe id="iframeGroup" class="frmContent" data-originsrc="${ctx }/define/group/list.vm" src="${ctx }/define/group/list.vm?readonly=${readonly}&id=root&type=group" style="border: none" frameborder="0" width="100%"></iframe>
                                </div>
                                <div class="tab-pane" id="tag">
                                    <iframe id="iframeTag" class="frmContent" data-originsrc="${ctx }/define/tag/list.vm" src="${ctx }/define/tag/list.vm?readonly=${readonly}&id=root&type=group" style="border: none" frameborder="0" width="100%" ></iframe>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
        </div><!--/.main-content-inner-->
    </div><!-- /.main-content -->
</div><!-- /.main-container -->
        
<%@ include file="/WEB-INF/jsp/_common/commonJS.jsp"%>
<script src="${ctx}/assets/components/jquery-ui/jquery-ui.js"></script>
<!--zTree-->
<script src="${ctx}/assets/components/zTree/js/jquery.ztree.all.min.js"></script>
<script src="${ctx}/assets/components/zTree/js/fuzzysearch.js" type="text/javascript"></script>
<script src="${ctx}/assets/components/zTree/js/jquery.ztree.exhide.min.js" type="text/javascript"></script>
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
		height -= 11;//边框的高度之和
	    /* whatever you set your body bottom margin/padding to be */
	    document.getElementById('iframeCurrent').style.height = height + "px";
	    document.getElementById('iframeGroup').style.height = height + "px";
	    document.getElementById('iframeTag').style.height = height + "px";
	    document.getElementById('divTreeWidget').style.height = (height-$("div .widget-header").height()) + "px";
	
	}
	
	document.getElementById('iframeGroup').onload = resizeIframe;
	window.onresize = resizeIframe;
	
	var zTreeObj;
	var zTreeSetting={
			data: {
				simpleData: {
					enable: true
				},
		        key:{
		        	title:"titleAlias"
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
				var count = {"num":0};
	            countTagNum(count,treeNode);
				count=count.num;
	        } else {
	            /*如果不是父节点,说明没有子节点,设置为1*/
	            count = 0;
	        }
	        var aObj = $("#" + treeNode.tId + "_span");
			if(count>0){
	        	var editStr = "<span style='color:red;' id='repairtypelist_" +treeNode.tId+ "_count' >("+count+")</span>";
				aObj.after(editStr);
			}
	        
	    }
		//递归统计节点下标签数量
		function countTagNum(count,node){
			//debugger;
			 if(node.isParent && node.children.length > 0) {
				for(var i = 0;i < node.children.length;i++){
					if(node.children[i].iconSkin == "tag"){
						count.num = count.num + 1;
					}
					countTagNum(count,node.children[i]);
				}
			}
		}
	
	//当前节点ID
	var cNodeId="root";
	//当前节点类型
	var cNodeType = "group";
	
	//初始化标签树
	function initTree(zNodes)
	{
		//console.log(zNodes);
		//添加title
		for(var i = 0;i < zNodes.length;i++){
			zNodes[i].titleAlias = zNodes[i].name;
		}
		//获得标签树目前选中的节点
		var nodes = null;
		var ztree = $.fn.zTree.getZTreeObj("treeTagNavi");
		if(ztree != null){
			nodes = ztree.getSelectedNodes();
			//console.log(nodes);
		}
		//重新初始化标签树
		zTreeObj = $.fn.zTree.init($("#treeTagNavi"), zTreeSetting, zNodes);
		fuzzySearch('treeTagNavi','#keyword',true,true);
		//如果重新初始化前没有选中任何节点，则默认选中根节点
		if(nodes != null && nodes.length > 0){
			var node = zTreeObj.getNodeByParam("id", nodes[0].id)
			if(node != null && zTreeObj.getNodeIndex(node) != -1){
				zTreeObj.selectNode(node);
				treeNodeClick(null, node.id, node);
				return;
			}
		}
		//选中根节点
	    zTreeObj.selectNode(zTreeObj.getNodeByParam("id", "root"));
        treeNodeClick(null, "root", zTreeObj.getNodeByParam("id", "root"));
	}
	
	//节点点击事件
	function treeNodeClick(event, treeId, treeNode)
	{
		var ENTITY_ID = $('#entitySelect').val();
		cNodeId = treeNode.id;
		cNodeType = treeNode.iconSkin;
		//控制哪个TAB显示
		if(treeNode.id == "root")
		{
			$("#li-currentInfo").hide();
			$("#li-group").show();
			$("#li-tag").show();
			if (!$("#li-group").hasClass("active") && !$("#tag").hasClass("active")) {
                $('#myTab a[href="#tag"]').tab('show');
            }
		}
		else if(treeNode.iconSkin == "tag")
		{
			$("#li-currentInfo").show();
			$("#li-group").hide();
			$("#li-tag").hide();
			$('#myTab a[href="#currentInfo"]').tab('show')
		}
		else if(treeNode.iconSkin == "group")
		{
			$("#li-currentInfo").show();
			$("#li-group").show();
			$("#li-tag").show();
		}
		//控制当前展示的TAB下的Iframe的src地址
		$("#tab-content > div").each(function(i){
			if(!$(this).is(':hidden'))
			{
				$(this).find("iframe").attr("src",$(this).find("iframe").data("origin" + ($(this).attr("id") == "currentInfo"?cNodeType:"") + "src") + "?readonly=${readonly}&id=" +cNodeId +  "&type=" +cNodeType+  "&ENTITY_ID=" +ENTITY_ID );
			}
		});
	}
	
	function reLoadTree(){
		var ENTITY_ID = $('#entitySelect').val();
		$.ajax({
			cache:false,
			type : 'GET',
			url : '${ctx}/define/searchEntityTree.vm?ENTITY_ID='+ENTITY_ID,
			dataType : "JSON",
			success : function(result) {
				var zNodes = result;
				//添加title
				for(var i = 0;i < zNodes.length;i++){
					zNodes[i].titleAlias = zNodes[i].name;
				}
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
	
	function loadTree(){
		var ENTITY_ID = $('#entitySelect').val();
		$.ajax({
			cache:false,
			type : 'GET',
			url : '${ctx}/define/searchEntityTree.vm?ENTITY_ID='+ENTITY_ID,
			dataType : "JSON",
			success : function(result) {
				initTree(result);
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
            resizeIframe();
	    });
	    
	    $('#entitySelect').change(function(){
	    	//加载目录树
	    	loadTree();
	    });
	
	    //TAB切换事件，控制iframe的src
	    $('#myTab a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
	    	var ENTITY_ID = $('#entitySelect').val();
	    	//目标iframeID
	    	var targetFrame = "";
	    	//目标iframe src
	    	var frmSrc = "";
	        switch ($(e.target).attr('href'))
	        {
	            case "#currentInfo":
	            	targetFrame = "iframeCurrent";
	            	frmSrc = $("#iframeCurrent").data("origin" +cNodeType + "src") + "?readonly=${readonly}&id=" +cNodeId +  "&type=" +cNodeType+  "&ENTITY_ID=" +ENTITY_ID;
	            	break;
	            case "#group":
	            	targetFrame = "iframeGroup";
	            	frmSrc = $("#iframeGroup").data("originsrc") + "?readonly=${readonly}&id=" +cNodeId +  "&type=" +cNodeType+  "&ENTITY_ID=" +ENTITY_ID;
	                break;
	            case "#tag":
	            	targetFrame = "iframeTag";
	            	frmSrc = $("#iframeTag").data("originsrc") + "?readonly=${readonly}&id=" +cNodeId +  "&type=" +cNodeType+  "&ENTITY_ID=" +ENTITY_ID;
	                break;
	            default:
	                alert("无法识别的Tab href");
	            	return;
	                break;
	
	        }
	        //if($("#" + targetFrame).attr("src") != frmSrc){
	        	console.log(frmSrc);
	        	$("#" + targetFrame).attr("src",frmSrc );
	        //}
	    })
	    /** 调整左树的宽度  **/
		$(".categorytree")._resizable({
			 minWidth: 200,
			 maxWidth: 500
		});
	
	});
	//返回
	function goBack() {
	    $("#main-container",window.parent.document).show();
	    $("#iframeInfo",window.parent.document).attr("src","").hide();
	}
</script>
</body>
</html>
