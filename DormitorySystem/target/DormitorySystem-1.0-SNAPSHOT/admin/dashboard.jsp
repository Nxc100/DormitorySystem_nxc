<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!DOCTYPE html>
    <html>

    <head>
      <title>管理员仪表板 - 学生宿舍管理系统</title>
      <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    </head>

    <body>
      <div class="header">
        <h1 class="system-title">学生宿舍管理系统</h1>
      </div>

      <div class="container">
        <div class="user-info">
          <span class="welcome-text">欢迎，管理员</span>
          <form action="${pageContext.request.contextPath}/logout" method="post" style="margin: 0;">
            <button type="submit" class="btn btn-danger logout-btn">退出登录</button>
          </form>
        </div>

        <div class="dashboard-grid">
          <div class="card">
            <h2 class="card-title">
              <i class="fas fa-users"></i>学生管理
            </h2>
            <p>查询和管理学生信息</p>
            <a href="${pageContext.request.contextPath}/admin/students" class="btn btn-primary">查看详情</a>
          </div>

          <div class="card">
            <h2 class="card-title">
              <i class="fas fa-box"></i>快件管理
            </h2>
            <p>管理快件信息</p>
            <a href="${pageContext.request.contextPath}/admin/packages" class="btn btn-primary">查看详情</a>
          </div>

          <div class="card">
            <h2 class="card-title">
              <i class="fas fa-tools"></i>报修管理
            </h2>
            <p>管理学生报修信息</p>
            <a href="${pageContext.request.contextPath}/admin/repairs" class="btn btn-primary">查看详情</a>
          </div>

          <div class="card">
            <h2 class="card-title">
              <i class="fas fa-moon"></i>夜归记录
            </h2>
            <p>管理学生夜归信息</p>
            <a href="${pageContext.request.contextPath}/admin/night-records" class="btn btn-primary">查看详情</a>
          </div>

          <div class="card">
            <h2 class="card-title">
              <i class="fas fa-home"></i>学生住宿
            </h2>
            <p>查看在校/离校学生</p>
            <a href="${pageContext.request.contextPath}/admin/student-status" class="btn btn-primary">查看详情</a>
          </div>

          <div class="card">
            <h2 class="card-title">
              <i class="fas fa-calendar-alt"></i>离校管理
            </h2>
            <p>查看学生离返校记录</p>
            <a href="${pageContext.request.contextPath}/admin/leave-manage" class="btn btn-success">管理</a>
          </div>

          <div class="card">
            <h2 class="card-title">
              <i class="fas fa-cog"></i>系统设置
            </h2>
            <p>修改管理员密码等</p>
            <a href="settings.jsp" class="btn btn-success">设置</a>
          </div>
        </div>
      </div>

      <script src="${pageContext.request.contextPath}/js/common.js"></script>
    </body>

    </html>