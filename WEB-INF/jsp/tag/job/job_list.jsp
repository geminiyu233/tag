<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/jsp/_common/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh">
<head>
    <title>作业监控</title>
	<%@ include file="/WEB-INF/jsp/_common/commonCSS.jsp"%>
  	<!--页面自定义的CSS，请放在这里 -->
    <style type="text/css">

    </style>
		    <style>
					table {
						width: 100%;
						table-layout: fixed;
					}
					table tr {
						width: 100%;
						height: 30px;
					}
					td {
						white-space: nowrap;
						overflow: hidden;
						text-overflow: ellipsis;
					}
					.td-info {
						display: none;
						position: absolute;
						z-index: 9999999;
						transition: left 0.4s cubic-bezier(0.23, 1, 0.32, 1) 0s,
							top 0.4s cubic-bezier(0.23, 1, 0.32, 1) 0s;
						padding: 5px 0 8px 0;
						border: 0;
					}
					.td-info .arrow {
						position: absolute;
						width: 0;
						height: 0;
						border-color: transparent;
						border-style: solid;
						bottom: 3px;
						border-width: 5px 5px 0;
						border-top-color: rgba(70, 76, 91, 0.9);
						left: 50%;
						margin-left: -5px;
					}
					.td-info .text {
						max-width: 500px;
						min-height: 34px;
						padding: 7px 12px;
						color: #fff;
						text-align: left;
						text-decoration: none;
						background-color: rgba(70, 76, 91, 0.9);
						border-radius: 4px;
						box-shadow: 0 1px 6px rgb(0 0 0 / 20%);
						white-space: wrap;
						box-sizing: border-box;
						font-size: 12px;
					}
					.list-text {
			display:flex;
			align-items:center;
			font-size:16px;
			color:#1b7ad9;
			line-height:32px;
			font-weight:700
		}
		.list-icon-left {
			display:inline-block;
			width:17px;
			height:18px;
			background:url('../../assets/blue/images/title-left.png') no-repeat;
			background-size: 100% 100%;
			margin-right:10px;
		}
		.list-icon-right {
			display:inline-block;
			width:27px;
			height:15px;
			background:url('../../assets/blue/images/title-right.png') no-repeat;
			background-size: 100% 100%;
			margin-left:7px
		}
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
                            <form class="form-horizontal" role="form" id="formList" action="${ctx }/job/list.vm" method="post">
								<input type="hidden" name="webtype" id="webtype" value="${webtype}" />
            					<input type="hidden" name="topicCode" id="topicCode" value="${topicCode}" />
                                
                                <!-- MIS系统面包屑 -->
                            	<input type="hidden" name="THS_JDP_RES_DESC" value="${THS_JDP_RES_DESC}">
								<input type="hidden" name="THS_JDP_RES_ID" value="${THS_JDP_RES_ID}">
                                
								<div class="module-layout">
<!-- 	                            <div class="high-search-btn-box" style="display:none;"> -->
<!-- 									<a class="high-search-btn">高级搜索<i class="fa fa-angle-down"></i><i class="fa fa-angle-up"></i></a> -->
<!-- 								</div>									 -->
                                <div class="form-group">
                                    <label class="col-sm-1 hidden-xs control-label no-padding-right" for="txtName">
                                       	 标签实体
                                    </label>
                                    <div class="col-sm-3">
										<input type="text" placeholder="请输入标签、标签实体 " class="form-control" name="keyword" value="${keyword}" />
									</div>
									
									<label class="col-sm-1 control-label no-padding-right">变更时间</label>
									<div class="col-xs-3">
										<div class="input-group input-group-date" id="divDate1">
                                    		<input type="text" class="form-control" id="start_date" readonly="readonly" name="start_date" value="${start_date}">
                                            <span class="input-group-btn">
                                                <button type="button" class="btn btn-white  " id="btnDateStart">
                                                    <i class="ace-icon fa fa-calendar"></i>
                                                </button>
                                            </span>
                                        </div>
									</div>
									<label class="col-sm-1 control-label no-padding-right">至</label>
									<div class="col-xs-3">
										<div class="input-group input-group-date" id="divDate2">
                                        	<input type="text" class="form-control" id="end_date" readonly="readonly" name="end_date" value="${end_date}">
                                            <span class="input-group-btn">
                                                <button type="button" class="btn btn-white  " id="btnDateEnd">
                                                    <i class="ace-icon fa fa-calendar"></i>
                                                </button>
                                            </span>
                                      	</div>
									</div>
								</div>
								<div class="form-group">
                                    <c:if test="${empty webtype}">
                                    <label class="col-sm-1 hidden-xs control-label no-padding-right" for="txtName">
                                        	任务类型
                                    </label>
                                    <div class="col-sm-3 ">
                                        <select class="form-control" id="form-field-select-1" name="log_type">
                                            <option value="tag" <c:if test="${log_type == 'tag'}">selected="selected"</c:if> >标签</option>
                                            <option value="entity" <c:if test="${log_type == 'entity'}">selected="selected"</c:if> >实体</option>
                                        </select>
                                    </div>
									</c:if>
									<label class="col-sm-1 hidden-xs control-label no-padding-right" for="status">状态
                                    </label>
                                    <div class="col-sm-3 col-xs-8">
                                        <select class="form-control" id="form-field-select-1" name="status">
                                            <option value="">--请选择--</option>
                                            <option value="1" <c:if test="${status == '1'}">selected="selected"</c:if> >成功</option>
                                            <option value="3" <c:if test="${status == '3'}">selected="selected"</c:if> >错误</option>
                                        </select>
									</div>   
									<div class="${empty webtype?'col-xs-4':'col-xs-8'}  align-right">
										<button type="button" class="btn btn-info btn-default-ths" id="btnSearch" data-self-js="doSearch(true);">
	                                		<i class="ace-icon fa fa-search"></i>搜索
		                              	</button>
									</div>
                               	</div>
                               	
								</div>
								<div class="module-layout">
									<div class="page-toolbar align-right list-toolbar" style="display:flex;justify-content:space-between""> 
                    <div style="" class="list-text">
                      <i class="list-icon-left"></i>列表<i class="list-icon-right"></i>
                    </div>
                    <div class="btn-group">
                    
                    </div>
                   </div>  
                                <table id="listTable" class="table  table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <th class="align-center" data-sort-col="ENTITY_NAME">
                                                	标签实体
                                                <i class="ace-icon fa fa-sort pull-right"></i>
                                            </th>
                                            <c:if test="${log_type == 'tag'}">
                                            <th class="align-center" data-sort-col="TAG_NAME">
                                                	标签名称
                                                <i class="ace-icon fa fa-sort pull-right"></i>
                                            </th>
                                            </c:if>
                                            <th class="align-center hidden-xs hidden-sm" data-sort-col="START_DATE" style="width:180px;min-width: 180px;">
                                                	起始时间
                                                <i class="ace-icon fa fa-sort pull-right"></i>
                                            </th>
                                            <th class="align-center hidden-xs hidden-sm" data-sort-col="END_DATE" style="width:180px;min-width: 180px;">
                                                	结束时间
                                                <i class="ace-icon fa fa-sort pull-right"></i>
                                            </th>
                                            <th class="align-center hidden-xs hidden-sm" >
                                                	耗时
                                            </th>

                                            <th class="align-center" style="width:60px" data-sort-col="STATUS">
                                                	状态
                                                <i class="ace-icon fa fa-sort pull-right"></i>
                                            </th>

                                            <th class="align-center" style="width:70px">
                                              	 	详情
                                            </th>
                                    </thead>
									<tbody>
		                                	<c:choose>
												<c:when test="${pageInfo.size > 0}">
													<c:forEach var="item"  items="${pageInfo.list}" varStatus="status">
									                	<tr>
						                                    <td>
						                                    	<span>${item.ENTITY_NAME}</span>
						                                    </td>
						                                    <c:if test="${log_type == 'tag'}">
						                                    <td>
						                                    	<span>${item.TAG_NAME}</span>
															</td>
															</c:if>
						                                    <td class="hidden-xs hidden-sm align-center">
						                                    	<span><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${item.START_DATE}" /></span>
															</td>
						                                    <td class="hidden-xs hidden-sm align-center">
						                                    	<span><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${item.END_DATE}" /></span>
						                                    </td>
															<td class="align-right">
						                                    	<span>${item.TIMES}</span>
															</td>						                                    
						                                    <td class="hidden-xs align-center">
							                                    <c:choose>
																	<c:when test="${item.STATUS=='1' }">
																		<span class="label label-sm label-success arrowed-in-right min-width-75">
                                                        				<i class="ace-icon fa fa-check-circle"></i> 成功 </span>
																	</c:when>
																	<c:when test="${item.STATUS=='3' }">
																		<span class="label label-sm label-danger arrowed-in-right min-width-75">
	                                                            		<i class="ace-icon fa fa-times"></i> 错误 </span>
																	</c:when>
																	<c:when test="${item.STATUS=='2' }">
																		<span class="label label-sm label-warning arrowed-in-right min-width-75">
	                                                                	<i class="ace-icon fa fa-bolt"></i> 警告 </span>
                                                                	</c:when>
																	<c:otherwise>
																		<span class="label label-sm label-primary arrowed-in-right min-width-75">
                                                    					<i class="ace-icon fa fa-ellipsis-h "></i> 执行中 </span>
																	</c:otherwise>
																</c:choose>
						                                    </td>
						                                    <td class="align-center col-op-ths">
						                                    	<c:if test="${log_type == 'entity'}">
						                                        <button type="button" class="btn btn-sm btn-info btn-white btn-op-ths" data-toggle="tooltip" title="详情" onclick="showerror('${item.ENTITY_NAME}','${item.LOG_ID}')">
							                                    	<i class="ace-icon fa fa-file-text"></i>详情
							                                    </button>
							                                    </c:if>
							                                    <c:if test="${log_type == 'tag'}">
							                                    <button type="button" class="btn btn-sm btn-info btn-white btn-op-ths" data-toggle="tooltip" title="详情" onclick="showerror('${item.TAG_NAME}','${item.LOG_ID}')">
							                                    	<i class="ace-icon fa fa-file-text"></i>详情
							                                    </button>
							                                    </c:if>
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
	//autoHeightIframe("iframeInfo");
	jQuery(function($){
		//初始化表格的事件，如表头排序，列操作等
		__doInitTableEvent("listTable");
		
		
		$("#btnDateStart").on(ace.click_event, function() {
			WdatePicker({
				el : "start_date",
				dateFmt:"yyyy-MM-dd",
				maxDate:$("#end_date").val()
			});
		});
		$("#btnDateEnd").on(ace.click_event, function() {
			WdatePicker({
				el : "end_date",
				dateFmt:"yyyy-MM-dd",
				minDate:$("#start_date").val()
			});
		});
	});
	//搜索
	function doSearch() {
		$("#formList").submit();
	}
	function showerror(logtitle,log_id) {
		$.ajax({
			   type: "POST",
			   url: "${ctx}/job/error.vm",
			   data: {"log_id":log_id},
			   dataType: "text",
			   success: function(result){
				   dialog({
						title : logtitle,
						content : '<div style="overflow: auto;height:300px;align:left!important;text-align:left!important;">'+result.replace(/\n/g,"<br/>")+'<div>',
						height : '350px',
						width : '550px',
						quickClose : true
					// 点击空白处快速关闭
					}).show();
			   }
			});
	}
</script>
</body>
<script src="../jquery.min.js"></script>
<script>
	$(document).ready(function(){
		var template = "<div class='td-info'><div class='arrow'></div><div class='text'></div></div>";
		$("body").append(template);
		var tdInfo = $(".td-info");
		var tdDom = $("td");
		tdDom.hover(function (e) {
			var spanWidth = $(this).find('span').width();
			var domWidth = $(this).width();
			if (spanWidth > domWidth) {
					tdInfo.find('.text').text($(this).text());
					tdInfo.css({
						left: $(this).offset().left,
						top: $(this).offset().top - tdInfo.height() - 10,
						display: 'block'
					});
			}
		});
		tdDom.mouseleave(function() {
			tdInfo.hide();
		});
	})
</script>
</html>
