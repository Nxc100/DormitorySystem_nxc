package org.example.servlet.student;

import org.example.entity.Package;
import org.example.entity.User;
import org.example.service.PackageService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/student/packages")
public class PackagesServlet extends HttpServlet {
    private PackageService packageService = new PackageService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null || user.getUserType() != 0) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        List<Package> packages = packageService.getStudentPackages(user.getUserId());
        request.setAttribute("packages", packages);
        request.getRequestDispatcher("/student/packages.jsp").forward(request, response);
    }
} 