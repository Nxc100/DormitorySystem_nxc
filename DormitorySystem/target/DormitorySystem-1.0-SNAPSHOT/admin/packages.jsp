<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
      <!DOCTYPE html>
      <html>

      <head>
        <title>快件管理 - 学生宿舍管理系统</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
        <style>
          .packages-container {
            background: white;
            border-radius: 10px;
            padding: 20px;
            margin: 20px auto;
            max-width: 1200px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
          }

          .package-form {
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

          .form-group input {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
          }

          .packages-table {
            width: 100%;
            border-collapse: collapse;
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

          .btn-receive {
            padding: 6px 12px;
            background: #28a745;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
          }

          .btn-receive:hover {
            background: #218838;
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

          .btn-edit {
            padding: 6px 12px;
            background: #ffc107;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-left: 10px;
          }

          .btn-edit:hover {
            background: #e0a800;
          }
        </style>
      </head>

      <body>
        <div class="header">
          <h1 class="system-title">学生宿舍管理系统</h1>
        </div>

        <div class="packages-container">
          <h2>快件管理</h2>

          <form class="package-form" action="${pageContext.request.contextPath}/admin/packages" method="post">
            <div class="form-group">
              <label for="studentName">学生姓名</label>
              <input type="text" id="studentName" name="studentName" required>
            </div>
            <div class="form-group">
              <label for="dormId">宿舍号</label>
              <input type="text" id="dormId" name="dormId" required>
            </div>
            <div class="form-group">
              <label for="packageCount">快件数量</label>
              <input type="number" id="packageCount" name="packageCount" required min="1">
            </div>
            <button type="submit" class="btn btn-primary">添加快件</button>
          </form>

          <table class="packages-table">
            <thead>
              <tr>
                <th>学生姓名</th>
                <th>宿舍号</th>
                <th>快件数量</th>
                <th>到达时间</th>
                <th>接收时间</th>
                <th>操作</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach items="${packages}" var="pkg">
                <tr>
                  <td>${pkg.studentName}</td>
                  <td>${pkg.dormId}</td>
                  <td>${pkg.packageCount}</td>
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
                  <td>
                    <c:if test="${empty pkg.receiveTime}">
                      <form style="display: inline;" action="${pageContext.request.contextPath}/admin/packages/receive"
                        method="post">
                        <input type="hidden" name="id" value="${pkg.id}">
                        <button type="submit" class="btn-receive">登记领取</button>
                      </form>
                      <button type="button" class="btn-edit" onclick="showEditForm(
                        ${pkg.id}, 
                        '${pkg.studentName}', 
                        '${pkg.dormId}', 
                        ${pkg.packageCount}, 
                        '${pkg.arrivalTime}', 
                        '${pkg.receiveTime}'
                      )">
                        编辑
                      </button>
                    </c:if>
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
            <h3>编辑快件信息</h3>
            <form id="editForm" action="${pageContext.request.contextPath}/admin/packages/edit" method="post">
              <input type="hidden" id="editId" name="id">
              <div class="form-group">
                <label for="editStudentName">学生姓名</label>
                <input type="text" id="editStudentName" name="studentName" required>
              </div>
              <div class="form-group">
                <label for="editDormId">宿舍号</label>
                <input type="text" id="editDormId" name="dormId" required>
              </div>
              <div class="form-group">
                <label for="editPackageCount">快件数量</label>
                <input type="number" id="editPackageCount" name="packageCount" required min="1">
              </div>
              <div class="form-group">
                <label for="editArrivalTime">到达时间</label>
                <input type="datetime-local" id="editArrivalTime" name="arrivalTime" required>
              </div>
              <div class="form-group">
                <label for="editReceiveTime">接收时间</label>
                <input type="datetime-local" id="editReceiveTime" name="receiveTime">
              </div>
              <button type="submit" class="btn btn-primary">保存修改</button>
            </form>
          </div>
        </div>

        <script>
          var modal = document.getElementById("editModal");
          var span = document.getElementsByClassName("close")[0];

          function showEditForm(id, studentName, dormId, packageCount, arrivalTime, receiveTime) {
            document.getElementById("editId").value = id;
            document.getElementById("editStudentName").value = studentName;
            document.getElementById("editDormId").value = dormId;
            document.getElementById("editPackageCount").value = packageCount;

            // 转换日期时间格式
            if (arrivalTime) {
              var date = new Date(arrivalTime);
              document.getElementById("editArrivalTime").value = formatDateTimeForInput(date);
            }

            if (receiveTime) {
              var date = new Date(receiveTime);
              document.getElementById("editReceiveTime").value = formatDateTimeForInput(date);
            } else {
              document.getElementById("editReceiveTime").value = '';
            }

            modal.style.display = "block";
          }

          function formatDateTimeForInput(date) {
            return date.getFullYear() + '-' +
              padZero(date.getMonth() + 1) + '-' +
              padZero(date.getDate()) + 'T' +
              padZero(date.getHours()) + ':' +
              padZero(date.getMinutes());
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