<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
      <!DOCTYPE html>
      <html>

      <head>
        <title>学生管理 - 学生宿舍管理系统</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
        <style>
          .students-container {
            background: white;
            border-radius: 10px;
            padding: 20px;
            margin: 20px auto;
            max-width: 1200px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
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

          .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.4);
          }

          .modal-content {
            background-color: #fefefe;
            margin: 5% auto;
            padding: 30px;
            border: none;
            width: 90%;
            max-width: 600px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
          }

          .modal-content h3 {
            color: #333;
            margin: 0 0 25px 0;
            padding-bottom: 15px;
            border-bottom: 2px solid #f0f0f0;
            font-size: 1.5em;
          }

          .form-group {
            margin-bottom: 20px;
          }

          .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #555;
            font-weight: 500;
            font-size: 0.95em;
          }

          .form-group input,
          .form-group select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 1em;
            transition: border-color 0.3s;
          }

          .form-group input:focus,
          .form-group select:focus {
            outline: none;
            border-color: #007bff;
            box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.1);
          }

          .form-group input[readonly] {
            background-color: #f8f9fa;
            cursor: not-allowed;
          }

          .form-group input[type="date"] {
            padding: 8px 10px;
          }

          .btn-primary {
            background: #007bff;
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 1em;
            font-weight: 500;
            /*width: 100%;*/
            transition: background-color 0.3s;
          }

          .btn-primary:hover {
            background: #0056b3;
          }

          .close {
            position: absolute;
            right: 20px;
            top: 15px;
            font-size: 24px;
            font-weight: bold;
            color: #666;
            cursor: pointer;
            transition: color 0.3s;
          }

          .close:hover {
            color: #333;
          }

          @media (max-width: 768px) {
            .modal-content {
              width: 95%;
              margin: 10% auto;
              padding: 20px;
            }

            .form-group {
              margin-bottom: 15px;
            }

            .form-group label {
              font-size: 0.9em;
            }

            .btn-primary {
              padding: 10px 20px;
            }
          }

          .form-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
          }

          .form-grid .form-group:first-child,
          .form-grid .form-group:last-child {
            grid-column: 1 / -1;
          }

          .modal {
            transition: opacity 0.3s ease-in-out;
          }

          .modal-content {
            animation: slideIn 0.3s ease-out;
          }

          @keyframes slideIn {
            from {
              transform: translateY(-30px);
              opacity: 0;
            }

            to {
              transform: translateY(0);
              opacity: 1;
            }
          }

          .alert {
            padding: 15px;
            margin-bottom: 20px;
            border: 1px solid transparent;
            border-radius: 4px;
          }

          .alert-success {
            color: #155724;
            background-color: #d4edda;
            border-color: #c3e6cb;
          }

          .alert-danger {
            color: #721c24;
            background-color: #f8d7da;
            border-color: #f5c6cb;
          }
        </style>
      </head>

      <body>
        <div class="header">
          <h1 class="system-title">学生宿舍管理系统</h1>
        </div>

        <div class="students-container">
          <h2>学生管理</h2>

          <form class="search-form" action="${pageContext.request.contextPath}/admin/students" method="get">
            <input type="text" name="keyword" placeholder="输入学号或姓名搜索" value="${param.keyword}">
            <button type="submit">搜索</button>
          </form>

          <table class="students-table">
            <thead>
              <tr>
                <th>学号</th>
                <th>姓名</th>
                <th>性别</th>
                <th>专业</th>
                <th>宿舍号</th>
                <th>入住时间</th>
                <th>操作</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach items="${students}" var="student">
                <tr>
                  <td>${student.studentId}</td>
                  <td>${student.name}</td>
                  <td>${student.gender}</td>
                  <td>${student.major}</td>
                  <td>${student.dormId}</td>
                  <td>
                    <fmt:formatDate value="${student.checkInDate}" pattern="yyyy-MM-dd" />
                  </td>
                  <td>
                    <button type="button" class="btn-edit" onclick="showEditForm(
                      '${student.studentId}',
                      '${student.name}',
                      '${student.gender}',
                      '${student.major}',
                      '${student.dormId}',
                      '${student.checkInDate}'
                    )">编辑</button>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>

          <a href="${pageContext.request.contextPath}/admin/dashboard.jsp" class="btn btn-primary"
            style="margin-top: 20px;">返回仪表板</a>
        </div>

        <div id="editModal" class="modal">
          <div class="modal-content">
            <span class="close">&times;</span>
            <h3>编辑学生信息</h3>
            <form id="editForm" action="${pageContext.request.contextPath}/admin/students/edit" method="post">
              <div class="form-grid">
                <div class="form-group">
                  <label for="editStudentId">学号</label>
                  <input type="text" id="editStudentId" name="studentId" required readonly>
                </div>
                <div class="form-group">
                  <label for="editName">姓名</label>
                  <input type="text" id="editName" name="name" required>
                </div>
                <div class="form-group">
                  <label for="editGender">性别</label>
                  <select id="editGender" name="gender" required>
                    <option value="男">男</option>
                    <option value="女">女</option>
                  </select>
                </div>
                <div class="form-group">
                  <label for="editMajor">专业</label>
                  <input type="text" id="editMajor" name="major" required>
                </div>
                <div class="form-group">
                  <label for="editDormId">宿舍号</label>
                  <input type="text" id="editDormId" name="dormId" required>
                </div>
                <div class="form-group">
                  <label for="editCheckInDate">入住时间</label>
                  <input type="date" id="editCheckInDate" name="checkInDate" required>
                </div>
                <div class="form-group">
                  <button type="submit" class="btn btn-primary">保存修改</button>
                </div>
              </div>
            </form>
          </div>
        </div>

        <c:if test="${param.success eq 'true'}">
          <div class="alert alert-success">
            修改成功
          </div>
        </c:if>
        <c:if test="${param.error eq 'update'}">
          <div class="alert alert-danger">
            修改失败
          </div>
        </c:if>
        <c:if test="${param.error eq 'date'}">
          <div class="alert alert-danger">
            日期格式错误
          </div>
        </c:if>

        <script>
          var modal = document.getElementById("editModal");
          var span = document.getElementsByClassName("close")[0];

          function showEditForm(studentId, name, gender, major, dormId, checkInDate) {
            document.getElementById("editStudentId").value = studentId;
            document.getElementById("editName").value = name;
            document.getElementById("editGender").value = gender;
            document.getElementById("editMajor").value = major;
            document.getElementById("editDormId").value = dormId;

            // 转换日期格式
            if (checkInDate) {
              var date = new Date(checkInDate);
              var formattedDate = date.getFullYear() + '-' +
                padZero(date.getMonth() + 1) + '-' +
                padZero(date.getDate());
              document.getElementById("editCheckInDate").value = formattedDate;
            }

            modal.style.display = "block";
          }

          function padZero(num) {
            return num < 10 ? '0' + num : num;
          }

          span.onclick = function () {
            modal.style.display = "none";
          }

          window.onclick = function (event) {
            if (event.target == modal) {
              modal.style.display = "none";
            }
          }
        </script>
      </body>

      </html>