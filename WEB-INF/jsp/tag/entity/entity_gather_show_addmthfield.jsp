<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/jsp/_common/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh">
	<head>
		<%@ include file="/WEB-INF/jsp/_common/commonCSS.jsp"%>
		<link rel="stylesheet" href="${ctx}/assets/components/bootstrap-select/dist/css/bootstrap-select.css"/>
		<script src="${ctx}/assets/components/bootstrap-select/dist/js/bootstrap-select-self.js"></script>
  		<!--页面自定义的CSS，请放在这里 -->
	    <style type="text/css">
	    </style>
	</head>
	<body class="no-skin">
		<div class="main-container" id="main-container">
		    <div class="main-content">
		        <div class="main-content-inner fixed-page-header fixed-40">
		            <div class="page-toolbar align-right">
		                <button type="button" class="btn btn-sm btn-purple btn-white" id="btnSave" onclick="doSaveGatherEntityRelate();">
                       		<i class="ace-icon fa fa-save"></i> 保存
                       	</button>
                     	<button type="button" class="btn btn-sm btn-danger btn-white" id="btnReturn" onclick="goBack();">
                    		<i class="ace-icon fa fa-reply"></i>取消
                   		</button>
		            </div> 					
		        </div>
		        
				<div class="main-content-inner padding-page-content">
					<div class="page-content" style="padding-top:0px;">
		                <div class="space-4"></div>
		                <div class="row">
		                    <div class=" col-xs-12">
		                        <form class="form-horizontal" role="form" id="mainForm" name="mainForm" action="" method="post" autocomplete="off">
		                        	<input type="hidden" id="entity_id" name="entity_id" value="${entity_id}">
		                            <input type="hidden" id="gentity_id" name="gentity_id" value="${gentity_id}">
		                       		<input type="hidden" id="batchnum" name="batchnum" value="${batchnum}">
		                        
		        					<hr class="no-margin">
		                            <div class="form-group" style="margin-top: 25px;">
										<label class="col-sm-2 control-label no-padding-right" style="float: left; text-align: right; margin-bottom: 0; padding-top: 7px;width: 85px;">
											<i class="ace-icon fa fa-asterisk red smaller-70"></i> 汇聚字段
										</label>
										<div class="col-sm-9 col-xs-9" style="width: 80%;">
											<select class="form-control" name="gentity_file_code" id="gentity_file_code" data-validation-engine="validate[required]">
											</select>
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-2 control-label no-padding-right" style="float: left; text-align: right; margin-bottom: 0; padding-top: 7px;width: 85px;">
											<i class="ace-icon fa fa-asterisk red smaller-70"></i> 实体字段
										</label>
										<div class="col-sm-9 col-xs-9" style="width: 80%;">
											<select class="form-control selectpicker" name="entity_file_code" id="entity_file_code"
											        data-validation-engine="validate[required]" 
											        data-style="form-control" data-hide-disabled="true" data-live-search="true"
											 >
												<option value="">--请选择--</option>
												<c:forEach var="field" items="${efields}" varStatus="status">
													<c:choose>
														<c:when test="${!empty efield && empty efield[field.FIELD_CODE]}">
															<option value="${field.FIELD_CODE }" vname="${field.FIELD_NAME }">${(empty field.FIELD_CODE_NAME)?field.FIELD_NAME:field.FIELD_CODE_NAME}</option>
														</c:when>
														<c:when test="${empty efield}">
															<option value="${field.FIELD_CODE }" vname="${field.FIELD_NAME }">${(empty field.FIELD_CODE_NAME)?field.FIELD_NAME:field.FIELD_CODE_NAME}</option>
														</c:when>
													</c:choose>
		                                        </c:forEach>
											</select>
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-2 control-label no-padding-right" style="float: left; text-align: right; margin-bottom: 0; padding-top: 7px;width: 85px;">
											<i class="ace-icon fa smaller-70"></i> 排序
										</label>
										<div class="col-sm-9 col-xs-9" style="width: 80%;">
											<input type="text" class="form-control" id="sort_num" name="sort_num">
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
	  		//获取汇聚实体对象的属性字段信息
	    	function setGatherEntityFiled(){
	    		var _html = '';
	    		if(window.parent && $('#entityFields', window.parent.document) ){
	               	$('#entityFields', window.parent.document).find('li').each(function(){
	               		var field_code = $(this).find('input[name="field_code"]').val();
						var field_name = $(this).find('input[name="field_name"]').val();
						//去除已经选择了的数据
						if("${gfield}".indexOf(field_code) == -1){
							_html +='<option value="'+field_code+'" vname="'+field_name+'">'+$(this).find('input[name="field_code_name"]').val()+'</option>';
						}
					})
	            }
	    		if(_html){
	    			_html = '<option value="">--请选择--</option>'+_html;
	    		}else{
	    			_html = '<option value="">--请添加新的汇聚字段--</option>';
	    		}
				$('#gentity_file_code').html(_html);
	    	}
	    
		   //初始化
		   $(document).ready(function(){
	            //表单验证组件初始化
	            $("#mainForm").validationEngine({
	                scrollOffset: 98,//必须设置，因为Toolbar position为Fixed
	                promptPosition: 'bottomLeft',
	                autoHidePrompt: true
	            });
	            //加载实体对象的属性字段信息
	            //getEntityFieldData();
	            //获取汇聚实体对象的属性字段信息
	            setGatherEntityFiled();
	            
	        });
	    	
	    	//返回
        	function goBack() {
        		closeMyWindow();
        	}
	        
        	function closeMyWindow(){
    	    	if(window.parent){
    	    		window.parent.closeDialog('add-match-field-mapping-window');
    	    	} else {
    	    		window.close();
    	    	}
    	    }
        	
        	//获取实体对象的属性字段信息
        	function getEntityFieldData(){
        		var datasourceid = '${entity.DATASOURCE_ID}';
        		var tablename = '${entity.DATATABLE}';
        		var dataType = '${entity.DATA_TYPE}';
        		var data_sql =  $('#datasql').val();
        		$.ajax({
					type : "POST",
					url : "${ctx}/tag-common/getDataSourceTableColumn.vm",
					data: {
						pkid: datasourceid,
						tablename: tablename,
						DATA_TYPE: dataType,
						DATA_SQL: data_sql
					},
					dataType : "text",
					success : function(treeJson) {
						var _data = [];
						if(treeJson && treeJson != ''){
							 _data = eval('('+treeJson+')');
							if(_data && _data.Status=="500"){
								_data = [];
							}
						}
						var _html = '';
						for(var i=1;i<_data.length;i++){
							_html +='<option value="'+_data[i].id+'">'+_data[i].name+'</option>';
						}
						$('#entity_file_code').html(_html);
					}
				});
        	}
        	
        	
        	
        	//保存实体与汇聚实体的关系
    		function doSaveGatherEntityRelate(){
    			var gentity_field_code = $('#gentity_file_code').val();
    			var gentity_field_name = $('#gentity_file_code').find("option:selected").text();
    			var entity_field_code = $('#entity_file_code').val();
    			var entity_field_name = $('#entity_file_code').find("option:selected").text();
    			
    			var gentity_id =  '${gentity_id}';
    			var entity_code = '${entity_code}';
    			var entity_id = '${entity_id}';
    			
    			var batchnum = $('#batchnum', window.parent.document).val();
    			var sortnum =  $('#sort_num').val();
    			
    			//数据保存到临时表中：1 新增  2 删除
    			var opt_type = '1';
        		if ($('#mainForm').validationEngine('validate')) {
    				ths.submitFormAjax({
    	                url: '${ctx }/entity/entity-gather/doSaveEntityRelate.vm',
    	                data: {
    	                	'gentity_field_code':gentity_field_code,
    	                	'gentity_field_name':gentity_field_name,
    	                	'entity_field_code':entity_field_code,
    	                	'entity_field_name':entity_field_name,
    	                	'gentity_id':gentity_id,
    	                	'entity_id':entity_id,
    	                	'entity_code':entity_code,
    	                	'batchnum': batchnum,
    	                	'sortnum':sortnum,
    	                	'opt_type': opt_type
    	                },
    	                dataType:"json",
    	                success: function (data) {
    	                    //弹出保存成功消息
    	                	parent.dialogMessage(data._msg);
    	                    //刷新iframe 页面
    	                	$('#clickform',window.parent.document).submit();
    	                	closeMyWindow();
    	                }
    	            });
    			}
    		}
		</script>
	</body>
</html>
