<%@page import="java.util.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/jsp/_common/taglib.jsp" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <title>新增\编辑汇聚实体</title>
    <%@ include file="/WEB-INF/jsp/_common/commonCSS.jsp" %>
    <!--页面自定义的CSS，请放在这里 -->
    <style type="text/css">
        li.search-choice .search-choice-close:before {
            content: "\f00d";
            display: inline-block;
            color: #888;
            font-family: FontAwesome;
            font-size: 13px;
            right: 2px;
            top: 5px;
        }

        #myTab li.tab-drop {
            margin-right: 1px;
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
                            <i class="fa fa-arrow-right"></i>
                            <span class="THS_JDP_RES_DESC">
                                    ${THS_JDP_RES_DESC}
                            </span>
                        </li>
                    </ul>
                </div>
            </div>
        </c:if>
        <div class="main-content-inner padding-page-content">
            <div class="page-content">
                <div class="page-content-new">
                    <div class="page-toolbar align-right form-group">
                        <c:if test="${empty readonly && isAdmin}">
                            <button type="button" class="btn btn-save" id="btnSave" data-self-js="doSaveGEntityData()">
                                <i class="ace-icon fa fa-save"></i> 保存
                            </button>
                        </c:if>
                        <button type="button" class="btn btn-info" id="btnReturn" data-self-js="goBack()">
                            <i class="ace-icon fa fa-reply"></i> 返回
                        </button>
                    </div>
                    <form class="form-horizontal" role="form" id="mainForm" name="mainForm" action="" method="post"
                          autocomplete="off">
                        <input type="hidden" id="optype" name="optype" value="${optype}">
                        <input type="hidden" id="gentity_id" name="gentity_id" value="${gentity_id}">
                        <input type="hidden" id="batchnum" name="batchnum" value="${batchnum}">

                        <div class="form-group">
                            <label class="col-sm-2 control-label no-padding-right" for="ENTITY_NAME">
                                <i class="ace-icon fa fa-asterisk red smaller-70"></i> 名称
                            </label>
                            <div class="col-sm-4">
                                <input type="text" id="ENTITY_NAME" name="gentity_name" <c:if
                                        test="${!empty readonly && readonly eq 'true'}"> readonly="readonly" </c:if>
                                       value="${gentity.GENTITY_NAME }" class="form-control"
                                       data-validation-engine="validate[required,maxLength[30]]" placeholder="10个汉字 "/>
                            </div>
                            <label class="col-sm-2 control-label no-padding-right">
                                <i class="ace-icon fa fa-asterisk red smaller-70"></i> 图标
                            </label>
                            <div class="col-sm-4">
                                <select class="form-control" name="gentity_portrait" <c:if
                                        test="${!empty readonly && readonly eq 'true'}"> disabled="disabled" </c:if>
                                        data-validation-engine="validate[required]">
                                    <option value="">--请选择--</option>
                                    <option ${gentity.GENTITY_PORTRAIT eq '1' ? 'selected' : '' } value="1">大烟囱</option>
                                    <option ${gentity.GENTITY_PORTRAIT eq '2' ? 'selected' : '' } value="2">清水滩</option>
                                    <option ${gentity.GENTITY_PORTRAIT eq '3' ? 'selected' : '' } value="3">蓝天白云
                                    </option>
                                    <option ${gentity.GENTITY_PORTRAIT eq '4' ? 'selected' : '' } value="4">大房子</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label no-padding-right" for="txtName">
                                <i class="ace-icon fa fa-asterisk red smaller-70"></i> 汇聚代码
                            </label>
                            <div class="col-sm-4">
                                <input type="text" id="ENTITY_CODE" name="gentity_code" value="${gentity.GENTITY_CODE }"
                                       class="form-control" data-validation-engine="validate[required]"
                                       readonly="readonly" placeholder="根据名称自动生成 "/>
                            </div>
                            <label class="col-sm-2 control-label no-padding-right">
                                <i class="ace-icon fa fa-asterisk red smaller-70"></i> 排序
                            </label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control"
                                       data-validation-engine="validate[required,custom[integer],maxLength[5]]"
                                       placeholder="请输入整数" id="SORT_NUM" name="sort_num" <c:if
                                        test="${!empty readonly && readonly eq 'true'}"> readonly="readonly" </c:if>
                                       value="${gentity.SORT_NUM}"/>
                            </div>
                        </div>
                        <div class="form-group fields">
                            <label class="col-sm-2 control-label no-padding-right">
                                <i class="ace-icon fa fa-asterisk red smaller-70"> </i>汇聚字段
                            </label>
                            <div class="col-sm-8">
                                <div class="chosen-container chosen-container-multi width-100"
                                     style="border: solid 1px #D5D5D5; min-height: 62px ">
                                    <ul class="chosen-choices" style="border: none" id="entityFields">
                                        <c:forEach var="field" items="${gentity.fields }">
                                            <li class="search-choice field-item" <c:if
                                                    test="${!empty readonly && readonly eq 'true'}"> style="padding-right: 5px;" </c:if>>
                                                <span>${field.FIELD_NAME }</span>
                                                <c:if test="${empty readonly && isAdmin}">
                                                    <a class="search-choice-close"
                                                       onclick="$(this).parent().remove();"></a>
                                                </c:if>
                                                <input type="hidden" name="field_code" value="${field.FIELD_CODE }"/>
                                                <input type="hidden" name="field_name" value="${field.FIELD_NAME }"/>
                                                <input type="hidden" name="field_code_name"
                                                       value="${field.FIELD_NAME}"/>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </div>
                            <div class="col-sm-2" style="padding-left: 0px;">
                                <button type="button" class="btn btn-xs btn-default btn-white btn-xs-ths" <c:if
                                        test="${!empty readonly && readonly eq 'true'}"> disabled="disabled" </c:if>
                                        data-self-js="showAddField()" title="选择">
                                    <i class="ace-icon fa fa-plus"></i> 添加
                                </button>
                                <div class="space-4 hidden-xs"></div>
                                <button type="button" class="btn btn-xs btn-default btn-white btn-xs-ths btnRemove"<c:if
                                        test="${!empty readonly && readonly eq 'true'}"> disabled="disabled" </c:if>
                                        data-self-js="doClearValue(this)" title="清空">
                                    <i class="ace-icon fa fa-trash"></i> 清空
                                </button>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 hidden-xs control-label no-padding-right">
                                &nbsp;
                            </label>
                            <div class="col-sm-10">
                                <div>
                                    <p>
                                        <i class="ace-icon fa fa-exclamation-triangle red"></i>
                                        注：<span class="red">汇聚字段</span>默认已包含<span class="red">TAG_ENTITY_CODE(实体代码) , TAG_ENTITY_NAME(实体名称) , TAG_TOPIC_CODE(主题编码)</span>字段
                                    </p>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label no-padding-right">
                                <i class="ace-icon fa fa-asterisk red smaller-70"> </i> 标识字段
                            </label>
                            <div class="col-sm-4">
                                <div class="input-group">
                                    <input type="text" id="identity_name" name="identity_name"
                                           value="${gentity.IDENTITY_NAME }" class="form-control"
                                           data-validation-engine="validate[required]" readonly="readonly"/>
                                    <input type="hidden" id="identity_code" name="identity_code"
                                           value="${gentity.IDENTITY_CODE }" class="form-control"/>
                                    <span class="input-group-btn">
                                            	<button type="button" class="btn btn-white btn-default btnIdentity"<c:if
                                                        test="${!empty readonly && readonly eq 'true'}"> disabled="disabled" </c:if>
                                                        data-self-js="showFieldSelected('identity_code','identity_name')">
                                                	<i class="ace-icon fa fa-search"></i>
												</button>
                                                <button type="button" class="btn btn-white  btn-clear" <c:if
                                                        test="${!empty readonly && readonly eq 'true'}"> disabled="disabled" </c:if>>
                                                    <i class="ace-icon fa fa-remove"></i>
                                                </button>
                                            </span>
                                </div>
                            </div>
							<label class="col-sm-2 control-label no-padding-right line-polygon-label">
								<i class="ace-icon fa smaller-70"></i>
								线面空间类型
							</label>
							<div class="col-sm-4">
								<select class="form-control" id="space_type" name="space_type">
									<option value="">--请选择--</option>
                                    <option <c:if test="${'line' eq gentity.SPACE_TYPE}">selected</c:if> value="line">线 </option>
                                    <option <c:if test="${'plane' eq gentity.SPACE_TYPE}">selected</c:if> value="plane">面 </option>
								</select>
							</div>
                            
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label no-padding-right">点字段</label>
                            <div class="col-sm-4 ">
                                <div class="input-group">
                                    <input type="text" id="space_name" name="space_name" value="${gentity.SPACE_NAME }"
                                           class="form-control" readonly="readonly"/>
                                    <input type="hidden" id="space_code" name="space_code"
                                           value="${gentity.SPACE_CODE }" class="form-control"/>
                                    <span class="input-group-btn">
                                            	<button type="button" class="btn btn-white btn-default btnSpace" <c:if
                                                        test="${!empty readonly && readonly eq 'true'}"> disabled="disabled" </c:if>
                                                        data-self-js="showFieldSelected('space_code','space_name', 'space_polygon_code')">
                                                	<i class="ace-icon fa fa-search"></i>
												</button>
                                                <button type="button" class="btn btn-white  btn-clear" <c:if
                                                        test="${!empty readonly && readonly eq 'true'}"> disabled="disabled" </c:if>>
                                                    <i class="ace-icon fa fa-remove"></i>
                                                </button>
                                            </span>
                                </div>
                            </div>
                            <label class="col-sm-2 control-label no-padding-right">线面字段</label>
                            <div class="col-sm-4 ">
                                <div class="input-group">
                                    <input type="text" id="space_polygon_name" name="space_polygon_name"  value="${gentity.SPACE_POLYGON_NAME }"
                                           class="form-control" readonly="readonly"/>
                                    <input type="hidden" id="space_polygon_code" name="space_polygon_code"
                                           value="${gentity.SPACE_POLYGON_CODE }" class="form-control"/>
                                    <span class="input-group-btn">
                                            	<button type="button" class="btn btn-white btn-default btnSpacePolygon" <c:if
                                                        test="${!empty readonly && readonly eq 'true'}"> disabled="disabled" </c:if>
                                                        data-self-js="showFieldSelected('space_polygon_code','space_polygon_name', 'space_code', 'spacePolygonCallBack')">
                                                	<i class="ace-icon fa fa-search"></i>
												</button>
                                                <button type="button" class="btn btn-white  btn-clear" <c:if
                                                        test="${!empty readonly && readonly eq 'true'}"> disabled="disabled" </c:if>>
                                                    <i class="ace-icon fa fa-remove"></i>
                                                </button>
                                            </span>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label no-padding-right">描述</label>
                            <div class="col-sm-8">
                                <textarea class="form-control" name="gentity_desc" <c:if
                                        test="${!empty readonly && readonly eq 'true'}"> readonly="readonly" </c:if>
                                          data-validation-engine="validate[maxLength[200]]" placeholder="200个字符以内"
                                          style=" height: 66px;">${gentity.GENTITY_DESC }</textarea>
                            </div>
                            <div class="col-sm-2"></div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label no-padding-right">
                                <i class="ace-icon fa fa-asterisk red smaller-70"> </i> 标签实体
                            </label>
                            <div class="col-sm-8">
                                <div class="chosen-container chosen-container-multi width-100"
                                     style="border: solid 1px #D5D5D5; min-height: 62px ">
                                    <ul class="chosen-choices" style="border: none" id="tagEntitys">
                                        <c:forEach var="item" items="${mappingList }">
                                            <li class="search-choice field-item" <c:if
                                                    test="${!empty readonly && readonly eq 'true'}"> style="padding-right: 5px;" </c:if>>
                                                <span>${item.ENTITY_NAME }[${item.ENTITY_CODE }]</span>
                                                <c:if test="${empty readonly && isAdmin}">
                                                    <a class="search-choice-close" onclick="doclearEntity(this)"></a>
                                                </c:if>
                                                <input type="hidden" name="identity_id" value="${item.ENTITY_ID }"/>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </div>
                            <div class="col-sm-2" style="padding-left: 0px;">
                                <button type="button" class="btn btn-xs btn-default btn-white btn-xs-ths" <c:if
                                        test="${!empty readonly && readonly eq 'true'}"> disabled="disabled" </c:if>
                                        data-self-js="showChgEntity('identity_id')" title="选择">
                                    <i class="ace-icon fa fa-plus"></i> 选择
                                </button>
                                <div class="space-4 hidden-xs"></div>
                                <button type="button" class="btn btn-xs btn-default btn-white btn-xs-ths btnRemove"<c:if
                                        test="${!empty readonly && readonly eq 'true'}"> disabled="disabled" </c:if>
                                        data-self-js="doClearAllValue(this)" title="清空">
                                    <i class="ace-icon fa fa-trash"></i> 清空
                                </button>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-2"></div>
                            <div class="col-xs-10 tabable" style="padding: 0px 12px 10px 12px;">
                                <ul id="myTab" class="nav nav-tabs tab-change">
                                    <c:if test="${mappingList ne null and mappingList.size() > 0 }">
                                        <c:forEach items="${mappingList }" var="item" varStatus="index">
                                            <li class='tab-item search-choice tab-change ${(index.index  eq 0)?"active":"" }'
                                                stab="${item.ENTITY_ID }" data-entitycode="${item.ENTITY_CODE }"
                                                style="padding-right: 5px">
                                                <a href="#frmCatefory" data-toggle="tab">
                                                    <span>${item.ENTITY_NAME }[${item.ENTITY_CODE }]</span>
                                                </a>
                                            </li>
                                        </c:forEach>
                                    </c:if>
                                </ul>
                                <div id="tab-content" class="tab-content in active col-xs-12" id="frmCatefory">
                                    <iframe id="ifrmCategory" name="ifrmCategory" class="frmContent" frameborder="no"
                                            scrolling="auto" width="100%"
                                            style="border: none; width: 100%; height: 100%;vertical-align:bottom;"></iframe>
                                </div>
                            </div>
                            <!-- <div class="col-sm-1"></div> -->

                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label no-padding-right" for="txtName">
                                <i class="ace-icon fa fa-asterisk red smaller-70"></i> 同步计划
                            </label>
                            <div class="col-sm-4">
                                <div class="input-group">
                                    <input type="text" id="SYNC_CRON" name="sync_cron" value="${gentity.SYNC_CRON }"
                                           class="form-control" placeholder="" readonly="readonly"
                                           data-validation-engine="validate[required,maxLength[50]]"/>
                                    <span class="input-group-btn">
		                                           <button type="button" class="btn btn-white btn-default" <c:if
                                                           test="${!empty readonly && readonly eq 'true'}"> disabled="disabled" </c:if>
                                                           id="btnChooseCron">
		                                               <i class="ace-icon fa fa-clock-o"></i>
		                                           </button>
				                                   <button type="button" class="btn btn-white  btn-clear" <c:if
                                                           test="${!empty readonly && readonly eq 'true'}"> disabled="disabled" </c:if>>
				                                       <i class="ace-icon fa fa-remove"></i>
				                                   </button>
		                                     </span>
                                </div>
                            </div>
                            <label class="col-sm-2 control-label no-padding-right">
                                <i class="ace-icon fa fa-asterisk red smaller-70"></i> 运行节点
                            </label>
                            <div class="col-sm-4">
                                <select class="form-control" name="lts_run_node" <c:if
                                        test="${!empty readonly && readonly eq 'true'}"> disabled="disabled" </c:if>
                                        data-validation-engine="validate[required]">
                                    <option value="">--请选择--</option>
                                    <c:forEach var="node" items="${ltsNodes }">
                                        <option
                                                <c:if test="${gentity.LTS_RUN_NODE eq node}">selected="selected"</c:if>
                                                value="${node }">${node }</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label no-padding-right" for="txtBirthday">
                                <i class="ace-icon fa fa-asterisk red smaller-70"></i> 状态
                            </label>
                            <div class="col-sm-4">
                                <select class="form-control" id="RUNSTATUS" <c:if
                                        test="${!empty readonly && readonly eq 'true'}"> disabled="disabled" </c:if>
                                        name="runstatus">
                                    <option
                                            <c:if test="${gentity.RUNSTATUS == 1 }">selected</c:if> value="1">启用
                                    </option>
                                    <option
                                            <c:if test="${gentity.RUNSTATUS == 0 }">selected</c:if> value="0">停用
                                    </option>
                                </select>
                            </div>
                            <label class="col-sm-2 control-label no-padding-right" for="txtBirthday">
                                <i class="ace-icon fa fa-asterisk red smaller-70"></i> 入库策略
                            </label>
                            <div class="col-sm-4">
                                <select class="form-control" id="TASKSTRATEGY" name="taskstrategy" <c:if
                                        test="${!empty readonly && readonly eq 'true'}"> disabled="disabled" </c:if>>
                                    <option
                                            <c:if test="${gentity.TASKSTRATEGY == '0' }">selected</c:if> value="0">增量
                                    </option>
                                    <option
                                            <c:if test="${gentity.TASKSTRATEGY == '1' }">selected</c:if> value="1">全量
                                    </option>
                                </select>
                            </div>
                        </div>
                    </form>
                </div>
            </div><!--/.main-content-inner-->
        </div><!-- /.main-content -->
    </div><!-- /.main-container -->
</div>
<!--  -->
<form action="${ctx}/entity/entity-gather/showMatchEField.vm" method="post" id="clickform" target="ifrmCategory"
      style="display:none">
    <input type="hidden" name="batchnum" value="${batchnum}"/>
    <input type="hidden" name="readonly" value="${readonly}"/>
    <input type="hidden" id="mgentity_id" name="gentity_id" value="${gentity_id}"/>
    <input type="hidden" id="mentity_id" name="entity_id"
           value="${mappingList ne null and mappingList.size()>0?mappingList[0].ENTITY_ID:"" }"/>
    <input type="hidden" id="mentity_code" name="entity_code"
           value="${mappingList ne null and mappingList.size()>0?mappingList[0].ENTITY_CODE:"" }"/>
</form>


<%@ include file="/WEB-INF/jsp/_common/commonJS.jsp" %>
<script src="${ctx}/assets/js/pinyin/dict/pinyin_dict_firstletter.js"></script>
<script src="${ctx}/assets/js/pinyin/pinyinUtil.js"></script>

<!-- 自己写的JS，请放在这里 -->
<script type="text/javascript">
    //初始化
    $(document).ready(function () {
        //表单验证组件初始化
        $("#mainForm").validationEngine({
            scrollOffset: 98,//必须设置，因为Toolbar position为Fixed
            promptPosition: 'bottomLeft',
            autoHidePrompt: true
        });
        //汇聚实体代码生成规则
        $("#ENTITY_NAME").change(function () {
            //实体编码生成
            var illegal_char = /[\s\W]+/g;
            var name = $('#ENTITY_NAME').val();
            var now = <%=new Date().getTime() %>;
            if (name != null && '${gentity.ENTITY_ID}' == '') {
                var code = 'TAG_GATHER_' + pinyinUtil.getFirstLetter(name, false).replace(illegal_char, '') + '_' + now;
                $('#ENTITY_CODE').val(code.toLowerCase());
            }
        });
        //打开cron选择弹框
        $("#btnChooseCron").click(function () {
            var _url = '${ctx}/common/cron/cron.jsp?cronField=SYNC_CRON&dialogId=cron-edit';
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
        });
        //清空[标识字段、空间字段、同步计划]
        $(".btn-clear").click(function () {
            $(this).parents('.input-group').find('input').val('');
            
            spacePolygonCallBack();
        });

        //处理tab标签换行问题
        doTabPosition();

        //隐藏没有实体标签div
        if ($('#tagEntitys li').length == 0) {
            $('#myTab').parent().css('display', 'none');
        }

        //mytab 切换
        $(document).on('click', '#myTab li', function () {
            var stab = $(this).attr("stab");
            if (stab && _stab != stab) {
                _stab = stab;
                loadEntityFiledIframe(stab, $(this).data('entitycode'));
                iframeRefresh();
            }
        });

        //如果存在值加载iframe
        var entity_id = $('#mentity_id').val();
        if (entity_id) {
            $('#clickform').submit();
            iframeRefresh();
        }
        
        spacePolygonCallBack();
    });
    

    //汇聚实体代码编辑框
    function showAddField() {
        dialog({
            id: "entity-gather-field-select-window",
            title: '字段配置',
            url: "${ctx}/entity/entity-gather/showAddField.vm",
            width: 450,
            height: 350,
            cancelDisplay: false
        }).showModal();
    }

    //添加汇聚字段回调函数
    function showAddFieldCallBack(columnCode, columnName) {
        //校验fieled_code是否重复
        var valid_result = true;
        $('#entityFields li').each(function () {
            var field_code = $('input[name="field_code"]', this).val();
            if (field_code == columnCode) {
                valid_result = false;
                return;
            }
        })
        //如果编码已存在返回false;
        if (!valid_result) {
            return valid_result;
        } else {
            var _html = '<li class="search-choice field-item">' +
                '<span>' + columnName + '</span>' +
                '<a class="search-choice-close" onclick="$(this).parent().remove();"></a>' +
                '<input type="hidden" name="field_code" value="' + columnCode + '"/>' +
                '<input type="hidden" name="field_name" value="' + columnName + '"/>' +
                '<input type="hidden" name="field_code_name" value="' + columnName + '"/>' +
                '</li>';
            $('#entityFields').append(_html);
            return true;
        }
    }
    
  	//判断线面空间类型选择是否必填
    function spacePolygonCallBack(columnCodes, columnNames){
    	var val = $('#space_polygon_name').val();
    	if(val && val !=''){
    		$('#space_type').attr('data-validation-engine', 'validate[required]');
    		$('.line-polygon-label i').addClass('fa-asterisk red');
    	}else{
    		$('#space_type').attr('data-validation-engine', '');
    		$('.line-polygon-label i').removeClass('fa-asterisk red');
    	}
    }

    //清除已选择的数据
    function doClearValue(btn) {
        $(btn).parents('.input-group').find('input').val('');
        $(btn).parents('.form-group').find('li').remove();
    }

    //标示字段、
    function showFieldSelected(id, name, noAllowChoseField, callbackFun) {
        _url = '${ctx}/entity/entity-gather/showChgField.vm?dicCodeId=' + id + '&dicNameId=' + name + '&noAllowChoseField=' + noAllowChoseField;
        if(!callbackFun || callbackFun ==''){
        	callbackFun = 'undefined';
        }
        _url += '&callbackFun=' + callbackFun;
        dialog({
            id: "entity-gather-field-select-window",
            title: '字段选择',
            url: _url,
            width: 320,
            height: 380,
            cancelDisplay: false
        }).showModal();
    }

    //保存实体汇聚信息[在添加实体前，需要先保存汇聚实体信息]
    function doSaveGEntityData() {
        if ($('#tagEntitys li').length > 0) {
            //提交之前验证表单
            if ($('#mainForm').validationEngine('validate')) {
                ths.submitFormAjax({
                    url: '${ctx }/entity/entity-gather/doSaveGEntityData.vm',
                    data: $("#mainForm").serialize(),// 如果不需要提交整个表单，可构造JSON提交，如{name:'老王',age:50}
                    dataType: "json",
                    success: function (data) {
                        dialog({
                            title: '提示',
                            content: data._msg,
                            cancel: false,
                            wraperstyle: 'alert-info',
                            ok: function () {
                                if (data._code == 1) {
                                    window.parent.doSearch();
                                }
                            }
                        }).showModal();
                    }
                });
            }
        } else {
            dialog({
                title: '提示',
                content: '请选择一个标签实体',
                cancel: false,
                wraperstyle: 'alert-info',
                ok: function () {
                }
            }).showModal();
        }
    }

    //标示字段
    function showChgEntity(id, name) {
        // 验证是否已保存数据，选择实体标签前，需要提前保存数据
        if ($("#identity_code").val()) {
            dialog({
                id: "entity-chose-dialog",
                title: '标签实体选择',
                url: '${ctx}/entity/entity-gather/showChgEntity.vm?dicCodeId=' + id + '&dicNameId=' + name,
                width: 800,
                height: 500 > document.documentElement.clientHeight ? document.documentElement.clientHeight : 500,
                cancelDisplay: false
            }).showModal();
        } else {
            dialog({
                title: '提示',
                content: '请先选择标识字段！',
                wraperstyle: 'alert-info',
                width: 380,
                ok: function () {
                }
            }).showModal();
        }
    }

    //关闭dialog
    function closeDialog(id) {
        dialog.get(id).close().remove();
    }

    //返回
    function goBack() {
        $("#main-container", window.parent.document).show();
        $("#iframeInfo", window.parent.document).attr("src", "").hide();
    }

    //打开弹框页面
    function showAddMthField(etyid, etype) {
        dialog({
            id: "add-match-field-mapping-window",
            title: '汇聚实体字段映射',
            url: "${ctx}/entity/entity-gather/showAddMthField.vm?gentity_id=${gentity_id}&batchnum=${batchnum}&entity_id=" + etyid,
            width: 550,
            height: 350,
            cancelDisplay: false
        }).showModal();
    }


    var _stab = '';

    //自动设置iframe宽高
    function iframeRefresh(height) {
        if (!height) {
            height = $("#ifrmCategory").contents().find("body").height();
        }
        $("#ifrmCategory").height(height);
    }

    //保存实体汇聚信息
    function saveEntityGatherForm() {
        //提交之前验证表单
        if ($('#formInfo').validationEngine('validate')) {
            ths.submitFormAjax({
                url: '${ctx }/entity/entity-gather/doSaveEntityGather.vm',
                data: $("#formInfo").serialize(),// 如果不需要提交整个表单，可构造JSON提交，如{name:'老王',age:50}
                dataType: "json",
                success: function (data) {
                    dialog({
                        title: '提示',
                        content: data._msg,
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

    //弹框提示消息
    function dialogMessage(message) {
        dialog({
            title: '提示',
            content: message,
            wraperstyle: 'alert-info',
            ok: function () {
            }
        }).showModal();
    }

    //删除实体
    function removeEntity(entity) {
        //如果没有选中实体，则取消tab的展示
        if ($(entity).parent().parent().parent().find('li').length == 1) {
            $('#entity_tab_id').css('display', 'none');
        }
        var entercode = $(entity).parent().parent().data('entitycode');
        var entername = $(entity).parent().parent().data('entityname');

        var code = $('input[name="entityids"]').val().replace(entercode + ",", '').replace("," + entercode, '').replace(entercode, '');
        var name = $('input[name="entitynames"]').val().replace(entername + ",", '').replace("," + entername, '').replace(entername, '');
        $('input[name="entityids"]').val(code);
        $('input[name="entitynames"]').val(name);
        $(entity).parent().parent().remove();
    }

    //清空实体
    function clearEntity() {
        $('#entity_tab_id').css('display', 'none');
        $('input[name="entityids"]').val('');
        $('input[name="entitynames"]').val('');
        $('#myTab li').remove();
    }

    //删除实体属性字段
    function removeEntityFiled(obj) {
        var filedcode = $(obj).parent().find('input[name="field_code"]').val();
        $('select[name="identity_code"]').find('option[value="' + filedcode + '"]').remove();
        $('select[name="space_code"]').find('option[value="' + filedcode + '"]').remove();
        $(obj).parent().remove();
    }

    //加载实体属性页面的iframe
    function loadEntityFiledIframe(entityid, entitycode) {
        document.getElementById("clickform").reset();
        $('#mentity_id').val(entityid);
        $('#mentity_code').val(entitycode);
        $('#clickform').submit();
    }

    //处理tab标签换行问题
    function doTabPosition() {
        var element = $(document).find('.nav-tabs');
        //创建下拉标签
        var dropdown = $('<li>', {
            'class': 'dropdown pull-right hide tabdrop tab-drop'
        }).append(
            $('<a>', {
                'class': 'dropdown-toggle',
                'data-toggle': 'dropdown',
                'href': '#'
            }).append(
                $('<i>', {'class': "fa fa-align-justify"})
            ).append(
                $('<b>', {'class': 'caret'})
            )
        ).append(
            $('<ul>', {'class': "dropdown-menu"})
        )

        //检测是否已增加
        if (!$('.tabdrop').html()) {
            dropdown.prependTo(element);
        } else {
            dropdown = element.find('.tabdrop');
        }
        //检测是否有下拉样式
        if (element.parent().is('.tabs-below')) {
            dropdown.addClass('dropup');
        }
        var collection = 0;

        //检查超过一行的标签页
        element.append(dropdown.find('li'))
            .find('>li')
            .not('.tabdrop')
            .each(function () {
                if (this.offsetTop > 0 || element.width() - $(this).position().left - $(this).width() < 83) {
                    dropdown.find('ul').prepend($(this));
                    collection++;
                }
            });

        //如果有超出的，显示下拉标签
        if (collection > 0) {
            dropdown.removeClass('hide');
            if (dropdown.find('.active').length == 1) {
                dropdown.addClass('active');
            } else {
                dropdown.removeClass('active');
            }
        } else {
            dropdown.addClass('hide');
        }
    }

    //删除某个实体
    function doclearEntity(btn) {
        var entityid = $(btn).parent().find('input[name="identity_id"]').val();

        //删除临时表中汇聚实体映射字段信息
        emptyEntityMappingTmp(entityid);

        $('#myTab li').each(function () {
            var stab = $(this).attr('stab');
            if (entityid == stab) {
                //如果删除的是当前的实体
                if ($(this).hasClass("active")) {
                    if ($(this).prev().length > 0 && $(this).prev().data('entitycode')) {
                        var enttiycode = $(this).prev().data('entitycode');
                        var enttiyid = $(this).prev().attr('stab');
                        $(this).prev().addClass('active');
                        loadEntityFiledIframe(enttiyid, enttiycode);
                        _stab = enttiyid;
                    } else if ($(this).next().length > 0) {
                        var enttiycode = $(this).next().data('entitycode');
                        var enttiyid = $(this).next().attr('stab');
                        $(this).next().addClass('active');
                        loadEntityFiledIframe(enttiyid, enttiycode);
                        _stab = enttiyid;
                    } else if ($('#myTab li.tab-item').length == 1) {
                        //隐藏掉tab标签
                        $('#myTab').parent().css('display', 'none');
                    } else {
                        var enttiycode = $('#myTab li').last().data('entitycode');
                        var enttiyid = $('#myTab li').last().attr('stab');
                        $('#myTab li').last().addClass('active');
                        loadEntityFiledIframe(enttiyid, enttiycode);
                        _stab = enttiyid;
                    }
                }
                $(this).remove();
            }
        });
        $(btn).parent().remove();
        doTabPosition();
    }


    //删除临时表中汇聚实体映射字段信息
    function emptyEntityMappingTmp(entity_id) {
        ths.submitFormAjax({
            url: '${ctx }/entity/entity-gather/doEmptyEntityMappingTmp.vm',
            data: {
                "gentity_id": $('#gentity_id').val(),
                "entity_id": entity_id,
                "batchnum": $('#batchnum').val()
            },
            dataType: "json",
            success: function (data) {
            }
        });
    }

    //清除已选择的数据
    function doClearAllValue(btn) {
        $('#myTab li').each(function () {
            var stab = $(this).attr('stab');
            if (stab) {
                //删除临时表中汇聚实体映射字段信息
                emptyEntityMappingTmp(stab);
            }
        });
        $(btn).parents('.input-group').find('input').val('');
        $(btn).parents('.form-group').find('li').remove();
        $('#myTab li').remove();
        //隐藏掉tab标签
        $('#myTab').parent().css('display', 'none');
    }

    //打开弹框页面
    function openPdialog(id, title, url) {
        dialog({
            id: id,
            title: title,
            url: url,
            width: 500,
            height: 270,
            cancel: function () {
            },
            cancelDisplay: false
        }).showModal();
    }
</script>
</body>
</html>
