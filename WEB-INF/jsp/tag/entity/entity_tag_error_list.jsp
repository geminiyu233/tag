<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/jsp/_common/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh">
<head>
    <title></title>
	<%@ include file="/WEB-INF/jsp/_common/commonCSS.jsp"%>
	<!--zTree-->
	<link rel="stylesheet" href="${ctx}/assets/components/zTree/css/metroStyle/metroStyle.css" type="text/css">
	<script src="${ctx}/assets/components/zTree/js/jquery.ztree.all.min.js"></script>	
  	<!--页面自定义的CSS，请放在这里 -->
    <style type="text/css">
        td,th
        {
        	white-space: nowrap!important;
        	overflow: hidden;
			text-overflow:ellipsis;
        }
        em{
        	color: red;
        	font-style: normal;
        }
    </style>
</head>

<body class="no-skin">

    <div class="main-container" id="main-container">
        <div class="main-content">
            <div class="main-content-inner fixed-page-header fixed-40">
                <div id="breadcrumbs" class="breadcrumbs">
                    <ul class="breadcrumb">
                        <li class="active"><i class="fa fa-arrow-right"></i> ${entity.ENTITY_NAME }<i class="fa fa-caret-right"></i>${tagName }</li>
                    </ul><!-- /.breadcrumb -->

                </div>
            </div>
            <div class="main-content-inner padding-page-content">
                <div class="page-content">
                    <div class="space-4"></div>
                    <div class="row">
                        <div class="col-xs-12">
                            <form class="form-horizontal" role="form" id="form" action="${ctx}/entity/tag/error/list.vm?ENTITY_ID=${ENTITY_ID }" method="post">
								<input type="hidden" name="TOPIC_CODE" value="${TOPIC_CODE }">
								<%@ include file="/WEB-INF/jsp/_common/commonArgs.jsp"%>
								<div class="module-layout">								
                                <div class="form-group">
                                    <label class="col-sm-1 hidden-xs control-label no-padding-right" for="txtName">
                                       	 关键字
                                    </label>
                                    <div class="col-sm-2">
                                        <input type="text"  autocomplete="off" class="form-control" placeholder="输入关键字" id="keyword" name="keyword" value="${keyword }"/>
                                    </div>
                                  
                                        <label class="col-sm-1 hidden-xs control-label no-padding-right" for="txtName">
                                              	非值域范围
                                        </label>
									<div class="col-sm-3">
                                     <div class="input-group" style="float:left;">
                                        <input type="hidden"   id="tagCode" name="tagCode" value="${tagCode }" >
                                        <input type="hidden"   id="tagName" name="tagName"  value="${tagName }" >
                                        <input type="hidden" id="tagValueNo" name="tagValueNo" value="${tagValueNo }">
                                        <input type="text"  class="form-control" readonly="readonly" placeholder="点击选择非值域范围标签值" id="tagValueShowNo" name="tagValueShowNo" value="${tagValueShowNo }"  onclick="showMenu('No');">
                                        <span class="input-group-btn">
                                            <button type="button" class="btn btn-white btn-clear" onclick="clearValue('No')">
                                                <i class="ace-icon fa fa-remove"></i>
                                            </button>
                                        </span>
                                     </div>
                                    </div>
                                    
                                        <label class="col-sm-1 hidden-xs control-label no-padding-right" for="txtName">
                                              	值域范围
                                        </label>
									<div class="col-sm-3">
                                     <div class="input-group" style="float:left;">
                                        <input type="text"  class="form-control" readonly="readonly" placeholder="点击选择值域范围标签值" id="tagValueShowYes" name="tagValueShowYes" value="${tagValueShowYes }"  onclick="showMenu('Yes');">
                                        <input type="hidden" id="tagValueYes" name="tagValueYes" value="${tagValueYes }">
                                        <span class="input-group-btn">
                                            <button type="button" class="btn btn-white btn-clear" onclick="clearValue('Yes')">
                                                <i class="ace-icon fa fa-remove"></i>
                                            </button>
                                        </span>
                                    </div>
                                    </div>


                                    <div class="col-sm-1 col-xs-1 align-right" >
                                        <button type="button" class="btn btn-info btn-default-ths" id="btnSearch" onclick="doSearch(true)">
                                            <i class="ace-icon fa fa-search"></i>
                                            	搜索
                                        </button>

                                    </div>
                                </div>
                                </div>
                                
							<div class="module-layout">
                                <div class="page-toolbar align-right list-toolbar">
                                	<input type="hidden" class="form-control"  id="tagColCode" name="tagColCode" value="${tagColCode }" >
                                	<input type="hidden" class="form-control"  id="tagColName" name="tagColName" value="${tagColName }" >
<!--                                     <button type="button" class="btn btn-xs btn-primary btn-xs-ths" id="btnChoose" onclick="chooseTag('checkbox','tagMutiCallBack','tagColCode','tagColName')"> -->
<!--                                         <i class="ace-icon fa fa-check"></i> -->
<!--                                         	选择显示标签 -->
<!--                                     </button> -->

                                    <button type="button" class="btn btn-xs btn-danger btn-xs-ths" id="btnReturn" data-self-js="goBack()">
                                        <i class="ace-icon fa fa-reply"></i>
                                        	返回
                                    </button>
                                </div>
                                <div style="overflow-x: auto;overflow-y: hidden;">
                                <table id="simple-table" class="table  table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <th class="align-center" width="80px">序号</th>		
                                            <c:forEach var="f" items="${fields}">
	                                            <th class="align-center">${f.FIELD_NAME }</th>
                                            </c:forEach>
	                                            <th class="align-center tag-col ${tagCode }">${tagName }</th>
											
                                        </tr>
                                    </thead>

		                               <tbody>
												<c:if test="${pageInfo == null || pageInfo.total <= 0 }"><tr><td class="align-center" colspan="20">没有检索到相关数据！</td></tr></c:if>
												<c:forEach items="${pageInfo.list}" var="entity" varStatus="status">
													<tr>
														
														<td class="align-center">${(pageInfo.pageNum - 1) * pageInfo.pageSize + status.index + 1}</td>
														<c:forEach var="f" items="${fields}">
				                                            <td class="align-left">${entity[f.FIELD_CODE] }</td>
			                                            </c:forEach>
				                                            <td class="align-left tag-col ${tagCode }">${entity[tagCode] }</td>
													</tr>
												</c:forEach>
		                        </tbody>
		                    </table>
		                   </div>
				 			<%@ include file="/WEB-INF/jsp/_common/paging.jsp"%>
							</div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <!--/.main-content-inner-->
        </div><!-- /.main-content -->
    </div><!-- /.main-container -->
    
    <div id="menuContent" style="display:none; position: absolute;">
		<ul id="tagValueTreeNo" class="ztree" style="margin-top:0; width:180px; height: 300px;overflow-x: auto;overflow-y:auto;z-index: 999;background-color: white;border: 1px solid #efefef;"></ul>
		<ul id="tagValueTreeYes" class="ztree" style="margin-top:0; width:180px; height: 300px;overflow-x: auto;overflow-y:auto;z-index: 999;background-color: white;border: 1px solid #efefef;"></ul>
	</div>    
        
<%@ include file="/WEB-INF/jsp/_common/commonJS.jsp"%>

<!-- 自己写的JS，请放在这里 -->
<script type="text/javascript">
//设置iframe自动高
autoHeightIframe("iframeInfo");


jQuery(function($){
	//初始化表格的事件，如表头排序，列操作等
	__doInitTableEvent("listTable");
	//页面初始化
	loadTagValueList($('#tagCode').val());
	if($('#tagColCode').val() != ''){
		tagMutiCallBack($('#tagColCode').val().split(','),null)
	}

});



//返回
function goBack() {
    $("#main-container",window.parent.document).show();
    $("#iframeInfo",window.parent.document).attr("src","").hide();
}

//搜索
function doSearch() {
	if (typeof (arguments[0]) != "undefined" && arguments[0] == true)
		$("#pageNum").val(1);
	$("#orderBy").closest("form").submit();
}

function chooseTag(checkType,callback,dicCodeId,dicNameId){
	dialog({
		id:"tag-select-window",
        title: '选择标签',
        url: "${ctx}/define/tag/tree/checkbox.vm?STATUS=1&checkType="+checkType+"&ENTITY_ID=${ENTITY_ID}"+"&TOPIC_CODE=${TOPIC_CODE}"+"&callback="+callback+"&dicCodeId="+dicCodeId+"&dicNameId="+dicNameId,
        width:400,
        height:460,
    }).showModal();
}



//选择父节点Dialog回调函数
function tagMutiCallBack(ids,names){
	$('.tag-col').hide();
	for(var i = 0;i < ids.length;i++){
		$('.'+ids[i]).show();
	}
}	

//清除已选择的数据
function clearValue(valueType){	
	$('#tagValue'+valueType).val('');
	$('#tagValueShow'+valueType).val('');
}

//关闭dialog
function closeDialog(id){
	dialog.get(id).close().remove();
}	

//加载标签值域
function loadTagValueList(tagCode,loadType){
	if(tagCode == null || tagCode == ''){
		return;
	}
	//加载非值域范围
	$.ajax({
	   type: "GET",
	   url: "${ctx}/ws/tag/error/range.vm?tagCode=${tagCode}&entityCode=${entityCode}",
	   dataType: "json",
	   success: function(result){
		   //console.log(result);
		   var nodes = new Array();
		   if(result && result.length > 0){
			   if(result.length == 1 && result[0].alias == 'service-url' && result[0].value != null && result[0].value != ''){
				   //服务接口类标签
					$.ajax({
						type : "GET",
						url : result[0].value,
						dataType : "json",
						success : function(treeJson) {
							$.fn.zTree.init($("#tagValueTreeNo"), setting, treeJson);
						}

					});
			   } else {
				   //动态sql、静态数组标签
				   nodes.push({id:'root',pId:null,name:$('#tagName').val(),open:true,chkDisabled:false});
				   for(var i = 0;i < result.length;i++){
					   nodes.push({id:result[i].value,pId:'root',name:result[i].value});
				   }
				   $.fn.zTree.init($("#tagValueTreeNo"), setting, nodes);
			   }
		   } else {
// 		   		dialog({
// 		 	        title: '提示',
// 		 	        content: "当前选择的标签值域为空或配置错误，请检查标签的值域配置！",
// 		 	        wraperstyle:'alert-info',
// 		 	        ok: function () {}
// 		 	    }).showModal();
		   }
	   },error: function(){
		   var nodes = new Array();
		   nodes.push({id:'root',pId:null,name:'标签值加载失败！',open:false,chkDisabled:true});
		   $.fn.zTree.init($("#tagValueTreeNo"), setting, nodes);
// 		   dialog({
// 	 	        title: '提示',
// 	 	        content: '标签值加载失败，请联系管理员检查标签配置！',
// 	 	        wraperstyle:'alert-info',
// 	 	        ok: function () {}
// 	 	    }).showModal();
	   }
	});
	//加载值域范围
	$.ajax({
		   type: "GET",
		   url: "${ctx}/ws/tag/range.vm?tagCode=${tagCode}&entityCode=${entityCode}",
		   dataType: "json",
		   success: function(result){
			   //console.log(result);
			   var nodes = new Array();
			   if(result && result.length > 0){
				   if(result.length == 1 && result[0].alias == 'service-url' && result[0].value != null && result[0].value != ''){
					   //服务接口类标签
						$.ajax({
							type : "GET",
							url : result[0].value,
							dataType : "json",
							success : function(treeJson) {
								$.fn.zTree.init($("#tagValueTreeYes"), setting, treeJson);
							}

						});
				   } else {
					   //动态sql、静态数组标签
					   nodes.push({id:'root',pId:null,name:$('#tagName').val(),open:true,chkDisabled:false});
					   for(var i = 0;i < result.length;i++){
						   nodes.push({id:result[i].value,pId:'root',name:result[i].value});
					   }
					   $.fn.zTree.init($("#tagValueTreeYes"), setting, nodes);
				   }
			   } else {
// 			   		dialog({
// 			 	        title: '提示',
// 			 	        content: "当前选择的标签值域为空或配置错误，请检查标签的值域配置！",
// 			 	        wraperstyle:'alert-info',
// 			 	        ok: function () {}
// 			 	    }).showModal();
			   }
		   },error: function(){
			   var nodes = new Array();
			   nodes.push({id:'root',pId:null,name:'标签值加载失败！',open:false,chkDisabled:true});
			   $.fn.zTree.init($("#tagValueTreeYes"), setting, nodes);
// 			   dialog({
// 		 	        title: '提示',
// 		 	        content: '标签值加载失败，请联系管理员检查标签配置！',
// 		 	        wraperstyle:'alert-info',
// 		 	        ok: function () {}
// 		 	    }).showModal();
		   }
		});	
}

var setting = {
		check: {
			enable: true,
			chkboxType: {"Y":"ps", "N":"ps"}
		},
		view: {
			dblClickExpand: false
		},
		data: {
			simpleData: {
				enable: true
			}
		},
		callback: {
			beforeClick: beforeClick,
			onCheck: onCheck
		}
	};

	function beforeClick(treeId, treeNode) {
		var zTreeObj = $.fn.zTree.getZTreeObj("tagValueTree"+treeType);
		zTreeObj.checkNode(treeNode, !treeNode.checked, null, true);
		return false;
	}
	
	function onCheck(e, treeId, treeNode) {
		var zTreeObj = $.fn.zTree.getZTreeObj("tagValueTree"+treeType),
		nodes = zTreeObj.getCheckedNodes(true),
		allName = "",
		allValue = "";
		for (var i=0, l=nodes.length; i<l; i++) {
			if(nodes[i].id == 'root'){
				continue;
			}
			allName += nodes[i].name + ",";
			allValue += nodes[i].id + "###";
		}
		if (allName.length > 0 ) allName = allName.substring(0, allName.length-1);
		if (allValue.length > 0 ) allValue = allValue.substring(0, allValue.length-3);
		$("#tagValueShow"+treeType).val(allName);
		$("#tagValue"+treeType).val(allValue);
	}

	var treeType = 'Yes';
	function showMenu(valueType) {
		treeType = valueType;
		if(valueType == 'Yes'){
			$("#tagValueTreeYes").show();
			$("#tagValueTreeNo").hide();
			if($("#tagValueYes").val() == ''){
				$.fn.zTree.getZTreeObj("tagValueTreeYes").checkAllNodes(false);
			}
		} else {
			$("#tagValueTreeYes").hide();
			$("#tagValueTreeNo").show();
			if($("#tagValueNo").val() == ''){
				$.fn.zTree.getZTreeObj("tagValueTreeNo").checkAllNodes(false);
			}
		}
		
		var cityObj = $("#tagValueShow"+valueType);
		var cityOffset = $("#tagValueShow"+valueType).offset();
		$("#menuContent").css("left",cityOffset.left + "px");
		$("#menuContent").css("top",(cityOffset.top + cityObj.outerHeight()) + "px");
		$("#tagValueTree"+valueType).css("width",cityObj.outerWidth() + "px");
		$("#menuContent").slideDown("fast");
		var zTreeObj = $.fn.zTree.getZTreeObj("tagValueTree"+treeType);
		//已选中值
		var checkVals = $("#tagValue"+treeType).val().split('###');
		if($("#tagValue"+treeType).val() != '' && checkVals.length > 0){
			var node = null;
			for(var i=0;i<checkVals.length; i++){
				node = zTreeObj.getNodesByParam("id", checkVals[i], null);
				if(node != null && node.length > 0){
					zTreeObj.checkNode(node[0], true, true);
				}
			}
		} else {
			zTreeObj.checkAllNodes(false);
		}		
		$("body").bind("mousedown", onBodyDown);
	}
	function hideMenu() {
		$("#menuContent").fadeOut("fast");
		$("body").unbind("mousedown", onBodyDown);
	}
	function onBodyDown(event) {
		if (!(event.target.id == "menuBtn" || event.target.id == "tagValueShow" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length>0)) {
			hideMenu();
		}
	}

	function showTagRange(){
		dialog({
			id:"tag-range-window",
	        title: '标签值域查看',
	        url: '${ctx}/entity/tag/range.vm?tagCode=${tagCode}',
	        width:400,
	        height:460,
	       	cancel:function()
	       	{
	       	},
	       	cancelDisplay: false
	    }).showModal();
	}

</script>
</body>
</html>
