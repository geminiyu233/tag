<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/jsp/_common/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh">
	<head>
	    <title>数据源管理</title>
		<%@ include file="/WEB-INF/jsp/_common/commonCSS.jsp"%>
	  	<!--页面自定义的CSS，请放在这里 -->
	    <style type="text/css">
	
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
			                        <h5 class="page-title" >
			                 			<i class="fa fa-file-text-o"></i> 
			                 			<span class="THS_JDP_RES_DESC">
											${THS_JDP_RES_DESC}
										</span>
			                        </h5>
			                    </li>
			                </ul>
			            </div>
			        </div>
		        </c:if>
		         <!-- 内容部分 -->
		        <div class="main-content-inner padding-page-content">
            		<div class="page-content">
                		<div class="space-4"></div>
                		<div class="row">
                    		<div class="col-xs-12">
                        		<form id="mainForm" name="mainForm" action="${ctx}/datasource/data-source-config!showlist.vm" class="form-horizontal" role="form" method="post" autocomplete="off">
									<!-- MIS系统面包屑 -->
	                            	<input type="hidden" name="THS_JDP_RES_DESC" value="${THS_JDP_RES_DESC}">
									<input type="hidden" name="THS_JDP_RES_ID" value="${THS_JDP_RES_ID}">
									
		                        	<div class="form-group">
										<label class="col-sm-1 control-label no-padding-right" style="width: 11%;" for="datasource_code">数据源CODE</label>
										<div class="col-sm-3" style="width: 22.3333%;" >
		                                   	<input type="text" class="form-control" id="datasourcecode" name="datasourcecode" value="${datasourcecode }">
		                                </div>
		                                
		                                <label class="col-sm-1 control-label no-padding-right" style="width: 11%;" for="datasource_name">数据源名称</label>
										<div class="col-sm-3" style="width: 22.3333%;">
		                                   	<input type="text" class="form-control" id="datasourcename" name="datasourcename" value="${datasourcename }">
		                                </div>
		                                <div class="col-sm-4 col-xs-4 align-right">
                                    		<button type="button" class="btn btn-info btn-default-ths pull-right" data-self-js="doSearch(true)">
			                                	<i class="ace-icon fa fa-search"></i>搜索
			                              	</button>
										</div>
									</div> 
									
									<hr class="no-margin">
                            		<div class="page-toolbar align-right list-toolbar">
                            			<c:if test="${isAdmin}">
		                                <c:if test="${show_meta eq '1' }">
	                            			<button id="btnAdd_meta" type="button" data-self-js="doSyncDataSource('${ctx}/datasource/data-source-config!saveMetaDataSource.vm','btnAdd_meta')" class="btn btn-xs btn-purple btn-xs-ths" >
			                                    <i class="ace-icon fa fa-arrow-down"></i>同步【元数据】数据源
			                                </button>
		                                </c:if>
		                                <c:if test="${show_lts eq '1' }">
			                                <button id="btnAdd_lts" type="button" class="btn btn-xs btn-purple btn-xs-ths" >
			                                    <i class="ace-icon fa fa-arrow-down"></i>同步【数据监控】数据源
			                                </button>
		                                </c:if>
		                                <button id="btnAdd" type="button" class="btn btn-xs btn-primary btn-xs-ths" data-self-href="${ctx}/datasource/data-source-config!showaddoredit.vm?type=add&THS_JDP_RES_ID=${THS_JDP_RES_ID}" >
		                                    <i class="ace-icon fa fa-plus"></i>添加
		                                </button>
		                                <button id="btnDelete" type="button" class="btn btn-xs btn-danger btn-xs-ths" data-self-js="doDelete()">
		                                    <i class="ace-icon fa fa-trash-o"></i>删除
		                                </button>
		                                </c:if>
		                            </div>
									 
		                            <table id="listTable" class="table table-bordered table-hover <c:if test='${pageInfo.size > 0}'>ellipsis-table</c:if>">
		                                <thead>
			                                <tr>
			                                	<th class="center" style="width: 50px; min-width: 50px;">
			                                        <label class="pos-rel">
			                                            <input type="checkbox" class="ace" />
			                                            <span class="lbl"></span>
			                                        </label>
			                                    </th>
												<th class="hidden-xs hidden-sm align-center" data-sort-col="DATASOURCECODE" width="20%">
			                                    	<i class="ace-icon fa fa-database"></i>数据源CODE
			                                        <i class="ace-icon fa fa-sort pull-right"></i>
			                                    </th>
			                                    <th class="hidden-xs hidden-sm align-center" data-sort-col="DATASOURCENAME" width="20%">
			                                    	<i class="ace-icon fa fa-file-o"></i>数据源名称
			                                        <i class="ace-icon fa fa-sort pull-right"></i>
			                                    </th>
			                                    <th class="hidden-xs hidden-sm align-center"  width="25%">
			                                    	<i class="ace-icon fa "></i>数据源描述
			                                    </th>
			                                    <th class="hidden-xs hidden-sm align-center" data-sort-col="ADAPTERNAME" style="width: 160px; min-width: 160px;">
			                                    	<i class="ace-icon fa fa-cog"></i> 适配器
			                                        <i class="ace-icon fa fa-sort pull-right"></i>
			                                    </th>
			                                    <th class="hidden-xs align-center sort" data-sort-col="SORTNO" style="width: 80px; min-width: 80px;">
			                              			<i class="ace-icon fa fa-sort-amount-asc"></i> 排序
			                                        <i class="ace-icon fa fa-sort pull-right"></i>
			                                    </th>
			                                    <th class="align-center" style="width: 100px; min-width: 100px;">
			                                    	<i class="ace-icon fa fa-wrench"></i>操作
			                                    </th>
			                                </tr>
		                                </thead>
		                                <tbody>
		                                	<c:choose>
												<c:when test="${pageInfo.size > 0}">
													<c:forEach var="item"  items="${pageInfo.list}" varStatus="status">
									                	<tr>
									                    	<td class="center">
				                                    			<label class="pos-rel">
					                                            	<input type="checkbox" class="ace" value="${item.PKID}"/>
					                                            	<span class="lbl"></span>
					                                        	</label>
						                                    </td>
						                                    <td>
						                                    	<span>${item.DATASOURCECODE}</span>
						                                    </td>
						                                    <td>
						                                    	<span>${item.DATASOURCENAME}</span>
															</td>
						                                    <td class="hidden-xs hidden-sm">
						                                    	<span>${item.REMARKS}</span>
															</td>
						                                    <td class="hidden-xs align-center">
						                                    	<span>${item.ADAPTERNAME}</span>
						                                    </td>
						                                    <td class="hidden-xs align-center">
						                                    	<span>${item.SORTNO}</span>
						                                    </td>
						                                    <td class="align-center col-op-ths">
						                                    	<c:if test="${isAdmin}">
						                                    	<button type="button" class="btn btn-sm btn-info btn-white btn-op-ths" data-toggle="tooltip" title="编辑" data-self-href="${ctx}/datasource/data-source-config!showaddoredit.vm?type=edit&pkid=${item.PKID}&THS_JDP_RES_ID=${THS_JDP_RES_ID}" >
							                                    	<i class="ace-icon fa fa-edit"></i>
							                                   	</button>
							                                   	</c:if>
						                                        <button type="button" class="btn btn-sm btn-info btn-white btn-op-ths" data-toggle="tooltip" title="查看" data-self-href="${ctx}/datasource/data-source-config!showaddoredit.vm?pkid=${item.PKID}&THS_JDP_RES_ID=${THS_JDP_RES_ID}" >
							                                    	<i class="ace-icon fa fa-eye"></i>
							                                    </button>
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
									<%@ include file="/WEB-INF/jsp/_common/paging.jsp"%>
		                        </form>
		                    </div>
		                </div>
		            </div>
		        </div><!--/.main-content-inner-->
		    </div><!-- /.main-content -->
		</div><!-- /.main-container -->

		<iframe id="iframeInfo" name="iframeInfo" class="frmContent" src="" style="border: none; display: none" frameborder="0" width="100%"></iframe>
		        
		<%@ include file="/WEB-INF/jsp/_common/commonJS.jsp"%>

		<!-- 自己写的JS，请放在这里 -->
		<script type="text/javascript">
			//设置iframe自动高
			autoHeightIframe("iframeInfo");
			
			//搜索
			function doSearch(){
				if( typeof(arguments[0]) != "undefined" && arguments[0] == true)
					$("#pageNum").val(1);
				$("#mainForm").submit();
			}
		
			//关闭dialog
			function closeDialog(id){
				dialog.get(id).close().remove();
			}
			
			//批量删除
			function doDelete() {
				var _ids = "";
				$('#listTable > tbody > tr > td:first-child :checkbox:checked')
						.each(function() {
							_ids = _ids + $(this).val() + ",";
						});
				_ids = _ids = "" ? _ids : _ids.substr(0, _ids.length - 1);
				/**
				 * 执行数据批量删除
				 *  __ids 为英文逗号分隔的ID字符串,也可仅传递一个ID,执行单个删除
				 *  serverUrl 服务器端AJAX POST 地址
				 *  callBackFn 删除成功的回调函数,无参数,如function(){}
				 */
				 if(_ids){
				 	__doDelete(_ids, "${ctx}/datasource/data-source-config!deletedatasource.vm", function() {
						//刷出之后，刷新列表
						doSearch();
					});
				 }else{
				 	dialog({
						title: '提示',
						content: '请选择需要删除的数据！',
						width: 300
					}).showModal();
				 }
				
			}
			//删除一条数据，可参考此函数
			function doDeleteOne(id){
				__doDelete(id,"${ctx}/datasource/data-source-config!deletedatasource.vm",function(){
					//刷出之后，刷新列表
					doSearch();
				});
			}
			
			function doSyncDataSource(_url,_id){
				$("#"+_id).attr("disabled","disabled");
				ths.submitFormAjax({
					url : _url,
					dataType: "json",
					success : function(rdata){
						$("#"+_id).attr("disabled",false);
						if(rdata.code == '1'){
							dialog({
								title: '提示',
								content: rdata.msg,
								cancel: false,
								ok: function () {
									doSearch();
								},
								width: 350
							}).showModal();
						}else{
							dialog({
								title: '错误',
								icon:'fa-times-circle',
								wraperstyle:'alert-warning',
								content: rdata.msg,
								width: 350,
								ok: function () {
									
								}
							}).showModal();
						}
					}
				});
			}
			
			jQuery(function($){
				//初始化表格的事件，如表头排序，列操作等
				__doInitTableEvent("listTable");
				// 初始化表格 太长使用省略号代替 ，并生成 title
				__addEllipsisTips();
			});
 				
		</script>
	</body>
</html>