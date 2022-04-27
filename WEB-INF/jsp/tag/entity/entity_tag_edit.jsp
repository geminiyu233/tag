<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/jsp/_common/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh">
<head>
    <title></title>
	<%@ include file="/WEB-INF/jsp/_common/commonCSS.jsp"%>
  	<!--页面自定义的CSS，请放在这里 -->
	<!--zTree-->
	<link rel="stylesheet" href="${ctx}/assets/components/zTree/css/metroStyle/metroStyle.css" type="text/css">
	<script src="${ctx}/assets/components/zTree/js/jquery.ztree.all.min.js"></script>	  	
    <style type="text/css">

    </style>
</head>

<body class="no-skin">

<div class="main-container" id="main-container">
    <div class="main-content">
        <div class="main-content-inner fixed-page-header fixed-40">
            
            <div class="page-toolbar align-right">
              <c:if test="${isAdmin}">
                <button type="button" class="btn btn-xs btn-primary btn-xs-ths" id="btnSave" onclick="saveForm();">
                    <i class="ace-icon fa fa-save"></i>
                    	保存
                </button>
                </c:if>
                
                <button type="button" class="btn btn-xs btn-danger btn-xs-ths" id="btnReturn" onclick="window.parent.closeDialog('tag-edit-window')">
                    <i class="ace-icon fa fa-close"></i>
                   		 关闭
                </button>

            </div>

        </div>
        <div class="main-content-inner padding-page-content">
            <div class="page-content">
                <div class="space-4"></div>
                <div class="row">
                    <div class="col-xs-12">
                        <form class="form-horizontal" role="form" id="formInfo" action="${ctx}/entity/tag/save.vm?ENTITY_ID=${ENTITY_ID }" method="post">
                                	<input type="hidden" name="id" value="${id }">
<!--                                 	<div class="form-group"> -->
<!--                                         <label class="col-xs-12 control-label blue align-left"> -->
<!--                                             XXXX污水处理厂 -->
<!--                                         </label> -->
<!--                                     </div> -->
									<c:if test="${fn:length(tags) == 0 }">
									    <div class="form-group">
                                        <label class="col-xs-12 control-label blue align-center">
                                            	没有查询到可用的手动标签！
                                        </label>
                                    	</div>
									</c:if>
									
                                    <c:forEach var="tag" items="${tags }">
	                                    <div class="form-group">
	                                        <label class="col-xs-4 control-label no-padding-right">
	                                            	${tag.tagName }
	                                        </label>
	                                       <div class="col-xs-8">
	                                       		<c:if test="${tag.tagValueType == '1' }">
		                                            <select class="form-control tag-select" id="${tag.tagCode }" onclick="checkTagValue('${tag.tagCode }')" name="${tag.tagCode }" tagValueType="${tag.tagValueType }" value="${doc[tag.tagCode] }">
		                                                <option value="">--请选择--</option>
		                                            </select>
	                                       		
	                                       		</c:if>
	                                       		<c:if test="${tag.tagValueType == '2' }">
				                                     <div class="input-group" style="float:left;">
				                                        <input type="text"  class="form-control tag-select" readonly="readonly" placeholder="点击选择标签值"  tagValueType="${tag.tagValueType }" id="${tag.tagCode }Show" name="${tag.tagCode }Show" value="${fn:replace(doc[tag.tagCode],'$',',')}"  onclick="showMenu('${tag.tagCode }');">
				                                        <input type="hidden" id="${tag.tagCode }" name="${tag.tagCode }"  value="${doc[tag.tagCode]}">
				                                        <span class="input-group-btn">
				                                            <button type="button" class="btn btn-white btn-default" onclick="clearValue(this)">
				                                                <i class="ace-icon fa fa-remove"></i>
				                                            </button>
				                                        </span>
				                                    </div>	                                       		
	                                       		</c:if>
	                                        </div>
	                                    </div>
                                    </c:forEach>
    
                        </form>
                    </div>
                </div><!-- /.row -->
            </div>
        </div><!--/.main-content-inner-->
    </div><!-- /.main-content -->
</div><!-- /.main-container -->

    <div id="menuContent" style="display:none; position: absolute;z-index: 999;">
		<ul id="tagValueTree" class="ztree" style="margin-top:0; width:180px; height: 300px;overflow-x: auto;overflow-y:auto;z-index: 999;background-color: white;border: 1px solid #efefef;"></ul>
	</div>    

<%@ include file="/WEB-INF/jsp/_common/commonJS.jsp"%>

<!-- 自己写的JS，请放在这里 -->
<script type="text/javascript">
	//AJAX保存
	function saveForm(){
		//提交之前验证表单
	    if ($('#formInfo').validationEngine('validate')) {
	        ths.submitFormAjax({
	            url:'${ctx }/entity/tag/save.vm?ENTITY_ID=${ENTITY_ID }',
	            data:$("#formInfo").serialize(),// 如果不需要提交整个表单，可构造JSON提交，如{name:'老王',age:50}
	            success:function(data){
	            	if(data == 'success'){
	            		dialog({
	            	        title: '提示',
	            	        content: '保存成功',
							cancel: false,
	            	        wraperstyle:'alert-info',
	            	        ok: function () {
	            	        	if(window.parent.doSearch){
	            	        		window.parent.doSearch();
	            	        	}	            	        	
	            	        }
	            	    }).showModal();
	            	}
	            }
	        });
	    }
	}
	//检查标签值域是否配置正确
	function checkTagValue(tagCode){
		if($('#'+tagCode+' option').length == 1){
			alertError();
		}
	}
	
	
	var hasError = false;
	function alertError(){
		hasError = true;
	   	dialog({
 	        title: '提示',
 	        content: '标签值域加载失败，请检查标签值域配置！',
 	        wraperstyle:'alert-info',
 	        ok: function () {}
 	    }).showModal();				
	}
	
	//加载标签值域
	function loadTagValueList(tagCode,tagValueType,fromEvent){
		if(tagCode == null || tagCode == ''){
			return;
		}
		$.ajax({
		   type: "GET",
		   url: "${ctx}/ws/tag/range.vm?tagCode="+tagCode,
		   dataType: "json",
		   async : (fromEvent == 'click' ? false : true),
		   success: function(result){
				if(tagValueType == '2'){
					if(result.length == 0 && fromEvent == 'click'){
						alertError();
					} else {
						loadMutiTagValue(tagCode,result,fromEvent);
					}
				} else {
					loadSingleTagValue(tagCode,result);
				}
		   },error: function(){
			   //console.log(tagValueType);
			   if(tagValueType == '2' && fromEvent == 'click'){
					alertError();
			   }
		   }
		});
	}	
	
	//单值标签
	function loadSingleTagValue(tagCode,result){
		$('#'+tagCode+' option').remove();
		$('#'+tagCode).append('<option value="">--请选择--</option>');
		  
		   if(result && result.length > 0){
			   if(result.length == 1 && result[0].alias == 'service-url' && result[0].value != null && result[0].value != ''){
				   //服务接口类标签
					$.ajax({
						type : "GET",
						url : result[0].value,
						dataType : "json",
						success : function(treeJson) {
							   for(var i = 0;i < treeJson.length;i++){
								   if($('#'+tagCode).attr('value') == result[i].value){
									   $('#'+tagCode).append('<option selected value="'+treeJson[i].id+'">'+treeJson[i].name+'</option>')
								   } else {
									   $('#'+tagCode).append('<option value="'+treeJson[i].id+'">'+treeJson[i].name+'</option>')
								   }
							   }
						}

					});
			   } else {
				   for(var i = 0;i < result.length;i++){
					   if($('#'+tagCode).attr('value') == result[i].value){
						   $('#'+tagCode).append('<option selected value="'+result[i].value+'">'+result[i].value+'</option>')
					   } else {
						   $('#'+tagCode).append('<option value="'+result[i].value+'">'+result[i].value+'</option>')
					   }
				   }
			   }			   
		   } else {

		   }
	}
	
	//多值标签
	function loadMutiTagValue(tagCode,result,fromEvent){
		   hasError = false;
		   var nodes = new Array();
		   if(result && result.length > 0){
			   if(result.length == 1 && result[0].alias == 'service-url' && result[0].value != null && result[0].value != ''){
				   //服务接口类标签
					$.ajax({
						type : "GET",
						url : result[0].value,
						dataType : "json",
						async : (fromEvent == 'click' ? false : true),
						success : function(treeJson) {
							$.fn.zTree.init($("#tagValueTree"), setting, treeJson);
						},
						error: function(){
							if(fromEvent == 'click'){
								alertError();
							}
						}

					});
			   } else {
				   //动态sql、静态数组标签
				   nodes.push({id:'root',pId:null,name:'标签值',open:true,chkDisabled:true});
				   for(var i = 0;i < result.length;i++){
					   nodes.push({id:result[i].value,pId:'root',name:result[i].value});
				   }
				   $.fn.zTree.init($("#tagValueTree"), setting, nodes);
			   }
		   } else {
				if(fromEvent == 'click'){
					alertError();
				}
		   }		
	}
		 
	jQuery(function($){
		 //加载所有标签值域
		 var tags = $('.tag-select');
		 if(tags.length > 0){
			 for(var i = 0;i < tags.length;i++){
				 loadTagValueList($(tags[i]).attr('name'),$(tags[i]).attr('tagValueType'));
			 }
		 }
		
	});
	
	var currentTagCode = null;
	var currentTagCodeValue = null;
	
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
			},
			callback: {
				beforeClick: beforeClick,
				onCheck: onCheck
			}
		};

		function beforeClick(treeId, treeNode) {
			var zTree = $.fn.zTree.getZTreeObj("tagValueTree");
			zTree.checkNode(treeNode, !treeNode.checked, null, true);
			return false;
		}
		
		function onCheck(e, treeId, treeNode) {
			var zTree = $.fn.zTree.getZTreeObj("tagValueTree"),
			nodes = zTree.getCheckedNodes(true),
			allName = "",
			allValue = "";
			for (var i=0, l=nodes.length; i<l; i++) {
				allName += nodes[i].name + ",";
				allValue += nodes[i].id + "$";
			}
			if (allName.length > 0 ) allName = allName.substring(0, allName.length-1);
			if (allValue.length > 0 ) allValue = allValue.substring(0, allValue.length-1);
			$(currentTagCode).val(allName);
			$(currentTagCodeValue).val(allValue);
		}

		function showMenu(tagCode) {
			currentTagCode = '#'+tagCode+'Show';
			currentTagCodeValue = '#'+tagCode;
			loadTagValueList(tagCode,'2','click');
			if(hasError){
				return;
			}
			var cityObj = $(currentTagCode);
			var cityOffset = $(currentTagCode).offset();
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
</script>
</body>
</html>
