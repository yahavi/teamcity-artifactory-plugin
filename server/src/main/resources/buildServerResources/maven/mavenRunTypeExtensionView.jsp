<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  ~ Copyright (C) 2010 JFrog Ltd.
  ~
  ~ Licensed under the Apache License, Version 2.0 (the "License");
  ~ you may not use this file except in compliance with the License.
  ~ You may obtain a copy of the License at
  ~
  ~ http://www.apache.org/licenses/LICENSE-2.0
  ~
  ~ Unless required by applicable law or agreed to in writing, software
  ~ distributed under the License is distributed on an "AS IS" BASIS,
  ~ WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  ~ See the License for the specific language governing permissions and
  ~ limitations under the License.
  --%>

<jsp:useBean id="propertiesBean" scope="request" type="jetbrains.buildServer.controllers.BasePropertiesBean"/>

<c:set var="foundExistingConfig"
       value="${not empty propertiesBean.properties['org.jfrog.artifactory.selectedDeployableServer.urlId'] ? true : false}"/>

<c:set var="foundPublishBuildInfoSelected"
       value="${(not empty propertiesBean.properties['org.jfrog.artifactory.selectedDeployableServer.publishBuildInfo'])
       && (propertiesBean.properties['org.jfrog.artifactory.selectedDeployableServer.publishBuildInfo'] == true) ? true : false}"/>

<jsp:include page="../common/artifactoryEnabledView.jsp">
    <jsp:param name="artifactoryEnabled" value="${foundExistingConfig}"/>
</jsp:include>

<c:if test="${foundExistingConfig}">

    <jsp:include page="../common/serversView.jsp"/>

    <jsp:include page="../common/targetRepoView.jsp"/>

    <div class="nestedParameter">
        Target snapshot repository :
        <c:set var="deploySnapshotFlag"
               value="${(propertiesBean.properties['org.jfrog.artifactory.selectedDeployableServer.deploySnapshotFlag'])}"/>
        <c:choose>
            <c:when test="${deploySnapshotFlag}">
                <props:displayValue
                        name="org.jfrog.artifactory.selectedDeployableServer.deploySnapshotText" emptyValue="not specified"/>
            </c:when>
            <c:otherwise>
                <props:displayValue
                        name="org.jfrog.artifactory.selectedDeployableServer.targetSnapshotRepo" emptyValue="not specified"/>
            </c:otherwise>
        </c:choose>
    </div>

    <jsp:include page="../common/credentialsView.jsp"/>

    <jsp:include page="../common/deployArtifactsView.jsp">
        <jsp:param name="shouldDisplay" value="true"/>
    </jsp:include>

    <div class="nestedParameter">
        Publish Build Info: <props:displayValue
            name="org.jfrog.artifactory.selectedDeployableServer.publishBuildInfo" emptyValue="false"/>
    </div>

    <jsp:include page="../common/envVarsView.jsp">
        <jsp:param name="shouldDisplay" value="${foundPublishBuildInfoSelected}"/>
    </jsp:include>

    <jsp:include page="../common/buildRetentionView.jsp">
        <jsp:param name="shouldDisplay" value="${foundPublishBuildInfoSelected}"/>
    </jsp:include>

    <jsp:include page="../common/xrayScanView.jsp">
        <jsp:param name="shouldDisplay" value="${foundPublishBuildInfoSelected}"/>
    </jsp:include>

    <jsp:include page="../common/releaseManagementView.jsp">
        <jsp:param name="shouldDisplay" value="true"/>
        <jsp:param name="builderName" value='maven'/>
    </jsp:include>
</c:if>
