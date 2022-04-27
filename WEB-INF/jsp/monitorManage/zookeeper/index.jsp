<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="/WEB-INF/jsp/_common/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh">
<head>
<title></title>
<%@ include file="/WEB-INF/jsp/_common/commonCSS.jsp"%>
<%@ include file="/WEB-INF/jsp/_common/commonJS.jsp"%>
<!--页面自定义的CSS，请放在这里 -->
<style type="text/css">
</style>
</head>
<body class="no-skin">
	<div class="main-container" id="main-container">
		<div class="main-content">
			 <c:if test="${not empty THS_JDP_RES_DESC}">
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
			<div class="main-content-inner padding-page-content">
				<div class="page-content">
					<div class="space-4"></div>
					<div class="row">
						<div class="col-xs-12">
							<div class="module-layout">
							<div class="page-toolbar align-right list-toolbar">
							</div>
							<!-- 列表区域 -->
							<table id="simple-table" class="table  table-bordered table-hover">
								<thead>
									<tr>
										<th class="align-center hidden-xs">节点类型</th>
										<th class="align-center hidden-xs">节点组名</th>
										<th class="align-center hidden-xs">IP</th>
										<th class="align-center hidden-xs">端口</th>
									</tr>
								</thead>
								<tbody>
									<c:choose>
										<c:when test="${empty ltsList}">
											<tr>
												<td colspan="4" align="center">未查询到信息</td>
											</tr>
										</c:when>
										<c:otherwise>
											<c:forEach items="${ltsList}" var="lts">
												<tr>
													<td>${lts.NODE_TYPE}</td>
													<td>${lts.GROUP}</td>
													<td class="align-center">${lts.IP}</td>
													<td class="align-center">${lts.HTTP_CMD_PORT}</td>
												</tr>
											</c:forEach>
										</c:otherwise>
									</c:choose>

								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
			<!--/.main-content-inner-->
		</div>
		<!-- /.main-content -->
	</div>
	<!-- /.main-container -->
</body>
</html>
