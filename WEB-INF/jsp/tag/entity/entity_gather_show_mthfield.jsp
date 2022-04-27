<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/jsp/_common/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh">
<head>
    <title></title>
	<%@ include file="/WEB-INF/jsp/_common/commonCSS.jsp"%>
  	<!--页面自定义的CSS，请放在这里 -->
    <style type="text/css">
		tr:hover {
		    background: #ffff !important;
		}
    </style>
</head>
<body class="no-skin">
    <div class="main-container" id="main-container">
        <div class="main-content">
            <div class="main-content-inner padding-page-content">
                <div class="page-content" style="padding: 0px !important;">
                    <div class="space-4"></div>
                    <div class="row">
                        <div class="col-xs-12">
                            <form class="form-horizontal" role="form" id="formInfo" name="formInfo"  method="post"  autocomplete="off">
								<input type="hidden" name="entity_code" value="${entity_code }">
								<input type="hidden" name="entity_id" value="${entity_id }">
								<input type="hidden" name="gentity_id" id="gentity_id" value="${gentity_id }">
								<input type="hidden" name="batchnum" id="batchnum">
								<div class="module-layout">
	                                <table id="listTable" class="table table-bordered table-hover">
	                                    <thead>
	                                    	<tr style="border-bottom: 1px #e9e9e9 solid;">
	                                    		<th class="align-center" colspan="2">
	                                           		汇聚实体
	                                            </th>
	                                            <th class="align-center" rowspan="2" style="border-bottom: 3px #e9e9e9 solid;">
	                                            </th>
	                                            <th class="align-center" colspan="2">
	                                          		标签实体
	                                            </th>
												<c:if test="${readonly ne 'true'}">
													<th class="align-center" >
														操作
													</th>
												</c:if>
	                                    	</tr>
	                                        <tr>
	                                            <th class="align-center">
	                                         		字段编码
	                                            </th>
	                                            <th class="align-center">
	                                         		字段名称
	                                            </th>
	                                            <th class="align-center">
	                                            	字段编码
	                                            </th>
	                                            <th class="align-center">
	                                          		字段名称
	                                            </th>

												<c:if test="${readonly ne 'true'}">
													<th class="align-center" style="width: 70px;">
														<a href="javascript:void(0);" onclick="showAddMthField(this);">
															<i class="ace-icon fa fa-plus"></i>
														</a>
													</th>
												</c:if>
	                                        </tr>
	                                    </thead>
	                                    <tbody >
	                                    	<c:forEach items="${list }" var="item">
	                                    		<tr>
											  		<td class="align-center">
											  			<input type="hidden" name="pkid" value="${item.PKID }"/>
											  			<input type="hidden" name="data_type" value="${item.DATA_TYPE }"/>
											  			${item.GENTITY_FIELD_CODE }
											  		</td>
											  		<td class="align-center">
											  			${item.GENTITY_FIELD_NAME }
											  		</td>
											  		<td class="align-center">
											  			<p style="margin-bottom:-12px"><i class="ace-icon fa fa-long-arrow-right"></i></p>
											  			<i class="ace-icon fa fa-long-arrow-right"></i>
											  		</td>
											  		<td class="align-center">
											  			${item.ENTITY_FIELD_CODE }
											  		</td>
											  		<td class="align-center">
											  			${item.ENTITY_FIELD_NAME }
											  		</td>
													<c:if test="${readonly ne 'true'}">
														<td class="align-center">
															<a href="javascript:void(0);" onclick="deleteRelationRow(this);" style="text-decoration:none;">
																<i class="ace-icon fa fa-trash"></i>
															</a>
														</td>
													</c:if>
											     </tr>
	                                    	</c:forEach>
	                                    </tbody>
	                                </table>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div><!--/.main-content-inner-->
        </div><!-- /.main-content -->
    </div><!-- /.main-container -->
    
	<%@ include file="/WEB-INF/jsp/_common/commonJS.jsp"%>
	<!-- 自己写的JS，请放在这里 -->
	<script type="text/javascript">
		//汇聚实体-实体关联关系编辑框
	    function showAddMthField(){
			if(window.parent){
				window.parent.showAddMthField('${entity_id}');
			}
	    }
		
		//删除行
		function deleteRelationRow(obj){
			$(obj).parent().parent().remove();
			//设置iframe自动高
			window.parent.iframeRefresh();
			var pkid = $(obj).parent().parent().find('input[name="pkid"]').val();
			//数据来源信息表1：原表  2：临时表中
			var data_type = $(obj).parent().parent().find('input[name="data_type"]').val();
			//批次号
			var batchnum = $('#batchnum', window.parent.document).val();
			$('#batchnum').val(batchnum);
			if(pkid){
				doDeleteGatherRelate(pkid, data_type, batchnum);
			}
		}
		
		//删除关联的实体映射关系临时表
		function doDeleteGatherRelate(pkid, data_type, batchnum){
			$.ajax({
				type : "POST",
				url : "${ctx}/entity/entity-gather/doDeleteGatherRelate.vm",
				data: {"pkid":pkid, "data_type":data_type, "batchnum": batchnum},
				dataType : "json",
				success : function(data) {
					parent.dialogMessage(data._msg);
					//刷新页面
					doSearch();
				}
			});
		}
		
		$(document).ready(function(){
			$("#formInfo").validationEngine({
                scrollOffset: 98,//必须设置，因为Toolbar position为Fixed
                promptPosition: 'bottomLeft',
                autoHidePrompt: true
            });
			
			//初始化表格的事件，如表头排序，列操作等
			__doInitTableEvent("listTable");
			
			//设置iframe自动高
			window.parent.iframeRefresh();
		})
		
		//搜索
		function doSearch(){
			if( typeof(arguments[0]) != "undefined" && arguments[0] == true)
				$("#pageNum").val(1);
			$("#formInfo").submit();
		}
	</script>
</body>
</html>
