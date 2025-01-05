package org.example.servlet.student;

import org.example.entity.User;
import org.example.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/student/change-password")
public class ChangePasswordServlet extends HttpServlet {
    private UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null || user.getUserType() != 0) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "新密码与确认密码不一致");
            request.getRequestDispatcher("/student/profile.jsp").forward(request, response);
            return;
        }

        if (userService.changePassword(user.getUserId(), oldPassword, newPassword)) {
            request.setAttribute("success", "密码修改成功");
        } else {
            request.setAttribute("error", "原密码错误或修改失败");
        }
        
        request.getRequestDispatcher("/student/profile.jsp").forward(request, response);
    }
} 