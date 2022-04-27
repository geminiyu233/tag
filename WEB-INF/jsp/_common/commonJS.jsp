<script type="text/javascript">
    if ('ontouchstart' in document.documentElement) 
    	document.write("<script src='${ctx}/assets/components/jquery.mobile.custom/jquery.mobile.custom.js'>" + "<" + "/script>");
</script>
<script src="${ctx}/assets/components/bootstrap/dist/js/bootstrap.js"></script>

<!-- page specific plugin scripts -->
<script src="${ctx}/assets/components/My97DatePicker/WdatePicker.js"></script><!--æ¥ææ§ä»¶-->
<script src="${ctx}/assets/components/artDialog/dist/dialog-plus.js"></script><!--artDialog 6.x,æºç å·²æ¹,å¿æ¿æ¢-->
<script src="${ctx}/assets/components/jQuery-Validation-Engine/jquery.validationEngine-zh_CN.js" type="text/javascript"></script>
<script src="${ctx}/assets/components/jQuery-Validation-Engine/jquery.validationEngine.js" type="text/javascript"></script>

<!-- ztree -->
<script src="${ctx}/assets/components/zTree/js/jquery.ztree.all.js" type=text/javascript></script>
<script src="${ctx}/assets/components/zTree/js/jquery.ztree.exedit.js" type=text/javascript></script>
<!-- echart -->

<script src="${ctx}/assets/components/echarts/3.x/echarts.min.js" type=text/javascript></script>

<!--ace script-->
<script src="${ctx}/assets/js/ace.js"></script>
<!--THS å·¥å·ç±» script-->
<script src="${ctx}/assets/js/ths-util.js"></script>
<!--THS è¡¨åæä½ script-->
<script src="${ctx}/assets/js/ths-form.js"></script>
<script type="text/javascript">
	//åè½æä½çæéæ§å¶(æ æéçéè)
	jQuery(function ($) {
		var __isAdmin = '<%=ths.jdp.core.context.PropertyConfigure.getProperty("superadmin")!=null && ths.jdp.project.web.LoginCache.getLoginUser(request) != null && ths.jdp.project.web.LoginCache.getLoginUser(request).getLoginName().equals(ths.jdp.core.context.PropertyConfigure.getProperty("superadmin").toString()) %>';
		if(__isAdmin != 'true'){
		 	
		}
		$('[data-toggle="tooltip"]').tooltip();
		
		// 高级搜索事件
		$('.high-search-btn').click(function(){
			$(this).toggleClass('up');
			if ($(this).hasClass('up')) {
				$('.high-search-box').show();
			}else {
				$('.high-search-box').hide();
			}
		});
	});
</script>
