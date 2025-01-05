<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
      <!DOCTYPE html>
      <html>

      <head>
        <title>快件信息 - 学生宿舍管理系统</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
        <style>
          .packages-container {
            background: white;
            border-radius: 10px;
            padding: 20px;
            margin: 20px auto;
            max-width: 1000px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
          }

          .packages-header {
            border-bottom: 2px solid #f0f0f0;
            padding-bottom: 15px;
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
          }

          .packages-header h2 {
            color: #333;
            margin: 0;
          }

          .packages-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
          }

          .packages-table th,
          .packages-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #eee;
          }

          .packages-table th {
            background: #f8f9fa;
            font-weight: 500;
            color: #666;
          }

          .packages-table tr:hover {
            background: #f8f9fa;
          }

          .status {
            padding: 5px 10px;
            border-radius: 15px;
            font-size: 0.9em;
          }

          .status-received {
            background: #d4edda;
            color: #155724;
          }

          .status-pending {
            background: #fff3cd;
            color: #856404;
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

          .empty-message {
            text-align: center;
            padding: 40px;
            color: #666;
            font-size: 1.1em;
          }
        </style>
      </head>

      <body>
        <div class="header">
          <h1 class="system-title">学生宿舍管理系统</h1>
        </div>

        <div class="packages-container">
          <div class="packages-header">
            <h2>快件信息</h2>
          </div>

          <c:if test="${empty packages}">
            <div class="empty-message">
              暂无快件信息
            </div>
          </c:if>

          <c:if test="${not empty packages}">
            <table class="packages-table">
              <thead>
                <tr>
                  <th>快件编号</th>
                  <th>宿舍号</th>
                  <th>到达时间</th>
                  <th>接收时间</th>
                  <th>快件数量</th>
                  <th>状态</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach items="${packages}" var="pkg">
                  <tr>
                    <td>${pkg.id}</td>
                    <td>${pkg.dormId}</td>
                    <td>
                      <fmt:formatDate value="${pkg.arrivalTime}" pattern="yyyy-MM-dd HH:mm" />
                    </td>
                    <td>
                      <c:if test="${not empty pkg.receiveTime}">
                        <fmt:formatDate value="${pkg.receiveTime}" pattern="yyyy-MM-dd HH:mm" />
                      </c:if>
                      <c:if test="${empty pkg.receiveTime}">
                        -
                      </c:if>
                    </td>
                    <td>${pkg.packageCount}</td>
                    <td>
                      <span class="status ${empty pkg.receiveTime ? 'status-pending' : 'status-received'}">
                        ${empty pkg.receiveTime ? '待领取' : '已领取'}
                      </span>
                    </td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </c:if>

          <a href="dashboard.jsp" class="back-btn">返回仪表板</a>
        </div>
      </body>

      </html>