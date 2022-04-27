<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/jsp/_common/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh">
	<head>
    	<title>字典配置查询</title>
		<%@ include file="/WEB-INF/jsp/_common/commonCSS.jsp"%>
		
  		<!--页面自定义的CSS，请放在这里 -->
	    <style type="text/css">

	    </style>
	</head>

	<body class="no-skin">

    	<div class="main-container" id="main-container">
        	<div class="main-content">
	            <div class="main-content-inner padding-page-content">
	                <div class="page-content">
	                    <div class="space-4"></div>
	                    <div class="row">
	                        <div class="col-xs-12">
	                            <form class="form-horizontal" role="form" id="form" action="${ctx }/dictionary/dictionary_manager_open.vm" method="post" autocomplete="off">
	                            	<input type="hidden" id="isavaliable" name="isavaliable" value="${isavaliable }" >
	                            	<input type="hidden" id="dictionarycatalogcode" name="dictionarycatalogcode" value="${dictionarycatalogcode }" >
	                            	<input type="hidden" id="_sid" name="_sid" value="${_sid }" >
	                            	<input type="hidden" id="dictionarycatalogcode" name="dictionarycatalogcode" value="${dictionarycatalogcode }" >
	                            	
	                            	<div class="form-group">
                                    	<label class="col-sm-1 hidden-xs control-label no-padding-right" for="dictionaryname">字典名称</label>
                                   		<div class="col-sm-4 col-xs-8">
                                   			<input type="text" class="form-control" placeholder="字典名称" id="dictionaryname" name="dictionaryname" value = "${dictionaryname}"/>
										</div>
										<div class="col-sm-7 col-xs-4 align-right">
	                                        <button type="button" class="btn btn-info btn-default-ths" id="btnSearch" data-self-js="doSearch(true)">
	                                            <i class="ace-icon fa fa-search"></i> 搜索
	                                        </button>
	                                        <button type="button" class="btn btn-save" id="btnSearch" data-self-js="saveDictionary()">
	                                            <i class="ace-icon fa fa-check"></i> 确定
	                                        </button>
	                                    </div>
                               		</div>
									<table id="listTable" class="table table-bordered table-hover <c:if test='${pageInfo.total > 0}'>ellipsis-table</c:if>">
										<thead>
											<tr>
												<th class="center" style="width: 50px"></th>
												<th class="align-center" style="width:50px;">序号</th>
												<th class="align-center">字典编码</th>
												<th class="align-center" data-sort-col="DICTIONARYNAME">
													<i class="ace-icon fa"></i>字典名称
													<i class="ace-icon fa fa-sort pull-right"></i> 
												</th>											
												<th class="align-center">父级编码</th>
											</tr>
										</thead>
										<tbody>
											<c:choose>
												<c:when test="${pageInfo.total > 0 }">
													<c:forEach items="${pageInfo.list }" var="item" varStatus="status">
														<tr>
															<td class="center">
				                                                <label class="pos-rel">
				                                                    <input type="checkbox" class="ace"  value="${item.DICTIONARYCODE}"/>
				                                                    <span class="lbl"></span>
				                                                </label>
				                                            </td>
															<td class="align-center">${(pageInfo.pageNum - 1) * pageInfo.pageSize + status.index + 1}</td>
															<td class="align-left">${item.DICTIONARYCODE }</td>
															<td class="align-left">${item.DICTIONARYNAME }</td>
															<td class="align-right">${item.DICTIONARYPARENTCODE }</td>
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
			function saveDictionary(){
				var _ids="";
		        $('#listTable > tbody > tr > td:first-child :checkbox:checked').each(function(){
		        	_ids = _ids + $(this).val() + ",";
		        });
		        _ids = _ids=""?_ids:_ids.substr(0,_ids.length -1 );
		        if(_ids){
		        	$('#${_sid}',window.parent.document).val(_ids);
		        	closeMyWindow();
		        }else{
		        	dialog({
						title: '提示',
						content: "请选择一条记录！",
						width: 350
					}).showModal();
		        }
			}
			
			function closeMyWindow(){
				if(window.parent){
					parent.closeDialog('datasourcetable-select-window');
				} else {
					window.close();
				}
			}
			
			jQuery(function($) {
				//初始化表格的事件，如表头排序，列操作等
				__doInitTableEvent("listTable");
				
				$('#listTable > tbody > tr > td:first-child :checkbox').click(function(){
					if($(this).is(':checked')){
						$(this).parent().parent().parent().siblings().find("td:first-child :checkbox:checked").prop('checked', false);
					}
				});
				$("#listTable > tbody > tr > td:first-child :checkbox[value='"+$('#${_sid}',window.parent.document).val()+"']").prop('checked', true);
			});
		</script>
	</body>
</html>