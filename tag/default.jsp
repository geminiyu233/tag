<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="/WEB-INF/jsp/_common/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh">
<head>
<title>污染源档案维护</title>
<!--浏览器兼容性设置-->
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta charset="utf-8" />

<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />

<!-- bootstrap & fontawesome -->
<link rel="stylesheet" href="${ctx}/assets/blue/css/bootstrap.css" />
<link rel="stylesheet" href="${ctx}/assets/components/font-awesome/css/font-awesome.css" />
<!-- ace styles -->

<link rel="stylesheet" href="${ctx}/assets/blue/css/ace.css" class="ace-main-stylesheet" id="main-ace-style"/>
<%-- <link rel="stylesheet" href="${ctx}/assets/blue/css/ace-split2.css" class="ace-main-stylesheet" id="main-ace-style"/> --%>
<!--[if lte IE 9]>
<link rel="stylesheet" href="${ctx}/assets/blue/css/ace-part2.css" class="ace-main-stylesheet"/>
<![endif]-->
<link rel="stylesheet" href="${ctx}/assets/blue/css/ace-skins.css" />
<!--THS CSS 插件-->
<link rel="stylesheet" href="${ctx}/assets/css/common/ths-custom.css"/>
<!--[if lte IE 9]>
    <link rel="stylesheet" href="${ctx}/assets/blue/css/ace-ie.css"/>
    <![endif]-->
<link rel="stylesheet" href="${ctx}/assets/blue/css/ths-menu.css" />

<!-- 自己写的CSS，请放在这里 -->
<style type="text/css">
</style>

<!-- ace settings handler -->
<script src="${ctx}/assets/js/menu/ace-extra.js"></script>

<!-- HTML5shiv and Respond.js for IE8 to support HTML5 elements and media queries -->

<!--[if lte IE 8]>
    <script src="${ctx}/assets/components/html5shiv/dist/html5shiv.min.js"></script>
    <script src="${ctx}/assets/components/respond/dest/respond.min.js"></script>
    <![endif]-->
</head>

<body class="no-skin">
	<div id="navbar" class="navbar navbar-default ths-top-menu">
		<div class="navbar-header pull-left">
			<!-- #section:basics/navbar.layout.brand -->
			<a href="#" class="navbar-brand navbar-brand-line no-padding"> <small>
					<i class="width_34"><img style="width: 35px;" src="${ctx}/assets/blue/images/logo.png"></i> <span>标签管理</span>
			</small>
			</a>
		</div>
		<div id="sidebarTop"
			class="sidebar h-sidebar navbar-collapse collapse  no-padding ">
			<ul class="nav nav-list ths-top-menu-ul">
				<li class="hover active">
					<a href="${ctx}/home/homepage_info.vm" target="main" class="ths-top-menu-a" data-level="top" onclick="switchMenu('menuhome')"> 
						<i class="menu-icon fa fa-desktop"></i> <span class="menu-text">首页 </span> 
					</a> 
					<b class="arrow"></b>
				</li>
				<li class="hover">
					<a href="${ctx}/entity/list.vm" target="main" class="ths-top-menu-a" data-level="top" onclick="switchMenu('menutag')"> 
						<i class="menu-icon fa fa-desktop"></i> <span class="menu-text">标签管理 </span> 
					</a> 
					<b class="arrow"></b>
				</li>
			</ul>
		</div>
	</div>
	<div class="main-container" id="main-container">
		<div id="sidebar" class="sidebar responsive  sidebar-fixed">
			<!-- 标签管理 -->
			<ul id="menuair" class="nav nav-list"  style="position: relative; top: 0px; transition-property: top; transition-duration: 0.15s;">
			  <li class=""><a href="${ctx}/entity/list.vm"  target="main"  menu_icon="fa-folder-o"><i class="menu-icon fa fa-folder-o"></i><span
			        class="menu-text">标签实体 </span></a></li>
			  <li class=""><a href="${ctx}/define/main.vm" target="main" menu_icon="fa-tag"><i class="menu-icon fa fa-tag"></i><span
			        class="menu-text">标签定义 </span></a></li>
			  <li class=""><a href="${ctx}/evaluate/list.vm" target="main" menu_icon="fa-industry"><i class="menu-icon fa fa-industry"></i><span
			        class="menu-text">标签评估 </span></a></li>
			  <li class=""><a href="${ctx}/topic/list.vm" target="main" menu_icon="fa-th"><i class="menu-icon fa fa-th"></i><span
			        class="menu-text">主题管理 </span></a></li>
			  <li class=""><a href="${ctx}/job/list.vm" target="main" menu_icon="fa-tasks"><i class="menu-icon fa fa-tasks"></i><span
			        class="menu-text">作业监控 </span></a></li>
			  <li class=""><a href="${ctx}/log/list.vm"target="main" menu_icon="fa-file-text-o"><i class="menu-icon fa fa-file-text-o"></i><span
			        class="menu-text">标签访问日志 </span></a></li>
			  <li class=""><a href="${ctx}/datasource/data-source-config!showlist.vm" target="main"><i class="menu-icon fa fa-arrow-circle-right"></i><span
			        class="menu-text">数据源管理 </span></a></li>
			  <li class=""><a href="${ctx}/dictionary/dictionary_manager_list.vm" target="main" menu_icon="fa-book"><i class="menu-icon fa fa-book"></i><span
			        class="menu-text">字典配置管理 </span></a></li>
			</ul>
			<div class="sidebar-toggle sidebar-collapse" id="sidebar-collapse">
				<i id="sidebar-toggle-icon"
					class="ace-icon fa fa-angle-double-left "
					data-icon1="ace-icon fa fa-angle-double-left"
					data-icon2="ace-icon fa fa-angle-double-right"></i>
			</div>
		</div>
		<div class="main-content">
			<div id="main-content-inner" class="main-content-inner">
				<iframe id="main-content-iframe" name="main" frameBorder="0"
					style="width: 100%; border: none; overflow-x: hidden; overflow-y: auto;vertical-align:bottom;"
					scrolling="auto" src="${ctx}/home/homepage_info.vm"></iframe>
			</div>
		</div>
	</div>
	<!--[if !IE]> -->
	<script src="${ctx}/assets/components/jquery/dist/jquery.js"></script>
	<!-- <![endif]-->
	<!--[if IE]>
	<script src="${ctx}/assets/components/jquery.1x/dist/jquery.js"></script>
	<![endif]-->
	<script type="text/javascript">
		if ('ontouchstart' in document.documentElement)
			document.write("<script src='${ctx}/assets/components/_mod/jquery.mobile.custom/jquery.mobile.custom.js'>" + "<" + "/script>");
	</script>
	<script src="${ctx}/assets/components/bootstrap/dist/js/bootstrap.js"></script>
	<script src="${ctx}/assets/js/menu/elements.scroller.js"></script>
	<script src="${ctx}/assets/js/ace.js"></script>
	<script src="${ctx}/assets/js/menu/ace.basics.js"></script>
	<script src="${ctx}/assets/js/menu/ace.sidebar.js"></script>
	<script src="${ctx}/assets/js/menu/ace.sidebar-scroll-1.js"></script>
	<script src="${ctx}/assets/js/menu/ace.submenu-hover.js"></script>
	<!-- 自己写的JS，请放在这里 -->
	<script type="text/javascript">
		function resizeIframe() {
			var hegiht = document.documentElement.clientHeight;
			var topHeight = document.getElementById('main-content-iframe').offsetTop;
			hegiht -= topHeight;
		    document.getElementById('main-content-iframe').style.height = hegiht+"px";
		}
		
		$("#sidebar").removeClass("sidebar").hide();
	
		document.getElementById('main-content-iframe').onload = resizeIframe;
		window.onresize = resizeIframe;
		
		/**切换目录方法**/
		function switchMenu(menuType){
			if(typeof(menuType) == 'undefined'){
				return;
			}
			if(menuType == 'menuhome'){
				$("#menutag").css('display','none');
				$("#menuhome").css('display','block');
				
				$("#sidebar").removeClass("sidebar").hide();
				$("#main-content-iframe").attr("src","${ctx}/home/homepage_info.vm")
			}
			if(menuType == 'menutag'){
				$("#menutag").css('display','block');
				$("#menuhome").css('display','none');
				
				$("#sidebar").addClass("sidebar").show();
				$("#main-content-iframe").attr("src","${ctx}/entity/list.vm")
			}
		}
		function information(){
			alert("正在开发中......");
		}
	</script>
</body>
</html>


