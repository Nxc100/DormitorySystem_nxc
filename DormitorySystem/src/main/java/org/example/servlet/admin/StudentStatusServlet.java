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
import java.util.List;
import java.util.Map;

@WebServlet("/admin/student-status")
public class StudentStatusServlet extends HttpServlet {
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

        String status = request.getParameter("status");
        if (status == null) {
            status = "all";
        }

        String keyword = request.getParameter("keyword");
        List<Student> students;
        
        if (keyword != null && !keyword.trim().isEmpty()) {
            students = studentService.searchStudents(keyword.trim());
        } else {
            students = studentService.getStudentsByStatus(status);
        }
        
        Map<String, Integer> counts = studentService.getStudentStatusCounts();
        
        request.setAttribute("students", students);
        request.setAttribute("status", status);
        request.setAttribute("totalStudents", counts.get("total"));
        request.setAttribute("inSchoolStudents", counts.getOrDefault("in", 0));
        request.setAttribute("outSchoolStudents", counts.getOrDefault("out", 0));
        
        request.getRequestDispatcher("/admin/student-status.jsp").forward(request, response);
    }
} 