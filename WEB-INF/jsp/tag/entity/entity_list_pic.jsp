<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/jsp/_common/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh">
<head>
    <title></title>
	<%@ include file="/WEB-INF/jsp/_common/commonCSS.jsp"%>
  	<!--页面自定义的CSS，请放在这里 -->
    <style type="text/css">
	.entityItem{
		height: 200px; width: 150px; border: solid 1px #ededed; text-align: center; padding: 3px;
		margin-bottom: 15px;
	}
	.itemTool{
		margin-top: 20px;padding-right:10px; text-align: right; font-size: 18px;font-weight: blod;
	}
	.itemTool a{
		color:#7794a8;
		margin-left: 4px;
		cursor: pointer;
	}
	.itemTool a:hover{
		color:#337ab7;
	}
	.itemName{
		margin-top: 10px; font-size: 19px;color:#4672c4;
		height:42px;
		word-break : break-all;
	}
	.entityItem a:hover{
		text-decoration: none;
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
        <div class="main-content-inner fixed-page-header fixed-40">
            <div id="breadcrumbs" class="breadcrumbs">
                <c:if test="${!empty THS_JDP_RES_DESC}">
	                <ul class="breadcrumb">
	                    <li class="active">
	                    	<i class="fa fa-arrow-right"></i>
	                    	<span class="THS_JDP_RES_DESC">
								${THS_JDP_RES_DESC}
							</span>
	                    </li>
	                </ul><!-- /.breadcrumb -->
                </c:if>
                <div class="breadcrumbs" style="float:right">
                    <button type="button" class="btn btn-xs btn-danger btn-xs-ths" id="btnSearch" data-self-href="${ctx }/entity/listmx.vm?THS_JDP_RES_ID=${THS_JDP_RES_ID}">
                    <i class="ace-icon fa fa-list-alt"></i>列表</button>
            	</div>
            </div>
        </div>
        <div class="main-content-inner padding-page-content">
            <div class="page-content">
                <div class="space-4"></div>
                <div class="row">
                    <div class="col-xs-12">
                        	<form class="form-horizontal" role="form" id="formList" action="${ctx }/entity/list.vm" method="post">
                          
                            <div class="row">
                                <div class="col-xs-12">
                                	<c:if test="${isAdmin}">
                                    <div class="col-xs-6 col-sm-3 col-md-2">
                                    	<div class="entityItem" style="padding-top: 32px">
                                    	<a data-self-href="${ctx}/entity/edit.vm?THS_JDP_RES_ID=${THS_JDP_RES_ID}" >
                                    		<img src="${ctx}/assets/img/add_entity.png" style="width:130px; height:130px"/>
                                    		</a>
                                    	</div>
                                       
                                    </div>
                                    </c:if>
                                    <c:forEach var="entity" items="${entityList}">
                                    <div class="col-xs-6 col-sm-3 col-md-2">
                                    	<div class="entityItem" >
                                    		<img src="${ctx}/assets/img/entity-${entity.ENTITY_PORTRAIT }.jpg" style="width:140px; height:85px"/>
                                    		<div class="itemName"><a>${entity.ENTITY_NAME }</a></div>
                                    		<div class="itemTool" >
                                    			  <a data-self-href="${ctx}/define/main.vm?THS_JDP_RES_ID=${THS_JDP_RES_ID}&entitySelect=${entity.ENTITY_ID }" data-toggle="tooltip" title="标签定义"><i class="ace-icon fa fa-sitemap"></i>标签定义</a>
                                    			 <c:if test="${isAdmin}">
                                    			  <a data-self-js="startJob('${entity.ENTITY_ID }','${entity.LTS_RUN_NODE }')" data-toggle="tooltip" title="手动执行"><i class="ace-icon fa fa-play" ></i>手动执行</a>
                                    			 </c:if>
                                    			  <a data-self-href="${ctx}/entity/tag/list.vm?THS_JDP_RES_ID=${THS_JDP_RES_ID}&ENTITY_ID=${entity.ENTITY_ID }"  data-toggle="tooltip" title="标签查询"><i class="ace-icon fa fa-tags"></i>标签查询</a>
                                    			  <c:if test="${isAdmin}">
                                    			  <a data-self-href="${ctx}/entity/edit.vm?THS_JDP_RES_ID=${THS_JDP_RES_ID}&ENTITY_ID=${entity.ENTITY_ID }"  data-toggle="tooltip" title="实体编辑"><i class="ace-icon fa fa-pencil" ></i>实体编辑</a>
                                    			  </c:if>
                                    			  <c:if test="${!isAdmin}">
                                    			  <a data-self-href="${ctx}/entity/edit.vm?THS_JDP_RES_ID=${THS_JDP_RES_ID}&ENTITY_ID=${entity.ENTITY_ID }"  data-toggle="tooltip" title="实体查看"><i class="ace-icon fa fa-search" ></i>实体查看</a>
                                    			  </c:if>
                                    			 <c:if test="${isAdmin}">
                                    			  <a data-self-js="doDeleteOne('${entity.ENTITY_ID }')" data-toggle="tooltip" title="实体删除"><i class="ace-icon fa fa-trash" ></i>实体删除</a>
                                    			 </c:if>
                                    		</div>
                                    	</div>
                                    </div>
                                    </c:forEach>
                                   
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div><!--/.main-content-inner-->
    </div><!-- /.main-content -->
</div><!-- /.main-container -->

<iframe id="iframeInfo" name="iframeInfo" class="frmContent"  src="" style="border: none; display: none" frameborder="0" width="100%"></iframe>
        
<%@ include file="/WEB-INF/jsp/_common/commonJS.jsp"%>

<!-- 自己写的JS，请放在这里 -->
<script type="text/javascript">
	//设置iframe自动高
	autoHeightIframe("iframeInfo");
	//删除一条数据，可参考此函数
	function doDeleteOne(id){
		__doDelete(id,"delete.vm",function(){
			//刷出之后，刷新列表
			doSearch();
		});
	}
	
	//搜索
	function doSearch() {
		if (typeof (arguments[0]) != "undefined" && arguments[0] == true)
			$("#pageNum").val(1);
		$("#formList").submit();
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
