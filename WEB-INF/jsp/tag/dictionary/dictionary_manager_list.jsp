<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/jsp/_common/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh">
	<head>
    	<title>字典配置管理</title>
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
	                            <form class="form-horizontal" role="form" id="form" action="${ctx }/dictionary/dictionary_manager_list.vm" method="post">
	                            	<!-- MIS系统面包屑 -->
	                            	<input type="hidden" name="THS_JDP_RES_DESC" value="${THS_JDP_RES_DESC}">
									<input type="hidden" name="THS_JDP_RES_ID" value="${THS_JDP_RES_ID}">
									<div class="module-layout">
		                            	<div class="form-group">
	                                    	<label class="col-sm-1 hidden-xs control-label no-padding-right" for="dictionaryname">字典名称</label>
	                                   		<div class="col-sm-3 col-xs-8">
	                                   			<input type="text" class="form-control" placeholder="字典名称" id="dictionaryname" name="dictionaryname" value = "${dictionaryname}"/>
											</div>
	
	                                    	<label class="col-sm-1 hidden-xs control-label no-padding-right" for="txtName">是否可用</label>
	                                    	<div class="col-sm-3 col-xs-8">
	                                            <select class="form-control" id="isavaliable" name="isavaliable">
	                                        		<option value="">--请选择--</option>
	                                        		<option value="1" <c:if test="${isavaliable eq '1'}">selected</c:if>>是</option>
	                                        		<option value="0" <c:if test="${isavaliable eq '0'}">selected</c:if>>否</option>
	                                        	</select>
											</div>
											<div class="col-sm-4 col-xs-4 align-right">
		                                        <button type="button" class="btn btn-info btn-default-ths" id="btnSearch" data-self-js="doSearch(true)">
		                                            <i class="ace-icon fa fa-search"></i> 搜索
		                                        </button>
		                                    </div>
	                               		</div>
	                                </div>
                                	<div class="module-layout">
										<div class="page-toolbar align-right list-toolbar"> 	
											<c:if test="${isAdmin}">		
											<button type="button" class="btn btn-xs btn-primary btn-xs-ths" data-self-href="${ctx }/dictionary/dictionary_manager_edit.vm?THS_JDP_RES_ID=${THS_JDP_RES_ID}"  id="btnAdd">
												<i class="ace-icon fa fa-plus"></i> 添加
											</button>
											 <button type="button" class="btn btn-xs btn-danger btn-xs-ths" id="btnDelete"  data-self-js="doDelete()">
	                                            <i class="ace-icon fa fa-trash-o"></i> 删除
	                                        </button>
	                                        </c:if>
		 								</div> 
		 								
										<table id="listTable" class="table table-bordered table-hover <c:if test='${pageInfo.total > 0}'>ellipsis-table</c:if>">
											<thead>
												<tr>
													<th class="center" style="width: 50px">
		                                                <label class="pos-rel">
		                                                    <input type="checkbox" class="ace" />
		                                                    <span class="lbl"></span>
		                                                </label>
		                                            </th>
													<th class="align-center" style="width:50px;">序号</th>
													<th class="align-center">字典编码</th>
													<th class="align-center" data-sort-col="DICTIONARYNAME">
														<i class="ace-icon fa"></i>字典名称
														<i class="ace-icon fa fa-sort pull-right"></i> 
													</th>											
													<!-- <th class="align-center">父级编码</th> -->
													<th class="align-center" style="width:120px;">字典分类代码</th>
													<th class="align-center" style="width:60px;">排序</th>
													<th class="align-center" style="width:80px;">是否可用</th>
													<!-- <th class="align-center" style="width:80px;">上限</th>
													<th class="align-center" style="width:80px;">下限</th>
													<th class="align-center" style="width:120px;">描述</th> -->
													<th class="align-center" style="width:100px;">
													 	<i class="ace-icon fa fa-wrench"></i>操作
													</th>
												</tr>
											</thead>
											<tbody>
												<c:choose>
													<c:when test="${pageInfo.total > 0 }">
														<c:forEach items="${pageInfo.list }" var="item" varStatus="status">
															<tr>
																<td class="center">
					                                                <label class="pos-rel">
					                                                    <input type="checkbox" class="ace"  value="${item.PKCODE}"/>
					                                                    <span class="lbl"></span>
					                                                </label>
					                                            </td>
																<td class="align-center">${(pageInfo.pageNum - 1) * pageInfo.pageSize + status.index + 1}</td>
																<td class="align-left">${item.DICTIONARYCODE }</td>
																<td class="align-left">${item.DICTIONARYNAME }</td>
																<%-- <td class="align-right">${item.DICTIONARYPARENTCODE }</td> --%>
																<td class="align-left">${item.DICTIONARYCATALOGCODE }</td>
																<td class="align-center">${item.DICTIONARYSORTINDEX }</td>
																<td class="align-center">
																	<c:if test="${item.ISAVALIABLE eq '1'}">是</c:if>
																	<c:if test="${item.ISAVALIABLE eq '0'}">否</c:if>
																</td>
																<%-- <td class="align-center">${item.OUTUP }</td>
																<td class="align-center">${item.OUTDOWN }</td>
																<td class="align-left" >${item.DICTIONARYDESCRIPTION }</td> --%>
																<td class="align-center col-op-ths">
																	<c:if test="${isAdmin}">
																	<button type="button" class="btn btn-sm btn-info btn-white btn-op-ths" data-toggle="tooltip" title="编辑" data-self-href="${ctx}/dictionary/dictionary_manager_edit.vm?THS_JDP_RES_ID=${THS_JDP_RES_ID}&pkcode=${item.PKCODE}"  >
																		<i class="ace-icon fa fa-edit"></i>
																	</button>
																	<button type="button" class="btn btn-sm btn-danger btn-white btn-op-ths" data-toggle="tooltip" title="删除" data-self-js="doDeleteOne('${item.PKCODE}')">
																		<i class="ace-icon fa fa-trash-o"></i>
																	</button>
																	</c:if>
																	
																	<c:if test="${!isAdmin}">
																	<button type="button" class="btn btn-sm btn-info btn-white btn-op-ths" data-toggle="tooltip" title="查看" data-self-href="${ctx}/dictionary/dictionary_manager_edit.vm?THS_JDP_RES_ID=${THS_JDP_RES_ID}&pkcode=${item.PKCODE}"  >
																		<i class="ace-icon fa fa-search"></i>
																	</button>
																	</c:if>
																</td>														
															</tr>
														</c:forEach>
													</c:when>
													<c:otherwise>
														<tr><td class="align-center" colspan="20">没有检索到相关数据！</td></tr>
													</c:otherwise>
												</c:choose>
											</tbody>
										</table>
										<%@ include file="/WEB-INF/jsp/_common/paging.jsp"%>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
				<!--/.main-content-inner-->
			</div>
			<!-- /.main-content -->
		</div>
		<!-- /.main-container -->
		<iframe id="iframeInfo" name="iframeInfo" class="frmContent" src="" style="border: none; display: none" frameborder="0" width="100%"></iframe>
	
		<%@ include file="/WEB-INF/jsp/_common/commonJS.jsp"%>
		<!-- 自己写的JS，请放在这里 -->
		<script type="text/javascript">
	
			//设置iframe自动高
			autoHeightIframe("iframeInfo");
			//搜索
			function doSearch() {
				if (typeof (arguments[0]) != "undefined" && arguments[0] == true)
					$("#pageNum").val(1);
				$("#orderBy").closest("form").submit();
			}
			
			//批量删除
			function doDelete(){
				var _ids="";
		        $('#listTable > tbody > tr > td:first-child :checkbox:checked').each(function(){
		        	_ids = _ids + $(this).val() + ",";
		        });
		        _ids = _ids=""?_ids:_ids.substr(0,_ids.length -1 );
		        /**
		         * 执行数据批量删除
		         *  __ids 为英文逗号分隔的ID字符串,也可仅传递一个ID,执行单个删除
		         *  serverUrl 服务器端AJAX POST 地址
		         *  callBackFn 删除成功的回调函数,无参数,如function(){}
		         */
				__doDelete(_ids,"${ctx }/dictionary/dictionary_manager_delete.vm",function(){
					//刷出之后，刷新列表
					doSearch();
				});
			}
			
			//删除一条数据，可参考此函数
			function doDeleteOne(id){
				__doDelete(id,"${ctx }/dictionary/dictionary_manager_delete.vm",function(){
					//刷出之后，刷新列表，并更新树的数据
					doSearch();
				});
			}
	
			jQuery(function($) {
				//初始化表格的事件，如表头排序，列操作等
				__doInitTableEvent("listTable");
				
			});
			
			
			
	
		</script>
	</body>
</html>