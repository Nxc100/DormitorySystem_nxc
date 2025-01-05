<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
      <!DOCTYPE html>
      <html>

      <head>
        <title>离校管理 - 学生宿舍管理系统</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
        <style>
          .leave-manage-container {
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

          .leave-table {
            width: 100%;
            border-collapse: collapse;
          }

          .leave-table th,
          .leave-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #eee;
          }

          .leave-table th {
            background: #f8f9fa;
            font-weight: 500;
            color: #666;
          }

          .leave-table tr:hover {
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

          .btn-edit {
            padding: 6px 12px;
            background: #ffc107;
            color: #000;
            border: none;
            border-radius: 4px;
            cursor: pointer;
          }

          .btn-edit:hover {
            background: #e0a800;
          }

          /* 模态框样式 */
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
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            max-width: 500px;
            border-radius: 5px;
          }

          .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
          }

          .close:hover {
            color: black;
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
        </style>
      </head>

      <body>
        <div class="header">
          <h1 class="system-title">学生宿舍管理系统</h1>
        </div>

        <div class="leave-manage-container">
          <h2>离校管理</h2>

          <!-- 搜索表单 -->
          <form class="search-form" action="${pageContext.request.contextPath}/admin/leave-manage" method="get">
            <input type="text" name="keyword" placeholder="输入学号或姓名搜索" value="${param.keyword}">
            <button type="submit">搜索</button>
          </form>

          <!-- 学生列表 -->
          <table class="leave-table">
            <thead>
              <tr>
                <th>学号</th>
                <th>姓名</th>
                <th>专业</th>
                <th>宿舍号</th>
                <th>状态</th>
                <th>离校时间</th>
                <th>预计返校时间</th>
                <th>操作</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach items="${students}" var="student">
                <c:set var="leaveTime">
                  <fmt:formatDate value="${student.leaveTime}" pattern="yyyy-MM-dd" />
                </c:set>
                <c:set var="returnTime">
                  <fmt:formatDate value="${student.returnTime}" pattern="yyyy-MM-dd" />
                </c:set>
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
                    <fmt:formatDate value="${student.leaveTime}" pattern="yyyy-MM-dd" />
                  </td>
                  <td>
                    <fmt:formatDate value="${student.returnTime}" pattern="yyyy-MM-dd" />
                  </td>
                  <td>
                    <button type="button" class="btn-edit" onclick="showEditForm(
                        '${student.studentId}',
                        '${student.status}',
                        '${leaveTime}',
                        '${returnTime}'
                    )">修改状态</button>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>

          <a href="${pageContext.request.contextPath}/admin/dashboard.jsp" class="btn btn-primary"
            style="margin-top: 20px;">返回仪表板</a>
        </div>

        <!-- 编辑模态框 -->
        <div id="editModal" class="modal">
          <div class="modal-content">
            <span class="close">&times;</span>
            <h3>修改学生状态</h3>
            <form id="editForm" action="${pageContext.request.contextPath}/admin/leave-manage/edit" method="post">
              <input type="hidden" id="editStudentId" name="studentId">
              <div class="form-group">
                <label for="editStatus">状态</label>
                <select id="editStatus" name="status" required onchange="toggleDateInputs()">
                  <option value="in">在校</option>
                  <option value="out">离校</option>
                </select>
              </div>
              <div id="leaveDateGroup" class="form-group" style="display: none;">
                <label for="editLeaveTime">离校时间</label>
                <input type="date" id="editLeaveTime" name="leaveTime">
              </div>
              <div id="returnDateGroup" class="form-group" style="display: none;">
                <label for="editReturnTime">预计返校时间</label>
                <input type="date" id="editReturnTime" name="returnTime">
              </div>
              <button type="submit" class="btn btn-primary">保存修改</button>
            </form>
          </div>
        </div>

        <script>
          var modal = document.getElementById("editModal");
          var span = document.getElementsByClassName("close")[0];

          function showEditForm(studentId, status, leaveTime, returnTime) {
            document.getElementById("editStudentId").value = studentId;
            document.getElementById("editStatus").value = status;
            document.getElementById("editLeaveTime").value = leaveTime;
            document.getElementById("editReturnTime").value = returnTime;

            toggleDateInputs();
            modal.style.display = "block";
          }

          function toggleDateInputs() {
            var status = document.getElementById("editStatus").value;
            var leaveDateGroup = document.getElementById("leaveDateGroup");
            var returnDateGroup = document.getElementById("returnDateGroup");

            if (status === 'out') {
              leaveDateGroup.style.display = "block";
              returnDateGroup.style.display = "block";
            } else {
              leaveDateGroup.style.display = "none";
              returnDateGroup.style.display = "none";
            }
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