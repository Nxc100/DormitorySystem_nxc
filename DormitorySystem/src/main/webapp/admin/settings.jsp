<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!DOCTYPE html>
    <html>

    <head>
      <title>系统设置 - 学生宿舍管理系统</title>
      <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
      <style>
        .settings-container {
          background: white;
          border-radius: 10px;
          padding: 20px;
          margin: 20px auto;
          max-width: 600px;
          box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .form-group {
          margin-bottom: 15px;
        }

        .form-group label {
          display: block;
          margin-bottom: 5px;
          color: #666;
        }

        .form-group input {
          width: 100%;
          padding: 8px;
          border: 1px solid #ddd;
          border-radius: 4px;
        }

        .error-message {
          color: #dc3545;
          margin-bottom: 10px;
        }

        .success-message {
          color: #28a745;
          margin-bottom: 10px;
        }
      </style>
    </head>

    <body>
      <div class="header">
        <h1 class="system-title">学生宿舍管理系统</h1>
      </div>

      <div class="settings-container">
        <h2>修改管理员密码</h2>

        <c:if test="${not empty error}">
          <div class="error-message">${error}</div>
        </c:if>
        <c:if test="${not empty success}">
          <div class="success-message">${success}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/admin/settings/password" method="post">
          <div class="form-group">
            <label for="oldPassword">当前密码</label>
            <input type="password" id="oldPassword" name="oldPassword" required>
          </div>
          <div class="form-group">
            <label for="newPassword">新密码</label>
            <input type="password" id="newPassword" name="newPassword" required>
          </div>
          <div class="form-group">
            <label for="confirmPassword">确认新密码</label>
            <input type="password" id="confirmPassword" name="confirmPassword" required>
          </div>
          <button type="submit" class="btn btn-primary">修改密码</button>
        </form>

        <a href="${pageContext.request.contextPath}/admin/dashboard.jsp" class="btn btn-primary"
          style="margin-top: 20px;">返回仪表板</a>
      </div>
    </body>

    </html>