<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/jsp/_common/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh">
<head>
    <title></title>
	<%@ include file="/WEB-INF/jsp/_common/commonCSS.jsp"%>
  	<!--页面自定义的CSS，请放在这里 -->
    <style type="text/css">
        .skin-ViewUI .tooltip.top {
            margin-top: -18px;
        }
        .skin-ViewUI .tooltip>.tooltip-inner {
            background-color: #1890ff;
        }
        .skin-ViewUI .tooltip.top .tooltip-arrow {
            border-top-color: #1890ff
        }
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
                            <form class="form-horizontal" role="form" id="form1" action="list.vm" method="post">
								<!-- MIS系统面包屑 -->
                            	<input type="hidden" name="THS_JDP_RES_DESC" value="${THS_JDP_RES_DESC}">
								<input type="hidden" name="THS_JDP_RES_ID" value="${THS_JDP_RES_ID}">
								<div class="module-layout">
                                <div class="form-group">
                                    <label class="col-sm-1 hidden-xs control-label no-padding-right" for="txtName">
                                        标签实体
                                    </label>
                                    <div class="col-sm-3 col-xs-8">
                                    
                                        <select class="form-control" id="ENTITY_ID" name="ENTITY_ID">
                                        		<option value="">全部</option>
                                       			 <c:forEach var="entity" items="${entityList }">
                                                	<option value="${entity.ENTITY_ID }">${entity.ENTITY_NAME }</option>
                                                </c:forEach>
                                        </select>

                                    </div>

                                    <label class="col-sm-1 hidden-xs control-label no-padding-right" for="txtName">
                                        主题
                                    </label>
                                    <div class="col-sm-3 col-xs-8">
                                            <input type="text" class="form-control" placeholder="关键字" id="TOPIC_NAME" name="TOPIC_NAME"
                                              value = "${TOPIC_NAME}"/>

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
                                    <div class="page-toolbar align-right list-toolbar" style="display:flex;justify-content:space-between""> 
                                        <div style="" class="list-text">
                                          <i class="list-icon-left"></i>列表<i class="list-icon-right"></i>
                                        </div>
                                        <div class="btn-group">
                                          <c:if test="${isAdmin}">
                                        <button type="button" class="btn btn-xs btn-primary btn-xs-ths" id="btnAdd" data-self-href="edit.vm?THS_JDP_RES_ID=${THS_JDP_RES_ID}">
                                            <i class="ace-icon fa fa-plus"></i>
                                            	添加
                                        </button>
                                        <button type="button" class="btn btn-xs btn-danger btn-xs-ths" id="btnDelete"  data-self-js="doDelete()">
                                            <i class="ace-icon fa fa-trash-o"></i>
                                           		 删除
                                        </button>
                                        </c:if>
                                        </div>
                                       </div>  
                         
                                <table id="listTable" class="table  table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <th class="center" style="width: 50px">
                                                <label class="pos-rel">
                                                    <input type="checkbox" class="ace" />
                                                    <span class="lbl"></span>
                                                </label>
                                            </th>
                                            <th class="align-center" data-sort-col="TOPIC_NAME">
                                                主题
                                                <i class="ace-icon fa fa-sort pull-right"></i>
                                            </th>
                                            <th class="align-center" data-sort-col="ENTITY_NAME">
                                                标签实体
                                                <i class="ace-icon fa fa-sort pull-right"></i>
                                            </th>
                                            <th style="width:120px" class="align-center" data-sort-col="STATUS">
                                                状态
                                                <i class="ace-icon fa fa-sort pull-right"></i>
                                            </th>
                                            <th class="align-center" style="width:180px;min-width: 180px;" data-sort-col="A.UPDATE_DATE">
                                                修改日期
                                                <i class="ace-icon fa fa-sort pull-right"></i>
                                            </th>
                                            <th class="align-center" style="width:90px">
                                                操作
                                            </th>
                                        </tr>
                                    </thead>

                                    <tbody>
                                    <c:if test="${pageInfo.total <= 0 }"><tr><td class="align-center" colspan="20">没有检索到相关数据！</td></tr></c:if>
                                     <c:forEach var="item" items="${pageInfo.list}">
                                        <tr>
                                            <td class="center">
                                                <label class="pos-rel">
                                                    <input type="checkbox" class="ace"  value="${item.TOPIC_ID}"/>
                                                    <span class="lbl"></span>
                                                </label>
                                            </td>
                                            <td class="">
                                                    <!-- <a href="read.vm?TOPIC_ID=${item.TOPIC_ID}"></a> -->
                                                   <span> ${item.TOPIC_NAME}</span>
                                            </td>
                                            <td>
                                               <span> ${item.ENTITY_NAME}</span>
                                            </td>
                                            <td  class="align-center">
                                               		<c:if test="${item.STATUS == 10 }">
                                                	 	<span class="label label-sm label-success arrowed-in-right min-width-75">
                                                	 	<i class="ace-icon fa fa-check-circle"></i> 发布 </span>
                                                	</c:if>
                                                    <c:if test="${item.STATUS != 10 }">
                                                    	<span class="label label-sm label-warning arrowed-in-right min-width-75">
                                                        <i class="ace-icon fa fa-minus-circle"></i> 草稿 </span>
                                                    </c:if>
                                            </td>

                                            <td  class="align-center">
												<fmt:formatDate value="${item.UPDATE_DATE}" type="date" pattern="yyyy-MM-dd HH:mm:ss"/> 
                                            </td>
                                            <td class=" align-center col-op-ths">
                                            	<c:if test="${isAdmin}">
                                                <button type="button" class="btn btn-sm btn-white btn-info btn-op-ths"
                                                    data-self-href="edit.vm?THS_JDP_RES_ID=${THS_JDP_RES_ID}&TOPIC_ID=${item.TOPIC_ID}" data-toggle="tooltip" title="编辑">
                                                    <i class="ace-icon fa fa-edit"></i>编辑
                                                </button>
                                                </c:if>
                                            	<c:if test="${!isAdmin}">
                                                <button type="button" class="btn btn-sm btn-white btn-info btn-op-ths"
                                                    data-self-href="edit.vm?THS_JDP_RES_ID=${THS_JDP_RES_ID}&TOPIC_ID=${item.TOPIC_ID}" data-toggle="tooltip" title="查看">
                                                    <i class="ace-icon fa fa-search"></i>查看
                                                </button>
                                                </c:if>
                                                <button type="button" class="btn btn-sm btn-white btn-info btn-op-ths"
                                                    data-self-href="${ctx}/define/tag/list.vm?THS_JDP_RES_ID=${THS_JDP_RES_ID}&topicCode=${item.TOPIC_CODE}&stype=topiclist" data-toggle="tooltip" title="主题标签定义">
                                                    <i class="ace-icon fa fa-tags"></i>主题标签定义
                                                </button>
                                                <!--
                                                <button type="button" class="btn btn-sm btn-white btn-success btn-op-ths"
                                                data-ths-href="ServiceTest.html" title="服务测试">
                                                <i class="ace-icon fa fa-cloud "></i>
                                            </button>
                                            -->
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
	
	//搜索
	function doSearch(){
		if( typeof(arguments[0]) != "undefined" && arguments[0] == true)
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
		__doDelete(_ids,"delete.vm",function(){
			//刷出之后，刷新列表
			doSearch();
		});
	}
	
	jQuery(function($){
		//初始化表格的事件，如表头排序，列操作等
		__doInitTableEvent("listTable");
		$("#ENTITY_ID").val("${ENTITY_ID}");
	});
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
