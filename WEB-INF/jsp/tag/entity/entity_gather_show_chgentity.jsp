<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="/WEB-INF/jsp/_common/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh">
	<head>
		<title>标签实体选择 </title>
		<%@ include file="/WEB-INF/jsp/_common/commonCSS.jsp"%>
		
		<!--页面自定义的CSS，请放在这里 -->
		<style type="text/css">
			td,th {white-space: nowrap!important;}
		</style>
	</head>

	<body class="no-skin">
		<div class="main-container" id="main-container">
	        <!-- 内容部分 -->
	        <div class="main-content-inner padding-page-content">
           		<div class="page-content">
               		<div class="row">
                   		<div class="col-xs-12">
                       		<form id="mainForm" name="mainForm" action="${ctx}/entity/entity-gather/showChgEntity.vm" class="form-horizontal" role="form" method="post" autocomplete="off">
                       			<input type="hidden" id="dicCodeId" name="dicCodeId" value="${dicCodeId}" />
                       			<input type="hidden" id="dicNameId" name="dicNameId" value="${dicNameId}" />
                       			<!-- 查询条件 -->
	                        	<div class="form-group">
									<label class="col-sm-1 control-label no-padding-right" style="width:10%">实体名称 </label>
									<div class="col-sm-5">
										<input type="text" class="form-control" name="entity_name" value="${entity_name}" />
									</div>
                             		<!-- 操作按钮 -->
									<div class="page-toolbar align-right list-toolbar" style="padding: 4px 0px; padding-right: 12px !important;">
										<button type="button" class="btn btn-xs btn-primary btn-xs-ths" id="btnSelect" data-self-js="doSaveMetaData()">
	                                    	<i class="ace-icon fa fa-check"></i>确定
	                                    </button>
	                           			<button type="button" class="btn btn-xs btn-primary btn-xs-ths" id="btnSelect" data-self-js="doSearch(true)">
	                                    	<i class="ace-icon fa fa-search"></i>查询
	                                    </button>
	                         		</div>
		                    	</div>
		                    	
								<!-- 分割线 -->
								<hr class="no-margin">
								
                           		<!-- 列表展示部分 -->
								<div style="overflow-x: auto;height:100%">
									<table id="listTable"  class="table table-bordered table-hover">
										<thead>
	                                		<tr>
	                                			<th class="align-center">
			                                        <label class="pos-rel">
			                                            <input type="checkbox" class="ace" id="checkAll"/>
			                                            <span class="lbl"></span>
			                                        </label>
			                                    </th>
			                                    <th class="align-center" style="min-width:150px;">
													实体名称
			                                    </th>
			                                    <th class="align-center" style="min-width:150px;">
													实体编码
			                                    </th>
			                                    <th class="align-center"  style="min-width:100px;">
													状态
			                                    </th>
			                                    <th class="align-center"  style="min-width:80px;">
													排序
			                                    </th>
	                                		</tr>
	                                	</thead>
										<tbody>
											<c:choose>
												<c:when test="${pageInfo.size > 0}">
	                                				<c:forEach var="item" items="${pageInfo.list }" varStatus="status">
		                                				<tr>
															<td class="center">
						                                        <label class="pos-rel">
						                                            <input type="checkbox" name="items" class="ace" value="${item.ENTITY_ID}" entitycode = "${item.ENTITY_CODE}" entityname="${item.ENTITY_NAME }" datatype="${item.DATA_TYPE }"/>
						                                            <span class="lbl"></span>
						                                        </label>
						                                    </td>
						                                    <td>
				                                     			<span>${item.ENTITY_NAME}</span>
				                                   			</td>
						                                    <td>
						                                    	<span>${item.ENTITY_CODE}</span>
						                                    </td>
						                                    <td class="align-center">
						                                    	<c:if test="${item.RUNSTATUS == 1 }">
			                                                	 	<span class="label label-sm label-success arrowed-in-right min-width-75">
			                                                	 	<i class="ace-icon fa fa-check-circle"></i> 启用 </span>
			                                                	</c:if>
			                                                    <c:if test="${item.RUNSTATUS != 1 }">
			                                                    	<span class="label label-sm label-warning arrowed-in-right min-width-75">
			                                                        <i class="ace-icon fa fa-minus-circle"></i> 停用 </span>
			                                                    </c:if>
						                                    </td>
					                                         <td  class="align-center col-op-ths">
						                                     	<span>${item.SORT_NUM}</span>
						                                    </td>
								                		</tr>
								                	</c:forEach>
												</c:when>
												<c:otherwise>
													<tr height="40px;">
														<td  align="center" class="grid_item" colspan="20">暂无数据</td>
													</tr>
												</c:otherwise>
											</c:choose>
										</tbody>
									</table>
								</div>
								<%@ include file="/WEB-INF/jsp/_common/paging.jsp"%>
	                        </form>
	                    </div>
	                </div>
	            </div>
	        </div><!--/.main-content-inner-->
		</div><!-- /.main-container -->

		<%@ include file="/WEB-INF/jsp/_common/commonJS.jsp"%>
		
		<script type="text/javascript" src="${ctx }/assets/js/ths-catalog.js"></script>
		
		<!-- 自己写的JS，请放在这里 -->
		<script type="text/javascript">
			autoHeightIframe("iframeInfo");
			//搜索
			function doSearch(){
				if( typeof(arguments[0]) != "undefined" && arguments[0] == true){
					$("#pageNum").val(1);
				}
				$("#mainForm").submit();
			}
			
			// 绑定数据资产信息
			function doSaveMetaData(){
				var _data = [];
				$('#listTable > tbody > tr > td:first-child :checkbox:checked:not(:disabled)').each(function() {
					var haschoose = $(this).data('haschoose');
					if(!haschoose){
						_data.push({
							"entityid": $(this).val(),
							"entitycode" : $(this).attr('entitycode'),
							"entityname" : $(this).attr('entityname'),
							"datatype" : $(this).attr('datatype')
						});
					}
				});
				
				if(_data.length>0 && window.parent){
					var _html = "";
					var _tab = "";
					var codes = $('input[name="${dicCodeId}"]', window.parent.document);
					for(var i=0;i<_data.length;i++){
						_html += (
								'<li class="search-choice field-item">' +
							 		'<span>'+ _data[i].entityname +'[' + _data[i].entitycode +']'+'</span>' +
										'<a class="search-choice-close" onclick="doclearEntity(this)"></a>' +
										'<input type="hidden" name="identity_id" value="'+ _data[i].entityid +'"/>'+
								'</li>'
						);
						if(codes.length == 0 && i==0){
							_tab =(
									'<li class="tab-item search-choice tab-change active" stab="'+_data[i].entityid+'" data-entitycode="'+_data[i].entitycode+'" style="padding-right: 5px">'+
										'<a href="#frmCatefory" data-toggle="tab">'+
							      			'<span>'+ _data[i].entityname +'['+ _data[i].entitycode +']</span>'+
							     		'</a>'+
							     	'</li>'
							);
							$('form[id="clickform"] input[id="mentity_id"]', window.parent.document).val(_data[i].entityid);
							$('form[id="clickform"]', window.parent.document).submit();
						}else{
							_tab =(
									'<li class="tab-item search-choice tab-change" stab="'+_data[i].entityid+'" data-entitycode="'+_data[i].entitycode+'" style="padding-right: 5px">'+
										'<a href="#frmCatefory" data-toggle="tab">'+
										'<span>'+ _data[i].entityname +'['+ _data[i].entitycode +']</span>'+
							     		'</a>'+
							     	'</li>'
							);
						}
		                $('#myTab', window.parent.document).append(_tab);
		                $('#myTab', window.parent.document).parent().css('display', 'block');
					}
					if(_html){
						$('#tagEntitys', window.parent.document).append(_html);
					}
					
					//处理tab标签换行问题
					window.parent.doTabPosition();
	                //关闭窗口
					window.parent.closeDialog('entity-chose-dialog');
				} else {
					dialog({
						title: '提示',
						wraperstyle:'alert-warning',
						content: '请选择需要添加的标签实体信息！',
						ok: function () {}
					}).showModal();
				}
			}
			
			jQuery(function($){
				//初始化表格的事件，如表头排序，列操作等
				__doInitTableEvent("listTable");

				if(window.parent && "${dicCodeId}"){
					$('input[name="${dicCodeId}"]', window.parent.document).each(function() {
						$('#listTable > tbody > tr > td:first-child input[name="items"][value="'+$(this).val()+'"]').attr("checked","checked").attr("disabled", "disabled");
					});
				}
			});
			
		</script>
	</body>
</html>