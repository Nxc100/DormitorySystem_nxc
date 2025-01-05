package org.example.servlet;

import org.example.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String userId = request.getParameter("userId");
        String password = request.getParameter("password");
        
        // 强制设置为学生类型
        int userType = 0;
        
        if (userService.register(userId, password, userType)) {
            response.sendRedirect("login.jsp?registered=true");
        } else {
            request.setAttribute("error", "注册失败，该学号可能已被注册");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
} 