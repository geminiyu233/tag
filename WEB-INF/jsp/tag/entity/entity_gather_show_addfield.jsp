<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/jsp/_common/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh">
	<head>
		<%@ include file="/WEB-INF/jsp/_common/commonCSS.jsp"%>
  		<!--页面自定义的CSS，请放在这里 -->
	    <style type="text/css">
			
	    </style>
	</head>
	<body class="no-skin">
		<div class="main-container" id="main-container">
		    <div class="main-content">
		        <div class="main-content-inner fixed-page-header fixed-40">
		            <div class="page-toolbar align-right">
		                <button type="button" class="btn btn-sm btn-purple btn-white" id="btnSave" onclick="doSaveData();">
                       		<i class="ace-icon fa fa-save"></i> 保存
                       	</button>
                     	<button type="button" class="btn btn-sm btn-danger btn-white" id="btnReturn" onclick="goBack();">
                    		<i class="ace-icon fa fa-reply"></i>取消
                   		</button>
		            </div>		        					
		        </div>
		        
				<div class="main-content-inner padding-page-content">
					<div class="page-content" style="padding-top:0px; ">
		                <div class="space-4"></div>
		                <div class="row">
		                    <div class=" col-xs-12">
		                        <form class="form-horizontal" role="form" id="mainForm" name="mainForm" action="" method="post" autocomplete="off">
		                            <input type="hidden" id="file_type" name="file_type" value="${file_type}" />
		                            <input type="hidden" id="_qitype" name="_qitype" value="${_qitype}" />
		                            <input type="hidden" id="file_id" name="file_id" value="${item.FILE_ID}" />
		                            <input type="hidden" id="_old_file_name" name="_old_file_id" value="${item.FILE_NAME}" />
		                            
		        					<hr class="no-margin">
		                            <div class="form-group" style="margin-top: 25px;">
										<label class="col-sm-2 control-label no-padding-right" style="float: left; text-align: right; margin-bottom: 0; padding-top: 7px;width: 85px;">
											<i class="ace-icon fa fa-asterisk red smaller-70"></i> 字段编码
										</label>
										<div class="col-sm-9 col-xs-9" style="width: 80%;">
											<input type="text" class="form-control" id="field_code" name="field_code" value="${item.FIELD_CODE}" data-validation-engine="validate[required,funcCall[do_dbfield],maxLength[50]]" maxlength="50">
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-2 control-label no-padding-right" style="float: left; text-align: right; margin-bottom: 0; padding-top: 7px;width: 85px;">
											<i class="ace-icon fa fa-asterisk red smaller-70"></i> 字段名称
										</label>
										<div class="col-sm-9 col-xs-9" style="width: 80%;">
											<input type="text" class="form-control" id="field_name" name="field_name" value="${item.FIELD_NAME}" data-validation-engine="validate[required,maxLength[50]]">
										</div>
									</div>
		                            <div>
		                               <label id="messagelabel" style="color:red;width:100%"></label>
		                            </div>
		                            <div class="form-group">
		                                <label class="col-sm-2 hidden-xs control-label no-padding-right">
		                                    &nbsp;
		                                </label>
		                                <div class="col-sm-9">
		                                    <div class="alert alert-block alert-info align-left">
		                                        <h4 class="blue">
		                                            <i class="ace-icon fa fa-question-circle"></i> 注意 
		                                        </h4>
		                                        <ul class="list-unstyled">
			                                        <li><i class="ace-icon fa fa-hand-o-right"></i>
			                                           <span class="text-danger">字段编码：</span>添加字段编码以首位字母，其他位可以是字母，数字以及下划线。
			                                         </li>
			                                    </ul>
		                                    </div>
		                                </div>
		                            </div>
		                        </form>
		                    </div>
		                </div><!-- /.row -->
		            </div>
		        </div><!--/.main-content-inner-->
		    </div><!-- /.main-content -->
		</div><!-- /.main-container -->
		
		<%@ include file="/WEB-INF/jsp/_common/commonJS.jsp" %>
		
		<!-- 自己写的JS，请放在这里 -->
	    <script type="text/javascript">
	  		//更新汇聚实体字段信息
	        function doSaveData(){
	        	if($('#mainForm').validationEngine('validate')) {
		        	var code = $('input[name="field_code"]').val();
		        	var name = $('input[name="field_name"]').val();
		        	var result = false;
		        	if(window.parent && window.parent.showAddFieldCallBack){
		        		//调用回调函数
		        		if(window.parent.showAddFieldCallBack(code,  code + '【' + name + '】')){
		        			dialog({
				    	        title: '确认',
				    	        content: '需要继续添加吗?',
				    	        wraperstyle:'alert-info',
				    	        width: 350,
				    	        ok: function () {
				    	        	$('input[name="field_code"]').val('');
				    	        	$('input[name="field_name"]').val('');
				    	        },
				    	        cancel:function(){
				    	        	closeMyWindow();
				    	        }
				    	    }).showModal();
		        		}else{
		        			dialog({
			                    title: '提示',
			                    content: '字段编码【' +code + '】已存在，请勿重复添加',
			                    wraperstyle: 'alert-info',
			                    width: 350,
			                    ok: function () {
			                    }
			                }).showModal();
		        		}
		        	}else{
		        		dialog({
		                    title: '提示',
		                    content: '添加字段失败！',
		                    wraperstyle: 'alert-info',
		                    width: 350,
		                    ok: function () {
		                    }
		                }).showModal();
		        	}
	        	}
	        }
			//返回
        	function goBack() {
        		closeMyWindow();
        	}
	        
        	function closeMyWindow(){
    	    	if(window.parent){
    	    		window.parent.closeDialog('entity-gather-field-select-window');
    	    	} else {
    	    		window.close();
    	    	}
    	    }
        	
        	//校验 数据库字段【字段编码以首位字母，其他位可以是字母，数字以及下划线】
        	function do_dbfield(field, rules, i, options){
        		if(field.val()){
        			//获取校验规则
        			try{
        				var regEx = new RegExp("^[a-zA-Z](_?[a-zA-Z0-9])*_?$");
        				if(!regEx.test(field.val())){
        					return "字段编码格式错误";
        				}
        				// 校验是否重复
        				if(window.parent && window.parent){
        					var vflag = false;
        					$('#entityFields li input[name="field_code"]',window.parent.document).each(function(){
        						var field_code = $('input[name="field_code"]', this).val();
        						if(field.val().toUpperCase() == $(this).val().toUpperCase()){
        							vflag = true;
        						}
        					})
        					if(vflag){
        						return '字段编码【' +field.val() + '】已存在，请勿重复添加';
        					}
			        	}else{
			        		return '校验字段编码【' +field + '】失败！';
			        	}
        			}catch(err){console.log("dv_dbfield:"+err);}
        		}
        	}
        	
        	//初始化
			$(document).ready(function(){
	            //表单验证组件初始化
	            $("#mainForm").validationEngine({
	                scrollOffset: 98,//必须设置，因为Toolbar position为Fixed
	                promptPosition: 'bottomLeft',
	                autoHidePrompt: true
	            });
	        });
		</script>
	</body>
</html>
