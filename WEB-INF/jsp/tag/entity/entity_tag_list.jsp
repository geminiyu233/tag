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
        th
        {
        	white-space: nowrap!important;
        }    
        #entity-data td
        {
        	white-space: nowrap!important;
        	overflow: hidden;
			text-overflow:ellipsis;
			max-width: 300px;
        }
        em{
        	color: red;
        	font-style: normal;
        }
    </style>
		    <style>
					table {
						width: 100%;
						table-layout: fixed;
					}
					table tr {
						width: 100%;
						height: 30px;
					}
					td {
						white-space: nowrap;
						overflow: hidden;
						text-overflow: ellipsis;
					}
					.td-info {
						display: none;
						position: absolute;
						z-index: 9999999;
						transition: left 0.4s cubic-bezier(0.23, 1, 0.32, 1) 0s,
							top 0.4s cubic-bezier(0.23, 1, 0.32, 1) 0s;
						padding: 5px 0 8px 0;
						border: 0;
					}
					.td-info .arrow {
						position: absolute;
						width: 0;
						height: 0;
						border-color: transparent;
						border-style: solid;
						bottom: 3px;
						border-width: 5px 5px 0;
						border-top-color: rgba(70, 76, 91, 0.9);
						left: 50%;
						margin-left: -5px;
					}
					.td-info .text {
						max-width: 500px;
						min-height: 34px;
						padding: 7px 12px;
						color: #fff;
						text-align: left;
						text-decoration: none;
						background-color: rgba(70, 76, 91, 0.9);
						border-radius: 4px;
						box-shadow: 0 1px 6px rgb(0 0 0 / 20%);
						white-space: wrap;
						box-sizing: border-box;
						font-size: 12px;
					}
					.list-text {
			display:flex;
			align-items:center;
			font-size:16px;
			color:#1b7ad9;
			line-height:32px;
			font-weight:700
		}
		.list-icon-left {
			display:inline-block;
			width:17px;
			height:18px;
			background:url('../../assets/blue/images/title-left.png') no-repeat;
			background-size: 100% 100%;
			margin-right:10px;
		}
		.list-icon-right {
			display:inline-block;
			width:27px;
			height:15px;
			background:url('../../assets/blue/images/title-right.png') no-repeat;
			background-size: 100% 100%;
			margin-left:7px
		}
				</style>
</head>

<body class="no-skin">

    <div class="main-container" id="main-container">
        <div class="main-content">
            <c:if test="${!empty THS_JDP_RES_DESC}"> 
	            <div class="main-content-inner fixed-page-header fixed-40">
	                <div id="breadcrumbs" class="breadcrumbs">
	                    <ul class="breadcrumb">
	                        <li class="active">
	                        	<i class="fa fa-arrow-right"></i>
	                        	<span class="THS_JDP_RES_DESC">
									${THS_JDP_RES_DESC}
								</span>
	                        </li>
	                    </ul><!-- /.breadcrumb -->
	                </div>
	            </div>
            </c:if>
            <div class="main-content-inner padding-page-content">
                <div class="page-content">
                    <div class="space-4"></div>
                    <div class="row">
                        <div class="col-xs-12">
                            <form class="form-horizontal" role="form" id="form" action="${ctx}/entity/tag/list.vm" method="post">
								<input type="hidden" name="TOPIC_CODE" value="${TOPIC_CODE }">
								<input type="hidden" name="readonly" value="${readonly }">
								<input type="hidden" name="noback" value="${noback }">
								<input type="hidden" name="hasGather" value="${hasGather }">
								
								<!-- MIS系统面包屑 -->
                            	<input type="hidden" name="THS_JDP_RES_DESC" value="${THS_JDP_RES_DESC}">
								<input type="hidden" name="THS_JDP_RES_ID" value="${THS_JDP_RES_ID}">
								<div class="module-layout">
<!-- 	                            <div class="high-search-btn-box" style="display:none;"> -->
<!-- 									<a class="high-search-btn">高级搜索<i class="fa fa-angle-down"></i><i class="fa fa-angle-up"></i></a> -->
<!-- 								</div>								 -->
                                <c:if test="${empty TOPIC_CODE}">
                                <div class="form-group">
	                                <label class="col-sm-2 hidden-xs control-label no-padding-right" for="txtName">
	                                    	所属实体
	                                </label>
                                    <div class="col-sm-3">
                                        <select class="form-control" id="ENTITY_ID" name="ENTITY_ID" onchange="changeEntity()">
                                        	<option value="" >--请选择--</option>
                                            <c:forEach var="e" items="${entityList }">
                                            	<c:choose>
                                            		<c:when test="${!empty hasGather && hasGather eq 'true' }">
                                            			<option value="${e.GENTITY_ID }" ${e.GENTITY_ID == ENTITY_ID ? 'selected' : '' }>${e.GENTITY_NAME }</option>
                                            		</c:when>
                                            		<c:otherwise>
                                            			<option value="${e.ENTITY_ID }" ${e.ENTITY_ID == ENTITY_ID ? 'selected' : '' }>${e.ENTITY_NAME }</option>
                                            		</c:otherwise>
                                            	</c:choose>
                                            </c:forEach>
                                        </select>

                                    </div>                                
                                    <label class="col-sm-1 hidden-xs control-label no-padding-right" for="txtName">
                                       	 关键字
                                    </label>
                                    <div class="col-sm-3">
                                        <input type="text"  autocomplete="off" class="form-control" placeholder="输入关键字" id="keyword" name="keyword" value="${keyword }"/>
                                    </div>

                                </div>                                
                                
                                </c:if>
                                 <c:if test="${not empty TOPIC_CODE}">
                                 <input type="hidden" name="ENTITY_ID" value="${ENTITY_ID }">
                                <div class="form-group">
                                    <label class="col-sm-2 hidden-xs control-label no-padding-right" for="txtName">
                                       	 关键字
                                    </label>
                                    <div class="col-sm-7">
                                        <input type="text"  autocomplete="off" class="form-control" placeholder="输入关键字" id="keyword" name="keyword" value="${keyword }"/>
                                    </div>

                                 
                                </div>
                                </c:if>
                                <div class="form-group">
                                        <label class="col-sm-2 hidden-xs control-label no-padding-right" for="txtName">
                                              	标签名称   
                                        </label>
                                        <div class="col-sm-3">
		                                    <div class="input-group" style="float:left;">
		                                        <input type="hidden" class="form-control"  id="tagCode" name="tagCode" value="${tagCode }" >
		                                        <input type="text" class="form-control"  id="tagName" name="tagName"  value="${tagName }" readonly="readonly">
		                                        <span class="input-group-btn">
		                                            <button type="button" class="btn btn-white btn-default" onclick="chooseTag('radio','tagCallBack','tagCode','tagName')">
		                                                <i class="ace-icon fa fa-search"></i>
		                                               	 选择
		                                            </button>
		                                            <button type="button" class="btn btn-white btn-clear" onclick="clearValue(this)">
		                                                <i class="ace-icon fa fa-remove"></i>
		                                            </button>
		                                        </span>
		                                    </div>
									</div>
									 <label class="col-sm-1 hidden-xs control-label no-padding-right" for="txtName">
                                       	 标签值
                                    </label>
									<div class="col-sm-3">
                                     <div class="input-group" style="float:left;">
                                        <input type="text"  class="form-control" readonly="readonly" placeholder="点击选择标签值" id="tagValueShow" name="tagValueShow" value="${tagValueShow }"  onclick="showMenu();">
                                        <input type="hidden" id="tagValue" name="tagValue" value="${tagValue }">
                                        <span class="input-group-btn">
		                                            <button type="button" class="btn btn-white btn-default" onclick="showMenu();">
		                                                <i class="ace-icon fa fa-search"></i>
		                                               	 选择
		                                            </button>                                        
                                            <button type="button" class="btn btn-white btn-clear" onclick="clearValue(this)">
                                                <i class="ace-icon fa fa-remove"></i>
                                            </button>
                                        </span>
                                    </div>
                                    </div>

                                    <div class="col-sm-3 align-right">
                                        <button type="button" class="btn btn-info btn-default-ths" id="btnSearch" onclick="doSearch(true)">
                                            <i class="ace-icon fa fa-search"></i>
                                            	搜索
                                        </button>

                                    </div>   
                                </div>
                                </div>
								<div class="module-layout">
									<div class="page-toolbar align-right list-toolbar" style="display:flex;justify-content:space-between""> 
										<div style="" class="list-text">
											<i class="list-icon-left"></i>列表<i class="list-icon-right"></i>
										</div>
										<div class="btn-group">
											<input type="hidden" class="form-control"  id="tagColCode" name="tagColCode" value="${tagColCode }" >
                                	<input type="hidden" class="form-control"  id="tagColName" name="tagColName" value="${tagColName }" >
                                    <button type="button" class="btn btn-xs btn-primary btn-xs-ths" id="btnChoose" onclick="chooseTag('checkbox','tagMutiCallBack','tagColCode','tagColName')">
                                        <i class="ace-icon fa fa-check"></i>
                                        	选择显示标签
                                    </button>
  									<c:if test="${empty noback}">
                                    <button type="button" class="btn btn-xs btn-danger btn-xs-ths" id="btnReturn" data-self-js="goBack()">
                                        <i class="ace-icon fa fa-reply"></i>
                                        	返回
                                    </button>
                                    </c:if>
										</div>
									 </div>  
                           
                                <div id="div_table" style="overflow-x: auto;overflow-y: hidden;">
                                <table id="simple-table" class="table table-bordered table-hover">
                                    <thead>
                                        <tr>
                                         <c:if test="${empty readonly && isAdmin}">
                                            <th class="center" style="width:90px">
                                                	手工标签
                                            </th>
                                         </c:if>
                                            <th class="align-center" width="80px" style="min-width: 80px;">序号</th>
                                            <c:forEach var="f" items="${fields}">
	                                            <th class="align-center" title='<c:out value="${f.FIELD_NAME }"></c:out>'>${f.FIELD_NAME }</th>
                                            </c:forEach>
											<c:if test="${selectTags == null }">
												<c:forEach var="t" items="${tags}">
													<th class="align-center tag-col ${t.tagCode }">${t.tagName }</th>
												</c:forEach>
											</c:if>
											<c:if test="${selectTags != null }">
												<c:forEach items="${selectTags }" var="t"  varStatus="stat">
													<th class="align-center tag-col ${t }">${fn:split(tagColName,',')[stat.index]}</th>
												</c:forEach>
											</c:if>
                                        </tr>
                                    </thead>

		                               <tbody id="entity-data">
												<c:if test="${pageInfo == null || pageInfo.total <= 0 }"><tr><td class="align-center" colspan="20">没有检索到相关数据！</td></tr></c:if>
												<c:forEach items="${pageInfo.list}" var="entity" varStatus="status">
													<tr>
													<c:if test="${empty readonly && isAdmin}">
														<td class="center">
														<label class="pos-rel"> 
															<a type="button" class="btn btn-sm btn-info btn-white btn-op-ths" title="编辑" data-self-js="editTag('${entity.id }')">
																<i class="ace-icon fa fa-tag"></i>编辑
															</a>
														</label>
														</td>
													</c:if>
														<td class="align-center"><span>${(pageInfo.pageNum - 1) * pageInfo.pageSize + status.index + 1}</span></td>
														<c:forEach var="f" items="${fields}">
															<c:set var="field_value"><c:out value="${entity[f.FIELD_CODE] }" /></c:set>
				                                            <td class="align-left"  title='<c:out value="${entity[f.FIELD_CODE] }"></c:out>'><span>${field_value eq "null"?"":field_value }</span></td>
			                                            </c:forEach>
			                                            <c:if test="${selectTags == null }">
				                                            <c:forEach var="t" items="${tags}">
					                                            <td class="align-left tag-col ${t.tagCode }" title='<c:out value="${entity[t.tagCode] }"></c:out>'><span>${entity[t.tagCode] }</span></td>
				                                            </c:forEach>			                                            
			                                            </c:if>
			                                            <c:if test="${selectTags != null }">
				                                            <c:forEach var="t" items="${selectTags}">
					                                            <td class="align-left tag-col ${t }" title='<c:out value="${entity[t] }"></c:out>'><span>${entity[t] }</span></td>
				                                            </c:forEach>			                                            
			                                            </c:if>
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
    
    <div id="menuContent" style="display:none; position: absolute;z-index: 9999;">
		<ul id="tagValueTree" class="ztree" style="margin-top:0; width:180px; height: 300px;overflow-x: auto;overflow-y:auto;z-index: 999;background-color: white;border: 1px solid #efefef;"></ul>
	</div>    
        
<%@ include file="/WEB-INF/jsp/_common/commonJS.jsp"%>
<link href="${ctx}/assets/components/supertable/superTables.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx}/assets/components/supertable/jFixed.min.js"></script>
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
		tagMutiCallBack($('#tagColCode').val().split(','),null,true)
	}
	/* <c:if test="${pageInfo.total > 0 }">
		var width = $("#div_table").width();
		var height = $("#div_table").height();
		$("#simple-table").jFixedtable({fixedCols: 3,width: width,height: height });
		$("#div_table").find("table").addClass("table table-bordered table-hover");
	</c:if> */

});


//返回
function goBack() {
    $("#main-container",window.parent.document).show();
    $("#iframeInfo",window.parent.document).attr("src","").hide();
}

function changeEntity(){
	$('#tagCode').val('');
	$('#tagName').val('');
	$('#tagValueShow').val('');
	$('#tagColCode').val('');
	$('#tagColName').val('');
	$('#tagValue').val('');
	doSearch(true);
}

//搜索
function doSearch() {
	if (typeof (arguments[0]) != "undefined" && arguments[0] == true)
		$("#pageNum").val(1);
	$("#orderBy").closest("form").submit();
}

function editTag(entityDocId){
	dialog({
		id:"tag-edit-window",
        title: '手工标签维护',
        url: '${ctx}/entity/tag/edit.vm?ENTITY_ID=${ENTITY_ID}&id='+entityDocId+"&topicCode=${topicCode}",
        width:600,
        height:460,
    }).showModal();
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
function tagCallBack(ids,names){
	loadTagValueList(ids[0]);
	$("#tagValueShow").val('');
	$("#tagValue").val('');
}	

//选择父节点Dialog回调函数
function tagMutiCallBack(ids,names,notLoadPage){
	$('.tag-col').hide();
	for(var i = 0;i < ids.length;i++){
		$('.'+ids[i]).show();
	}
	if(typeof notLoadPage == 'undefined'){
		doSearch(true);
	}
}	

//清除已选择的数据
function clearValue(btn){	
	$(btn).parents('.input-group').find('input').val('');
	$(btn).parents('.form-group').find('li').remove();
}

//关闭dialog
function closeDialog(id){
	dialog.get(id).close().remove();
}	

//加载标签值域
function loadTagValueList(tagCode){
	checkVals = new Array();
	if(tagCode == null || tagCode == ''){
		return;
	}
	$.ajax({
	   type: "GET",
	   url: "${ctx}/ws/tag/range.vm?tagCode="+tagCode,
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
				   nodes.push({id:'root',pId:null,name:$('#tagName').val(),open:true,chkDisabled:false});
				   for(var i = 0;i < result.length;i++){
					   nodes.push({id:result[i].value,pId:'root',name:result[i].alias});
				   }
				   $.fn.zTree.init($("#tagValueTree"), setting, nodes);
			   }
		   } else {
			   var nodes = new Array();
			   nodes.push({id:'root',pId:null,name:'标签值域加载失败！',open:false,chkDisabled:true});
			   $.fn.zTree.init($("#tagValueTree"), setting, nodes);
// 		   		dialog({
// 		 	        title: '提示',
// 		 	        content: "当前选择的标签值域为空或配置错误，请检查标签的值域配置！",
// 		 	        wraperstyle:'alert-info',
// 		 	        ok: function () {}
// 		 	    }).showModal();
		   }
	   },error: function(){
		   var nodes = new Array();
		   nodes.push({id:'root',pId:null,name:'标签值域加载失败！',open:false,chkDisabled:true});
		   $.fn.zTree.init($("#tagValueTree"), setting, nodes);
// 		   dialog({
// 	 	        title: '提示',
// 	 	        content: '标签值加载失败，请联系管理员检查标签配置！',
// 	 	        wraperstyle:'alert-info',
// 	 	        ok: function () {}
// 	 	    }).showModal();
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
		var zTreeObj = $.fn.zTree.getZTreeObj("tagValueTree");
		zTreeObj.checkNode(treeNode, !treeNode.checked, null, true);
		return false;
	}
	

	function onCheck(e, treeId, treeNode) {
		var zTreeObj = $.fn.zTree.getZTreeObj("tagValueTree"),
		nodes = zTreeObj.getCheckedNodes(true),
		allName = "",
		allValue = "";
		for (var i=0, l=nodes.length; i<l; i++) {
			if(nodes[i].id == 'root'){
				continue;
			}
			allName += nodes[i].name + ",";
			allValue += nodes[i].id + "$";
		}
		if (allName.length > 0 ) allName = allName.substring(0, allName.length-1);
		if (allValue.length > 0 ) allValue = allValue.substring(0, allValue.length-1);
		$("#tagValueShow").val(allName);
		$("#tagValue").val(allValue);
	}

	function showMenu() {
		var cityObj = $("#tagValueShow");
		var cityOffset = $("#tagValueShow").offset();
		$("#menuContent").css("left",cityOffset.left + "px");
		$("#menuContent").css("top",(cityOffset.top + cityObj.outerHeight()) + "px");
		$("#tagValueTree").css("width",cityObj.outerWidth() + "px");
		$("#menuContent").slideDown("fast");
		var zTreeObj = $.fn.zTree.getZTreeObj("tagValueTree");
		//已选中值
		var checkVals = $("#tagValue").val().split('$');
		if($("#tagValue").val() != '' && checkVals.length > 0){
			var node = null;
			for(var i=0;i<checkVals.length; i++){
				node = zTreeObj.getNodesByParam("id", checkVals[i], null);
				if(node != null && node.length > 0){
					zTreeObj.checkNode(node[0], true, true);
				}
			}
		} else if(zTreeObj != null){
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

</script>
</body>
<script src="../jquery.min.js"></script>
<script>
	$(document).ready(function(){
		var template = "<div class='td-info'><div class='arrow'></div><div class='text'></div></div>";
		$("body").append(template);
		var tdInfo = $(".td-info");
		var tdDom = $("td");
		tdDom.hover(function (e) {
			var spanWidth = $(this).find('span').width();
			var domWidth = $(this).width();
			if (spanWidth > domWidth) {
					tdInfo.find('.text').text($(this).text());
					tdInfo.css({
						left: $(this).offset().left,
						top: $(this).offset().top - tdInfo.height() - 10,
						display: 'block'
					});
			}
		});
		tdDom.mouseleave(function() {
			tdInfo.hide();
		});
	})
</script>
</html>
