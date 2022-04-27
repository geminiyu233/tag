<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/jsp/_common/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh">
<head>
    <title></title>
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
                        <form class="form-horizontal" role="form" id="form1" action="list.vm" method="post">
							<input type="hidden" name="ENTITY_ID" value="${ENTITY_ID}">
							<input type="hidden" name="topicCode" value="${topicCode}">
							<input type="hidden" id="managerNode" name="managerNode" value="${managerNode}">
							<input type="hidden" id="topicGroupId" name="topicGroupId" value="${id}">
							<input type="hidden" name="id" value="${id}">
							
							<%@ include file="/WEB-INF/jsp/_common/commonArgs.jsp"%>
								<div class="module-layout">
                            <div class="form-group">
                                <label class="col-sm-1 hidden-xs control-label no-padding-right" for="txtName">
                                    	标签名称
                                </label>
                                <div class="col-sm-4 col-xs-8">
                                        <input type="text" class="form-control" placeholder="标签名称"  id="tagName" name="tagName" value="${tagName }">
                                </div>

                                <div class="col-sm-7 col-xs-4 align-right">
                                    <button type="button" class="btn btn-info btn-default-ths" id="btnSearch" onclick="doSearch(true)">
                                        <i class="ace-icon fa fa-search"></i>
                                        	搜索
                                    </button>
                                </div>
                            </div>
                            </div>
                            
							<div class="module-layout">
                            <div class="page-toolbar align-right list-toolbar">
                            	<c:if test="${isAdmin}">
                                <button type="button" class="btn btn-xs btn-primary btn-xs-ths" id="btnAdd" data-self-href="${ctx}/define/tag/edit.vm?ENTITY_ID=${ENTITY_ID }&topicCode=${topicCode}&managerNode=${managerNode}&topicGroupId=${id}">
                                    <i class="ace-icon fa fa-plus"></i>
                                    	添加
                                </button>
                                <button type="button" class="btn btn-xs btn-danger btn-xs-ths" id="btnDelete"  data-self-js="doDelete()">
                                    <i class="ace-icon fa fa-trash"></i>
                                   		 删除
                                </button>
                            	</c:if>      
                            </div>
                             <table id="listTable" class="table  table-bordered table-hover">
                                <thead>
                                <tr>
                                    <th class="center" style="width:50px">
                                        <label class="pos-rel">
                                            <input type="checkbox" class="ace"/>
                                            <span class="lbl"></span>
                                        </label>
                                    </th>
                                    <th class="align-center" width="80px">序号</th>		
                                    <th class="align-center"><i class="ace-icon fa fa-folder-o"></i>
                                        	标签名称
                                    </th>
                                    <th class="hidden-xs align-center">
                                        	所属分组
                                    </th>
                                    <th style="width:100px"  data-sort-col="tpt.sort" class="hidden-xs align-center">
                                        	排序
                                        <i class="ace-icon fa fa-sort pull-right"></i>
                                    </th>
                                    <th style="width:120px" class="hidden-xs align-center">
                                        	状态
                                    </th>                                    
                                    
                                    <th class="align-center" style="width:90px"><i class="ace-icon fa fa-wrench"></i>
                                        	操作
                                    </th>
                                </tr>
                                </thead>

                                <tbody>
										<c:if test="${pageInfo.total <= 0 }"><tr><td class="align-center" colspan="20">没有检索到相关数据！</td></tr></c:if>
										<c:forEach items="${pageInfo.list}" var="tag" varStatus="status">
											<tr>
												<td class="center">
												<label class="pos-rel"> 
													<input type="checkbox" class="ace" value="${tag.PKID}" /> <span class="lbl"></span>
												</label>
												</td>
												<td class="align-center">${(pageInfo.pageNum - 1) * pageInfo.pageSize + status.index + 1}</td>
												<td class="align-left">${tag.NODE_NAME}</td>
												<td class="align-left">${tag.GROUPNAME}</td>
												<td class="align-right">${tag.SORT}</td>
			                                    <td class="hidden-xs align-center">
				                                    <c:choose>
														<c:when test="${tag.STATUS=='1' }">
															<span class="label label-sm label-success arrowed-in-right min-width-75">
                                                     				<i class="ace-icon fa fa-check-circle"></i> 启用 </span>
														</c:when>
														<c:otherwise>
															<span class="label label-sm label-warning arrowed-in-right min-width-75">
                                                              	<i class="ace-icon fa fa-minus-circle"></i> 停用 </span>
														</c:otherwise>
													</c:choose>
			                                    </td>												
												<td class="hidden-xs align-center col-op-ths">
													<c:if test="${isAdmin}">
													<button type="button" class="btn btn-sm btn-info btn-white btn-op-ths" title="编辑"
														data-self-href="${ctx}/define/tag/edit.vm?id=${tag.TAG_ID}&managerNode=${managerNode}&pkid=${tag.PKID}&topicCode=${topicCode}">
														<i class="ace-icon fa fa-edit"></i>
													</button>
													<c:if test="${tag.CODE_TYPE != '40' }">
													<button title="立即运行" class="btn btn-sm btn-info btn-white btn-op-ths" type="button" 
													data-self-js="startJob('${tag.TAG_ID}','${tag.LTS_RUN_NODE}','${tag.RULE_TYPE}','${tag.DATASET_ID }');">
														<i class="ace-icon fa fa-play"></i>
													</button>
													</c:if>
													</c:if>
													<c:if test="${!isAdmin}">
													<button type="button" class="btn btn-sm btn-info btn-white btn-op-ths" title="查看"
														data-self-href="${ctx}/define/tag/edit.vm?id=${tag.TAG_ID}&managerNode=${managerNode}&pkid=${tag.PKID}&topicCode=${topicCode}">
														<i class="ace-icon fa fa-search"></i>
													</button>
													
													</c:if>
												</td>
											</tr>
										</c:forEach>
                        </tbody>
                    </table>
		 			<%@ include file="/WEB-INF/jsp/_common/paging.jsp"%>
                   </div>
                </form>
            </div>
        </div>
    </div>
</div><!--/.main-content-inner-->
    </div><!-- /.main-content -->
</div><!-- /.main-container -->
<iframe id="iframeInfo" name="iframeInfo" class="frmContent"
        src="" style="border: none; display: none" frameborder="0"
        width="100%"></iframe>
        
<%@ include file="/WEB-INF/jsp/_common/commonJS.jsp"%>

<!-- 自己写的JS，请放在这里 -->
<script type="text/javascript">
	//设置iframe自动高
	autoHeightIframe("iframeInfo");
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
		__doDelete(_ids,"${ctx}/topic/deletetopictag.vm",function(){
			//刷出之后，刷新列表
			if(window.parent.parent.reLoadTree){
        		window.parent.parent.reLoadTree();
        	}
        	if(window.parent.reLoadTree){
        		window.parent.reLoadTree();
        	}	
			doSearch();
		});
	}
	
	jQuery(function($){
		//初始化表格的事件，如表头排序，列操作等
		__doInitTableEvent("listTable");
		
	});
	
	//搜索
	function doSearch() {
		if (typeof (arguments[0]) != "undefined" && arguments[0] == true)
			$("#pageNum").val(1);
		$("#orderBy").closest("form").submit();
	}	
	
	//执行方案
	function startJob(jobid,lts_run_node,ruleType,datasetId){
		// ruleType 1:资源目录标签 2:SQL标签 3：实体
		$.ajax({
		   type: "POST",
		   url: "${ctx}/define/plan-excuse-handJob.vm",
		   data: {"TAG_ID":jobid,"LTS_RUN_NODE":lts_run_node,"ruleType":ruleType,"datasetId":datasetId,"JOBID":jobid},
		   dataType: "text",
		   success: function(result){
          		dialog({
        	        title: '提示',
        	        content: result,
        	        cancel: false,
        	        wraperstyle:'alert-info',
        	        ok: function () {window.close();}
        	    }).showModal();
		   }
		});
	}
	function goBack() {
	    $("#main-container",window.parent.document).show();
	    $("#iframeInfo",window.parent.document).attr("src","").hide();
	}
</script>
</body>
</html>
