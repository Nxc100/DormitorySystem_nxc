<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!DOCTYPE html>
    <html>

    <head>
      <title>学生仪表板 - 学生宿舍管理系统</title>
      <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    </head>

    <body>
      <div class="header">
        <h1 class="system-title">学生宿舍管理系统</h1>
      </div>

      <div class="container">
        <div class="user-info">
          <span class="welcome-text">欢迎，${user.userId}</span>
          <form action="${pageContext.request.contextPath}/logout" method="post" style="margin: 0;">
            <button type="submit" class="btn btn-danger logout-btn">退出登录</button>
          </form>
        </div>

        <div class="dashboard-grid">
          <div class="card">
            <h2 class="card-title">
              <i class="fas fa-user"></i>个人信息
            </h2>
            <p>查看和修改个人信息</p>
            <a href="${pageContext.request.contextPath}/student/profile" class="btn btn-primary">查看详情</a>
          </div>

          <div class="card">
            <h2 class="card-title">
              <i class="fas fa-box"></i>快递信息
            </h2>
            <p>查看快递到达和领取情况</p>
            <a href="${pageContext.request.contextPath}/student/packages" class="btn btn-primary">查看详情</a>
          </div>

          <div class="card">
            <h2 class="card-title">
              <i class="fas fa-tools"></i>报修服务
            </h2>
            <p>提交和查询报修信息</p>
            <a href="${pageContext.request.contextPath}/student/repairs" class="btn btn-primary">查看详情</a>
          </div>

          <div class="card">
            <h2 class="card-title">
              <i class="fas fa-calendar-alt"></i>离返校登记
            </h2>
            <p>登记离校和返校信息</p>
            <a href="${pageContext.request.contextPath}/student/leave-records" class="btn btn-primary">查看详情</a>
          </div>
        </div>
      </div>

      <script src="${pageContext.request.contextPath}/js/common.js"></script>
    </body>

    </html>