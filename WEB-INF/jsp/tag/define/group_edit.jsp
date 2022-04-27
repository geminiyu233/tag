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
</head>

<body class="no-skin">

<div class="main-container" id="main-container">
    <div class="main-content">
        <div class="main-content-inner padding-page-content">
            <div class="page-content">
	            <div class="page-content-new">
					<div class="page-toolbar align-right form-group">
						 <p class="title" style="display:none;">${(empty readonly && isAdmin) ? (empty group ? '添加' : '编辑') : '查看'}</p>
			             <c:if test="${empty readonly && isAdmin}">
			                <button type="button" class="btn  btn-save" id="btnSave" data-self-js="saveForm()">
			                    <i class="ace-icon fa fa-save"></i>
			                    	保存
			                </button>
			             </c:if>
			                <c:if test="${type == null }">
			                <button type="button" class="btn  btn-info" id="btnReturn" data-self-js="goBack()">
			                    <i class="ace-icon fa fa-reply"></i>
			                    	返回
			                </button>
			                </c:if>
				    </div>
       
                        <form class="form-horizontal" role="form" id="formInfo" action="index.html" method="post">
                        	<input type="hidden" name="ENTITY_ID" value="${ENTITY_ID}">
                        	<input type="hidden" name="GROUP_ID" value="${group.GROUP_ID }">
                            <div class="form-group">
                                <label class="col-sm-2 control-label no-padding-right" for="txtName">
                                    <i class="ace-icon fa fa-asterisk red smaller-70"></i>
                                			组名
                                </label>
                                <div class="col-sm-4">
                                      <input type="text" class="form-control"  data-validation-engine="validate[required,maxLength[30]]" placeholder="20个字符以内" id="GROUP_NAME" name="GROUP_NAME" value="${group.GROUP_NAME}"/>

                                </div>
                                <label class="col-sm-2 control-label no-padding-right" for="txtName">
                                    <i class="ace-icon fa fa-asterisk red smaller-70"></i>
                                        	父节点
                                    </label>
                                    <div class="col-sm-4">
                                            <div class="input-group">
                                                    <input type="hidden" id="PARENT_ID" name="PARENT_ID" value="${group.GROUP_ID == null ? (parent.GROUP_ID == null ? 'root' : parent.GROUP_ID) : group.PARENT_ID}">
                                                    <input type="text" class="form-control"  data-validation-engine="validate[required]"  placeholder="" id="PARENT_NAME" name="PARENT_NAME" value="${group.GROUP_ID == null ? (parent.GROUP_NAME== null ? '标签树' : parent.GROUP_NAME): group.PARENT_NAME}" readonly="readonly"/>
                                                <span class="input-group-btn">
                                                <button type="button" class="btn btn-white btn-default" data-self-js="chooseParentGroup()">
                                                    <i class="ace-icon fa fa-search"></i>
                                                </button>
                                                    <button type="button" class="btn btn-white btn-clear">
                                                        <i class="ace-icon fa fa-remove"></i>
                                                    </button>
                                                </span>
                                                </div>
    
                                    </div>
                                </div>


                                <div class="form-group">
	                                <label class="col-sm-2 control-label no-padding-right">
	                                	<i class="ace-icon fa fa-asterisk red smaller-70"></i>
	                                        	排序</label>
	                                <div class="col-sm-4">
	                                        <input type="text" class="form-control"  data-validation-engine="validate[required,custom[integer],maxLength[5]]" placeholder="请输入整数"  id="SORT" name="SORT" value="${group.SORT}"/>
	                                </div>
	                                <label class="col-sm-2 control-label no-padding-right">
	                                        
	                                       </label>
	                                <div class="col-sm-4 ">
	                                   
	                                </div>
                            	</div>
                            	

                                <div class="form-group">
                                    <label class="col-sm-2 control-label no-padding-right" for="txtBirthday">
                                      	  描述
                                    </label>
                                    <div class="col-sm-10">
                                        <textarea class="form-control" id="GOURP_DESC" name="GOURP_DESC" data-validation-engine="validate[maxLength[150]]"  placeholder="150个字符以内" style=" height: 66px;">${group.GOURP_DESC }</textarea>
                                               
                                    </div>
                                    
                                    
                                </div>                            	
                           
                            
                        </form>
                        
                </div><!-- /.row -->
            </div>
        </div><!--/.main-content-inner-->
    </div><!-- /.main-content -->
</div><!-- /.main-container -->

<%@ include file="/WEB-INF/jsp/_common/commonJS.jsp"%>

<!-- 自己写的JS，请放在这里 -->
<script type="text/javascript">
	//AJAX保存
	function saveForm(){
		//提交之前验证表单
	    if ($('#formInfo').validationEngine('validate')) {
	        ths.submitFormAjax({
	            url:'${ctx }/define/group/save.vm',
	            data:$("#formInfo").serialize(),// 如果不需要提交整个表单，可构造JSON提交，如{name:'老王',age:50}
	            success:function(data){
	            	if(data == 'success'){
	            		dialog({
	            	        title: '提示',
	            	        content: '保存成功',
							cancel: false,
	            	        wraperstyle:'alert-info',
	            	        ok: function () {
	            	        	if(window.parent.doSearch){
	            	        		window.parent.doSearch();
	            	        	}
	            	        	if(window.parent.parent.loadTree){
	            	        		window.parent.parent.loadTree();
	            	        	}
	            	        	if(window.parent.loadTree){
	            	        		window.parent.loadTree();
	            	        	}	            	        	
	            	        	
	            	        }
	            	    }).showModal();
	            	}
	            }
	        });
	    }
	}
		
	//返回
	function goBack() {
	    $("#main-container",window.parent.document).show();
	    $("#iframeInfo",window.parent.document).attr("src","").hide();
	}
	
	function chooseParentGroup(){
		dialog({
			id:"dialog-group-select",
            title: '选择父节点',
            url: "${ctx}/define/tag/tree.vm?TYPE=group&ENTITY_ID=${ENTITY_ID == null ? group.ENTITY_ID : ENTITY_ID}&HIDE_ID=${group.GROUP_ID}",
            width:400,
            height:450>document.documentElement.clientHeight?document.documentElement.clientHeight:450,
        }).showModal();
	}
	//选择父节点Dialog回调函数
	function treeCallBack(treeNode){
		$('#PARENT_ID').val(treeNode.id);
		$('#PARENT_NAME').val(treeNode.name);
	}
	//关闭选择父节点Dialog
	function closeCallback(){
		dialog.get("dialog-group-select").close().remove();
	}
	 
	jQuery(function ($) {
		
	    //表单验证组件初始化，详细文档请参考http://code.ciaoca.com/jquery/validation-engine/ 或官网文档http://posabsolute.github.io/jQuery-Validation-Engine/
	    $("#formInfo").validationEngine({
	        scrollOffset: 98,//必须设置，因为Toolbar position为Fixed
	        promptPosition: 'bottomLeft',
	        autoHidePrompt: true
	    });
	   
	});

</script>
</body>
</html>
