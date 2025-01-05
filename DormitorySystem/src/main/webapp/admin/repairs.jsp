<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
      <!DOCTYPE html>
      <html>

      <head>
        <title>报修管理 - 学生宿舍管理系统</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
        <style>
          .repairs-container {
            background: white;
            border-radius: 10px;
            padding: 20px;
            margin: 20px auto;
            max-width: 1200px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
          }

          .repair-form {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 5px;
            margin-bottom: 20px;
          }

          .repairs-table {
            width: 100%;
            border-collapse: collapse;
          }

          .repairs-table th,
          .repairs-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #eee;
          }

          .repairs-table th {
            background: #f8f9fa;
            font-weight: 500;
            color: #666;
          }

          .btn-solve {
            padding: 6px 12px;
            background: #28a745;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
          }

          .btn-solve:hover {
            background: #218838;
          }

          .status {
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 0.9em;
          }

          .status-pending {
            background: #ffc107;
            color: #000;
          }

          .status-solved {
            background: #28a745;
            color: white;
          }
        </style>
      </head>

      <body>
        <div class="header">
          <h1 class="system-title">学生宿舍管理系统</h1>
        </div>

        <div class="repairs-container">
          <h2>报修管理</h2>

          <!-- 添加报修表单 -->
          <form class="repair-form" action="${pageContext.request.contextPath}/admin/repairs" method="post">
            <div class="form-group">
              <label for="dormId">宿舍号</label>
              <input type="text" id="dormId" name="dormId" required>
            </div>
            <div class="form-group">
              <label for="propertyId">财产</label>
              <select id="propertyId" name="propertyId" required>
                <option value="">请选择报修物品</option>
                <c:forEach items="${properties}" var="property">
                  <option value="${property.id}">${property.name}</option>
                </c:forEach>
              </select>
            </div>
            <div class="form-group">
              <label for="reason">报修原因</label>
              <textarea id="reason" name="reason" required></textarea>
            </div>
            <button type="submit" class="btn btn-primary">提交报修</button>
          </form>

          <!-- 报修列表 -->
          <table class="repairs-table">
            <thead>
              <tr>
                <th>宿舍号</th>
                <th>财产名称</th>
                <th>报修原因</th>
                <th>报修时间</th>
                <th>解决时间</th>
                <th>状态</th>
                <th>操作</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach items="${repairs}" var="repair">
                <tr>
                  <td>${repair.dormId}</td>
                  <td>${repair.propertyName}</td>
                  <td>${repair.reason}</td>
                  <td>
                    <fmt:formatDate value="${repair.submitDate}" pattern="yyyy-MM-dd HH:mm" />
                  </td>
                  <td>
                    <c:if test="${not empty repair.solveDate}">
                      <fmt:formatDate value="${repair.solveDate}" pattern="yyyy-MM-dd HH:mm" />
                    </c:if>
                    <c:if test="${empty repair.solveDate}">
                      -
                    </c:if>
                  </td>
                  <td>
                    <span class="status ${empty repair.solveDate ? 'status-pending' : 'status-solved'}">
                      ${empty repair.solveDate ? '待处理' : '已解决'}
                    </span>
                  </td>
                  <td>
                    <c:if test="${empty repair.solveDate}">
                      <form style="display: inline;" action="${pageContext.request.contextPath}/admin/repairs"
                        method="post">
                        <input type="hidden" name="action" value="solve">
                        <input type="hidden" name="id" value="${repair.id}">
                        <button type="submit" class="btn-solve">标记解决</button>
                      </form>
                    </c:if>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>

          <a href="${pageContext.request.contextPath}/admin/dashboard.jsp" class="btn btn-primary"
            style="margin-top: 20px;">返回仪表板</a>
        </div>
      </body>

      </html>