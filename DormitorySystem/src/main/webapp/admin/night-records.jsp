<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
      <!DOCTYPE html>
      <html>

      <head>
        <title>夜归记录 - 学生宿舍管理系统</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
        <style>
          .night-records-container {
            background: white;
            border-radius: 10px;
            padding: 20px;
            margin: 20px auto;
            max-width: 1200px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
          }

          .record-form {
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

          .form-group input,
          .form-group textarea {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
          }

          .records-table {
            width: 100%;
            border-collapse: collapse;
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
        </style>
      </head>

      <body>
        <div class="header">
          <h1 class="system-title">学生宿舍管理系统</h1>
        </div>

        <div class="night-records-container">
          <h2>夜归记录</h2>

          <!-- 在表单前添加错误信息显示 -->
          <c:if test="${not empty error}">
            <div class="error-message" style="color: red; margin-bottom: 10px;">
              ${error}
            </div>
          </c:if>

          <!-- 修改表单，移除studentName和dormId字段，因为这些会自动从学生信息中获取 -->
          <form class="record-form" action="${pageContext.request.contextPath}/admin/night-records" method="post">
            <div class="form-group">
              <label for="studentId">学号</label>
              <input type="text" id="studentId" name="studentId" required>
            </div>
            <div class="form-group">
              <label for="returnTime">返回时间</label>
              <input type="datetime-local" id="returnTime" name="returnTime" required>
            </div>
            <div class="form-group">
              <label for="reason">夜归原因</label>
              <textarea id="reason" name="reason" required></textarea>
            </div>
            <button type="submit" class="btn btn-primary">添加记录</button>
          </form>

          <!-- 搜索表单 -->
          <form class="search-form" action="${pageContext.request.contextPath}/admin/night-records" method="get">
            <input type="text" name="keyword" placeholder="输入学号或姓名搜索" value="${param.keyword}">
            <button type="submit">搜索</button>
          </form>

          <!-- 夜归记录列表 -->
          <table class="records-table">
            <thead>
              <tr>
                <th>学号</th>
                <th>姓名</th>
                <th>宿舍号</th>
                <th>返回时间</th>
                <th>夜归原因</th>
                <th>记录时间</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach items="${nightRecords}" var="record">
                <tr>
                  <td>${record.studentId}</td>
                  <td>${record.studentName}</td>
                  <td>${record.dormId}</td>
                  <td>
                    <fmt:formatDate value="${record.returnTime}" pattern="yyyy-MM-dd HH:mm" />
                  </td>
                  <td>${record.reason}</td>
                  <td>
                    <fmt:formatDate value="${record.recordTime}" pattern="yyyy-MM-dd HH:mm" />
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