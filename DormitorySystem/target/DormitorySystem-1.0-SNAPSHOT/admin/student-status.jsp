<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
      <!DOCTYPE html>
      <html>

      <head>
        <title>学生住宿状态 - 学生宿舍管理系统</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
        <style>
          .status-container {
            background: white;
            border-radius: 10px;
            padding: 20px;
            margin: 20px auto;
            max-width: 1200px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
          }

          .status-tabs {
            margin-bottom: 20px;
            display: flex;
            gap: 10px;
          }

          .status-tab {
            padding: 10px 20px;
            background: #f8f9fa;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1em;
            color: #666;
          }

          .status-tab.active {
            background: #007bff;
            color: white;
          }

          .search-form {
            margin-bottom: 20px;
            display: flex;
            gap: 10px;
          }

          .search-form input {
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            flex: 1;
          }

          .search-form button {
            padding: 8px 16px;
            background: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
          }

          .students-table {
            width: 100%;
            border-collapse: collapse;
          }

          .students-table th,
          .students-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #eee;
          }

          .students-table th {
            background: #f8f9fa;
            font-weight: 500;
            color: #666;
          }

          .students-table tr:hover {
            background: #f8f9fa;
          }

          .status-badge {
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 0.9em;
          }

          .status-in {
            background: #28a745;
            color: white;
          }

          .status-out {
            background: #dc3545;
            color: white;
          }

          .summary-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 20px;
          }

          .summary-card {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 5px;
            text-align: center;
          }

          .summary-card h3 {
            margin: 0;
            color: #666;
            font-size: 1em;
          }

          .summary-card .number {
            font-size: 2em;
            font-weight: bold;
            color: #007bff;
            margin: 10px 0;
          }
        </style>
      </head>

      <body>
        <div class="header">
          <h1 class="system-title">学生宿舍管理系统</h1>
        </div>

        <div class="status-container">
          <h2>学生住宿状态</h2>

          <!-- 统计卡片 -->
          <div class="summary-cards">
            <div class="summary-card">
              <h3>总学生数</h3>
              <div class="number">${totalStudents}</div>
            </div>
            <div class="summary-card">
              <h3>在校学生</h3>
              <div class="number">${inSchoolStudents}</div>
            </div>
            <div class="summary-card">
              <h3>离校学生</h3>
              <div class="number">${outSchoolStudents}</div>
            </div>
          </div>

          <!-- 状态切换标签 -->
          <div class="status-tabs">
            <button class="status-tab ${status == 'all' ? 'active' : ''}"
              onclick="window.location.href='${pageContext.request.contextPath}/admin/student-status?status=all'">
              全部学生
            </button>
            <button class="status-tab ${status == 'in' ? 'active' : ''}"
              onclick="window.location.href='${pageContext.request.contextPath}/admin/student-status?status=in'">
              在校学生
            </button>
            <button class="status-tab ${status == 'out' ? 'active' : ''}"
              onclick="window.location.href='${pageContext.request.contextPath}/admin/student-status?status=out'">
              离校学生
            </button>
          </div>

          <!-- 搜索表单 -->
          <form class="search-form" action="${pageContext.request.contextPath}/admin/student-status" method="get">
            <input type="hidden" name="status" value="${status}">
            <input type="text" name="keyword" placeholder="输入学号或姓名搜索" value="${param.keyword}">
            <button type="submit">搜索</button>
          </form>

          <!-- 学生列表 -->
          <table class="students-table">
            <thead>
              <tr>
                <th>学号</th>
                <th>姓名</th>
                <th>专业</th>
                <th>宿舍号</th>
                <th>状态</th>
                <th>离校时间</th>
                <th>预计返校时间</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach items="${students}" var="student">
                <tr>
                  <td>${student.studentId}</td>
                  <td>${student.name}</td>
                  <td>${student.major}</td>
                  <td>${student.dormId}</td>
                  <td>
                    <span class="status-badge ${student.status eq 'in' ? 'status-in' : 'status-out'}">
                      ${student.status eq 'in' ? '在校' : '离校'}
                    </span>
                  </td>
                  <td>
                    <c:if test="${student.status eq 'out'}">
                      <fmt:formatDate value="${student.leaveTime}" pattern="yyyy-MM-dd HH:mm" />
                    </c:if>
                  </td>
                  <td>
                    <c:if test="${student.status eq 'out'}">
                      <fmt:formatDate value="${student.expectedReturnTime}" pattern="yyyy-MM-dd HH:mm" />
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