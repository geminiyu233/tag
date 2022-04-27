<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/jsp/_common/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh">
	<head>
	    <title>编辑数据源</title>
		<%@ include file="/WEB-INF/jsp/_common/commonCSS.jsp"%>
	  	<!--页面自定义的CSS，请放在这里 -->
	    <style type="text/css">
	    	#paramTable{
	    		table-layout: fixed;
	    	}
	    	#paramTable th,#paramTable td{
	    		text-overflow: ellipsis; /* for IE */  
			    -moz-text-overflow: ellipsis; /* for Firefox,mozilla */  
			    overflow: hidden;  
			    white-space: nowrap;  
			    border: 1px solid;  
			    text-align: left  ;
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
			                        <h5 class="page-title" >
			                 			<i class="fa fa-file-text-o"></i> 
			                 			<span class="THS_JDP_RES_DESC">
											${THS_JDP_RES_DESC}
										</span>
			                        </h5>
			                    </li>
			                </ul><!-- /.breadcrumb -->
			            </div>
			        </div>
		        </c:if>
		        <div class="main-content-inner padding-page-content" style="padding: 52px 12px 0px 12px;">
		            <ul id="myTab" class="nav nav-tabs ">
						<li class="active">
							<a href="#datasourceInfo" data-toggle="tab"> 
								<i class=" ace-icon fa fa-info-circle bigger-120"></i>基本信息
							</a>
						</li>
						<li class="">
							<a href="#datasourceParamInfo" data-toggle="tab" aria-expanded="false"> 
								<i class=" ace-icon fa fa-ellipsis-h bigger-120"></i>配置参数
							</a>
						</li>
						<li style="float: right; width: 500px; text-align: right; padding-top: 3px;">
							<div>
								<div style="display: inline-block;padding-right: 20px;line-height: 27px;vertical-align: middle;">
									<span id="is_conn"></span>
								</div>
								<c:if test="${isAdmin}">
				                <button type="button" class="btn btn-xs btn-primary btn-xs-ths" id="btnTestConnnection" data-self-js="testConnection()" style="display: none;">
				                    <i class="ace-icon fa fa-save"></i>连接测试
				                </button>
				                <button type="button" class="btn btn-xs btn-primary btn-xs-ths" id="btnSave">
				                    <i class="ace-icon fa fa-save"></i>保存
				                </button>
				                </c:if>
				                <button type="button" class="btn btn-xs btn-danger btn-xs-ths" id="btnReturn" data-self-js="goBack()">
					            	<i class="ace-icon fa fa-reply"></i>返回
					           </button>
				            </div>
						</li>
					</ul>
					<div class="row">
		            	<div class=" col-xs-12">
		        			<form class="form-horizontal" role="form" id="formInfo" action="" method="post">
								<div id="tab-content" class="tab-content">
									<!-- 基本信息 -->
									<div class="tab-pane in active" id="datasourceInfo">
										<input type="hidden" id="pkid" name="pkid" value="${rdata.PKID }">
										<input type="hidden" id="isconn" name="isconn" >
										<input type="hidden" id="data_source_param_token" name="data_source_param_token" value="${data_source_param_token}">
										
										<div class="form-group">
			                                <label class="col-sm-2 control-label no-padding-right">
			                                    <i class="ace-icon fa fa-asterisk red smaller-70"></i> 数据源CODE
			                                </label>
			                                <div class="col-sm-4">
			                                	<input type="text" class="form-control" id="datasourcecode" name="datasourcecode" value="${rdata.DATASOURCECODE }" data-validation-engine="validate[required,funcCall[checkDatasourceCode],[maxSize[50]]" maxlength="50" placeholder="允许字母、数字、下划线，50个字符以内" />
			                                </div>
			                                <label class="col-sm-2 control-label no-padding-right">
			                                    <i class="ace-icon fa fa-asterisk red smaller-70"></i>数据源名称
			                                </label>
			                                <div class="col-sm-4">
			                                	<input type="text" class="form-control" id="datasourcename" name="datasourcename" value="${rdata.DATASOURCENAME }" data-validation-engine="validate[required,funcCall[checkDatasourceName],[maxSize[25]]" maxlength="25"/>
			                                </div>
			                            </div>
			                            <div class="form-group">
			                                <label class="col-sm-2 control-label no-padding-right">
			                                    <i class="ace-icon fa fa-asterisk red smaller-70"></i>适配器
			                                </label>
			                                <div class="col-sm-4">
			                                	<input type="hidden" id="adaptercode" name="adaptercode" value="1"> 
				                                <span class="">
				                             		<input type="text" class="form-control" id="adaptername" name="adaptername" value="DB数据字典采集适配器" data-validation-engine="validate[required]" readonly="readonly">
				                          		</span>
			                                	<!-- <div class="input-group">
		                                			<input type="hidden" id="adaptercode" name="adaptercode" value="${rdata.ADAPTERCODE}"> 
					                                <span class="">
					                             		<input type="text" class="form-control" id="adaptername" name="adaptername" value="${rdata.ADAPTERNAME }" data-validation-engine="validate[required]" readonly="readonly">
					                          		</span>
					                                <span class="input-group-btn">
					                                	<button type="button" class="btn btn-white btn-default" onclick="selectAdapter()">
															选择
												      	</button>    
					                                </span>
				                         		</div> -->
			                                </div>
			                                <label class="col-sm-2 control-label no-padding-right">排序 </label>
			                                <div class="col-sm-4">
			                                	<input type="text" class="form-control" id="sortno" name="sortno" value="${rdata.SORTNO }" data-validation-engine="validate[custom[integer],[maxSize[20]]" />
			                                </div>
			                            </div>
			                            <div class="form-group">
			                                <label class="col-sm-2 control-label no-padding-right">数据源描述</label>
			                                <div class="col-sm-10">
			                                    <textarea class="form-control" id="remarks" name="remarks" style="height: 66px;" maxlength="200">${rdata.REMARKS }</textarea>
			                                </div>
			                            </div>
			                            
									</div>
									<!-- 配置参数 -->
									<div class="tab-pane" id="datasourceParamInfo" style="">
										<table class="table table-bordered table-hover" id="paramTable">
											<thead>
												<tr>
													<th style="width: 20%;">参数CODE</th>
													<th style="width: 40%;">参数名称</th>
													<th style="width: 40%;">参数值</th>
												</tr>
											</thead>
											<tbody id="adapter_div">
												<tr>
													<td style="padding: 0px 5px; vertical-align: middle;">
														driverClass
														<i class="ace-icon fa fa-asterisk red smaller-70"></i>
													</td>
													<td style="padding: 0px 5px; vertical-align: middle;" title="驱动">驱动</td>
													<td style="padding: 0px;">
														<select class="form-control" id="dirverclass" name="dirverclass" style="width: 100%;" data-validation-engine="validate[required]" >
															<option value="oracle.jdbc.driver.OracleDriver" <c:if test="${'oracle.jdbc.driver.OracleDriver' eq rdata.DIRVERCLASS }">selected="selected"</c:if>>ORACLE</option>
															<option value="net.sourceforge.jtds.jdbc.Driver" <c:if test="${'net.sourceforge.jtds.jdbc.Driver' eq rdata.DIRVERCLASS }">selected="selected"</c:if>>SQLSERVER_JTDS</option>
															<option value="com.mysql.jdbc.Driver" <c:if test="${'com.mysql.jdbc.Driver' eq rdata.DIRVERCLASS }">selected="selected"</c:if>>MYSQL</option>
															<option value="org.postgresql.Driver" <c:if test="${'org.postgresql.Driver' eq rdata.DIRVERCLASS }">selected="selected"</c:if>>POSTGRESQL</option>
															<option value="com.ibm.db2.jcc.DB2Driver" <c:if test="${'com.ibm.db2.jcc.DB2Driver' eq rdata.DIRVERCLASS }">selected="selected"</c:if>>DB2</option>
															<option value="dm.jdbc.driver.DmDriver" <c:if test="${'dm.jdbc.driver.DmDriver' eq rdata.DIRVERCLASS }">selected="selected"</c:if>>DM DBMS</option>
														</select>
													</td>
												</tr>
												<tr>
													<td style="padding: 0px 5px; vertical-align: middle;">
														jdbcUrl
														<i class="ace-icon fa fa-asterisk red smaller-70"></i>
													</td>
													<td style="padding: 0px 5px; vertical-align: middle;" title="数据访问URL">
														数据访问URL
														<span class="help-button" style="height: 20px; width: 20px; line-height: normal;" data-rel="popover" data-original-title="" title="">?</span>
														<p style="display: none;">
															db2: jdbc:db2://10.194.21.126:50001/sjzxcp<br/>oracle: jdbc:oracle:thin:@192.168.0.140:1521:orcl<br/>sqlserver: jdbc:jtds:sqlserver://192.168.4.151:1433;DatabaseName=bpmtest<br/>mysql: jdbc:mysql://localhost:3306/jdp?useUnicode=true&amp;characterEncoding=UTF-8
														</p>
													</td>
													<td style="padding: 0px;">
														<input class="form-control" type="text" style="width: 100%;" id="jdbcurl" name="jdbcurl" value="${rdata.JDBCURL }" data-validation-engine="validate[required,maxSize[100]]">
													</td>
												</tr>
												<tr>
													<td style="padding: 0px 5px; vertical-align: middle;">
														user
														<i class="ace-icon fa fa-asterisk red smaller-70"></i>
													</td>
													<td style="padding: 0px 5px; vertical-align: middle;" title="用户名">用户名</td>
													<td style="padding: 0px;">
														<input class="form-control" type="text" style="width: 100%;" id="username" name="username" value="${rdata.USERNAME }" data-validation-engine="validate[required,maxSize[30]]">
													</td>
												</tr>
												<tr>
													<td style="padding: 0px 5px; vertical-align: middle;">
														password
														<i class="ace-icon fa fa-asterisk red smaller-70"></i>
													</td>
													<td style="padding: 0px 5px; vertical-align: middle;" title="密码">密码</td>
													<td style="padding: 0px;">
														<input class="form-control" type="password" style="width: 100%;" id="password" name="password" value="${rdata.PASSWORD }" data-validation-engine="validate[required,maxSize[128]]">
													</td>
												</tr>
											</tbody>
										</table>
										<!-- 注 -->
										<div style="height: 40px;line-height: 40px;">
											<span style="color: red;">注：数据源配置参数完成后，请先点击【连接测试】按钮，测试连接成功后再保存信息。</span>
										</div>
									</div>
									
								</div>
							</form>
						</div>
					</div>
		            <!-- <div class="page-toolbar align-center">
		            	<button type="button" class="btn btn-xs btn-primary btn-xs-ths" id="btnTestConnnection" data-self-js="testConnection()" style="display: none;">
		                    <i class="ace-icon fa fa-save"></i>
							连接测试
		                </button>
		                <button type="button" class="btn btn-xs btn-primary btn-xs-ths" id="btnSave">
		                    <i class="ace-icon fa fa-save"></i>
							保存
		                </button>
		                <button type="button" class="btn btn-xs btn-danger btn-xs-ths" id="btnReturn" data-self-js="goBack()">
		                    <i class="ace-icon fa fa-reply"></i>
							返回
		                </button>
		            </div> -->
		        </div>
		    </div><!-- /.main-content -->
		</div><!-- /.main-container -->
		
		<%@ include file="/WEB-INF/jsp/_common/commonJS.jsp"%>
		
		<script src="${ctx}/assets/js/security.js" type=text/javascript></script>
		<!-- 自己写的JS，请放在这里 -->
		<script type="text/javascript">
			var old_driverclass="";
			var old_jdbcurl="";
			var old_username="";
			var old_password="";
			
			$(document).ready(function() {
				if("${type}" == "edit"){
					var key = new RSAUtils.getKeyPair('${exponent}', '', '${modulus_16}');
		            var reversedPwd = "${rdata.PASSWORD }".split("").reverse().join("");
		            $("#password").val(RSAUtils.encryptedString(key,reversedPwd));
				}
				//判读页面是查看、编辑、添加页面 【 type：add-添加，edit-编辑，其他则是查看】
				if("${type}" != "add" && "${type}" != "edit"){
					$("#formInfo").find("input,select,textarea").attr( "disabled", true);
					$("#btnTestConnnection").css( "display", "none");
					$("#btnSave").css( "display", "none");
				}
				$("#formInfo").validationEngine({
			        scrollOffset: 98,//必须设置，因为Toolbar position为Fixed
			        promptPosition: 'bottomLeft',
			        autoHidePrompt: true,
			        validateNonVisibleFields: true
			    });
				
				 $("select[name='dirverclass'],#jdbcurl,#username,#password").change(function(){$("#is_conn").html("");});
				
				//监听tab切换，移除提示
			    $('#myTab a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
			    	//判断显示测试连接按钮
			    	if($(e.target).attr("href") == "#datasourceParamInfo" &&("${type}" == "add" || "${type}" == "edit")){
			    		$("#btnTestConnnection").css("display", "");
			    	}else{
			    		$("#btnTestConnnection").css("display", "none");
			    	}
			    	//移除提示
            		$("div.formError").remove();
				});
				
				$('[data-rel=popover]').popover({
					placement: "auto right",
					trigger: "click",
					html: true,
					content: function() {
						var content = $(this).parent().find("p").html().replace(/(^\s*)|(\s*$)/g, "");
			            return "<pre style=\"padding: 2px; margin-bottom: 0px;\">" + content + "</pre>";
			       	}
				});
				
				 //保存操作
			    $("#btnSave").on(ace.click_event, function () {
			    	//移除提示
            		$("div.formError").remove();
		            if($('#formInfo').validationEngine('validate')) {
		            	if(isConnection()){
		            		var passwordObj = $("#password");
							var key = new RSAUtils.getKeyPair('${exponent}', '', '${modulus_16}');
							if("${type}" == "edit"){
								var reversedPwd_old = "${rdata.PASSWORD}".split("").reverse().join("");
								if(RSAUtils.encryptedString(key,reversedPwd_old) != passwordObj.val()){
					            	var reversedPwd = passwordObj.val().split("").reverse().join("");
					            	passwordObj.val(RSAUtils.encryptedString(key,reversedPwd));
								}
							}else{
								var reversedPwd = passwordObj.val().split("").reverse().join("");
					            passwordObj.val(RSAUtils.encryptedString(key,reversedPwd));
							}
		            		ths.submitFormAjax({
								url : '${ctx}/datasource/data-source-config!savedatasource.vm',
								data: $("#formInfo").serialize(),//将对象序列化成JSON字符串  
								dataType: "json",
								success : function(rdata){
									if(rdata.code == '1'){
										parent.doSearch();
									}else{
										dialog({
											title: '信息',
											content: rdata.msg,
											ok: function () {}
										}).showModal();
									}
								}
							});
		            	}else{
		            		dialog({
								title: '提示',
								content: '请先点击【连接测试】按钮，测试连接成功后再保存信息！',
								ok: function () {
								},
								width: 350
							}).showModal();
		            	}
		            }else{
		            	//需要切换的tab_id
		            	var tab_id = "#" + $($("div.formError")[0]).closest(".tab-pane").attr("id");
		            	//判断tab是否需要切换
		            	if($($("#myTab li.active").children("a")[0]).attr("href") != tab_id){
		            		//切换tab
			            	$("a[href='" + tab_id + "']").click();
		            		//定时显示提示
			            	setTimeout(function(){
			            		$('#formInfo').validationEngine('validate');
			            	},100);
		            	}
		            }
		        });
			    
			    //编辑操作，初始化数据源适配器参数
			    if("${rdata.DATASOURCE_ID }" && "${rdata.ADAPTER_ID }"){
			    	loadAdapterParam("${rdata.ADAPTER_ID }");
			    }
				
            });
            
            
            //检测数据源CODE是否可用
			function checkDatasourceCode(field, rules, i, options){
				if("${rdata.DATASOURCECODE }" == field.val()){
					return;
				}
				var ajaxResult = true;
				$.ajax({
					url: "${ctx}/datasource/data-source-config!checkcode.vm",
					data: "datasourcecode=" + field.val(),
					type:"post",
					dataType:"text",
					async: false,
					success: function(response){
						if(response == "error"){
							ajaxResult = false;
						}
					},
					error: function(response){
						ajaxResult = false; 
					}
				});
				if(ajaxResult == false){
					return "此数据源CODE已被使用，请重新命名！";
				}
			}
			//检测数据源Name是否可用
			function checkDatasourceName(field, rules, i, options){
				if("${rdata.DATASOURCENAME }" == field.val()){
					return;
				}
				var ajaxResult = true;
				$.ajax({
					url: "${ctx}/datasource/data-source-config!checkcode.vm",
					data: "datasourcename=" + field.val(),
					type:"post",
					dataType:"text",
					async: false,
					success: function(response){
						if(response == "error"){
							ajaxResult = false;
						}
					},
					error: function(response){
						ajaxResult = false; 
					}
				});
				if(ajaxResult == false){
					return "此数据源名称已被使用，请重新命名！";
				}
			}
            // 判断连接信息
            function isConnection(){
            	var flag = false;
            	var password_old = "${rdata.PASSWORD }";
            	if("${type}" == "edit"){
					var key = new RSAUtils.getKeyPair('${exponent}', '', '${modulus_16}');
		            var reversedPwd = "${rdata.PASSWORD }".split("").reverse().join("");
		            password_old = RSAUtils.encryptedString(key,reversedPwd);
				}
            	if("${rdata.DIRVERCLASS }" == $("select[name='dirverclass']").val() && "${rdata.JDBCURL }" == $("#jdbcurl").val() && "${rdata.USERNAME }" == $("#username").val() && password_old == $("#password").val()){
            		flag = true;
            	}else{
            		if($("#isconn").val()=='1' && old_driverclass==$("select[name='dirverclass']").val() &&old_jdbcurl==$("#jdbcurl").val() && old_username==$("#username").val()&&old_password==$("#password").val()){
            			flag = true;
            		}else{
            			$("#is_conn").html("");
            		}
            	}
            	return flag;
            }
            
            //连接测试
			function testConnection(){
				var driverClassObj = $("select[name='dirverclass']");
				var jdbcUrlObj = $("#jdbcurl");
				var userObj = $("#username");
				var passwordObj = $("#password");
				
				if(driverClassObj[0] && jdbcUrlObj[0] && userObj[0] && passwordObj[0] && !driverClassObj.validationEngine('validate') && !jdbcUrlObj.validationEngine('validate') && !userObj.validationEngine('validate') && !passwordObj.validationEngine('validate')){
					$("#btnTestConnnection").attr("disabled","disabled");
					var pwd = passwordObj.val();
					var key = new RSAUtils.getKeyPair('${exponent}', '', '${modulus_16}');
					if("${type}" == "edit"){
						var reversedPwd_old = "${rdata.PASSWORD}".split("").reverse().join("");
						if(RSAUtils.encryptedString(key,reversedPwd_old) != passwordObj.val()){
			            	var reversedPwd = passwordObj.val().split("").reverse().join("");
			            	pwd= RSAUtils.encryptedString(key,reversedPwd);
						}
					}else{
						var reversedPwd = passwordObj.val().split("").reverse().join("");
			            pwd= RSAUtils.encryptedString(key,reversedPwd);
					}
					ths.submitFormAjax({
						url : "${ctx}/datasource/data-source-config!testconnection.vm",
						data : {"driverClass":driverClassObj.val(), "jdbcUrl":jdbcUrlObj.val(),"user":userObj.val(),"password":pwd},
						dataType: "json",
						success : function(response){
							$("#isconn").val(response.code);
							if(response.code == 1){
								old_driverclass=driverClassObj.val();
								old_jdbcurl=jdbcUrlObj.val();
								old_username=userObj.val();
								old_password=passwordObj.val();
								$("#is_conn").html("连接测试状态：<span style='color:green'>成功</span>");
								dialog({
									title: '提示',
									content: response.msg,
									cancel: false,
									ok: function () {
										$("#btnTestConnnection").attr("disabled",false);
									},
									width: 350
								}).showModal();
							}else{
								$("#is_conn").html("连接测试状态：<span style='color:red'>失败</span>");
								dialog({
									title: '错误',
									icon:'fa-times-circle',
									wraperstyle:'alert-warning',
									content: response.msg,
									cancel: false,
									width: 350,
									ok: function () {
										$("#btnTestConnnection").attr("disabled",false);
									}
								}).showModal();
							}
							$("#btnTestConnnection").attr("disabled","");
						}
					});
				}
			}
			//返回
			function goBack() {
			    $("#main-container",parent.document).show();
			    $("#iframeInfo",parent.document).attr("src","").hide();
			}
	        /*------------------选择适配器 结束-------------------*/
	        
	        
		</script>
	</body>
</html>
