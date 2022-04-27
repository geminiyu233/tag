<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/jsp/_common/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh">
	<head>
	    <title>实体任务执行</title>
	    <%@ include file="/WEB-INF/jsp/_common/commonCSS.jsp"%>
	    <!--THS CSS 插件-->
	    <link rel="stylesheet" href="${ctx }/assets/components/zTree/css/metroStyle/metroStyle.css" type="text/css">
	    <link rel="stylesheet" href="${ctx}/assets/blue/css/proctree.css"/>
	    <!--页面自定义的CSS，请放在这里 -->
	    <style type="text/css">
	        .widget-box{margin: 0px !important;margin-top: -3px !important;}
	        .tab-content{ border: none !important;}
	        .widget-box.transparent > .widget-header {border-bottom: 1px solid #C5D0DC !important;}
	        .widget-box.transparent > .widget-header {border-bottom: 1px solid #C5D0DC !important;}
	        @font-face {
	            font-family: 'FontAwesome';
	            src: url('${ctx}/assets/components/font-awesome/fonts/fontawesome-webfont.eot?v=4.5.0');
	            src: url('${ctx}/assets/components/font-awesome/fonts/fontawesome-webfont.eot?#iefix&v=4.5.0')
	            format('embedded-opentype'),
	            url('${ctx}/assets/components/font-awesome/fonts/fontawesome-webfont.woff2?v=4.5.0')
	            format('woff2'),
	            url('${ctx}/assets/components/font-awesome/fonts/fontawesome-webfont.woff?v=4.5.0')
	            format('woff'),
	            url('${ctx}/assets/components/font-awesome/fonts/fontawesome-webfont.ttf?v=4.5.0')
	            format('truetype'),
	            url('${ctx}/assets/components/font-awesome/fonts/fontawesome-webfont.svg?v=4.5.0#fontawesomeregular')
	            format('svg');
	            font-weight: normal;
	            font-style: normal;
	        }
	
	        .ztree li span.button.org_ico_open,
	        .ztree li span.button.org_ico_close,
	        .ztree li span.button.org_ico_docu,
	        .ztree li span.button.ico_open,
	        .ztree li span.button.ico_close,
	        .ztree li span.button.ico_docu,
	        .ztree li span.button.entity_ico_open,
	        .ztree li span.button.entity_ico_close,
	        .ztree li span.button.entity_ico_docu{
	            background-image: none !important;
	            *background-image: none !important;
	        }
	
	        .ztree li span.button:after,.ztree li span.button:after,.ztree li span.button:after{
	            width: 1.25em;
	            margin-top:3px;
	            text-align: center;
	            display: inline-block;
	            font: normal normal normal 14px/1 FontAwesome;
	            font-size: 15px;
	            text-rendering: auto;
	            -webkit-font-smoothing: antialiased;
	            -moz-osx-font-smoothing: grayscale;
	        }
	        .ztree li span.button.org_ico_open:after,.ztree li span.button.org_ico_close:after,.ztree li span.button.org_ico_docu:after{content: "\f0e8";}
	        .ztree li span.button.ico_close:after,.ztree li span.button.ico_docu:after{content:"\f114";}
	        .ztree li span.button.ico_open:after {content:"\f115";}
	        .ztree li span.button.entity_ico_open:after,.ztree li span.button.entity_ico_close:after,.ztree li span.button.entity_ico_docu:after{content: "\f114";}
	        /* 移动大小设置*/
	        .ui-resizable-e {
	            cursor: e-resize;
	            width: 7px;
	            right: -5px;
	            top: 0;
	            height: 100%;
	        }
	        .ui-resizable-handle {
	            position: absolute;
	            font-size: 0.1px;
	            display: block;
	            -ms-touch-action: none;
	            touch-action: none;
	        }
	    </style>
	</head>

	<body class="no-skin">
		<div class="main-container" id="main-container">
		    <div class="main-content">
		        <div class="main-content-inner padding-page-content">
		            <div style="padding-top: 5px">
		                <div class="col-xs-12 no-padding" style="display: flex;">
		                    <div class="col-xs-3 categorytree no-padding" style="min-width: 200px" id="leftDiv">
		                        <div class="widget-box transparent">
		                            <div class="widget-header">
		                                <h5 class="widget-title lighter smaller hidden-sm hidden-xs" style="margin-left: 5px">${empty THS_JDP_RES_DESC?"实体":THS_JDP_RES_DESC}</h5>
		                                <div class="widget-toolbar no-border">
		                                    <a href="javascript:void(0)" data-action="reload" id="refreshTree">
		                                        <i class="ace-icon fa fa-refresh"></i>
		                                    </a>
		                                </div>
		                            </div>
		                            <div id="divTreeWidget" class="widget-body" style="margin-right: -1px;overflow: auto">
		                                <div class="widget-main padding-2">
		                                    <i id="loading" class="ace-icon fa fa-spinner fa-spin orange bigger-200"></i>
		                                    <ul id="treeDiv" class="ztree no-padding"></ul>
		                                </div>
		                            </div>
		                        </div>
		                    </div>
		                    <div class="col-xs-9 tabable no-padding" id="rightDiv" style="width:100%;">
		                        <ul id="myTab" class="nav nav-tabs ">
		                            <li class="active">
		                                <a href="#frmCatefory" data-toggle="tab">
		                                    <i class=" ace-icon fa fa-folder-open-o bigger-120"></i> 执行日志 ${_auto_task_start_btn_status }
		                                </a>
		                            </li>
		                        </ul>
		                        <div id="tab-content" class="tab-content" style="width: 100%">
									<!-- 隐藏域数据 -->
									<div class="page-toolbar align-left form-group">
			                			<div class="col-sm-3">
			                				<label class="pos-rel">
												<input type="checkbox" name="stype" class="ace" value="entity" checked="checked"/> 
												<span class="lbl">&nbsp;<i class="ace-icon fa fa-folder-o"></i> 实体</span>
											</label>
											
											<label class="pos-rel" style="margin-left: 10px;">
												<input type="checkbox" name="stype" class="ace" value="tag" checked="checked"/> 
												<span class="lbl">&nbsp;<i class="ace-icon fa fa-tag"></i> 标签</span>
											</label>
										</div>
										<div class="col-sm-9 align-left">
											<c:if test="${_auto_task_start_btn_status eq 'on' || empty _auto_task_start_btn_status}">
												<button type="button" class="btn btn-xs btn-primary btn-xs-ths"  id="btnPlay"  onclick="doStartTaskData()">
													<i class="ace-icon fa fa-save"></i> 执行
												</button>
	                                       	</c:if>
	                                       	<c:if test="${_auto_task_start_btn_status eq 'off'}">
	                                       		<button type="button" class="btn btn-xs btn-primary btn-xs-ths disabled"  id="btnPlay"  title="执行中,请稍后！">
													<i class="ace-icon fa fa-save"></i> 执行
												</button>
	                                       	</c:if>
											<button type="button" class="btn btn-xs btn-danger btn-xs-ths" onclick="doCleanLog()" >
												<i class="ace-icon fa fa-trash-o"></i> 清理日志
											</button>
										</div>
									</div>
									<div class="page-toolbar align-left form-group" id="log_progres" style="padding-top: 25px;display: none;">
										<!-- 进度条 -->
										<label class="col-sm-2 control-label no-padding-right" style="width: 80px">
			                                <i class="ace-icon fa smaller-70"> </i> 执行进度
			                            </label>
										<div class="col-sm-9" style="overflow: auto;">
				                            <div id="progressBarParent" class="progress" style="width: 100%;">
												<div id="progressBar" class="progress-bar" style="width: 0%;">0%</div>
											</div>
			                         	</div>
			                         </div>
									<div class="col-sm-12" id="logCatefory" style="overflow: auto;padding-left:35px;">
			                            
		                         	</div>
		                    	</div>
		                    </div>
		                </div>
		            </div>
		        </div><!--/.main-content-inner-->
		    </div><!-- /.main-content -->
		</div><!-- /.main-container -->
		
		<%@ include file="/WEB-INF/jsp/_common/commonJS.jsp"%>
		<%@ include file="/common/socket/socket_client.jsp"%>
		<script type="text/javascript" src="${ctx }/assets/components/zTree/js/jquery.ztree.all.min.js"></script>
		<script src="${ctx}/assets/components/jquery-ui/jquery-ui.js"></script>
		
		<!-- 自己写的JS，请放在这里 -->
		<script type="text/javascript">
		    //------- 目录树  开始 -------
		    var zTreeObj;
		    var serverNodeArray=[];//服务器端返回的节点数组
		    // zTree 的参数配置，深入使用请参考 API 文档（setting 配置详解）
		    var setting = {
		    		check : {
						enable: true,
						chkStyle: "checkbox",
						chkboxType: { "Y": "ps", "N": "ps" },
						radioType: "all"
					},
					callback: {
						beforeClick: beforeClick,
						onCheck: zTreeOnCheck //勾选事件回调函数
					},
					data : {
						simpleData : {
							enable : true
						}
					},
					view : {
						showTitle : false
					}
		    };
		
		    function zTreeOnCheck(event, treeId, treeNode) {
		        if(treeNode && treeNode.id){
		        	zTreeObj.selectNode(treeNode);
		        }
		    };
		
		    //Ajax 请求tree
		    function loadTreeAjax(){
		        $("#treeDiv").hide();
		        $("#loading").show();
		        $.ajax( {
		            url:'${ctx}/entity/entity-start-task/ztree.vm',
		            type:'post',
		            cache:false,
		            dataType:'json',
		            success:function(data) {
		                serverNodeArray = data;
		                renderTreeAdapter();
		            },
		            error : function() {}
		        });
		    }
		
		    //绘制tree
		    function renderTreeAdapter(){
		        var zNodes =[{"id":"ENTITY","name":"标签实体","open":true,"pId":"root","nocheck":"true"},{"id":"GENTITY","name":"汇聚实体","open":true,"pid":"root","nocheck":"true"}];
		        var j  = zNodes.length;
		        for(var i = 0 ; i<serverNodeArray.length;i++)
		        {
		            var node_str = JSON.stringify(serverNodeArray[i]);
		            node_str = node_str.replace(/\"/g, "~S~");
		            var node = {};
		            node.id = serverNodeArray[i].NODE_ID;
		            node.pId = serverNodeArray[i].NODE_PID != undefined?serverNodeArray[i].NODE_PID:"";
		            node.name = serverNodeArray[i].NODE_NAME;
		            node.iconSkin = "entity";
		            zNodes[j++] =node;
		        }
		        zTreeObj = $.fn.zTree.init($("#treeDiv"), setting, zNodes);
		        $("#treeDiv").show();
		        $("#loading").hide();
		    }
		
		    
		
			// 取消选择根节点
			function beforeClick(treeId, treeNode) {
				if (treeNode.isParent) {
					return false;
				} else {
					zTreeObj.checkNode(treeNode, !treeNode.checked, true, true);
			        return true;
				}
			}
		    
		    // ------- 目录树  结束 -------
		
		  	//清除执行日志
			function doCleanLog() {
				$("#logCatefory").html("");
				$("#progressBar").css("width","0%").html( "0%");
			}
		  	
			//执行标签实体数据
			function doStartTaskData() {
				//是否已选择需要执行的实体信息
				var checkedNodes = zTreeObj.getCheckedNodes();
				if(checkedNodes && checkedNodes.length>0){
					//校验是执行实体\标签\实体+标签
					if($("#tab-content label input[name='stype']:checkbox:checked").length > 0){
						$("#log_progres").show();
						$("#progressBar").css("width","0%").html( "0%");
						//将按钮置灰，
						$("#btnPlay").attr("onclick","").attr("disabled","disabled");
						var entityIds = [];
						var gentityIds = [];
						for(var i=0;i<checkedNodes.length; i++){
							if(checkedNodes[i].pId == 'ENTITY'){
								entityIds.push(checkedNodes[i].id);
							}else if(checkedNodes[i].pId == 'GENTITY'){
								gentityIds.push(checkedNodes[i].id);
							}
						}
						var chk_value =[]; 
						$($("#tab-content label input[name='stype']:checkbox:checked")).each(function(){ 
							chk_value.push($(this).val()); 
						}); 
						ths.submitFormAjax({
		                    url: '${ctx}/entity/entity-start-task/doStartTaskData.vm',
		                    data : {"entityids": entityIds.join(','),"gentityids": gentityIds.join(','),"rtype":chk_value.join(','),"_clientCode":"_auto_task_start_btn_status:collect"},
		                    dataType:"json",
		                    success: function (data) {
		                    	console.log(data._msg);
		                    }
		                });
					}else{
						dialog({
							title: '提示',
							content: "请选择要执行的类型！",
							width: 300
						}).showModal();
					}
				}else{
					dialog({
						title: '提示',
						content: "请选择要执行的实体记录！",
						width: 300
					}).showModal();
				}
			}
		    
			function receiveCallback(socketMap){
				let data = JSON.parse(socketMap);
				// 接收服务端的实时日志并添加到HTML页面中
				$("#progressBar").css("width",data._period + "%").html(data._period +"%");
				if(data._msg !== ''){
					$('#logCatefory').append(data._msg + "<p> </p>");
					var box=document.getElementById("logCatefory");
					box.scrollTop=box.scrollHeight;
				}
				if(data._period==100){
					$("#btnPlay").attr("onclick","doStartTaskData()");
					$("#btnPlay").removeAttr("disabled");
				}
			}
			
			//页面加载完毕执行
		    $(document).ready(function(){
		        var offset = document.getElementById('tab-content').offsetTop+10;
		        autoHeightIframe("ifrmCategory",offset-3);
		        autoHeightIframe("divTreeWidget",offset-3);
		
		        $("#refreshTree").on(ace.click_event,function(){
		            loadTreeAjax();
		        });
		        //加载Tree
		        loadTreeAjax();
		
		        /** 调整左树的宽度  **/
		        $(".categorytree")._resizable({
		            minWidth: 200,
		            maxWidth: 500
		        });
		        
		        // 初始化socket
	            ths.initSocket("_auto_task_start_btn_status:collect", receiveCallback);
		    });
			
		  //设置日志模块高度
			var winHeight = $(window).height() - 132;
			$("#logCatefory").css("height",winHeight);
			$(window).resize(function() {
				winHeight = $(window).height() - 132;
				$("#logCatefory").css("height",winHeight);
			});
		</script>
	</body>
</html>