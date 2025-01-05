<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <!DOCTYPE html>
  <html>

  <head>
    <title>注册 - 学生宿舍管理系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
      .register-container {
        max-width: 400px;
        margin: 50px auto;
        padding: 30px;
        background-color: white;
        border-radius: 10px;
        box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
      }

      .register-header {
        text-align: center;
        margin-bottom: 30px;
      }

      .register-header h1 {
        color: #333;
        font-size: 24px;
        margin-bottom: 10px;
      }

      .register-form {
        margin-top: 20px;
      }

      .form-group {
        margin-bottom: 20px;
      }

      .form-group label {
        display: block;
        margin-bottom: 8px;
        color: #555;
        font-weight: 500;
      }

      .form-group input {
        width: 100%;
        padding: 12px;
        border: 1px solid #ddd;
        border-radius: 6px;
        font-size: 14px;
        transition: all 0.3s ease;
      }

      .form-group input:focus {
        border-color: #007bff;
        box-shadow: 0 0 0 2px rgba(0, 123, 255, 0.25);
        outline: none;
      }

      .register-btn {
        width: 100%;
        padding: 12px;
        background: #007bff;
        color: white;
        border: none;
        border-radius: 6px;
        font-size: 16px;
        font-weight: 500;
        cursor: pointer;
        transition: all 0.3s ease;
      }

      .register-btn:hover {
        background: #0056b3;
        transform: translateY(-2px);
      }

      .login-link {
        text-align: center;
        margin-top: 20px;
        color: #666;
      }

      .login-link a {
        color: #007bff;
        text-decoration: none;
        margin-left: 5px;
      }

      .login-link a:hover {
        text-decoration: underline;
      }

      .error {
        color: #dc3545;
        background-color: #f8d7da;
        padding: 10px;
        border-radius: 4px;
        margin-bottom: 20px;
        text-align: center;
      }
    </style>
  </head>

  <body>
    <div class="header">
      <h1 class="system-title">学生宿舍管理系统</h1>
    </div>

    <div class="register-container">
      <div class="register-header">
        <h1>学生注册</h1>
      </div>

      <% if (request.getAttribute("error") !=null) { %>
        <div class="error">${error}</div>
        <% } %>

          <form class="register-form" action="register" method="post" onsubmit="return validateForm()">
            <input type="hidden" name="userType" value="0">
            <div class="form-group">
              <label for="userId">
                <i class="fas fa-user"></i> 学号
              </label>
              <input type="text" id="userId" name="userId" required placeholder="请输入学号">
            </div>
            <div class="form-group">
              <label for="password">
                <i class="fas fa-lock"></i> 密码
              </label>
              <input type="password" id="password" name="password" required placeholder="请输入密码">
            </div>
            <div class="form-group">
              <label for="confirmPassword">
                <i class="fas fa-lock"></i> 确认密码
              </label>
              <input type="password" id="confirmPassword" name="confirmPassword" required placeholder="请再次输入密码">
            </div>
            <button type="submit" class="register-btn">注册</button>
          </form>

          <div class="login-link">
            已有账号？<a href="login.jsp">立即登录</a>
          </div>
    </div>

    <script>
      function validateForm() {
        const password = document.getElementById('password').value;
        const confirmPassword = document.getElementById('confirmPassword').value;

        if (password !== confirmPassword) {
          alert('两次输入的密码不一致！');
          return false;
        }
        return true;
      }
    </script>
  </body>

  </html>