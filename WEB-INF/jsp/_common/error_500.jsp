<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/jsp/_common/taglib.jsp"%>
<!DOCTYPE html>
<html>

<head>
	<title>错误</title>
	<meta charSet="utf-8" />
	<meta httpEquiv="X-UA-Compatible" content="IE=edge" />
	<meta httpEquiv="Cache-Control" content="no-siteapp" />
	<meta name="renderer" content="webkit" />
	<meta name="keywords" content="demo" />
	<meta name="description" content="demo" />
	<meta name="viewport" content="width=device-width, initial-scale=1" />
	<link rel="stylesheet" type="text/css" href="${ctx}/common/error/dist/css/_common.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/common/error/dist/css/style.css">
</head>

<body>
<div class="statusCodePage">
	<div class="errorPageMain">
		<div class="defaultError error500">
			<img src="${ctx}/common/error/dist/img/500.png">
		</div>
		<h4 class="pageTips">您访问的页面暂时无法加载，正在努力修复中...</h4>
		<div class="errorBackBtn">
			<!--        <div class="fn-inline btnEl returnHome" @click="backHome">
      <i class="fn-inline btnIcon"></i>
      <span class="fn-inline btnName">返回首页</span>
    </div> -->
			<div class="fn-inline btnEl returnPreLevel" onclick="goback()">
				<i class="fn-inline btnIcon"></i>
				<span class="fn-inline btnName">返回上级</span>
			</div>
		</div>
	</div>
</div>
<script>
	function goback() {
		history.go(-1);
	}
</script>
</body>

</html>
