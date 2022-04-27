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
                            <form class="form-horizontal" role="form" id="form1" action="${ctx }/entity/entity-gather/showList.vm" method="post">
								<!-- MIS系统面包屑 -->
                            	<input type="hidden" name="THS_JDP_RES_DESC" value="${THS_JDP_RES_DESC}">
								<input type="hidden" name="THS_JDP_RES_ID" value="${THS_JDP_RES_ID}">
								<div class="module-layout">
	                                <div class="form-group">
	                                	<label class="col-sm-1 hidden-xs control-label no-padding-right" for="gentity_name">
	                                       		 实体汇聚名称
	                                    </label>
	                                    <div class="col-sm-3 col-xs-8">
	                                            <input type="text" class="form-control" placeholder="关键字" id="gentity_name" name="gentity_name"
	                                              value = "${gentity_name}"/>
	                                    </div>
	                                    <label class="col-sm-1 hidden-xs control-label no-padding-right" for="runstatus">
	                                        	状态
	                                    </label>
	                                    <div class="col-sm-3 col-xs-8">
	                                        <select class="form-control" id="runstatus" name="runstatus">
	                                            <option value="">全部</option>
	                                            <option value="1" ${runstatus == '1' ? 'selected' : '' }>启用</option>
	                                            <option value="0" ${runstatus == '0' ? 'selected' : '' }>停用</option>
	                                        </select>
	                                    </div>
	                                    <div class="col-sm-4 col-xs-4 align-right">
	                                        <button type="button" class="btn btn-info btn-default-ths" id="btnSearch" data-self-js="doSearch(true)">
	                                            <i class="ace-icon fa fa-search"></i>
	                                         		   搜索
	                                        </button>
	                                    </div>
	                                </div>
								</div>
								<div class="module-layout">
	                                <div class="page-toolbar align-right list-toolbar">
                                		<c:if test="${isAdmin}">
	                                        <button type="button" class="btn btn-xs btn-primary btn-xs-ths" id="btnAdd" data-self-href="${ctx}/entity/entity-gather/showAddEdit.vm?THS_JDP_RES_ID=${THS_JDP_RES_ID}">
	                                            <i class="ace-icon fa fa-plus"></i>添加
	                                        </button>
                                        </c:if>
                                        <button type="button" class="btn btn-xs btn-primary btn-xs-ths" id="btnReturn" data-self-js="goBack()">
						                    <i class="ace-icon fa fa-reply"></i>返回
						            	</button>
	                                </div>
	                                <table id="listTable" class="table  table-bordered table-hover">
	                                    <thead>
	                                        <tr>
	                                            <th class="align-center" data-sort-col="GENTITY_NAME">
	                                                  	实体汇聚名称
	                                                <i class="ace-icon fa fa-sort pull-right"></i>
	                                            </th>
	                                            <th class="align-center" data-sort-col="GENTITY_CODE">
	                                                	实体汇聚代码
	                                                <i class="ace-icon fa fa-sort pull-right"></i>
	                                            </th>
	                                            <th style="width:120px" class="align-center" data-sort-col="RUNSTATUS">
	                                                	状态
	                                                <i class="ace-icon fa fa-sort pull-right"></i>
	                                            </th>
	                                            <th class="align-center" style="width:100px" data-sort-col="SORT_NUM">
	                                                	排序
	                                                <i class="ace-icon fa fa-sort pull-right"></i>
	                                            </th>
	                                            <th class="align-center" style="width:250px"><i class="ace-icon fa fa-wrench"></i>
	                                              	  	操作
	                                            </th>
	                                        </tr>
	                                    </thead>
	                                    <tbody>
		                                    <c:if test="${pageInfo.total <= 0 }"><tr><td class="align-center" colspan="20">没有检索到相关数据！</td></tr></c:if>
		                                    <c:forEach var="item" items="${pageInfo.list}">
		                                        <tr>
		                                            <td>${item.GENTITY_NAME}</td>
		                                            <td>${item.GENTITY_CODE}</td>
		                                            <td  class="align-center">
		                                               		<c:if test="${item.RUNSTATUS == 1 }">
		                                                	 	<span class="label label-sm label-success arrowed-in-right min-width-75">
		                                                	 	<i class="ace-icon fa fa-check-circle"></i> 启用 </span>
		                                                	</c:if>
		                                                    <c:if test="${item.RUNSTATUS != 1 }">
		                                                    	<span class="label label-sm label-warning arrowed-in-right min-width-75">
		                                                        <i class="ace-icon fa fa-minus-circle"></i> 停用 </span>
		                                                    </c:if>
		                                            </td>
		                                            <td class="align-center">
														${item.SORT_NUM }
		                                            </td>
		                                            <td class=" align-center col-op-ths">
		                                            	<button type="button" class="btn btn-sm btn-white btn-info btn-op-ths"
															data-self-href="${ctx}/define/gmain.vm?THS_JDP_RES_ID=${THS_JDP_RES_ID}&entitySelect=${item.GENTITY_ID }" data-toggle="tooltip" title="标签定义"><i class="ace-icon fa fa-sitemap" ></i>
		                                                </button>
		                                            	<c:if test="${isAdmin}">
			                                                <button type="button" class="btn btn-sm btn-white btn-info btn-op-ths"
																data-self-js="startJob('${item.GENTITY_ID }','${item.LTS_RUN_NODE }')" data-toggle="tooltip" title="手动执行"><i class="ace-icon fa fa-play" ></i>
			                                                </button>
		                                                </c:if>
		                                                <button type="button" class="btn btn-sm btn-white btn-info btn-op-ths"
															data-self-href="${ctx}/entity/tag/list.vm?hasGather=true&THS_JDP_RES_ID=${THS_JDP_RES_ID}&ENTITY_ID=${item.GENTITY_ID }" data-toggle="tooltip" title="标签查询"><i class="ace-icon fa fa-tags"></i>
		                                                </button>
		                                                <c:if test="${isAdmin}">
		                                                    <button type="button" class="btn btn-sm btn-white btn-info btn-op-ths"
																data-self-href="${ctx}/entity/entity-gather/showAddEdit.vm?THS_JDP_RES_ID=${THS_JDP_RES_ID}&gentity_id=${item.GENTITY_ID }" data-toggle="tooltip" title="实体编辑"><i class="ace-icon fa fa-pencil" ></i>
		                                                    </button>
		                                                </c:if>
		                                                <c:if test="${!isAdmin}">
			                                                <button type="button" class="btn btn-sm btn-white btn-info btn-op-ths"
																data-self-href="${ctx}/entity/entity-gather/showAddEdit.vm?readonly=true&THS_JDP_RES_ID=${THS_JDP_RES_ID}&gentity_id=${item.GENTITY_ID }" data-toggle="tooltip" title="实体查看"><i class="ace-icon fa fa-search" ></i>
			                                                </button>
		                                                </c:if>
		                                                <c:if test="${isAdmin}">
			                                                <button type="button" class="btn btn-sm btn-white btn-info btn-op-ths"
																onclick="doDeleteOne('${item.GENTITY_ID }')" data-toggle="tooltip" title="实体删除"><i class="ace-icon fa fa-trash" ></i>
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
            </div>
            <!--/.main-content-inner-->
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
		jQuery(function($){
			//初始化表格的事件，如表头排序，列操作等
			__doInitTableEvent("listTable");
		});	
		
		//删除实体汇聚
		function doDeleteOne(entityid){
			 dialog({
	             title: '删除',
	             icon:'fa-times-circle',
	             wraperstyle:'alert-warning',
	             content: '确实要删除选定记录吗?',
	             ok: function () {
	            	 $.ajax({
	         			type : "POST",
	         			url : "${ctx}/entity/entity-gather/doDelGEntityData.vm",
	         			data:{"gentity_id": entityid},
	         			dataType : "json",
	         			success : function(rdata) {
	         				dialog({
	         					title: '信息',
	         					content: rdata._msg,
	         					ok: function () {
	         						//删除成功后刷新页面
	         						if(rdata._code == "1"){
	         							doSearch();
	         						}
	         					}
	         				}).showModal();
	         			}
	         		});
	             },cancel:function(){}
	         }).showModal();
		}
		
		//搜索
		function doSearch(){
			if( typeof(arguments[0]) != "undefined" && arguments[0] == true)
				$("#pageNum").val(1);
			$("#orderBy").closest("form").submit();
		}
		//执行任务作业
		function startJob(jobid,lts_run_node){
			// ruleType 1:资源目录标签 2:SQL标签 3：实体
			$.ajax({
			   type: "POST",
			   url: "${ctx}/define/plan-excuse-handJob.vm",
			   data: {"LTS_RUN_NODE":lts_run_node,"ruleType":'3',"JOBID":jobid},
			   dataType: "text",
			   success: function(result){
		      		dialog({
		    	        title: '提示',
		    	        content: result,
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
