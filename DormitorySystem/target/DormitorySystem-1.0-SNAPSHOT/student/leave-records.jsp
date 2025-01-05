<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
      <!DOCTYPE html>
      <html>

      <head>
        <title>离返校记录 - 学生宿舍管理系统</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
        <style>
          .leave-records-container {
            background: white;
            border-radius: 10px;
            padding: 20px;
            margin: 20px auto;
            max-width: 1000px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
          }

          .leave-records-header {
            border-bottom: 2px solid #f0f0f0;
            padding-bottom: 15px;
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
          }

          .leave-records-header h2 {
            color: #333;
            margin: 0;
          }

          .leave-form {
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

          .form-group input[type="date"] {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
          }

          .records-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
          }

          .records-table th,
          .records-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #eee;
          }

          .records-table th {
            background: #f8f9fa;
            font-weight: 500;
            color: #666;
          }

          .records-table tr:hover {
            background: #f8f9fa;
          }

          .btn {
            display: inline-block;
            padding: 8px 16px;
            border-radius: 4px;
            text-decoration: none;
            color: white;
            cursor: pointer;
            border: none;
            font-size: 14px;
          }

          .btn-primary {
            background: #007bff;
          }

          .btn-primary:hover {
            background: #0056b3;
          }

          .btn-danger {
            background: #dc3545;
          }

          .btn-danger:hover {
            background: #c82333;
          }

          .btn-success {
            background: #28a745;
          }

          .btn-success:hover {
            background: #218838;
          }

          .status {
            padding: 5px 10px;
            border-radius: 15px;
            font-size: 0.9em;
          }

          .status-ongoing {
            background: #fff3cd;
            color: #856404;
          }

          .status-returned {
            background: #d4edda;
            color: #155724;
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

        <div class="leave-records-container">
          <div class="leave-records-header">
            <h2>离返校记录</h2>
          </div>

          <c:if test="${not empty error}">
            <div class="error">${error}</div>
          </c:if>

          <form class="leave-form" action="${pageContext.request.contextPath}/student/leave-records" method="post">
            <input type="hidden" name="action" value="add">
            <div class="form-group">
              <label for="leaveDate">离校时间</label>
              <input type="date" id="leaveDate" name="leaveDate" required>
            </div>
            <button type="submit" class="btn btn-primary">登记离校</button>
          </form>

          <table class="records-table">
            <thead>
              <tr>
                <th>离校时间</th>
                <th>返校时间</th>
                <th>状态</th>
                <th>操作</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach items="${records}" var="record">
                <tr>
                  <td>
                    <fmt:formatDate value="${record.leaveTime}" pattern="yyyy-MM-dd" />
                  </td>
                  <td>
                    <c:if test="${not empty record.returnTime}">
                      <fmt:formatDate value="${record.returnTime}" pattern="yyyy-MM-dd" />
                    </c:if>
                    <c:if test="${empty record.returnTime}">
                      -
                    </c:if>
                  </td>
                  <td>
                    <span class="status ${empty record.returnTime ? 'status-ongoing' : 'status-returned'}">
                      ${empty record.returnTime ? '离校中' : '已返校'}
                    </span>
                  </td>
                  <td>
                    <c:if test="${empty record.returnTime}">
                      <form style="display: inline;" action="${pageContext.request.contextPath}/student/leave-records"
                        method="post">
                        <input type="hidden" name="action" value="return">
                        <input type="hidden" name="id" value="${record.id}">
                        <input type="date" name="returnDate" required style="margin-right: 10px;">
                        <button type="submit" class="btn btn-success">登记返校</button>
                      </form>
                    </c:if>
                    <form style="display: inline;" action="${pageContext.request.contextPath}/student/leave-records"
                      method="post">
                      <input type="hidden" name="action" value="delete">
                      <input type="hidden" name="id" value="${record.id}">
                      <button type="submit" class="btn btn-danger" onclick="return confirm('确定要删除这条记录吗？')">删除</button>
                    </form>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>

          <a href="${pageContext.request.contextPath}/student/dashboard.jsp" class="btn btn-primary"
            style="margin-top: 20px;">返回仪表板</a>
        </div>
      </body>

      </html>