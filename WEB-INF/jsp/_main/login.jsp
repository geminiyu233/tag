<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/jsp/_common/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>登录</title>
	<%@ include file="/WEB-INF/jsp/_common/commonCSS.jsp"%>
	<!--页面自定义的CSS，请放在这里 -->
    <style type="text/css">

    </style>
</head>

<body class="login-layout light-login">
<div class="main-container">
    <div class="main-content">
        <div class="row">
            <div class="col-sm-10 col-sm-offset-1">
                <div class="login-container">
                    <div class="center">
                        <h1>
                            <i class="ace-icon fa fa-tags green"></i>
                            <span class="red">TAG</span>
                            <span class="grey" id="id-text2">标签服务平台</span>
                        </h1>
                    </div>

                    <div class="space-6"></div>

                    <div class="position-relative">
                        <div id="login-box" class="login-box visible widget-box no-border">
                            <div class="widget-body">
                                <div class="widget-main">
                                    <h4 class="header blue lighter bigger">
                                        <i class="ace-icon fa fa-coffee green"></i>
                                        登录
                                    </h4>

                                    <div class="space-6"></div>

                                    <form id="ouForm">
                                        <fieldset>
                                            <label class="block clearfix">
														<span class="block input-icon input-icon-right">
															<input id="txtUserName" type="text" class="form-control" placeholder="用户名"  value="admin" data-validation-engine="validate[required]"  maxlength="20" />
															<i class="ace-icon fa fa-user"></i>
														</span>
                                            </label>

                                            <label class="block clearfix">
														<span class="block input-icon input-icon-right">
															<input  id="password" type="password" class="form-control" placeholder="密码"  value="solutionadmin"  data-validation-engine="validate[required]"  maxlength="20" />
															<i class="ace-icon fa fa-lock"></i>
														</span>
                                            </label>

                                            <div class="space"></div>

                                            <div class="clearfix">
                                                <label class="inline">
                                                    <input type="checkbox" class="ace" />
                                                    <span class="lbl">记住我</span>
                                                </label>

                                                <button id="btnLogin" type="button" class="width-35 pull-right btn btn-sm    btn-xs-ths line-height-150" 
                                                	onclick="login()">
                                                    <i class="ace-icon fa fa-key"></i>
                                                    <span class="bigger-110">登录</span>
                                                </button>
                                            </div>

                                            <div class="space-4"></div>
                                        </fieldset>


                                        <div id="dError" class="alert alert-block alert-danger width-100" style="display: none;">
                                            <i class="ace-icon fa fa-times-circle red2" ></i>
                                            用户名或密码错误！
                                        </div>
                                    </form>

                                    <div class="social-or-login center">
                                        <span class="bigger-110"></span>
                                    </div>

                                    <div class="space-6"></div>


                                </div><!-- /.widget-main -->

                                <div class="toolbar clearfix">
                                    <div>
                                        <a href="#" data-target="#forgot-box" class="forgot-password-link">
                                            <i class="ace-icon fa fa-arrow-left"></i>
                                            忘记密码？
                                        </a>
                                    </div>

                                    <div class="hide">
                                        <a href="#"  class="user-signup-link">
                                            注册
                                            <i class="ace-icon fa fa-arrow-right"></i>
                                        </a>
                                    </div>
                                </div>
                            </div><!-- /.widget-body -->
                        </div><!-- /.login-box -->

                        <div id="forgot-box" class="forgot-box widget-box no-border">
                            <div class="widget-body">
                                <div class="widget-main">
                                    <h4 class="header red lighter bigger">
                                        <i class="ace-icon fa fa-key"></i>
                                        找回密码
                                    </h4>

                                    <div class="space-6"></div>
                                    <p class="alert alert-block alert-danger ">
                                       目前不提供自助找回密码功能，请联系信息中心系统管理员，以重置密码。
                                    </p>


                                </div><!-- /.widget-main -->

                                <div class="toolbar center">
                                    <a href="#" data-target="#login-box" class="back-to-login-link">
                                        返回登录
                                        <i class="ace-icon fa fa-arrow-right"></i>
                                    </a>
                                </div>
                            </div><!-- /.widget-body -->
                        </div><!-- /.forgot-box -->


                    </div><!-- /.position-relative -->
                      
                </div>
            </div><!-- /.col -->
        </div><!-- /.row -->
         <div class="row" style="position: fixed;width:100%;text-align: center;bottom:0px; margin-bottom:10px">
          <h4 class="blue" id="id-company-text">&copy; 北京思路创新科技有限公司</h4>
          </div>
    </div><!-- /.main-content -->
</div><!-- /.main-container -->
<%@ include file="/WEB-INF/jsp/_common/commonJS.jsp"%>

<script type="text/javascript">

    jQuery(function($) {
    	
		//给整个窗口注册回车keydown事件
		$(window).keydown(function(event){
			if(event.keyCode==13){
				login();
			}
		});
		
		//让帐号文本框获得焦点
		$("#txtUserName").focus();
    	
    	$('#ouForm').validationEngine();
        $(document).on(ace.click_event, '.toolbar a[data-target]', function(e) {
            e.preventDefault();
            var target = $(this).data('target');
            $('.widget-box.visible').removeClass('visible');//hide others
            $(target).addClass('visible');//show target
        });

        //$("#btnLogin").on(ace.click_event,login());

        $("#txtUserName").on("focus",function(e){
            $("#dError").hide();
        });
    });
    
    function login(){
    	//验证
	    	var flag=$("#ouForm").validationEngine("validate");
   		if(!flag){
   			return ; 
   		}
    	var loginname=$("#txtUserName").val();
    	var password=$("#password").val();
    	$.ajax( {  
  	        url:'${ctx}/login.vm?format=json',// 跳转到 action  
  	        type:'post',  
  	        cache:false,  
  	        contentType:'application/json',
  	        data:JSON.stringify({'loginName':loginname,'password':password}),
  	        dataType:'json',  
  	        success:function(data) {
  	        	if(data.status=='1'){//登录成功
  	        		window.location.href="${ctx}/index.vm";
  	        	}else{
  	        		$("#dError").text(data.message);
  	        		$("#dError").show();
  	        	}
  	         },  
  	         error : function() {  
  	        	 console.log("error");
  	         }  
  	    });
        
    }
    
    
  	//如果当前窗口不是顶层窗口
	if(window.self!=window.top){
		window.top.location.href='${ctx}/loginpage.vm';
	}
</script>
</body>
</html>
