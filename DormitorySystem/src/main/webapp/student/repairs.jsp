<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
      <!DOCTYPE html>
      <html>

      <head>
        <title>报修服务 - 学生宿舍管理系统</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
        <style>
          .repairs-container {
            background: white;
            border-radius: 10px;
            padding: 20px;
            margin: 20px auto;
            max-width: 1000px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
          }

          .repairs-header {
            border-bottom: 2px solid #f0f0f0;
            padding-bottom: 15px;
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
          }

          .repairs-header h2 {
            color: #333;
            margin: 0;
          }

          .repair-form {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 5px;
            margin-bottom: 20px;
          }

          .form-group {
            margin-bottom: 15px;
          }

          .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #666;
          }

          .form-group select,
          .form-group textarea {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
          }

          .form-group textarea {
            height: 100px;
            resize: vertical;
          }

          .repairs-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
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

          .repairs-table tr:hover {
            background: #f8f9fa;
          }

          .status {
            padding: 5px 10px;
            border-radius: 15px;
            font-size: 0.9em;
          }

          .status-pending {
            background: #fff3cd;
            color: #856404;
          }

          .status-solved {
            background: #d4edda;
            color: #155724;
          }

          .submit-btn {
            background: #007bff;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
          }

          .submit-btn:hover {
            background: #0056b3;
          }

          .back-btn {
            display: inline-block;
            padding: 10px 20px;
            background: #6c757d;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            margin-top: 20px;
          }

          .back-btn:hover {
            background: #5a6268;
          }

          .error {
            color: #dc3545;
            background-color: #f8d7da;
            padding: 10px;
            border-radius: 4px;
            margin-bottom: 20px;
          }
        </style>
      </head>

      <body>
        <div class="header">
          <h1 class="system-title">学生宿舍管理系统</h1>
        </div>

        <div class="repairs-container">
          <div class="repairs-header">
            <h2>报修服务</h2>
          </div>

          <c:if test="${not empty error}">
            <div class="error">${error}</div>
          </c:if>

          <form class="repair-form" action="${pageContext.request.contextPath}/student/repairs" method="post">
            <div class="form-group">
              <label for="propertyId">报修物品</label>
              <select id="propertyId" name="propertyId" required>
                <option value="">请选择报修物品</option>
                <option value="1">床</option>
                <option value="2">桌子</option>
                <option value="3">椅子</option>
                <option value="4">空调</option>
                <option value="5">灯</option>
              </select>
            </div>
            <div class="form-group">
              <label for="reason">报修原因</label>
              <textarea id="reason" name="reason" required placeholder="请详细描述问题"></textarea>
            </div>
            <button type="submit" class="submit-btn">提交报修</button>
          </form>

          <h3>报修记录</h3>
          <table class="repairs-table">
            <thead>
              <tr>
                <th>物品名称</th>
                <th>报修原因</th>
                <th>提交时间</th>
                <th>解决时间</th>
                <th>状态</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach items="${repairs}" var="repair">
                <tr>
                  <td>${repair.propertyName}</td>
                  <td>${repair.reason}</td>
                  <td>
                    <fmt:formatDate value="${repair.submitDate}" pattern="yyyy-MM-dd" />
                  </td>
                  <td>
                    <c:if test="${not empty repair.solveDate}">
                      <fmt:formatDate value="${repair.solveDate}" pattern="yyyy-MM-dd" />
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
                </tr>
              </c:forEach>
            </tbody>
          </table>

          <a href="${pageContext.request.contextPath}/student/dashboard.jsp" class="back-btn">返回仪表板</a>
        </div>
      </body>

      </html>