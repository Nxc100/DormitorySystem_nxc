<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
      <!DOCTYPE html>
      <html>

      <head>
        <title>个人信息 - 学生宿舍管理系统</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
        <style>
          .profile-container {
            background: white;
            border-radius: 10px;
            padding: 20px;
            margin: 20px auto;
            max-width: 800px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
          }

          .profile-header {
            border-bottom: 2px solid #f0f0f0;
            padding-bottom: 15px;
            margin-bottom: 20px;
          }

          .profile-header h2 {
            color: #333;
            margin: 0;
          }

          .info-group {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
            margin-bottom: 20px;
          }

          .info-item {
            padding: 10px;
            background: #f8f9fa;
            border-radius: 5px;
          }

          .info-label {
            color: #666;
            font-size: 0.9em;
            margin-bottom: 5px;
          }

          .info-value {
            color: #333;
            font-weight: 500;
          }

          .back-btn {
            display: inline-block;
            padding: 10px 20px;
            background: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            margin-top: 20px;
          }

          .back-btn:hover {
            background: #0056b3;
          }

          .password-form {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 5px;
            margin-top: 20px;
          }

          .password-form h3 {
            margin-top: 0;
            margin-bottom: 20px;
            color: #333;
          }

          .success {
            color: #155724;
            background-color: #d4edda;
            padding: 10px;
            border-radius: 4px;
            margin-bottom: 20px;
          }

          .error {
            color: #dc3545;
            background-color: #f8d7da;
            padding: 10px;
            border-radius: 4px;
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

          .form-group input {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
          }

          .btn-primary {
            background: #007bff;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
          }

          .btn-primary:hover {
            background: #0056b3;
          }
        </style>
      </head>

      <body>
        <div class="header">
          <h1 class="system-title">学生宿舍管理系统</h1>
        </div>

        <div class="profile-container">
          <div class="profile-header">
            <h2>个人信息</h2>
          </div>

          <c:if test="${not empty student}">
            <div class="info-group">
              <div class="info-item">
                <div class="info-label">学号</div>
                <div class="info-value">${student.studentId}</div>
              </div>
              <div class="info-item">
                <div class="info-label">姓名</div>
                <div class="info-value">${student.name}</div>
              </div>
              <div class="info-item">
                <div class="info-label">性别</div>
                <div class="info-value">${student.gender}</div>
              </div>
              <div class="info-item">
                <div class="info-label">专业</div>
                <div class="info-value">${student.major}</div>
              </div>
              <div class="info-item">
                <div class="info-label">宿舍号</div>
                <div class="info-value">${student.dormId}</div>
              </div>
              <div class="info-item">
                <div class="info-label">宿舍电话</div>
                <div class="info-value">${student.dormPhone}</div>
              </div>
              <div class="info-item">
                <div class="info-label">入住时间</div>
                <div class="info-value">
                  <fmt:formatDate value="${student.checkInDate}" pattern="yyyy-MM-dd" />
                </div>
              </div>
            </div>
          </c:if>

          <c:if test="${empty student}">
            <div class="empty-message">
              未找到学生信息
            </div>
          </c:if>

          <div class="password-form">
            <h3>修改密码</h3>

            <c:if test="${not empty error}">
              <div class="error">${error}</div>
            </c:if>
            <c:if test="${not empty success}">
              <div class="success">${success}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/student/change-password" method="post"
              onsubmit="return validatePasswordForm()">
              <div class="form-group">
                <label for="oldPassword">原密码</label>
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
          </div>

          <a href="${pageContext.request.contextPath}/student/dashboard.jsp" class="back-btn">返回仪表板</a>
        </div>

        <script>
          function validatePasswordForm() {
            var newPassword = document.getElementById('newPassword').value;
            var confirmPassword = document.getElementById('confirmPassword').value;

            if (newPassword !== confirmPassword) {
              alert('新密码与确认密码不一致');
              return false;
            }

            if (newPassword.length < 6) {
              alert('新密码长度不能小于6位');
              return false;
            }

            return true;
          }
        </script>
      </body>

      </html>