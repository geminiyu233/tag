<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/jsp/_common/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh">
<head>
    <title>项目费用</title>
	<%@ include file="/WEB-INF/jsp/_common/commonCSS.jsp"%>
  	<!--页面自定义的CSS，请放在这里 -->
    <style type="text/css">

    </style>
</head>

<body class="no-skin">

<div class="main-container" id="main-container">
    <div class="main-content">
        <c:if test="${!empty THS_JDP_RES_DESC}"> 
	        <div class="main-content-inner fixed-page-header fixed-82">
	            <div id="breadcrumbs" class="breadcrumbs">
	                <ul class="breadcrumb">
	                    <li class="active">
	                        <h5 class="page-title" >
	                            <i class="fa fa-edit"></i>
	                            <span class="THS_JDP_RES_DESC">
									${THS_JDP_RES_DESC}
								</span>
	                        </h5>
	                    </li>
	                </ul><!-- /.breadcrumb -->
	            </div>
	            <!-- <div class="page-toolbar align-right">
	                <button type="button" class="btn btn-xs    btn-xs-ths" id="btnSave" data-self-js="save()">
	                    <i class="ace-icon fa fa-save"></i>
	                    保存
	                </button>
	                <button type="button" class="btn btn-xs    btn-xs-ths" id="btnSubmit" data-self-js="doSubmit()">
	                    <i class="ace-icon fa fa-check"></i>
	                    提交
	                </button>
	                <button type="button" class="btn btn-xs btn-xs-ths" id="btnReturn" data-self-js="goBack()">
	                    <i class="ace-icon fa fa-reply"></i>
	                    返回
	                </button>
	                <div class="space-2"></div>
	                <hr class="no-margin">
	            </div> -->
	
	        </div>
        </c:if>
        <div class="main-content-inner padding-page-content">
            <div class="page-content">
                <div class="space-4"></div>
                <div class="row">
                    <div class=" col-xs-12">
                        	${info}
                    </div>
                </div><!-- /.row -->
            </div>
        </div><!--/.main-content-inner-->
    </div><!-- /.main-content -->
</div><!-- /.main-container -->

<%@ include file="/WEB-INF/jsp/_common/commonJS.jsp"%>

<!-- 自己写的JS，请放在这里 -->
<script type="text/javascript">
	
</script>
</body>
</html>
