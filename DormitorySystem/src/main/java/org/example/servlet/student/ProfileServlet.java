package org.example.servlet.student;

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

@WebServlet("/student/profile")
public class ProfileServlet extends HttpServlet {
    private StudentService studentService = new StudentService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null || user.getUserType() != 0) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        Student student = studentService.getStudentInfo(user.getUserId());
        if (student != null) {
            request.setAttribute("student", student);
            request.getRequestDispatcher("/student/profile.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/student/dashboard.jsp");
        }
    }
} 