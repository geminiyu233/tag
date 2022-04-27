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
            <div class="main-content-inner padding-page-content" style="overflow-x: hidden;">
                <div class="page-content">
	            <div class="page-content-new">
					<div class="page-toolbar align-right form-group">
						 <p class="title" style="display:none;">${(empty readonly && isAdmin) ? (empty tag.tagId ? '添加' : '编辑') : '查看'}</p>
						 		<c:if test="${empty readonly && isAdmin}">
				                  <button type="button" class="btn btn-save" id="btnSave" data-self-js="saveForm()">
				                    <i class="ace-icon fa fa-save"></i>
				                   	 保存
				                </button>
				                </c:if>
				                <c:if test="${type == null }">
				                <button type="button" class="btn btn-info" id="btnReturn" data-self-js="goBack()">
				                    <i class="ace-icon fa fa-reply"></i>
				                   	 返回
				                </button>
				                </c:if>	
				     </div>		
                            <form class="form-horizontal" role="form" id="formInfo" action="index.html" method="post">
                            	<input type="hidden" name="entityId" value="${ENTITY_ID}">
                            	<input type="hidden" id="tagId" name="tagId" value="${tag.tagId }">
                                <div class="form-group">
                                    <label class="col-sm-2 control-label no-padding-right" for="txtName">
                                        <i class="ace-icon fa fa-asterisk red smaller-70"></i>
                                       	 	标签名称
                                    </label>
                                    <div class="col-sm-4">
                                        <input type="text" class="form-control" data-validation-engine="validate[required,maxLength[60]]"
                                            placeholder="60个字符以内" id="tagName" name="tagName" value="${tag.tagName }">
                                    </div>
                                    <label class="col-sm-2 control-label no-padding-right" for="txtName">
                                        <i class="ace-icon fa fa-asterisk red smaller-70"></i>
                                        	标签代码
                                    </label>
                                    <div class="col-sm-4">
                                        <div class="input-group">
                                            <input type="text" class="form-control" data-validation-engine="validate[required]" placeholder=""  readonly="readonly" id="tagCode" name="tagCode" value="${tag.tagCode }">
                                        <span class="input-group-btn">
                                        <button type="button" class="btn btn-white btn-default btnTagCode" ${tag.tagCode == null ? '' : 'disabled'}>
                                            	生成
                                        </button>
                                          
                                        </span>
                                        </div>

                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label no-padding-right">
                                        <i class="ace-icon fa fa-asterisk red smaller-70"> </i>
                                        	标签类型</label>
                                    <div class="col-sm-4">
                                        <select class="form-control" name="codeType" id="codeType" data-validation-engine="validate[required]">
                                        	<option value=""></option>
                                        	<c:forEach var="dic" items="${tagTypeList }">
                                        		<option <c:if test="${tag.codeType == dic.DICTIONARYCODE }">selected</c:if> value="${dic.DICTIONARYCODE }">${dic.DICTIONARYNAME }</option>
                                        	</c:forEach>
                                        </select>
                                    </div>
                                    
                                     <label class="col-sm-2 control-label no-padding-right">
                                     <i class="ace-icon fa fa-asterisk red smaller-70"></i>
										所属分组</label>
                                    <div class="col-sm-4 ">
                                    		<c:if test="${empty topicCode}">
                                            <div class="input-group">
                                                    <input type="hidden" data-validation-engine="validate[required]" id="groupId" name="groupId" value="${tag.groupId == null ? (group.GROUP_ID == null ? 'root' : group.GROUP_ID) : tag.groupId}">
                                                    <input type="text" class="form-control"  data-validation-engine="validate[required]"  placeholder="" id="groupName" name="groupName" value="${tag.groupId == null ? (group.GROUP_NAME== null ? '标签树' : group.GROUP_NAME): (tag.groupId == 'root' ? '标签树' : tag.groupName)}" readonly="readonly"/>
                                                <span class="input-group-btn">
                                                <button type="button" class="btn btn-white btn-default" id="btnParentGroup">
                                                    <i class="ace-icon fa fa-search"></i>
                                                </button>
                                                    <button type="button" class="btn btn-white btn-clear btnRemove">
                                                        <i class="ace-icon fa fa-remove"></i>
                                                    </button>
                                                </span>
                                             </div>
                                            </c:if>
                                            <c:if test="${not empty topicCode}">
                                            <!-- 维护主题标签需要的基本信息 -->
                                            <input type="hidden" id="pkid" name="pkid" value="${pkid}"/>
                                            <input type="hidden" id="managerNode" name="managerNode" value="${managerNode}">
                                            <input type="hidden" id="topicCode" name="topicCode" value="${topicCode}">
                                            <input type="hidden" id="topicPath" name="topicPath" value="${topicPath}">
                                            <input type="hidden" id="topicId" name="topicId" value="${topicId}">
                                            
                                            	<div class="input-group">
                                                    <input type="hidden" data-validation-engine="validate[required]" id="groupId" name="groupId" value="${id==null?managerNode:(tag.groupId == null ? (group.GROUP_ID == null ? 'root' : group.GROUP_ID) : tag.groupId)}">
                                                    <input type="hidden" id="topicGroupId" name="topicGroupId" value="${topicGroupId}">
                                                    <input type="text" class="form-control"  placeholder="" id="topicGroupName" name="topicGroupName" value="${topicGroupName}" readonly="readonly"/>
                                                <span class="input-group-btn">
                                                <button type="button" class="btn btn-white btn-default" id="btnTopicGroup">
                                                    <i class="ace-icon fa fa-search"></i>
                                                </button>
                                                    <button type="button" class="btn btn-white btn-clear btnRemove">
                                                        <i class="ace-icon fa fa-remove"></i>
                                                    </button>
                                                </span>
                                             </div>
                                            </c:if>
                                    </div>
                                     
                                    
                                    
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label no-padding-right">
                                        	权重
                                    </label>
                                    <div class="col-sm-4">
                                        <input type="text" class="form-control" placeholder="数值大于0且小于等于100（保留两位小数）" data-validation-engine="validate[min[0.01],max[100],custom[twoDecimalNumber]]"  name="tagWeight" value="${tag.tagWeight }">

                                    </div>
                                    <label class="col-sm-2 control-label no-padding-right">
                                        	色彩</label>
                                    <div class="col-sm-4 ">
                                        <select class="form-control" name="codeColor">
                                            <option value="">--请选择--</option>
                                        	<c:forEach var="dic" items="${tagColorList }">
                                        		<option <c:if test="${tag.codeColor == dic.DICTIONARYCODE }">selected</c:if> value="${dic.DICTIONARYCODE }">${dic.DICTIONARYNAME }</option>
                                        	</c:forEach>
                                        </select>
                                    </div>
                                   

                                </div>
                               <div class="form-group">
                                    <label class="col-sm-2 control-label no-padding-right">
                                        	标签值类型</label>
                                    <div class="col-sm-4 ">
                                        <select class="form-control" name="tagValueType" >
                                        	<c:forEach var="dic" items="${tagValueTypeList }">
                                        		<option <c:if test="${tag.tagValueType == dic.DICTIONARYCODE }">selected</c:if> value="${dic.DICTIONARYCODE }">${dic.DICTIONARYNAME }</option>
                                        	</c:forEach>
                                        </select>
                                    </div>                                
                                	 <label class="col-sm-2 control-label no-padding-right" for="txtBirthday">
                                        	值域数值类型
                                    </label>
                                    <div class="col-sm-4">
                                        <div class="control-group">
                                            <div class="radio-inline">
                                                <label>
                                                    <input name="valueType" type="radio" class="ace" value="1" ${(tag.valueType == '1' || tag.valueType == null) ? 'checked' : '' }/>
                                                    <span class="lbl">字符型</span>
                                                </label>
                                            </div>

                                            <div class="radio-inline">
                                                <label>
                                                    <input name="valueType" type="radio" class="ace" value="2" ${tag.valueType == '2' ? 'checked' : '' }/>
                                                    <span class="lbl">数值型</span>
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                	 <label class="col-sm-2 control-label no-padding-right" for="txtBirthday">
                                        	排序
                                    </label>
                                    <div class="col-sm-4">
                                    	<c:if test="${empty topicCode}">
                                        <input type="text" class="form-control" placeholder="请输入整数" data-validation-engine="validate[custom[integer],maxLength[5]]" name="sort" value="${tag.sort }">
										</c:if>
										<c:if test="${not empty topicCode}">
										<input type="hidden" class="form-control" name="sort" value="${tag.sort }">
                                        <input type="text" class="form-control" placeholder="请输入整数" data-validation-engine="validate[custom[integer],maxLength[5]]" name="topicSort" value="${topicSort}">
										</c:if>
                                    </div>
                                    <label class="col-sm-2 control-label no-padding-right" for="txtBirthday">
                                        	是否型标签
                                    </label>
                                    <div class="col-sm-4">
                                        <div class="control-group">
                                            <div class="radio-inline">
                                                <label>
                                                    <input name="isboolean" type="radio" class="ace" value="1" ${(tag.isboolean == '1' || tag.isboolean == null) ? 'checked' : '' }/>
                                                    <span class="lbl">是</span>
                                                </label>
                                            </div>

                                            <div class="radio-inline">
                                                <label>
                                                    <input name="isboolean" type="radio" class="ace" value="2" ${tag.isboolean == '2' ? 'checked' : '' }/>
                                                    <span class="lbl">否</span>
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label no-padding-right" for="txtBirthday">
                                      	  描述
                                    </label>
                                    <div class="col-sm-10">
                                        <textarea class="form-control" name="tagDesc" placeholder="500字符以内" data-validation-engine="validate[maxLength[500]]" style="height: 66px;">${tag.tagDesc}</textarea>
                                    </div>

                                </div>
								<div id="tag-data-config">
                                <div class="form-group">
                                    <label class="col-sm-2 control-label no-padding-right">
                                        <i class="ace-icon fa fa-asterisk red smaller-70"> </i>
                                    	    生成规则</label>
                                    <div class="col-sm-10">
                                        <div class="control-group">
                                            <div class="radio-inline tagRule tagProperty tagModel" style="display:none">
                                                <label>
                                                    <input name="ruleType" type="radio" class="ace" value="1" ${(tag.ruleType == '1' || tag.ruleType == null) ? 'checked' : '' }>
                                                    <span class="lbl">资源目录</span>
                                                </label>
                                            </div>

                                            <div class="radio-inline tagRule tagProperty tagModel">
                                                <label>
                                                    <input name="ruleType" type="radio" class="ace" value="2" ${tag.ruleType == '2' ? 'checked' : '' }>
                                                    <span class="lbl">自定义SQL</span>
                                                </label>
                                            </div>
                                            
                                            <div class="radio-inline tagRule tagProperty tagModel">
                                                <label>
                                                    <input name="ruleType" type="radio" class="ace" value="3" ${tag.ruleType == '3' ? 'checked' : '' }>
                                                    <span class="lbl">手工标签</span>
                                                </label>
                                            </div>

                                        </div>

                                    </div>

                                </div>
                                <div class="form-group metaSource" ${(tag.ruleType == '1' || tag.ruleType == null) ? '' : 'style="display: none;"' }>
                                    <label class="col-sm-2 control-label no-padding-right">
                                       	 数据集
                                    </label>
                                    <div class="col-sm-10">

                                        <div class="input-group">
                                            <input type="hidden" id="datasetId" name="datasetId" value="${tag.datasetId }" />
                                            <input type="text" id="datasetName" name="datasetName" value="${tag.datasetName }"  ${tag.ruleType == '1' ? 'data-validation-engine="validate[required]"' : '' } class="form-control input-required" placeholder=""   readonly="readonly"  />
                                            <span class="input-group-btn">
                                                <button type="button" class="btn btn-white btn-default" id="btnDataset">
                                                    <i class="ace-icon fa fa-search"></i>
                                                   	 选择
                                                </button>
                                                <button type="button" class="btn btn-white btn-clear btnRemove">
                                                    <i class="ace-icon fa fa-remove"></i>
                                                </button>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group metaSource" ${(tag.ruleType == '1' || tag.ruleType == null) ? '' : 'style="display: none;"' }>
                                    <label class="col-sm-2 control-label no-padding-right">
                                        	指标字段
                                    </label>
                                    <div class="col-sm-4">
                                        <div class="input-group">
                                            <input type="hidden" id="datasetFieldid" name="datasetFieldid" value="${tag.datasetFieldid }" />
                                            <input type="text" id="datasetFieldname" name="datasetFieldname" value="${tag.datasetFieldname }"  ${tag.ruleType == '1' ? 'data-validation-engine="validate[required]"' : '' } class="form-control input-required" placeholder=""   readonly="readonly"  />
                                            <span class="input-group-btn">
                                                <button type="button" class="btn btn-white btn-default" id="btnDatasetField">
                                                    <i class="ace-icon fa fa-search"></i>
                                                   	 选择
                                                </button>
                                                <button type="button" class="btn btn-white btn-clear btnRemove">
                                                    <i class="ace-icon fa fa-remove"></i>
                                                </button>
                                            </span>
                                        </div>
                                    </div>
                                    <label class="col-sm-2 control-label no-padding-right">
                                        	关联字段</label>
                                    <div class="col-sm-4 ">
                                        <div class="input-group">
                                            <input type="hidden" id="datasetJoinId" name="datasetJoinId" value="${tag.datasetJoinId }" />
                                            <input type="text" id="datasetJoinName" name="datasetJoinName" value="${tag.datasetJoinName }"  ${tag.ruleType == '1' ? 'data-validation-engine="validate[required]"' : '' } class="form-control input-required" placeholder=""   readonly="readonly"  />
                                            <span class="input-group-btn">
                                                <button type="button" class="btn btn-white btn-default" id="btnDatasetJoin">
                                                    <i class="ace-icon fa fa-search"></i>
                                                   	 选择
                                                </button>
                                                <button type="button" class="btn btn-white btn-clear btnRemove">
                                                    <i class="ace-icon fa fa-remove"></i>
                                                </button>
                                            </span>
                                        </div>
                                    </div>

                                </div>
                                <div class="form-group sqlSource" ${tag.ruleType == '2'? '' : 'style="display: none;"' }>
                                    <label class="col-sm-2 control-label no-padding-right">
                                    </label>
                                    <div class="col-sm-10">
                                        <div class="input-group">
                                            <input type="hidden" id="sqldataSouce" name="sqldataSouce" value="${tag.sqldataSouce }" />
                                            <input type="text" id="sqldataSoucename" name="sqldataSoucename" value="${tag.sqldataSoucename }"  ${tag.ruleType == '2' ? 'data-validation-engine="validate[required]"' : '' } class="form-control input-required" placeholder=""   readonly="readonly"  />
                                            <span class="input-group-btn">
                                                <button type="button" class="btn btn-white btn-default" id="btnSqlDatasource">
                                                    <i class="ace-icon fa fa-search"></i>
                                                    	选择数据源
                                                </button>
                                                <button type="button" class="btn btn-white btn-clear btnRemove">
                                                    <i class="ace-icon fa fa-remove"></i>
                                                </button>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group tagRule tagProperty tagModel sqlSource"  ${tag.ruleType == '2'? '' : 'style="display: none;"' }>
                                    <label class="col-sm-2 control-label no-padding-right">

                                    </label>
                                    <div class="col-sm-10">
                                        <textarea class="form-control input-required" id="sqldataSql" name="sqldataSql" data-validation-engine="validate[${tag.ruleType == '2' ? 'required,' : '' }maxLength[4000]]"  placeholder="输入SQL语句，4000字符以内" style="height: 66px;">${tag.sqldataSql}</textarea>

                                    </div>

                                </div>

                                <div class="form-group sqlSource"  ${tag.ruleType == '2'? '' : 'style="display: none;"' }>
                                    <label class="col-sm-2 control-label no-padding-right" for="txtBirthday">
                                        	样本时间范围
                                    </label>
                                    <div class="col-sm-10">
                                        <textarea class="form-control" id="sqldataRemark"  name="sqldataRemark" data-validation-engine="validate[maxLength[1000]]" placeholder="请输入SQL，返回值将作为标签备注信息，1000字符以内" style=" height: 66px;">${tag.sqldataRemark }</textarea>

                                    </div>

                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 hidden-xs control-label no-padding-right">
                                        &nbsp;
                                    </label>
                                    <div class="col-sm-10">
                                        <div>
                                            <h4 class="blue">
                                                <i class="ace-icon fa fa-question-circle"></i>
                                                	帮助 - 生成规则
                                            </h4>
                                            <p><i class="ace-icon fa fa-hand-o-right"></i>
                                                <span class="red">自定义SQL</span>即通过SQL语句查询出标签结果集，结果集包含两列（KEY，VALUE）,系统根据KEY值匹配标签实体标识字段，更新对应的标签值为VALUE
                                            </p>
                                            <p><i class="ace-icon fa fa-hand-o-right"></i>
                                                <span class="red">手工标签</span>需人工录入
                                            </p>
                                        </div>
                                    </div>
                                </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label no-padding-right" for="txtBirthday">
                                        <i class="ace-icon fa fa-asterisk red smaller-70"> </i>
                                       	 值域
                                    </label>
                                    <div class="col-sm-10">
                                        <div class="control-group">
                                            <div class="radio-inline">
                                                <label>
                                                    <input name="rangeType" type="radio" class="ace" value="1" ${(tag.rangeType == '1' || tag.ruleType == null) ? 'checked' : '' }>
                                                    <span class="lbl">动态SQL</span>
                                                </label>
                                            </div>

                                            <div class="radio-inline">
                                                <label>
                                                    <input name="rangeType" type="radio" class="ace" value="2" ${tag.rangeType == '2' ? 'checked' : '' }>
                                                    <span class="lbl">静态JSON</span>
                                                </label>
                                            </div>
                                            <div class="radio-inline">
                                                <label>
                                                    <input name="rangeType" type="radio" class="ace" value="4" ${tag.rangeType == '4' ? 'checked' : '' }>
                                                    <span class="lbl">HTTP服务</span>
                                                </label>
                                            </div>
                                            <!-- //
                                            <div class="radio-inline">
                                                <label>
                                                    <input name="rangeType" type="radio" class="ace" value="3" ${tag.rangeType == '3' ? 'checked' : '' }>
                                                    <span class="lbl">级联</span>
                                                </label>
                                            </div>
											//-->
                                        </div>

                                    </div>

                                </div>
                                
                                <div class="form-group rangeDatasource"  ${(tag.rangeType == '1'|| tag.rangeType == '3' || tag.rangeType == null) ? '' : 'style="display: none;"' }>
                                    <label class="col-sm-2 control-label no-padding-right">
                                    </label>
                                    <div class="col-sm-10">
                                        <div class="input-group">
                                            <input type="hidden" id="rangeSourcekey" name="rangeSourcekey" value="${tag.rangeSourcekey }" />
                                            <input type="text" class="form-control" placeholder="" id="rangeSourcename" name="rangeSourcename" value="${tag.rangeSourcename }" ${tag.rangeType == '1' ? 'data-validation-engine="validate[required]"' : '' } readonly="readonly" />
                                            <span class="input-group-btn">
                                                <button type="button" class="btn btn-white btn-default" id="btnValueDatasource">
                                                    <i class="ace-icon fa fa-search"></i>
                                                    	选择数据源
                                                </button>
                                                <button type="button" class="btn btn-white btn-clear btnRemove">
                                                    <i class="ace-icon fa fa-remove"></i>
                                                </button>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group rangeParentTag"   ${tag.rangeType == '3' ? '' : 'style="display: none;"' }>
                                    <label class="col-sm-2 control-label no-padding-right">
                                    </label>
                                    <div class="col-sm-10">
                                        <div class="input-group">
                                            <input type="hidden"  id="rangeParentTagId" name="rangeParentTagId" value="${tag.rangeParentTagId }"/>
                                            <input type="text" class="form-control" placeholder="" id="rangeParentTagName" name="rangeParentTagName" value="${tag.rangeParentTagName }" readonly="readonly" />
                                            <span class="input-group-btn">
                                                <button type="button" class="btn btn-white btn-default" id="btnParentTag">
                                                    <i class="ace-icon fa fa-search"></i>
                                                    	选择父标签
                                                </button>
                                                <button type="button" class="btn btn-white btn-clear btnRemove">
                                                    <i class="ace-icon fa fa-remove"></i>
                                                </button>
                                            </span>
                                        </div>
                                    </div>
                                </div>                                
                                <div class="form-group rangeValue">
                                    <label class="col-sm-2 control-label no-padding-right" for="txtBirthday">

                                    </label>
                                    <div class="col-sm-10">
                                        <textarea class="form-control"  id="rangeValue" name="rangeValue" data-validation-engine="validate[required,maxLength[2000]]" placeholder="请输入值域SQL，2000字符以内" style="height: 66px;">${tag.rangeValue }</textarea>
                                    </div>

                                </div>

                                <div class="form-group">
                                    <label class="col-sm-2 hidden-xs control-label no-padding-right">
                                        &nbsp;
                                    </label>
                                    <div class="col-sm-10">
                                        <div class="alert-block">
                                            <h4 class="blue">
                                                <i class="ace-icon fa fa-question-circle"></i>
                                                	帮助 - 值域范围
                                            </h4>
                                            <p><i class="ace-icon fa fa-hand-o-right"></i>
                                                <span class="red">动态SQL</span>通过查询数据表，返回标签值域集合，必须包含value/icon/alias/desc四个字段，如:<br />
                                                SELECT field1 AS "value",field2 AS "icon",field3 AS "alias",field4 AS "desc" 
                                                <br/>FROM T_COD_DIC WHERE TYPE = 'C'
                                            </p>
                                            <p><i class="ace-icon fa fa-hand-o-right"></i>
                                                <span class="red">静态JSON</span>为对象数组，必须具有value/icon/alias/desc四个属性。如：<br/>
                                                [<br/>
												 &nbsp; &nbsp;{"value":"1-50吨","icon":"/assets/img/1.png","alias":"轻度污染","desc":"描述"},<br/>
												 &nbsp; &nbsp;{"value":"50-150吨","icon":"/assets/img/2.png","alias":"中度污染","desc":"描述"},<br/>
												 &nbsp; &nbsp;{"value":"150吨以上","icon":"/assets/img/3.png","alias":"重度污染","desc":"描述"}<br/>
												]
                                            </p>
                                            <p><i class="ace-icon fa fa-hand-o-right"></i>
                                                <span class="red">HTTP服务</span>是通过服务接口返回值域范围，系统自带3个服务接口，其他接口自行开发和解析。自带接口如下：<br/>
	                                               	行政区接口：/ws/dic/region.vm<br/>
	                                               	行业接口：/ws/dic/trade.vm<br/>
	                                               	流域接口：/ws/dic/wsystem.vm<br/>
                                            </p>  
                                            <!--  
                                            <p><i class="ace-icon fa fa-hand-o-right"></i>
                                                <span class="red">数字范围</span>为对象数组，必须具有v_up/v_down两个属性。如：<br/>
                                                [<br/>
												 &nbsp;&nbsp;{"v_up":"50","v_down":"0"},<br/>
												 &nbsp;&nbsp;{"v_up":"100","v_down":"50"}<br/>
												]
                                            </p>                                            
                                            <p><i class="ace-icon fa fa-hand-o-right"></i>
                                                <span class="red">级联</span>指标签之间的联动。如：行政区省、市、县的联动等。<br/>
                                                SQL语句需返回CODE、NAME两个字段，SQL参数 <span class="yellow">{0}</span> 将由父标签值替换<br/>
                                                SELECT CODE1 AS CODE,NAME1 AS NAME FROM TABLE1 WHERE PARENTCODE IN ( {0} )
                                            </p>
                                             -->
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group" id="task-config">
                                    <label class="col-sm-2 control-label no-padding-right" for="txtName">
                                        	执行方式
                                    </label>
                                    <div class="col-sm-4">
                                        <select class="form-control" id="ltsRunType" name=ltsRunType>
											<option <c:if test="${tag.ltsRunType=='new'}">selected="selected"</c:if> value="new">增量</option>
											<option <c:if test="${tag.ltsRunType=='all'}">selected="selected"</c:if> value="all">全量</option>
										</select>
                                    </div>
                                    <label class="col-sm-2 control-label no-padding-right"> 
									<i class="ace-icon fa fa-asterisk red smaller-70"></i>
										运行节点
									</label>
									<div class="col-sm-4">
										<select class="form-control input-required" name="ltsRunNode" data-validation-engine="validate[required]">
											<option  value="">--请选择--</option>
											<c:forEach var="node" items="${ltsNodes }">
												<option <c:if test="${tag.ltsRunNode == node}">selected="selected"</c:if> value="${node }">${node }</option>
											</c:forEach>
										</select>
									</div>
                                </div>
								<div class="form-group">
                                    <label class="col-sm-2 control-label no-padding-right" for="txtBirthday">
                                        <i class="ace-icon fa fa-asterisk red smaller-70"></i>
                                        	状态
                                    </label>
                                    <div class="col-sm-4">
                                        <select class="form-control" id="status" name="status">
                                            <option <c:if test="${tag.status == '1' }">selected</c:if> value="1">启用</option>
                                            <option <c:if test="${tag.status == '0' }">selected</c:if> value="0">停用</option>
                                        </select>
                                    </div>
                                    <label class="col-sm-2 control-label no-padding-right task-data-config" for="txtName">
                                        	维护计划
                                    </label>
                                    <div class="col-sm-4 task-data-config">
                                        <div class="input-group">
                                            <input type="text" class="form-control" placeholder="" id="maintainCron" name="maintainCron" data-validation-engine="validate[maxLength[50]]" value="${tag.maintainCron }"  readonly="readonly" />
                                            <span class="input-group-btn">
                                                <button type="button" class="btn btn-white btn-default" id="btnChooseCron">
                                                    <i class="ace-icon fa fa-clock-o"></i>

                                                </button>
                                                <button type="button" class="btn btn-white btn-clear btnRemove">
                                                    <i class="ace-icon fa fa-remove"></i>
                                                </button>	 
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <div id="dialog-cron" class="hide">

                                </div>
                                <div id="dialog-datasource" class="hide">
                                    <span>系统中的所有数据源选择，均采用智能生产线(元数据管理)中的数据源选择。</span>

                                </div>
                            </form>
                    </div><!-- /.row -->
                </div>
            </div>
            <!--/.main-content-inner-->
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
	            url:'${ctx }/define/tag/save.vm',
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
	            	        	if(window.parent.reLoadTree){
	            	        		window.parent.reLoadTree();
	            	        	}else if(window.parent.parent.reLoadTree){
	            	        		window.parent.parent.reLoadTree();
	            	        	}		            	        	
	            	        }
	            	    }).showModal();
	            	}
	            }
	        });
	    }
	}
	
	function createCode() {
		function S4() {
		  return (((1+Math.random())*0x10000)|0).toString(16).substring(1);
		}
		var code = S4()+S4()+S4()+S4()+S4()+S4()+S4()+S4();
		$('input[name="tagCode"]').val(code.toUpperCase());
	}	
	
	
	//返回
	function goBack() {
	    $("#main-container",window.parent.document).show();
	    $("#iframeInfo",window.parent.document).attr("src","").hide();
	}
	
	//关闭dialog
	function closeDialog(id){
		dialog.get(id).close().remove();
	}	
	
	//清除已选择的数据
	function clearValue(btn){	
		$(btn).parents('.input-group').find('input').val('');
		$(btn).parents('.form-group').find('li').remove();
	}
	
	function cronEdit(){		
		_url='${ctx}/common/cron/cron.jsp?cronField=maintainCron&dialogId=cron-edit';
		dialog({
			id:"cron-edit",
	        title: '计划配置',
	        url: _url,
	        width:450,
	        height:380,
	       	cancel:function()
	       	{
	       	},
	       	cancelDisplay: false
	    }).showModal();
	}	
	
	function chooseParentGroupOrTag(type,callback){
		dialog({
			id:"dialog-group-select",
            title: '选择父节点',
            url: "${ctx}/define/tag/tree.vm?TYPE="+type+"&ENTITY_ID=${ENTITY_ID == null ? tag.entityId : ENTITY_ID}"+"&callback="+callback,
            width:400,
            height:450>document.documentElement.clientHeight?document.documentElement.clientHeight:450,
        }).showModal();
	}
	<!--主题树开始-->
	//选择主题树,根据topicCode是否有值来判断取主题树还是标签树
	function chooseTopicGroup(type,callback){
		var topicCode = '${topicCode}';
		dialog({
			id:"dialog-group-select",
            title: '选择父节点',
            url: "${ctx}/define/tag/tree.vm?TYPE="+type+"&topicCode=" + topicCode+"&callback="+callback,
            width:400,
            height:450>document.documentElement.clientHeight?document.documentElement.clientHeight:450,
        }).showModal();
	}
	$("#btnTopicGroup").click(function(){
		chooseTopicGroup('group','treeTopicGroupCallBack');
	});		
	//选择父节点Dialog回调函数
	function treeTopicGroupCallBack(treeNode){
		$('#topicGroupId').val(treeNode.id);
		$('#topicGroupName').val(treeNode.name);
		$('#topicPath').val(treeNode.path);
	}	
	<!--主题树结束-->
	
	//关闭选择父节点Dialog
	function closeCallback(){
		dialog.get("dialog-group-select").close().remove();
	}	
	
	//选择父节点Dialog回调函数
	function treeGroupCallBack(treeNode){
		$('#groupId').val(treeNode.id);
		$('#groupName').val(treeNode.name);
	}	
	
	//选择父节点Dialog回调函数
	function treeTagCallBack(treeNode){
		$('#rangeParentTagId').val(treeNode.id);
		$('#rangeParentTagName').val(treeNode.name);
	}		
	
	
	function datasourceSelected(id,name){		
		_url='${ctx}/tag-common/data-source-selected.vm?dicCodeId='+id+'&dicNameId='+name;
		dialog({
			id:"datasource-select-window",
	        title: '数据源选择',
	        url: _url,
	        width:400,
	        height:460,
	       	cancel:function()
	       	{
	       	},
	       	cancelDisplay: false
	    }).showModal();
	}	
	
	function datasetSelected(){	
		var _url='/tag/resourceutils/showlist.vm?layer=1&tid=03&opentype=showModal';
	    var d=dialog({
			id:"resource-select-window",
	        title: '数据集选择',
	        url: _url,
	        width:880,
	        height:500,
	       	cancelDisplay: false
	    });
	    d.showModal();
	}		
	
	//数据集选择回调函数
	function datasetSelectCallBack(datasetcode,datasetname){
		$("#datasetId").val(datasetcode);
		$("#datasetName").val(datasetname);
	}	
	
	//数据集字段选择
	function columnSelected(callback){	
		var _url='/tag/resourceutils/reportcolumntree.vm?datasetid='+$("#datasetId").val()+'&callback='+callback;
	    var d=dialog({
			id:"resource-columnselect-window",
	        title: '字段选择',
	        url: _url,
	        width:350,
	        height:450,
	       	cancelDisplay: false
	    });
	    d.showModal();
	}
	
	//数据集指标字段选择回调函数
	function datasetIndicatorColumnCallBack(id,name){
		$("#datasetFieldid").val(id);
		$("#datasetFieldname").val(name);
	}
	
	//数据集关联字段选择回调函数
	function datasetJoinColumnCallBack(id,name){
		$("#datasetJoinId").val(id);
		$("#datasetJoinName").val(name);
	}
	
	//根据值域类型设置表单验证逻辑
	function changeValidateByType(){
		var type = $("input[name='ruleType']:checked").val();
		if(type == '1'){
			$('.metaSource .input-required').attr('data-validation-engine','validate[required]');
			$('.sqlSource .input-required').removeAttr('data-validation-engine');
			$('.metaSource').show();
			$('.sqlSource').hide();
			
			$('#task-config').show();
			$('.task-data-config').show();
		} else if(type == '2'){
			$('.metaSource .input-required').removeAttr('data-validation-engine');
			$('.sqlSource .input-required').attr('data-validation-engine','validate[required,maxLength[4000]]');
			$('.sqlSource').show();
			$('.metaSource').hide();
			
			$('#task-config').show();
			$('.task-data-config').show();
		} else if(type == '3'){
			$('.sqlSource .input-required').removeAttr('data-validation-engine');
			$('.metaSource .input-required').removeAttr('data-validation-engine');
			$('.sqlSource').hide();
			$('.metaSource').hide();
			
			$('#task-config').hide();
			$('.task-data-config').hide();
			$('.metaSource .input-required').attr('data-validation-engine','validate[maxLength[100]]');
			$('.sqlSource .input-required').attr('data-validation-engine','validate[maxLength[2000]]');
			$('#task-config .input-required').attr('data-validation-engine','validate[maxLength[100]]');
		} 
	}
	
	jQuery(function($){
		changeValidateByType();
		//执行计划配置
		$("#btnChooseCron").click(function(){
			cronEdit();
		});
		$(".btnRemove").click(function(){
			clearValue(this);
		});		
		$(".btnTagCode").click(function(){
			createCode();
		});	
		$("#btnParentGroup").click(function(){
			chooseParentGroupOrTag('group','treeGroupCallBack');
		});		
		$("#btnParentTag").click(function(){
			chooseParentGroupOrTag('tag','treeTagCallBack');
		});		
		$("#btnSqlDatasource").click(function(){
			datasourceSelected('sqldataSouce','sqldataSoucename');
		});		
		$("#btnValueDatasource").click(function(){
			datasourceSelected('rangeSourcekey','rangeSourcename');
		});		
		$("#btnDataset").click(function(){
			datasetSelected('datasetId','datasetName');
		});		
		$("#btnDatasetField").click(function(){
			columnSelected('datasetIndicatorColumnCallBack');
		});		
		$("#btnDatasetJoin").click(function(){
			columnSelected('datasetJoinColumnCallBack');
		});		
		$("input[name='ruleType']").click(function(){
			changeValidateByType(); 
		});	
		$("input[name='rangeType']").click(function(){
			var type = $("input[name='rangeType']:checked").val();
			if(type == '1'){
				$('#rangeSourcename').attr('data-validation-engine','validate[required]');
				$('.rangeDatasource').show();
				$('.rangeParentTag').hide();
				$("#rangeValue").attr("placeholder", "请输入值域SQL，2000字符以内");
			} else if(type == '2'){
				$('#rangeSourcename').removeAttr('data-validation-engine');
				$('.rangeDatasource').hide();
				$('.rangeParentTag').hide();
				$("#rangeValue").attr("placeholder", "格式详见：帮助 - 值域范围");
			} else if(type == '3'){
				$('#rangeSourcename').removeAttr('data-validation-engine');
				$('.rangeDatasource').show();
				$('.rangeParentTag').show();
				$("#rangeValue").attr("placeholder", "请输入级联SQL，2000字符以内，如SELECT CODE,NAME FROM TABLE1 WHERE PARENTCODE IN ({0})");
			} else if(type == '4'){
				$('#rangeSourcename').removeAttr('data-validation-engine');
				$('.rangeDatasource').hide();
				$('.rangeParentTag').hide();
				$("#rangeValue").attr("placeholder", "请输入值域HTTP服务地址，2000字符以内");
			} 
		});			
		
		
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
