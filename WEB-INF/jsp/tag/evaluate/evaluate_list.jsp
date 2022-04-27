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
	                        <li class="active"><i class="fa fa-arrow-right"></i><span class="THS_JDP_RES_DESC">${THS_JDP_RES_DESC}</span></li>
	                    </ul><!-- /.breadcrumb -->
	                </div>
	            </div>
            </c:if>
            <div class="main-content-inner padding-page-content">
                <div class="page-content">
                    <div class="space-4"></div>
                    <div class="row">
                        <div class="col-xs-12">
                            <form class="form-horizontal" role="form" id="form" action="${ctx }/evaluate/list.vm" method="post">
								<!-- MIS系统面包屑 -->
                            	<input type="hidden" name="THS_JDP_RES_DESC" value="${THS_JDP_RES_DESC}">
								<input type="hidden" name="THS_JDP_RES_ID" value="${THS_JDP_RES_ID}">
								<div class="module-layout">
                                <div class="form-group">
                                    <label class="col-sm-1 hidden-xs control-label no-padding-right" >
                                       	 时间范围
                                    </label>
                                    <div class="col-sm-3 col-xs-8">
                                        <select class="form-control" id="period" name="period">
                                            <option value="1" ${period == '1' ? 'selected' : '' } ${topNum == '20' ? 'selected' : '' }>最近一周</option>
                                            <option value="2" ${period == '2' ? 'selected' : '' }>最近一月</option>
                                            <option value="3" ${period == '3' ? 'selected' : '' }>最近一年</option>
                                        </select>

                                    </div>
<!--                                     <div class="col-sm-3 col-xs-8"> -->
<!--                                         <select class="form-control" id="topNum" name="topNum"> -->
<%--                                             <option value="20" ${topNum == '20' ? 'selected' : '' }>TOP20</option> --%>
<%--                                             <option value="50" ${topNum == '50' ? 'selected' : '' }>TOP50</option> --%>
<%--                                             <option value="100" ${topNum == '100' ? 'selected' : '' }>TOP100</option> --%>
<!--                                         </select> -->

<!--                                     </div> -->
                                    <div class="col-sm-3 col-xs-8">
                                        <select class="form-control" id="entityId" name="entityId">
                                            <option value="">所有实体</option>
                                            <c:forEach var="e" items="${entityList }">
                                            	<option value="${e.ENTITY_ID }" ${e.ENTITY_ID == entityId ? 'selected' : '' }>${e.ENTITY_NAME }</option>
                                            </c:forEach>
                                        </select>

                                    </div>

                                    <div class="col-sm-5 col-xs-4 align-right">
                                        <button type="button" class="btn btn-info btn-default-ths" id="btnSearch" onclick="doSearch(true)">
                                            <i class="ace-icon fa fa-search"></i>
                                            	查询
                                        </button>

                                    </div>
                                </div>
								</div>
								
								<div class="module-layout">
                               
                                <div class="page-toolbar align-right list-toolbar">
                                 <!--//
                                        <button type="button" class="btn btn-xs btn-primary btn-xs-ths" id="btnAdd" data-ths-href="TopicEdit.html">
                                            <i class="ace-icon fa fa-plus"></i>
                                           	 添加
                                        </button>
                                        <button type="button" class="btn btn-xs btn-danger btn-xs-ths" id="btnDelete">
                                            <i class="ace-icon fa fa-trash-o"></i>
                                           	删除
                                        </button>
                                       //-->
        
                                    </div>
                                    
                                <table id="listTable" class="table  table-bordered table-hover">
                                    <thead>
                                        <tr>
                                    		<th class="align-center" width="80px">序号</th>		                                           
                                            <th class="align-center" style="width:200px"><i class="ace-icon fa fa-tag"></i>
                                                	标签名称
                                            </th>
                                            <th class="align-center" style="width:200px"  ><i class="ace-icon fa fa-folder-o"></i>
                                               	 	所属实体
                                            </th>
                                            <th  class="align-center">
                                                	分类路径
                                            </th>
                                            <th class="align-center" style="width:160px" data-sort-col="VISIT_COUNT"><i class="ace-icon fa fa-bar-chart "></i>
                                                	使用次数
                                                <i class="ace-icon fa fa-sort pull-right"></i>
                                            </th>
                                        </tr>
                                    </thead>

                                    <tbody>
										<c:if test="${pageInfo.total <= 0 }"><tr><td class="align-center" colspan="20">没有检索到相关数据！</td></tr></c:if>
										<c:forEach items="${pageInfo.list}" var="tag" varStatus="status">
											<tr>
												<td class="align-center">${(pageInfo.pageNum - 1) * pageInfo.pageSize + status.index + 1}</td>
												<td class="align-left">${tag.TAG_NAME}</td>
												<td class="align-left">${tag.ENTITY_NAME}</td>
												<td class="align-left">${tag.PATH}</td>
												<td class="align-right">${tag.VISIT_COUNT}</td>
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
<iframe id="iframeInfo" name="iframeInfo" class="frmContent"  src="" style="border: none; display: none" frameborder="0"   width="100%"></iframe>
        
<%@ include file="/WEB-INF/jsp/_common/commonJS.jsp"%>

<!-- 自己写的JS，请放在这里 -->
<script type="text/javascript">
	//设置iframe自动高
	autoHeightIframe("iframeInfo");
	
	
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
</script>
</body>
</html>
