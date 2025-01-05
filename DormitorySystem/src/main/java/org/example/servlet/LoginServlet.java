package org.example.servlet;

import org.example.entity.User;
import org.example.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String userId = request.getParameter("userId");
        String password = request.getParameter("password");
        int userType = Integer.parseInt(request.getParameter("userType"));
        
        User user = userService.login(userId, password);
        
        if (user != null && user.getUserType() == userType) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            
            if (userType == 1) {
                response.sendRedirect("admin/dashboard.jsp");
            } else {
                response.sendRedirect("student/dashboard.jsp");
            }
        } else {
            request.setAttribute("error", "用户名或密码错误，或选择的用户类型不正确");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
} 