<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/jsp/_common/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh">
<head>
    <title></title>
	<%@ include file="/WEB-INF/jsp/_common/commonCSS.jsp"%>  	
	<!-- page plugin css -->
    <!--zTree-->
    <link rel="stylesheet" href="${ctx}/assets/components/zTree/css/metroStyle/metroStyle.css"/>
  	<!--页面自定义的CSS，请放在这里 -->
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
	        <div class="main-content-inner fixed-page-header fixed-40">
	             <div id="breadcrumbs" class="breadcrumbs">
	                 <ul class="breadcrumb">
	                    <li class="active">
	                      	<i class="fa fa-arrow-right"></i>
	                      	<span class="THS_JDP_RES_DESC">
								${empty THS_JDP_RES_DESC?'主题编辑':THS_JDP_RES_DESC}
							</span>
	                    </li>
	                 </ul><!-- /.breadcrumb -->
	             </div>
	        </div>
        <div class="main-content-inner padding-page-content">
            <div class="page-content">
	            <div class="page-content-new">
					<div class="page-toolbar align-right form-group">
						 <p class="title" style="display:none;">${(empty readonly && isAdmin) ? (empty topic.TOPIC_ID ? '添加' : '编辑') : '查看'}</p>
						 		<c:if test="${empty readonly && isAdmin}">
				                  <button type="button" class="btn btn-save" id="btnSave" data-self-js="save()">
				                    <i class="ace-icon fa fa-save"></i>
				                   	 保存
				                </button>
				                </c:if>
				                <c:if test="${type == null }">
				                <button type="button" class="btn btn-info" id="btnReturn" data-self-js="goBack()">
				                    <i class="ace-icon fa fa-reply"></i>
				                   	 返回
				                </button>
				                </c:if>	
				     </div>	
                        <form class="form-horizontal" role="form" id="formInfo" action="index.html" method="post">
                            <div class="form-group">
                                <label class="col-sm-2 control-label no-padding-right no-padding-left" for="txtName">
                                    <i class="ace-icon fa fa-asterisk red smaller-70"></i>
                                	主题名称
                                </label>
                                <div class="col-sm-4">
                                        <input type="text" class="form-control"
                                               data-validation-engine="validate[required,maxLength[50]]" placeholder=""  
                                               name="TOPIC_NAME" value="${topic.TOPIC_NAME }" maxlength="25"/>
                                        <input type="hidden" name="TOPIC_ID" value="${topic.TOPIC_ID }">

                                </div>
                                <label class="col-sm-2 control-label no-padding-right" for="txtName">
                                    <i class="ace-icon fa fa-asterisk red smaller-70"></i>
                                        主题代码
                                    </label>
                                    <div class="col-sm-4">
                                    <c:if test='${ACTION != "EDIT"}'>
    									<div class="input-group">
                                            <input type="text" class="form-control" placeholder=""  data-validation-engine="validate[required,maxLength[50]]"  id="TOPIC_CODE" name="TOPIC_CODE" readonly="readonly" value="${topic.TOPIC_CODE }" maxlength="25">
                                        	 <span class="input-group-btn">
	                                        <button type="button" class="btn btn-white btn-default" id="btnUUID" >
	                                            	生成
	                                        </button>
	                                        </span>
                                        </div>
                                        </c:if>
                                        <c:if test='${ACTION == "EDIT"}'>
                                        <input type="text" class="form-control"  name="TOPIC_CODE" id="TOPIC_CODE" value="${topic.TOPIC_CODE }" readonly="readonly"/>
                                        </c:if>
                                    </div>
                                </div>
                                <div class="form-group">
                                <label class="col-sm-2 control-label no-padding-right">
                                        <i class="ace-icon fa fa-asterisk red smaller-70"> </i>
                                        标签实体</label>
                                <div class="col-sm-4">
                                        <select class="form-control"  id="ENTITY_ID" name="ENTITY_ID" data-validation-engine="validate[required]">
                                        		<option value="">--请选择--</option>
                                       			 <c:forEach var="entity" items="${entityList }">
                                                	<option value="${entity.ENTITY_ID }" >${entity.ENTITY_NAME }</option>
                                                </c:forEach>
                                            </select>
                                </div>
                                <label class="col-sm-2 control-label no-padding-right" for="txtBirthday"> 主题菜单  </label>
                            	<div class="col-sm-4">
                                    <div class="control-group">
                                   		<div class="input-group">
											<span class="width-100"> 
												<input type="text" class="form-control" id="MENUID" name="MENUID" value="${topic.MENUID }" data-validation-engine="validate[funcCall[checkMenuid]]" readonly="readonly" placeholder="请选主题菜单"/>
											</span> 
											<span class="input-group-btn">
												<button type="button" class="btn btn-white btn-default" onclick="openCheckMenuId('MENUID')">选择</button>
												<button type="button" class="btn btn-white btn-clear" onclick="_removeSingle('MENUID')"><i class="ace-icon fa fa-remove"></i></button>
											</span>
										</div>
									</div>
                            	</div>
                            </div>
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
									<div class="col-sm-3">
                                     <div class="input-group" style="float:left;">
                                        <input type="text"  class="form-control" readonly="readonly" placeholder="点击选择标签值" id="tagValueShow" name="tagValueShow" value="${tagValueShow }"  onclick="showMenu();">
                                        <input type="hidden" id="tagValue" name="tagValue" value="${tagValue }">
                                        <span class="input-group-btn">
                                            <button type="button" class="btn btn-white btn-clear" onclick="clearValue(this)">
                                                <i class="ace-icon fa fa-remove"></i>
                                            </button>
                                        </span>
                                    </div>
                                    </div>

                             </div>
                             <div class="form-group">
                             	<label class="col-sm-2 hidden-xs control-label no-padding-right" for="txtName"></label>
                             	<div class="col-sm-9">
                                 	<input type="hidden" id="hiddenTags" name="hiddenTags"> 
                              		<div class="chosen-container chosen-container-multi width-100" style="border: solid 1px #D5D5D5; min-height: 62px ">
                                        <ul class="chosen-choices" style="border: none" id="topictagUl"></ul>
                                    </div>
                                </div>
                              	<div class="col-sm-1">
                                    <div class="space-4 hidden-xs"></div>
                                    <button id="btnChooseDeptManagerX" type="button" class="btn btn-xs  btn-white btn-xs-ths" style="min-width: 60px" title="清空">
                                        <i class="ace-icon fa fa-trash"></i>
                                    </button>
                                </div>
                             </div>
                            <div class="form-group">
                            	<label class="col-sm-2 control-label no-padding-right" for="txtBirthday"> 状态 </label>
                             	<div class="col-sm-4">
                                    <div class="control-group">
                              			<div class="radio-inline">
                                    		<label>
                                         		<input name="STATUS" type="radio" class="ace" value="10" <c:if test="${topic.STATUS==10}">checked</c:if>>
                                           		<span class="lbl">发布</span>
                                    		</label>
                                		</div>
			    						<div class="radio-inline">
                                       		<label>
                                        		<input name="STATUS" type="radio" class="ace" value="0" <c:if test="${topic.STATUS==null || topic.STATUS == 0}">checked</c:if>>
                                       			<span class="lbl">草稿</span>
                                        	</label>
                                    	</div>
    								</div>
								</div>
                            </div>  
                            <div class="form-group">
                                <label class="col-sm-2 control-label no-padding-right"> 选择主题标签</label>
                                        <div class="col-sm-10">
                                            <div id="" class="ztree no-padding" 
                                            style="height: 400px; width: 250px; border:rgb(213, 213, 213) 1px solid;float:left; overflow: auto">
                                                <div class="widget-box transparent">
													<div class="widget-header" style="padding: 5px;min-height:26px;">
														<label class="pos-rel" style="width: 100%;margin-bottom:0px;">
															<span>关键字：</span>
															<input type="text"  style="height: 26px;width: 130px;" id="keyword" name="keyword" value="${keyword}" />
														</label>
													</div>
												</div>
                                                <div id="d_tree_all"></div>
                                            </div>
                                            <div style="height: 400px; width: 50px; float:left;padding-left: 9px">
                                                    <div style="color: darkgray;font-size: 11px; margin-top:12px">
                                                        拖拽节<br/>点到右<br/>侧
                                                        <i class="ace-icon fa fa-hand-o-right " style=" font-size: 12px"></i>
                                                        <br/>
                                                        <br/>
                                                        点 <i class="ace-icon fa fa-plus " style=" font-size: 12px"></i>
                                                        <br/>
                                                        可增加<br/>新节点

                                                        <br/>
                                                        <br/>
                                                        选中节<br/>点可编<br/>
                                                        辑 <i class="ace-icon fa fa-edit " style=" font-size: 12px"></i>
                                                        
                                                    </div>
                                                </div>
                                            
                                            <div id="d_tree_topic" class="ztree no-padding" 
                                            style="height: 400px; width: 250px; border:rgb(213, 213, 213) 1px solid;float:left;overflow: auto ">
                                                   <div>


                                                   </div>
                                                </div>
                                                <div style="height: 400px; width: 50px; float:left">
                                                    <div>
                                                        <button id="btnTopicTreeAdd" type="button" class="btn btn-xs btn-default btn-white" 
                                                        title="添加节点" style="border:rgb(213, 213, 213) 1px solid;width: 40px;min-width: 40px;border-left: none">
                                                            <i class="ace-icon fa fa-plus" style="color: #000;"></i>
                                                        </button>
                                                        <button id="btnTopicTreeClear" type="button" class="btn btn-xs btn-default btn-white" 
                                                        title="清空" style="border:rgb(213, 213, 213) 1px solid;width: 40px;min-width: 40px;border-left: none;border-top: none">
                                                            <i class="ace-icon fa fa-trash" style="color: #000;"></i>
                                                        </button>
                                                    </div>
                                                </div>
                                            <input type="hidden" name="HIDE_TOPIC_TREE" id="HIDE_TOPIC_TREE" value="">
                                            <div id="d_tree_editAttr" 
                                            style="height: 400px; width: 210px; border:rgb(213, 213, 213) 1px solid;float:left; overflow: auto; display:none">
                                            	<input type="hidden" id='tagid' name='tagid' value=""/>
												<input type="hidden" id='tagname' name='tagname' value=""/>
												<input type="hidden" id='tagTid' name='tagTid' value=""/>
													<div class="form-group col-sm-12">
														<label class="col-sm-5 control-label no-padding-right no-padding-left">
							                                是否查询
							                            </label>
							                            <div class="col-sm-7">
															<input type="checkbox" id="isSearch" name="isSearch" class="ace" value="1"/> <span class="lbl"></span>
							                            </div>
						                            </div>
						                            <div class="form-group col-sm-12">
														<label class="col-sm-5 control-label no-padding-right no-padding-left">
							                                查询类型
							                            </label>
							                            <div class="col-sm-7">
							                                   <select class="form-control" name="searchType" id="searchType">
							                                   		<option value="">--请选择--</option>
							                                   		<option value="1">维度</option>
							                                   		<option value="2">指标</option>
						                                        </select>
							                            </div>
						                            </div>
				                                <div class="form-group col-sm-12 valueTypeRangeValue">
				                                	 <label class="col-sm-1 hidden-xs control-label no-padding-right">
				                                        数字范围
				                                    </label>
				                                    <div class="col-sm-11">
				                                        <textarea class="form-control"  id="valueTypeRangeValue" name="valueTypeRangeValue" data-validation-engine="validate[maxLength[2000]]" placeholder="请输入数字范围，2000字符以内" style="height: 150px;"></textarea>
				                                    </div>
				                                </div>
				                                <div class="form-group col-sm-12 valueTypeRangeValue">
				                                	 <label class="col-sm-1 hidden-xs control-label no-padding-right">
				                                        &nbsp;
				                                    </label>
				                                    <div class="col-sm-11">
				                                        <div class="alert alert-block alert-info">
				                                            <h4 class="blue">
				                                                <i class="ace-icon fa fa-question-circle"></i>
				                                                	帮助 - 数字范围
				                                            </h4>
				                                            <p><i class="ace-icon fa fa-hand-o-right"></i>
				                                                <span class="red">静态JSON</span>为对象数组，必须具有v_up/v_down两个属性。如：<br/>
				                                                [<br/>
																 &nbsp;&nbsp;{"v_up":"50","v_down":"0"},<br/>
												 				 &nbsp;&nbsp;{"v_up":"100","v_down":"50"}<br/>
																]
				                                            </p>
				                                        </div>
				                                    </div>
				                                </div>
                                            </div>
    
                                        </div>
                                        
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label no-padding-right" for="txtBirthday">
                                   	 描述
                                </label>
                                <div class="col-sm-10">
                                    <textarea class="form-control" id="TOPIC_DESC"  name="TOPIC_DESC" placeholder=""  data-validation-engine="validate[maxLength[300]]" style=" height: 66px;">${topic.TOPIC_DESC }</textarea>
                                           
                                </div>
                                
                            </div>  
                            
                        </form>
                 
            </div>
        </div><!--/.main-content-inner-->
    </div><!-- /.main-content -->
</div><!-- /.main-container -->

<div id="menuContent" style="display:none; position: absolute;">
	<ul id="tagValueTree" class="ztree" style="margin-top:0; width:180px; height: 300px;overflow-x: auto;overflow-y:auto;z-index: 999;background-color: white;border: 1px solid #efefef;"></ul>
</div>

<%@ include file="/WEB-INF/jsp/_common/commonJS.jsp"%>	
<!--zTree-->
<script src="${ctx}/assets/components/zTree/js/jquery.ztree.all.js"></script>
<script src="${ctx}/assets/components/zTree/js/fuzzysearch.js" type="text/javascript"></script>
<script src="${ctx}/assets/components/zTree/js/jquery.ztree.exhide.min.js" type="text/javascript"></script>
<!-- 自己写的JS，请放在这里 -->
<script type="text/javascript">
	var zTreeTopic;
	//保存
	function save(){
			updateTreeNode();
         if ($('#formInfo').validationEngine('validate')) {
        	 
        	 //console.log(JSON.stringify(zTreeTopic.getNodes()));
        	//updateallpath(zTreeTopic);
        	 $("#HIDE_TOPIC_TREE").val(JSON.stringify(zTreeTopic.getNodes()));
        	 ths.submitFormAjax({
 	            url:'save.vm',// any URL you want to submit
 	            data:$("#formInfo").serialize()
 	        });
             
         }
	}
	//因为ID每次保存重新生成，所以全路径暂时无用
	function updateallpath(zTreeTopic){
		var nodesSys = zTreeTopic.getNodes(); //可以获取所有的父节点
		var nodes = zTreeTopic.transformToArray(nodesSys); //获取树所有节点
		
		
        for(var i=0;i<nodes.length;i++){
        	var pnodes = nodes[i].getPath();
            var path="";
            var name="";
            var id="";
            for(var j=0;j<pnodes.length;j++){
            	if(pnodes[j].pId!=null){
            		path+="/"+pnodes[j].pId;
            	}
            	name+="/"+pnodes[j].name;
            	id+="/"+pnodes[j].id;
            }
            nodes[i].path=path;
            console.log(name+" "+path+" "+id);
	    	zTreeTopic.updateNode(nodes[i]);
        }
        
	}
	//返回
	function goBack() {
	    $("#main-container",window.parent.document).show();
	    $("#iframeInfo",window.parent.document).attr("src","").hide();
	}
	
	//数据源表选择 【源库，目标库】
	function openCheckMenuId(_id){
		dialog({
			id:"datasourcetable-select-window",
	        title: '主题菜单 选择',
	        url: "${ctx}/dictionary/dictionary_manager_open.vm?_sid="+_id+"&dictionarycatalogcode=dc_tag_theme_type",
	        width:900,
	        height:460,
	       	cancel:function()
	       	{
	       	},
	       	cancelDisplay: false
	    }).showModal();
	}
	
	//关闭dialog
	function closeDialog(id){
		dialog.get(id).close().remove();
	}
	
	// 清理input类容
    function _removeSingle(){
		for(var i=0;i<arguments.length;i++){
			if(typeof(arguments[i]) != "undefined"){
				$("#"+arguments[i]).val("");
			}
			
		}
	}
	//验证是否存在编码
    function checkMenuid(field, rules, i, options){
		var _old_entity_id ="${topic.ENTITY_ID }";
		var _menuid="${topic.MENUID }";
		var _entity_id = $("#ENTITY_ID").val();
		if(_menuid == field.val() && _entity_id== $("#ENTITY_ID").val()){
			return;
		}
		var _entity_id = $("#ENTITY_ID").val();
		var ajaxResult = true;
		if(_entity_id){
			$.ajax({
				url: "${ctx}/topic/checkmenuid.vm",
				data: {"menuid":field.val(),"entity_id":_entity_id},
				type:"post",
				dataType:"text",
				async: false,
				success: function(response){
					if(response == "error"){
						ajaxResult = false;
					}
				},
				error: function(response){
					ajaxResult = false; 
				}
			});
			if(ajaxResult == false){
				return "此主题菜单已被该标签实体使用，请重新选择！";
			}
		}
	}
	 
	jQuery(function($){
		//表单验证组件初始化，详细文档请参考http://code.ciaoca.com/jquery/validation-engine/ 或官网文档http://posabsolute.github.io/jQuery-Validation-Engine/
	    $("#formInfo").validationEngine({
	        scrollOffset: 98,//必须设置，因为Toolbar position为Fixed
	        promptPosition: 'bottomLeft',
	        autoHidePrompt: true
	    });
		
		$("#btnUUID").click(function(){
			$("#TOPIC_CODE").val(generateUUID());
		}); 
        
        $("#ENTITY_ID").change(function(){
        	loadEntityTree();
        });
		$("#ENTITY_ID").val("${topic.ENTITY_ID }").change();
		loadTopicTree("${topic.TOPIC_ID}");
		
		//加载实体定义的标签树
        function loadEntityTree(){
        	var ENTITY_ID = $('#ENTITY_ID').val();
        	if(ENTITY_ID == "") {
        		zTreeObj = $.fn.zTree.init($("#d_tree_all"), setting);
                zTreeTopic = $.fn.zTree.init($("#d_tree_topic"), setting2);
        		return;
        	}
    		$.ajax({
    			type : 'GET',
    			cache: false,
    			url : '${ctx}/define/searchEntityTree.vm?STATUS=1&ENTITY_ID='+ENTITY_ID + "&NOROOT=true",
    			dataType : "JSON",
    			success : function(result) {
    				zTreeObj = $.fn.zTree.init($("#d_tree_all"), setting, result);
    				fuzzySearch('d_tree_all','#keyword',false,true);
    			},
    			error : function(e) {
    				console.log(e);
    			}
    		});	
        }
        
		//加载制定主题的标签树
        function loadTopicTree(topicId){
			if(topicId==''){
				return;
			}
        	$.ajax({
    			type : 'GET',
    			cache: false,
    			url : '${ctx}/topic/tree.vm?TOPIC_ID=' + topicId,
    			dataType : "JSON",
    			success : function(result) {
    				zTreeTopic = $.fn.zTree.init($("#d_tree_topic"), setting2, result);
    			},
    			error : function(e) {
    				console.log(e);
    			}
    		});	
        }
        
        
        $("#btnTopicTreeAdd").click(function(){
            zTreeTopic.addNodes(null, { iconSkin:"group",isParent:false, name:"自定义节点"});
        });
        $("#btnTopicTreeClear").click(function(){
            zTreeTopic = $.fn.zTree.init($("#d_tree_topic"), setting2);
        });
        $("input[name='valueType']").click(function(){
        	showValueTypeRangeValue();
		});	
        //加载隐藏域的默认标签
        loadHiddenTags();
        //清空隐藏域的默认标签
        $("#btnChooseDeptManagerX").click(function(){
        	$("#topictagUl").empty();
        	setHidenTags();
        });
        
	});
	var zTreeObj;
    // zTree 的参数配置，深入使用请参考 API 文档（setting 配置详解）
    var setting = {
        data: {
			simpleData: {
				enable: true
			}
		},
        edit: {
			enable: true,
			showRemoveBtn: false,
			showRenameBtn: false,
			drag:{
				isCopy:true,
				isMove:false
			}
		},
        callback: {
			beforeDrag: beforeDrag,
			beforeDrop: beforeDrop
		}
    };
    var setting2 = {
        data: {
			simpleData: {
				enable: true
			}
		},
        edit: {
			enable: true,
			showRemoveBtn: true,
			showRenameBtn: true,
            removeTitle: "删除节点",
            renameTitle: "编辑节点名称",
            txtMaxLength:50,
			drag:{
				isCopy:false,
				isMove:true,
                prev:true,
                next:true,
                inner:true
			}
		},
        callback: {
			beforeDrag: beforeDrag,
			beforeDrop: beforeDrop,
			onClick:zTreeOnClick,
			beforeClick: zTreeBeforeClick
		}
    };
    function beforeDrag(treeId, treeNodes) {
		for (var i=0,l=treeNodes.length; i<l; i++) {
			if (treeNodes[i].drag === false) {
				return false;
			}
		}
		return true;
	}
	function beforeDrop(treeId, treeNodes, targetNode, moveType) {
        if(treeId == "d_tree_all") return false;
		return targetNode ? targetNode.drop !== false : true;
	}
	function zTreeOnClick(event, treeId, treeNode) {
	    $("#d_tree_editAttr").show();
	    $("#tagid").val(treeNode.id);
	    $("#tagTid").val(treeNode.tId);
	    $("#tagname").val(treeNode.name);
	    if(treeNode.isSearch==0){
	    	$("input[name='isSearch']").prop("checked",false);
	    }else{
	    	$("input[name='isSearch']").prop("checked",true);
	    }
	    $("#searchType").val(treeNode.searchType);
	    showValueTypeRangeValue(treeNode);
	}
	
	function zTreeBeforeClick(treeId, treeNode, clickFlag) {
		updateTreeNode();
	};
    function showValueTypeRangeValue(treeNode){
    	if(treeNode.valueType==null){
	    	treeNode.valueType=1;
	    }
    	var type = treeNode.valueType;
		if(type == '1'){
			$('.valueTypeRangeValue').hide();
		} else if(type == '2'){
			$('.valueTypeRangeValue').show();
			$("#valueTypeRangeValue").val(treeNode.valueTypeRangeValue);
		} 
    }
    //保存节点属性 编辑信息到树节点（没有入库）
    function updateTreeNode(){
    	var tId=$("#tagTid").val();
    	if(tId!=""){
	    	var isSearchvalue = $("input[name='isSearch']:checked").val();
	    	if(isSearchvalue===undefined){
	    		isSearchvalue=0;
	    	}else {
				isSearchvalue=1;
			}
	    	var node = zTreeTopic.getNodeByTId(tId);
	    	if(node != null){
		    	node.isSearch=isSearchvalue;
		    	node.searchType=$("#searchType").val();
		    	node.valueTypeRangeValue=$("#valueTypeRangeValue").val();
		    	zTreeTopic.updateNode(node);
	    	}
    	}
    }
    

    function chooseTag(checkType,callback,dicCodeId,dicNameId){
    	var ENTITY_ID = $('#ENTITY_ID').val();
    	dialog({
    		id:"tag-select-window",
            title: '选择标签',
            url: "${ctx}/define/tag/tree/checkbox.vm?STATUS=1&checkType="+checkType+"&ENTITY_ID="+ENTITY_ID+"&callback="+callback+"&dicCodeId="+dicCodeId+"&dicNameId="+dicNameId,
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
    function tagMutiCallBack(ids,names){
    	$('.tag-col').hide();
    	for(var i = 0;i < ids.length;i++){
    		$('.'+ids[i]).show();
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
    	if(tagCode == null || tagCode == ''){
    		return;
    	}
    	$.ajax({
    	   type: "GET",
    	   url: "${ctx}/ws/tag/range.vm?tagCode="+tagCode,
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
    							$.fn.zTree.init($("#tagValueTree"), setting3, treeJson);
    						}

    					});
    			   } else {
    				   //动态sql、静态数组标签
    				   nodes.push({id:'root',pId:null,name:$('#tagName').val(),open:true,chkDisabled:true});
    				   for(var i = 0;i < result.length;i++){
    					   nodes.push({id:result[i].value,pId:'root',name:result[i].value});
    				   }
    				   $.fn.zTree.init($("#tagValueTree"), setting3, nodes);
    			   }
    		   } else {
    		   		dialog({
    		 	        title: '提示',
    		 	        content: result,
    		 	        wraperstyle:'alert-info',
    		 	        ok: function () {}
    		 	    }).showModal();
    		   }
    	   },error: function(){
    		   var nodes = new Array();
    		   nodes.push({id:'root',pId:null,name:'标签值加载失败！',open:false,chkDisabled:true});
    		   $.fn.zTree.init($("#tagValueTree"), setting3, nodes);
    		   dialog({
    	 	        title: '提示',
    	 	        content: '标签值加载失败，请联系管理员检查标签配置！',
    	 	        wraperstyle:'alert-info',
    	 	        ok: function () {}
    	 	    }).showModal();
    	   }
    	});
    }

    var setting3 = {
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
    		
    		$("body").bind("mousedown", onBodyDown);
    	}
    	function hideMenu() {
    		$("#menuContent").fadeOut("fast");
    		$("body").unbind("mousedown", onBodyDown);
    	}
    	function onBodyDown(event) {
    		if (!(event.target.id == "menuBtn" || event.target.id == "tagValueShow" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length>0)) {
    			hideMenu();
    			addTopicTagUl();
    		}
    	}
    	
    	var ths_tag = "";
    	function addTopicTagUl(){
    		var tagName = $("#tagName").val();
    		var tagCode = $("#tagCode").val();
			var allName = $("#tagValueShow").val();
			var allValue = $("#tagValue").val();
			
			var spancode = $("#span_"+tagCode).text();
			var name = "<span id=\"span_"+tagCode+"\" >"+tagName+"：</span><span style=\"color:#028DFB\">"+allName+"</span>";
			if(spancode!=''){
				$("#span_"+tagCode).html(name);
				$("#span_"+tagCode).attr("spanvalue",allValue);
			}else if(tagName!=''){
				ths_tag="<li class=\"search-choice\" liTagCode=\""+tagCode+"\" liTagName=\""+tagName+"\" liAllValue=\""+allValue+"\" liAllName=\""+allName+"\">"
				+name+"<a class=\"search-choice-close\" onclick=\"$(this).parent().remove();setHidenTags();\"></a></li>";
	    		$("#topictagUl").append(ths_tag);
			}
			if($("li.search-choice").length>0){
				setHidenTags();
			}
			
    	}
    	function setHidenTags(){
    		var param = new Array();
    		$("li.search-choice").each(function(){
    			param.push({"tagCode":$(this).attr("liTagCode"), "tagName":$(this).attr("liTagName"), "allValue":$(this).attr("liAllValue"), "allName":$(this).attr("liAllName")});
    		});
    		$("#hiddenTags").val(JSON.stringify(param));
    	}
    	function loadHiddenTags(){
    		var hiddenTags = '${topic.HIDDENTAGS}';
    		$("#hiddenTags").val(hiddenTags);
    		$.each(eval(hiddenTags), function (n, value) {
    			var name = "<span id=\"span_"+value.tagCode+"\" >"+value.tagName+"：</span><span style=\"color:#028DFB\">"+value.allName+"</span>";
    			var topictag="<li class=\"search-choice\" liTagCode=\""+value.tagCode+"\" liTagName=\""+value.tagName+"\" liAllValue=\""+value.allValue+"\" liAllName=\""+value.allName+"\">"
				+name+"<a class=\"search-choice-close\" onclick=\"$(this).parent().remove();setHidenTags();\"></a></li>";
				$("#topictagUl").append(topictag);
            });
    	}
</script>
</body>
</html>
