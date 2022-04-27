<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/jsp/_common/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh">
	<head>
    	<title>字典维护</title>
		<%@ include file="/WEB-INF/jsp/_common/commonCSS.jsp"%>  	
		<!-- page plugin css -->
  	
  		<!--页面自定义的CSS，请放在这里 -->
    	<style type="text/css">
 
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
										${empty THS_JDP_RES_DESC?'字典维护':THS_JDP_RES_DESC}
									</span>
	                           	</li>
	                        </ul><!-- /.breadcrumb -->
	        			</div>
					</div>

        		<div class="main-content-inner padding-page-content">
            		<div class="page-content">
	            <div class="page-content-new">
					<div class="page-toolbar align-right form-group">
						 <p class="title" style="display:none;">${(empty readonly && isAdmin) ? (empty pkcode ? '添加' : '编辑') : '查看'}</p>
	            			<c:if test="${isAdmin}">
	              			<button type="button" class="btn btn-xs btn-primary btn-xs-ths" id="btnSave" data-self-js="save()">
	                    		<i class="ace-icon fa fa-save"></i> 保存
	                		</button>
	                		</c:if>
	                		<button type="button" class="btn btn-xs btn-danger btn-xs-ths" id="btnReturn" data-self-js="goBack()">
	                    		<i class="ace-icon fa fa-reply"></i> 返回
	                		</button>
				     </div>	
                       			<form class="form-horizontal" role="form" id="formInfo" action="index.html" method="post" autocomplete="off">
                       				<!-- MIS系统面包屑 -->
	                            	<input type="hidden" name="THS_JDP_RES_DESC" value="${THS_JDP_RES_DESC}">
									<input type="hidden" name="THS_JDP_RES_ID" value="${THS_JDP_RES_ID}">
                       				<!-- 隐藏域 -->
                       				<input type="hidden" id="pkcode" name="pkcode" value="${pkcode }">
                           			
                           			<div class="form-group">
		                                <label class="col-sm-2 control-label no-padding-right no-padding-left" for="txtName">
		                                    <i class="ace-icon fa fa-asterisk red smaller-70"></i> 字典编码
		                                </label>
		                                <div class="col-sm-4">
		                             		<input type="text" class="form-control" id="dictionarycode" name="dictionarycode" value="${rdata.DICTIONARYCODE }" data-validation-engine="validate[required,funcCall[checkCode],maxLength[50]]" maxlength="50"/>
		                            	</div>
                               			<label class="col-sm-2 control-label no-padding-right" for="txtName">
                                   			<i class="ace-icon fa fa-asterisk red smaller-70"></i>字典名称
                                   		</label>
	                                    <div class="col-sm-4">
	                                    	<input type="text" class="form-control" id="dictionaryname" name="dictionaryname" value="${rdata.DICTIONARYNAME }" data-validation-engine="validate[required,maxLength[150]]" maxlength="150"/>
	                                    </div>
                               		</div>
                               		
                               		<div class="form-group">
		                                
                               			<label class="col-sm-2 control-label no-padding-right" for="txtName">
                                   			<i class="ace-icon fa fa-asterisk red smaller-70"></i> 字典分类代码
                                   		</label>
	                                    <div class="col-sm-4">
	                                    	<input type="text" class="form-control" id="dictionarycatalogcode" name="dictionarycatalogcode" value="${rdata.DICTIONARYCATALOGCODE }" data-validation-engine="validate[required,maxLength[50]]" maxlength="50"/>
	                                    </div>
	                                    <label class="col-sm-2 control-label no-padding-right" for="txtName">
                                   			<i class="ace-icon fa fa-asterisk red smaller-70"></i> 是否可用
                                   		</label>
	                                    <div class="col-sm-4">
	                                    	<select class="form-control" id="isavaliable" name="isavaliable">
                                        		<option value="1" <c:if test="${rdata.ISAVALIABLE eq '1'}">selected</c:if>>是</option>
                                        		<option value="0" <c:if test="${rdata.ISAVALIABLE eq '0'}">selected</c:if>>否</option>
                                        	</select>
	                                    </div>
                               		</div>
                               		<div class="form-group">
                               			<label class="col-sm-2 control-label no-padding-right no-padding-left" for="txtName">
											 父级编码
		                                </label>
		                                <div class="col-sm-4">
		                               		<input type="text" class="form-control" id="dictionaryparentcode" name="dictionaryparentcode" value="${rdata.DICTIONARYPARENTCODE }" data-validation-engine="validate[maxLength[50]]" maxlength="50"/>
		                           		</div>
		                                <label class="col-sm-2 control-label no-padding-right no-padding-left" for="txtName">
											 排序
		                                </label>
		                                <div class="col-sm-4">
		                              		<input type="text" class="form-control" id="dictionarysortindex" name="dictionarysortindex" value="${rdata.DICTIONARYSORTINDEX }" data-validation-engine="validate[maxLength[10]]" maxlength="10"/>
		                              	</div>
                               		</div>
                               		
                               		<div class="form-group">
		                                <label class="col-sm-2 control-label no-padding-right no-padding-left" for="txtName">
											上限
		                                </label>
		                                <div class="col-sm-4">
		                             		<input type="text" class="form-control" id="outup" name="outup" value="${rdata.OUTUP }" data-validation-engine="validate[onlyNumberSp,maxLength[9]]" maxlength="9"/>
		                         		</div>
                               			<label class="col-sm-2 control-label no-padding-right" for="txtName">
											下限
                                   		</label>
	                                    <div class="col-sm-4">
	                                   		<input type="text" class="form-control" id="outdown" name="outdown" value="${rdata.OUTDOWN }" data-validation-engine="validate[onlyNumberSp,maxLength[9]]" maxlength="9"/>
	                                    </div>
                               		</div>
									<div class="form-group">
		                                <label class="col-sm-2 control-label no-padding-right" for="txtBirthday">  描述 </label>
		                                <div class="col-sm-10">
		                                    <textarea class="form-control" id="dictionarydescription"  name="dictionarydescription" data-validation-engine="validate[maxLength[200]]" style="height: 66px;">${rdata.DICTIONARYDESCRIPTION }</textarea>
		                                </div>
                               		</div>  
                       			</form>
           			</div>
       			</div><!--/.main-content-inner-->
   			</div><!-- /.main-content -->
		</div><!-- /.main-container -->

		<%@ include file="/WEB-INF/jsp/_common/commonJS.jsp"%>

		<!-- 自己写的JS，请放在这里 -->
		<script type="text/javascript">
	
			//返回
			function goBack() {
			    $("#main-container",window.parent.document).show();
			    $("#iframeInfo",window.parent.document).attr("src","").hide();
			}
			
			function save(){
				if ($('#formInfo').validationEngine('validate')) {
			    	 ths.submitFormAjax({
					   url: "${ctx}/dictionary/dictionary_manager_save.vm",
					   data: $('#formInfo').serialize(),
					   dataType:"json",
					   success: function(rdata){
			     			if(rdata._code=='1'){
			     				dialog({
									title: '提示',
									content: rdata._msg,
									width: 350,
									cancel: false,
									ok:function(){
										goBack();
										window.parent.doSearch();
								}}).showModal();
			            	}else{
			            		dialog({
									title: '提示',
									content: rdata.msg,
									width: 350
								}).showModal();
			            	}
					   },
					   error: function(XMLHttpRequest, textStatus, errorThrown) {
							dialog({
								title: '提示',
								content: XMLHttpRequest.responseText,
								width: 350
							}).showModal();
					   }
					});
			    }
			}
			
			//检测CODE是否可用
			function checkCode(field, rules, i, options){
				var _code="${rdata.DICTIONARYCODE}";
				if(_code == field.val()){
					return;
				}
				var ajaxResult = true;
				var _type = $("#dictionarycatalogcode").val();
				if(_type){
					$.ajax({
						url: "${ctx}/dictionary/dictionary_manager_checkcode.vm",
						data: {"dictionarycode":field.val(),"dictionarycatalogcode":_type},
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
						return "此字典编码已被使用，请重新填写！";
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
			});
		</script>
	</body>
</html>