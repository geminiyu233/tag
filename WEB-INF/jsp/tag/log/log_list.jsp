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
	                    </ul>
	
	                </div>
	            </div>
            </c:if>
            <div class="main-content-inner padding-page-content">
                <div class="page-content">
                    <div class="space-4"></div>
                    <div class="row">
                        <div class="col-xs-12">
                            <form class="form-horizontal" role="form" id="form1" action="list.vm" method="post">
								<%@ include file="/WEB-INF/jsp/_common/commonArgs.jsp"%>
								<!-- MIS系统面包屑 -->
                            	<input type="hidden" name="THS_JDP_RES_DESC" value="${THS_JDP_RES_DESC}">
								<input type="hidden" name="THS_JDP_RES_ID" value="${THS_JDP_RES_ID}">
								<div class="module-layout">
                                <div class="form-group">
                                    <label class="col-sm-1 hidden-xs control-label no-padding-right" for="txtName">
                                      	  标签实体
                                    </label>
                                    <div class="col-sm-3 col-xs-8">
                                      <select class="form-control" id="entityId" name="entityId">
                                            <option value="">所有实体</option>
                                            <c:forEach var="e" items="${entityList }">
                                            	<option value="${e.ENTITY_ID }" ${e.ENTITY_ID == entityId ? 'selected' : '' }>${e.ENTITY_NAME }</option>
                                            </c:forEach>
                                        </select>
                                    </div>

                                    <label class="col-sm-1 hidden-xs control-label no-padding-right" for="txtName">
                                      	  标签名称
                                    </label>
                                    <div class="col-sm-3 col-xs-8">
                                        <div class="input-group">
                                            <input type="hidden" id="tagCode" name="tagCode" value="${tagCode }" />
                                            <input type="text" class="form-control" name="tagName" value="${tagName }" id="tagName"  readonly="readonly" />
                                            <span class="input-group-btn">
                                                <button type="button" class="btn btn-white btn-default" onclick="chooseTag('checkbox','tagMutiCallBack','tagCode','tagName')">
                                                    <i class="ace-icon fa fa-search"></i>
                                                </button>
                                                <button type="button" class="btn btn-white btn-clear" onclick="clearValue(this)">
                                                    <i class="ace-icon fa fa-remove"></i>
                                                </button>
                                            </span>
                                        </div>

                                    </div>

                                    <div class="col-sm-4 col-xs-8 align-right">
                                        <button type="button" class="btn btn-info btn-default-ths" id="btnSearch" onclick="doSearch(true)">
                                            <i class="ace-icon fa fa-search"></i>
                                           	 搜索
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
                                    		<th class="align-center" width="80px">序号</th>	                                        
                                            <th class="align-center">
                                               	标签名称
                                            </th>
                                            <th class="align-center" >
                                               	 标签实体
                                            </th>
                                            <th class="align-center" style="width:200px">
                                               	 访问来源
                                            </th>

                                            <th class="align-center" style="width:120px">
                                              	访问用户
                                            </th>
                                            <th class="align-center" style="width:180px;min-width: 180px;"  data-sort-col="VISIT_DATE">
                                               	 访问时间
                                                <i class="ace-icon fa fa-sort pull-right"></i>
                                            </th>
                                        </tr>
                                    </thead>

                                    <tbody>
                                       	<c:if test="${pageInfo.total <= 0 }"><tr><td class="align-center" colspan="20">没有检索到相关数据！</td></tr></c:if>
										<c:forEach items="${pageInfo.list}" var="tag" varStatus="status">
											<tr>
												<td class="align-center"><span>${(pageInfo.pageNum - 1) * pageInfo.pageSize + status.index + 1}</span></td>
												<td class="align-left"><span>${tag.TAG_NAME}</span></td>
												<td class="align-left"><span>${tag.ENTITY_NAME}</span></td>
												<td class="align-left"><span>${tag.VISIT_SOURCE}</span></td>
												<td class="align-left"><span>${tag.VISIT_USERNAME}</span></td>
												<td class="align-center"><fmt:formatDate value="${tag.VISIT_DATE}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
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
	//autoHeightIframe("iframeInfo");
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
		
	
	function chooseTag(checkType,callback,dicCodeId,dicNameId){
		var entityId = $('#entityId').val();
		if(entityId == ''){
	   		dialog({
	 	        title: '提示',
	 	        content: '请先选择实体！',
	 	        wraperstyle:'alert-info',
	 	        ok: function () {}
	 	    }).showModal();
	   		return;
		}
		dialog({
			id:"tag-select-window",
	        title: '选择标签',
	        url: "${ctx}/define/tag/tree/checkbox.vm?checkType="+checkType+"&ENTITY_ID="+entityId+"&callback="+callback+"&dicCodeId="+dicCodeId+"&dicNameId="+dicNameId,
	        width:400,
	        height:460,
	    }).showModal();
	}
	//关闭dialog
	function closeDialog(id){
		dialog.get(id).close().remove();
	}	
	
	//清除已选择的数据
	function clearValue(btn){	
		$(btn).parents('.input-group').find('input').val('');
		$(btn).parents('.form-group').find('li').remove();
	}	

	//选择父节点Dialog回调函数
	function tagMutiCallBack(ids,names){
		
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
