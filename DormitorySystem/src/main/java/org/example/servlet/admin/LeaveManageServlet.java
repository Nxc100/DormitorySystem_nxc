package org.example.servlet.admin;

import org.example.entity.Student;
import org.example.entity.User;
import org.example.service.StudentService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

@WebServlet("/admin/leave-manage/*")
public class LeaveManageServlet extends HttpServlet {
    private StudentService studentService = new StudentService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null || user.getUserType() != 1) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String keyword = request.getParameter("keyword");
        List<Student> students;
        
        if (keyword != null && !keyword.trim().isEmpty()) {
            students = studentService.searchStudents(keyword.trim());
        } else {
            students = studentService.getAllStudents();
        }
        
        request.setAttribute("students", students);
        request.getRequestDispatcher("/admin/leave-manage.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null || user.getUserType() != 1) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String pathInfo = request.getPathInfo();
        if ("/edit".equals(pathInfo)) {
            handleEditStatus(request, response);
        }
    }

    private void handleEditStatus(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        try {
            String studentId = request.getParameter("studentId");
            String status = request.getParameter("status");
            String leaveTimeStr = request.getParameter("leaveTime");

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            
            Student student = new Student();
            student.setStudentId(studentId);
            student.setStatus(status);
            
            if ("out".equals(status) && leaveTimeStr != null && !leaveTimeStr.isEmpty()) {
                student.setLeaveTime(sdf.parse(leaveTimeStr));
            }

            if (studentService.updateStudentStatus(student)) {
                response.sendRedirect(request.getContextPath() + "/admin/leave-manage?success=true");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/leave-manage?error=update");
            }
        } catch (ParseException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/leave-manage?error=date");
        }
    }
} 