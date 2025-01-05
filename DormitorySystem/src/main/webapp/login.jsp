<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <!DOCTYPE html>
  <html>

  <head>
    <title>登录 - 学生宿舍管理系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
      .login-container {
        max-width: 400px;
        margin: 50px auto;
        padding: 30px;
        background-color: white;
        border-radius: 10px;
        box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
      }

      .login-header {
        text-align: center;
        margin-bottom: 30px;
      }

      .login-header h1 {
        color: #333;
        font-size: 24px;
        margin-bottom: 10px;
      }

      .role-switch-container {
        background: #f8f9fa;
        padding: 5px;
        border-radius: 30px;
        display: inline-flex;
        position: relative;
        margin: 20px 0;
        overflow: hidden;
      }

      .role-switch-container::before {
        content: '';
        position: absolute;
        width: 50%;
        height: 100%;
        background: #007bff;
        border-radius: 30px;
        left: 0;
        top: 0;
        transition: transform 0.3s ease;
      }

      .role-switch-container.admin::before {
        transform: translateX(100%);
      }

      .role-option {
        position: relative;
        z-index: 1;
        padding: 10px 30px;
        cursor: pointer;
        transition: color 0.3s ease;
        color: #555;
      }

      .role-option.active {
        color: white;
      }

      .login-form {
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

      .login-btn {
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

      .login-btn:hover {
        background: #0056b3;
        transform: translateY(-2px);
      }

      .register-link {
        text-align: center;
        margin-top: 20px;
        color: #666;
      }

      .register-link a {
        color: #007bff;
        text-decoration: none;
        margin-left: 5px;
      }

      .register-link a:hover {
        text-decoration: underline;
      }
    </style>
  </head>

  <body>
    <div class="header">
      <h1 class="system-title">学生宿舍管理系统</h1>
    </div>

    <div class="login-container">
      <div class="login-header">
        <h1>用户登录</h1>
        <div class="role-switch-container" id="roleSwitchContainer">
          <div class="role-option active" data-role="student">
            <i class="fas fa-user-graduate"></i> 学生
          </div>
          <div class="role-option" data-role="admin">
            <i class="fas fa-user-shield"></i> 管理员
          </div>
        </div>
      </div>

      <% if (request.getAttribute("error") !=null) { %>
        <div class="error">${error}</div>
        <% } %>

          <form class="login-form" action="login" method="post">
            <input type="hidden" name="userType" id="userType" value="0">
            <div class="form-group">
              <label for="userId">
                <i class="fas fa-user"></i> 用户ID
              </label>
              <input type="text" id="userId" name="userId" required placeholder="请输入用户ID">
            </div>
            <div class="form-group">
              <label for="password">
                <i class="fas fa-lock"></i> 密码
              </label>
              <input type="password" id="password" name="password" required placeholder="请输入密码">
            </div>
            <button type="submit" class="login-btn">登录</button>
          </form>

          <div class="register-link">
            还没有账号？<a href="register.jsp">立即注册</a>
          </div>
    </div>

    <script>
      document.addEventListener('DOMContentLoaded', function () {
        const container = document.getElementById('roleSwitchContainer');
        const options = container.querySelectorAll('.role-option');
        const userTypeInput = document.getElementById('userType');

        options.forEach(option => {
          option.addEventListener('click', function () {
            options.forEach(opt => opt.classList.remove('active'));
            this.classList.add('active');

            const isAdmin = this.dataset.role === 'admin';
            userTypeInput.value = isAdmin ? '1' : '0';
            container.classList.toggle('admin', isAdmin);
          });
        });
      });
    </script>
  </body>

  </html>