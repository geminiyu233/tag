<%@page import="java.util.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/jsp/_common/taglib.jsp" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <title></title>
    <%@ include file="/WEB-INF/jsp/_common/commonCSS.jsp" %>
    <!--页面自定义的CSS，请放在这里 -->
    <style type="text/css">

    </style>
</head>

<body class="no-skin">
	<div class="main-container" id="main-container">
	    <div class="main-content">
	        <div class="main-content-inner fixed-page-header fixed-40">
	            <div id="breadcrumbs" class="breadcrumbs">
	                <ul class="breadcrumb">
	                    <li class="active">
	                        <i class="fa fa-arrow-right"></i>
	                        <span class="THS_JDP_RES_DESC">
	                            ${empty THS_JDP_RES_DESC?'实体编辑':THS_JDP_RES_DESC}
	                        </span>
	                    </li>
	                </ul><!-- /.breadcrumb -->
	            </div>
	        </div>
	        <div class="main-content-inner padding-page-content">
	            <div class="page-content">
	                <div class="page-content-new">
	                    <div class="page-toolbar align-right form-group">
	                        <p class="title"
	                           style="display:none;">${(empty readonly && isAdmin) ? (empty entity.ENTITY_ID ? '添加' : '编辑') : '查看'}</p>
	                        <c:if test="${empty readonly && isAdmin}">
	                            <button type="button" class="btn btn-save" id="btnSave" data-self-js="saveForm()">
	                                <i class="ace-icon fa fa-save"></i>保存
	                            </button>
	                        </c:if>
	                        <c:if test="${type == null }">
	                            <button type="button" class="btn btn-info" id="btnReturn" data-self-js="goBack()">
	                                <i class="ace-icon fa fa-reply"></i>返回
	                            </button>
	                        </c:if>
	                    </div>
	                    <form class="form-horizontal" role="form" id="formInfo" method="post">
	                        <input type="hidden" name="ENTITY_ID" value="${entity.ENTITY_ID }">
	                        <input type="hidden" name="is_copy" value="${is_copy }">
	
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label no-padding-right" for="txtName">
	                                <i class="ace-icon fa fa-asterisk red smaller-70"></i> 名称
	                            </label>
	                            <div class="col-sm-4">
	                                <input type="text" id="ENTITY_NAME" name="ENTITY_NAME" value="${entity.ENTITY_NAME }"
	                                       class="form-control" data-validation-engine="validate[required,maxLength[200]]"
	                                       placeholder="最大长度200 "/>
	                            </div>
	                            <label class="col-sm-2 control-label no-padding-right" for="txtName">
	                                <i class="ace-icon fa fa-asterisk red smaller-70"></i>图标
	                            </label>
	                            <div class="col-sm-4">
	
	                                <select class="form-control" name="ENTITY_PORTRAIT"
	                                        data-validation-engine="validate[required]">
	                                    <option value="">--请选择--</option>
	                                    <option ${entity.ENTITY_PORTRAIT == '1' ? 'selected' : '' } value="1">大烟囱</option>
	                                    <option ${entity.ENTITY_PORTRAIT == '2' ? 'selected' : '' } value="2">清水滩</option>
	                                    <option ${entity.ENTITY_PORTRAIT == '3' ? 'selected' : '' } value="3">蓝天白云</option>
	                                    <option ${entity.ENTITY_PORTRAIT == '4' ? 'selected' : '' } value="4">大房子</option>
	                                </select>
	
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label no-padding-right" for="txtName">
	                                <i class="ace-icon fa fa-asterisk red smaller-70"></i> 实体代码
	                            </label>
	                            <div class="col-sm-4">
	                                <input type="text" id="ENTITY_CODE" name="ENTITY_CODE" value="${entity.ENTITY_CODE }"
	                                       class="form-control" data-validation-engine="validate[required]"
	                                       readonly="readonly" placeholder="根据名称自动生成 "/>
	                            </div>
	                            <label class="col-sm-2 control-label no-padding-right">
	                                <i class="ace-icon fa fa-asterisk red smaller-70"></i> 排序</label>
	                            <div class="col-sm-4">
	                                <input type="text" class="form-control"
	                                       data-validation-engine="validate[required,custom[integer],maxLength[5]]"
	                                       placeholder="请输入整数" id="SORT_NUM" name="SORT_NUM" value="${entity.SORT_NUM}"/>
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label no-padding-right">
	                                <i class="ace-icon fa fa-asterisk red smaller-70"> </i>数据源</label>
	                            <div class="col-sm-4">
	                                <div class="input-group">
	                                    <input type="text" id="DATASOURCE_NAME" name="DATASOURCE_NAME"
	                                           value="${entity.DATASOURCE_NAME }" class="form-control"
	                                           data-validation-engine="validate[required]" placeholder=""
	                                           readonly="readonly"/>
	                                    <input type="hidden" id="DATASOURCE_ID" name="DATASOURCE_ID"
	                                           value="${entity.DATASOURCE_ID }" class="form-control" placeholder=""/>
	                                    <span class="input-group-btn">
	                                            <button type="button" class="btn btn-white btn-default btnDatasource">
	                                                <i class="ace-icon fa fa-search"></i>
	                                            </button>
	                                            <button type="button" class="btn btn-white  btn-clear">
	                                                <i class="ace-icon fa fa-remove"></i>
	                                            </button>
	                                    </span>
	                                </div>
	                            </div>
	                            <label class="col-sm-2 control-label no-padding-right">
	                                <i class="ace-icon fa fa-asterisk red smaller-70"></i> 数据获取方式
	                            </label>
	                            <div class="col-sm-4">
	                                <select class="form-control" id="DATA_TYPE" name="DATA_TYPE" data-validation-engine="validate[required]" onchange="changeDataType();">
	                                    <option value="1" <c:if test="${entity.DATA_TYPE == 1}">selected="selected"</c:if>>数据表</option>
	                                    <option value="2" <c:if test="${entity.DATA_TYPE == 2}">selected="selected"</c:if>>SQL</option>
	                                </select>
	                            </div>
	                        </div>
	                        <div class="form-group tag-sql">
	                            <label class="col-sm-2 control-label no-padding-right">
	                                <i class="ace-icon fa fa-asterisk red smaller-70"></i>查询SQL
	                            </label>
	                            <div class="col-sm-10">
	                                <textarea class="form-control DATA_SQL" id="DATA_SQL" name="DATA_SQL" data-validation-engine="validate[maxLength[20000]]" style="height: 80px;" placeholder="请填写数据查询SQL"><c:out value="${entity.DATA_SQL}"></c:out></textarea>
	                            </div>
	                        </div>
	                        <div class="form-group tag-table">
	                            <label class="col-sm-2 control-label no-padding-right">
	                                <i class="ace-icon fa fa-asterisk red smaller-70"> </i> 数据表</label>
	                            <div class="col-sm-10 ">
	                                <div class="input-group">
	                                    <input type="text" id="DATATABLE_NAME" name="DATATABLE_NAME"
	                                           value="${entity.DATATABLE_NAME }" class="form-control DATA_TABLENAME"
	                                           data-validation-engine="validate[required]" placeholder=""
	                                           readonly="readonly"/>
	                                    <input type="hidden" id="DATATABLE" name="DATATABLE" value="${entity.DATATABLE }"
	                                           class="form-control" placeholder=""/>
	                                    <span class="input-group-btn">
	                                           <button type="button" class="btn btn-white btn-default btnTable">
	                                              <i class="ace-icon fa fa-search"></i>
	                                           </button>
	                                           <button type="button" class="btn btn-white  btn-clear">
	                                               <i class="ace-icon fa fa-remove"></i>
	                                           </button>
	                                    </span>
	                                </div>
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label no-padding-right">
	                                <i class="ace-icon fa fa-asterisk red smaller-70"> </i>标识字段</label>
	                            <div class="col-sm-4 ">
	                                <div class="input-group">
	                                    <input type="text" id="IDENTITY_NAME" name="IDENTITY_NAME"
	                                           value="${entity.IDENTITY_NAME }" class="form-control" placeholder=""
	                                           data-validation-engine="validate[required]" readonly="readonly"/>
	                                    <input type="hidden" id="IDENTITY_CODE" name="IDENTITY_CODE"
	                                           value="${entity.IDENTITY_CODE }" class="form-control" placeholder=""/>
	                                    <span class="input-group-btn">
	                                            <button type="button" class="btn btn-white btn-default btnIdentity">
	                                                <i class="ace-icon fa fa-search"></i>
	                                            </button>
	                                        	<button type="button" class="btn btn-white  btn-clear">
	                                            	<i class="ace-icon fa fa-remove"></i>
	                                       		</button>
	                                    </span>
	                                </div>
	                            </div>
								<label class="col-sm-2 control-label no-padding-right line-polygon-label">
									<i class="ace-icon fa smaller-70"> </i>线面空间类型
								</label>
								<div class="col-sm-4">
									<select class="form-control" id="SPACE_TYPE"  name="SPACE_TYPE">
										<option value="">--请选择--</option>
										<option <c:if test="${'line' eq entity.SPACE_TYPE}">selected</c:if> value="line">线 </option>
										<option <c:if test="${'plane' eq entity.SPACE_TYPE}">selected</c:if> value="plane">面 </option>
									</select>
								</div>
	                        </div>
	                        
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label no-padding-right">点字段</label>
	                            <div class="col-sm-4">
	                                <div class="input-group">
	                                    <input type="text" id="SPACE_NAME" name="SPACE_NAME" value="${entity.SPACE_NAME }" class="form-control" placeholder="" readonly="readonly"/>
	                                    <input type="hidden" id="SPACE_CODE" name="SPACE_CODE"
	                                           value="${entity.SPACE_CODE }" class="form-control" placeholder=""/>
	                                    <span class="input-group-btn">
		                                    <button type="button" class="btn btn-white btn-default btnSpace">
		                                        <i class="ace-icon fa fa-search"></i>
		                                    </button>
	                                        <button type="button" class="btn btn-white  btn-clear">
	                                            <i class="ace-icon fa fa-remove"></i>
	                                        </button>
	                                    </span>
	                                </div>
	                            </div>
								<label class="col-sm-2 control-label no-padding-right">线面字段</label>
								<div class="col-sm-4">
									<div class="input-group">
										<input type="text" id="SPACE_POLYGON_NAME" name="SPACE_POLYGON_NAME" value="${entity.SPACE_POLYGON_NAME }"  class="form-control" placeholder="" readonly="readonly"/>
										<input type="hidden" id="SPACE_POLYGON_CODE" name="SPACE_POLYGON_CODE"
											   value="${entity.SPACE_POLYGON_CODE }" class="form-control" placeholder=""/>
										<span class="input-group-btn">
		                                    <button type="button" class="btn btn-white btn-default btnSpacePolygon">
		                                        <i class="ace-icon fa fa-search"></i>
		                                    </button>
	                                        <button type="button" class="btn btn-white  btn-clear">
	                                            <i class="ace-icon fa fa-remove"></i>
	                                        </button>
	                                    </span>
									</div>
								</div>
	                        </div>
	
	
	                        <div class="form-group fields">
	                            <label class="col-sm-2 control-label no-padding-right">抽取字段</label>
	                            <div class="col-sm-8">
	                                <div class="chosen-container chosen-container-multi width-100"
	                                     style="border: solid 1px #D5D5D5; min-height: 62px ">
	                                    <ul class="chosen-choices" style="border: none" id="entityFields">
	                                        <c:forEach var="f" items="${entity.fields }">
	                                            <li class="search-choice field-item"><span>${f.FIELD_NAME }</span>
	                                                <a class="search-choice-close" onclick="$(this).parent().remove();"></a>
	                                                <input type="hidden" name="FIELD_CODE" value="${f.FIELD_CODE }"/>
	                                                <input type="hidden" name="FIELD_NAME" value="${f.FIELD_NAME }"/>
	                                            </li>
	                                        </c:forEach>
	                                    </ul>
	
	                                </div>
	
	                            </div>
	                            <div class="col-sm-2" style="padding-left: 0px;">
	                                <button type="button" class="btn btn-xs btn-default btn-white btn-xs-ths btnField"
	                                        title="选择">
	                                    <i class="ace-icon fa fa-search"></i>选择
	                                </button>
	                                <div class="space-4 hidden-xs"></div>
	                                <button type="button" class="btn btn-xs btn-default btn-white btn-xs-ths btnRemove"
	                                        data-self-js="clearValue(this)" title="清空">
	                                    <i class="ace-icon fa fa-trash"></i>清空
	                                </button>
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label no-padding-right" for="txtBirthday"> 描述</label>
	                            <div class="col-sm-8">
	                                <textarea class="form-control" name="ENTITY_DESC" data-validation-engine="validate[maxLength[200]]" placeholder="200个字符以内"style="height: 66px;">${entity.ENTITY_DESC}</textarea>
	                            </div>
	                            <div class="col-sm-2">
	                            </div>
	
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label no-padding-right" for="txtName">
	                                <i class="ace-icon fa fa-asterisk red smaller-70"></i>同步计划
	                            </label>
	                            <div class="col-sm-4">
	                                <div class="input-group">
	                                    <input type="text" id="SYNC_CRON" name="SYNC_CRON" value="${entity.SYNC_CRON }"
	                                           data-validation-engine="validate[required,maxLength[50]]"
	                                           class="form-control" placeholder="" readonly="readonly"/>
	                                    <span class="input-group-btn">
			                                   <button type="button" class="btn btn-white btn-default" id="btnChooseCron">
			                                      <i class="ace-icon fa fa-clock-o"></i>
			                                   </button>
					                           <button type="button" class="btn btn-white  btn-clear">
					                               <i class="ace-icon fa fa-remove"></i>
					                           </button>
			                            </span>
	                                </div>
	                            </div>
	                            <label class="col-sm-2 control-label no-padding-right">
	                                <i class="ace-icon fa fa-asterisk red smaller-70"></i> 运行节点
	                            </label>
	                            <div class="col-sm-4">
	                                <select class="form-control" name="LTS_RUN_NODE"
	                                        data-validation-engine="validate[required]">
	                                    <option value="">--请选择--</option>
	                                    <c:forEach var="node" items="${ltsNodes }">
	                                        <option
	                                                <c:if test="${entity.LTS_RUN_NODE == node}">selected="selected"</c:if>
	                                                value="${node }">${node }</option>
	                                    </c:forEach>
	                                </select>
	                            </div>
	                        </div>
	                        <div class="form-group">
	                            <label class="col-sm-2 control-label no-padding-right" for="txtBirthday">
	                                <i class="ace-icon fa fa-asterisk red smaller-70"></i>状态
	                            </label>
	                            <div class="col-sm-4">
	                                <select class="form-control" id="RUNSTATUS" name="RUNSTATUS">
	                                    <option
	                                            <c:if test="${entity.RUNSTATUS == 1 }">selected</c:if> value="1">启用
	                                    </option>
	                                    <option
	                                            <c:if test="${entity.RUNSTATUS == 0 }">selected</c:if> value="0">停用
	                                    </option>
	                                </select>
	                            </div>
	                            <label class="col-sm-2 control-label no-padding-right" for="txtBirthday">
	                                <i class="ace-icon fa fa-asterisk red smaller-70"></i>入库策略
	                            </label>
	                            <div class="col-sm-4">
	                                <select class="form-control" id="TASKSTRATEGY" name="TASKSTRATEGY">
	                                    <option
	                                            <c:if test="${entity.TASKSTRATEGY == '0' }">selected</c:if> value="0">增量
	                                    </option>
	                                    <option
	                                            <c:if test="${entity.TASKSTRATEGY == '1' }">selected</c:if> value="1">全量
	                                    </option>
	                                </select>
	                            </div>
	                        </div>
	                        <div class="form-group" style="display: none;">
	                            <label class="col-sm-2 control-label no-padding-right">相关数据集</label>
	                            <div class="col-sm-8">
	                                <div class="chosen-container chosen-container-multi width-100"
	                                     style="border: solid 1px #D5D5D5; min-height: 62px ">
	                                    <ul class="chosen-choices" style="border: none" id="entityDatasets"></ul>
	                                </div>
	
	                            </div>
	                            <div class="col-sm-2" style="padding-left: 0px;">
	                                <button type="button" class="btn btn-xs btn-default btn-white btn-xs-ths" title="选择"
	                                        id="btnMeta">
	                                    <i class="ace-icon fa fa-search"></i> 选择
	                                </button>
	                                <div class="space-4 hidden-xs"></div>
	                                <button type="button" class="btn btn-xs btn-default btn-white btn-xs-ths" title="清空">
	                                    <i class="ace-icon fa fa-trash"></i> 清空
	                                </button>
	                            </div>
	                        </div>
	                    </form>
	                </div>
	            </div><!--/.main-content-inner-->
	        </div><!-- /.main-content -->
	    </div><!-- /.main-container -->
    </div>
    <div style="display: none;" id="templet">
        <ul>
            <li class="search-choice field-item"><span>名称</span>
                <a class="search-choice-close" onclick="$(this).parent().remove();"></a>
                <input type="hidden" name="FIELD_CODE" value=""/>
                <input type="hidden" name="FIELD_NAME" value=""/>
            </li>
        </ul>

        <ul>
            <li class="search-choice dataset-item"><span>名称</span>
                <a class="search-choice-close" onclick="$(this).parent().remove();"></a>
                <input type="hidden" name="DATASET_ID" value=""/>
                <input type="hidden" name="DATASET_NAME" value=""/>
            </li>
        </ul>
    </div>

    <%@ include file="/WEB-INF/jsp/_common/commonJS.jsp" %>
    <script src="${ctx}/assets/js/pinyin/dict/pinyin_dict_firstletter.js"></script>
    <script src="${ctx}/assets/js/pinyin/pinyinUtil.js"></script>

    <!-- 自己写的JS，请放在这里 -->
    <script type="text/javascript">
        jQuery(function ($) {

            //表单验证组件初始化，详细文档请参考http://code.ciaoca.com/jquery/validation-engine/ 或官网文档http://posabsolute.github.io/jQuery-Validation-Engine/
            $("#formInfo").validationEngine({
                scrollOffset: 98,//必须设置，因为Toolbar position为Fixed
                promptPosition: 'bottomLeft',
                autoHidePrompt: true
            });
            //判断线面空间类型选择是否必填
            spacePolygonCallBack();
        });

      
        //关闭dialog
        function closeDialog(id) {
            dialog.get(id).close().remove();
        }

        //返回
        function goBack() {
            $("#main-container", window.parent.document).show();
            $("#iframeInfo", window.parent.document).attr("src", "").hide();
        }

        //AJAX保存
        function saveForm() {
            //提交之前验证表单
            if ($('#formInfo').validationEngine('validate')) {
                ths.submitFormAjax({
                    url: '${ctx }/entity/save.vm',
                    data: $("#formInfo").serialize(),// 如果不需要提交整个表单，可构造JSON提交，如{name:'老王',age:50}
                    success: function (data) {
                        var message = "保存成功";
                        if (data != 'success') {
                            message = "保存发生错误，请联系管理员检查原因！";
                        }
                        dialog({
                            title: '提示',
                            content: message,
                            cancel: false,
                            wraperstyle: 'alert-info',
                            ok: function () {
                                window.parent.doSearch();
                            }
                        }).showModal();
                    }
                });
            }
        }

        function datasourceSelected(id, name) {
            _url = '${ctx}/tag-common/data-source-selected.vm?dicCodeId=' + id + '&dicNameId=' + name;
            dialog({
                id: "datasource-select-window",
                title: '数据源选择',
                url: _url,
                width: 400,
                height: 460,
                cancel: function () {
                },
                cancelDisplay: false
            }).showModal();
        }

        function datasourceTableSelected(id, name, datasourceId) {
            if (datasourceId == '') {
                dialog({
                    title: '提示',
                    content: '请先选择数据源！',
                    wraperstyle: 'alert-info',
                    ok: function () {
                    }
                }).showModal();
                return;
            }
            _url = '${ctx}/tag-common/data-source-table-selected.vm?dicCodeId=' + id + '&dicNameId=' + name + '&pkid=' + datasourceId;
            dialog({
                id: "datasource-table-select-window",
                title: '数据表选择',
                url: _url,
                width: 400,
                height: 460,
                cancel: function () {
                },
                cancelDisplay: false
            }).showModal();
        }

        function datasourceTableColumnSelected(id, name, datasourceId, tablename, callbackFun, checkType, noAllowChoseField) {
            var type = $('#DATA_TYPE').val();
            if(type == '2') {
                //SQL
                if (datasourceId == '' || $('.DATA_SQL').val() == '') {
                    dialog({
                        title: '提示',
                        content: '请先选择数据源、输入SQL！',
                        wraperstyle: 'alert-info',
                        ok: function () {
                        }
                    }).showModal();
                    return;
                }
            }else{
                //数据表
                if (datasourceId == '' || tablename == '') {
                    dialog({
                        title: '提示',
                        content: '请先选择数据源、数据表！',
                        wraperstyle: 'alert-info',
                        ok: function () {
                        }
                    }).showModal();
                    return;
                }
            }
            _url = '${ctx}/tag-common/data-source-table-column-selected.vm?DATA_TYPE='+$('#DATA_TYPE').val()+'&dicCodeId=' + id + '&dicNameId=' + name + '&pkid=' + datasourceId + '&tablename=' + tablename + '&callbackFun=' + callbackFun + '&checkType=' + checkType + '&noAllowChoseField=' + noAllowChoseField;
            dialog({
                id: "datasource-table-column-select-window",
                title: '字段选择',
                url: _url,
                width: 400,
                height: 460,
                cancel: function () {
                },
                cancelDisplay: false
            }).showModal();
        }

        //清除已选择的数据
        function clearValue(btn) {
            $(btn).parents('.input-group').find('input').val('');
            $(btn).parents('.form-group').find('li').remove();
            //判断线面空间类型选择是否必填
            spacePolygonCallBack();
        }

        function cronEdit() {
            _url = '${ctx}/common/cron/cron.jsp?cronField=SYNC_CRON&dialogId=cron-edit';
            dialog({
                id: "cron-edit",
                title: '计划配置',
                url: _url,
                width: 450,
                height: 380,
                cancel: function () {
                },
                cancelDisplay: false
            }).showModal();
        }

        //字段选择回调函数
        function columnSelectCallBack(columnCodes, columnNames) {
            //console.log('columnCodes-length:'+columnCodes.length);
            $('#entityFields li').remove();
            for (var i = 0; i < columnNames.length; i++) {
                var copy = $('#templet .field-item').clone();
                $('input[name="FIELD_CODE"]', copy).val(columnCodes[i]);
                $('input[name="FIELD_NAME"]', copy).val(columnNames[i]);
                $('span', copy).text(columnNames[i]);
                $('#entityFields').append(copy);
            }
        }
        
        //判断线面空间类型选择是否必填
        function spacePolygonCallBack(columnCodes, columnNames){
        	var val = $('#SPACE_POLYGON_NAME').val();
        	if(val && val !=''){
        		$('#SPACE_TYPE').attr('data-validation-engine', 'validate[required]');
        		$('.line-polygon-label i').addClass('fa-asterisk red');
        	}else{
        		$('#SPACE_TYPE').attr('data-validation-engine', '');
        		$('.line-polygon-label i').removeClass('fa-asterisk red');
        	}
        }

        //数据集选择回调函数
        function datasetSelectCallBack(columnCodes, columnNames) {
            $('#entityDatasets li').remove();
            for (var i = 0; i < columnNames.length; i++) {
                var copy = $('#templet .dataset-item').clone();
                $('input[name="DATASET_ID"]', copy).val(columnCodes[i]);
                $('input[name="DATASET_NAME"]', copy).val(columnNames[i]);
                $('span', copy).text(columnNames[i]);
                $('#entityDatasets').append(copy);
            }
        }

        //页面事件初始化
        jQuery(function ($) {
            $("#btnChooseCron").click(function () {
                cronEdit();
            });
            $(".btnDatasource").click(function () {
                datasourceSelected('DATASOURCE_ID', 'DATASOURCE_NAME');
            });
            $(".btnTable").click(function () {
                datasourceTableSelected('DATATABLE', 'DATATABLE_NAME', $('#DATASOURCE_ID').val());
            });
            $(".btnIdentity").click(function () {
                datasourceTableColumnSelected('IDENTITY_CODE', 'IDENTITY_NAME', $('#DATASOURCE_ID').val(), $('#DATATABLE').val());
            });
            $(".btnSpace").click(function () {
                datasourceTableColumnSelected('SPACE_CODE', 'SPACE_NAME', $('#DATASOURCE_ID').val(), $('#DATATABLE').val(), 'undefined',  'undefined', 'SPACE_POLYGON_CODE');
            });
			$(".btnSpacePolygon").click(function () {
				datasourceTableColumnSelected('SPACE_POLYGON_CODE', 'SPACE_POLYGON_NAME', $('#DATASOURCE_ID').val(), $('#DATATABLE').val(), 'spacePolygonCallBack',  'undefined', 'SPACE_CODE');
			});
            $(".btnField").click(function () {
                datasourceTableColumnSelected('FIELD_CODE', 'FIELD_NAME', $('#DATASOURCE_ID').val(), $('#DATATABLE').val(), 'columnSelectCallBack', 'checkbox');
            });
            $(".btn-clear").click(function () {
                clearValue(this);
            });
            $("#ENTITY_NAME").change(function () {
                //实体编码生成
                var illegal_char = /[\s\W]+/g;
                var name = $('#ENTITY_NAME').val();
                var now = <%=new Date().getTime() %>;
                if (name != null && '${entity.ENTITY_ID}' == '') {
                    var code = 'TAG_' + pinyinUtil.getFirstLetter(name, false).replace(illegal_char, '') + '_' + now;
                    $('#ENTITY_CODE').val(code.toLowerCase());
                }
            });
            $("#btnMeta").click(function () {
                $("#dialog-meta").removeClass('hide').dialog({
                    width: 660,
                    height: 480,
                    modal: true,
                    position: {
                        my: "center center",
                        at: "center center-50"
                    },
                    iconCss: "fa-clock",
                    title: "选择数据集",
                    buttons: []
                });
            });
            changeDataType();
        });
        function changeDataType(){
            var type = $('#DATA_TYPE').val();
            if(type == 2){
                //SQL
                $('.tag-table').hide();
                $('.fields').hide();

                $('.tag-sql').show();
                $('.DATA_SQL').attr('data-validation-engine','validate[required,maxLength[20000]]');
                $('.DATA_TABLENAME').attr('data-validation-engine','');
                //$('.DATA_TABLENAME').val('');
                //$('.DATA_SQL').attr('disabled',false);
                //$('.DATA_TABLENAME').attr('disabled',true);
            } else {
                //数据表
                $('.tag-table').show();
                $('.fields').show();
                $('.tag-sql').hide();
                $('.DATA_SQL').attr('data-validation-engine','');
                $('.DATA_TABLENAME').attr('data-validation-engine','validate[required]');
                //$('.DATA_SQL').val('');
                //$('.DATA_SQL').attr('disabled',true);
                //$('.DATA_TABLENAME').attr('disabled',false);
            }

        }
    </script>
</body>
</html>
