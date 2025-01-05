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
import java.util.Date;
import java.util.List;

@WebServlet("/admin/students/*")
public class StudentManageServlet extends HttpServlet {
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
        request.getRequestDispatcher("/admin/students.jsp").forward(request, response);
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
        if (pathInfo != null && pathInfo.equals("/edit")) {
            handleEditStudent(request, response);
        }
    }

    private void handleEditStudent(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        try {
            String studentId = request.getParameter("studentId");
            String name = request.getParameter("name");
            String gender = request.getParameter("gender");
            String major = request.getParameter("major");
            String dormId = request.getParameter("dormId");
            Date checkInDate = new SimpleDateFormat("yyyy-MM-dd")
                .parse(request.getParameter("checkInDate"));
            
            Student student = new Student();
            student.setStudentId(studentId);
            student.setName(name);
            student.setGender(gender);
            student.setMajor(major);
            student.setDormId(dormId);
            student.setCheckInDate(checkInDate);
            
            if (studentService.updateStudent(student)) {
                response.sendRedirect(request.getContextPath() + "/admin/students?success=true");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/students?error=update");
            }
        } catch (ParseException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/students?error=date");
        }
    }
} 