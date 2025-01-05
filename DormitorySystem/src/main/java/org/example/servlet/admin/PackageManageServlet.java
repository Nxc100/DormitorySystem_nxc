package org.example.servlet.admin;

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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet("/admin/packages/*")
public class PackageManageServlet extends HttpServlet {
    private PackageService packageService = new PackageService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null || user.getUserType() != 1) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        List<Package> packages = packageService.getAllPackages();
        request.setAttribute("packages", packages);
        request.getRequestDispatcher("/admin/packages.jsp").forward(request, response);
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
        if (pathInfo == null || pathInfo.equals("/")) {
            // 添加新快件
            handleAddPackage(request, response);
        } else if (pathInfo.equals("/receive")) {
            // 登记领取
            handleReceivePackage(request, response);
        } else if (pathInfo.equals("/edit")) {
            // 编辑快件信息
            handleEditPackage(request, response);
        }
    }

    private void handleAddPackage(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        String studentName = request.getParameter("studentName");
        String dormId = request.getParameter("dormId");
        int packageCount = Integer.parseInt(request.getParameter("packageCount"));

        Package pkg = new Package();
        pkg.setStudentName(studentName);
        pkg.setDormId(dormId);
        pkg.setPackageCount(packageCount);
        pkg.setArrivalTime(new Date());

        packageService.addPackage(pkg);
        response.sendRedirect(request.getContextPath() + "/admin/packages");
    }

    private void handleReceivePackage(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        packageService.receivePackage(id);
        response.sendRedirect(request.getContextPath() + "/admin/packages");
    }

    private void handleEditPackage(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String studentName = request.getParameter("studentName");
        String dormId = request.getParameter("dormId");
        int packageCount = Integer.parseInt(request.getParameter("packageCount"));
        
        // 解析日期时间
        Date arrivalTime = null;
        Date receiveTime = null;
        try {
            String arrivalTimeStr = request.getParameter("arrivalTime");
            if (arrivalTimeStr != null && !arrivalTimeStr.isEmpty()) {
                arrivalTime = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm").parse(arrivalTimeStr);
            }
            
            String receiveTimeStr = request.getParameter("receiveTime");
            if (receiveTimeStr != null && !receiveTimeStr.isEmpty()) {
                receiveTime = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm").parse(receiveTimeStr);
            }
        } catch (ParseException e) {
            e.printStackTrace();
        }

        Package pkg = new Package();
        pkg.setId(id);
        pkg.setStudentName(studentName);
        pkg.setDormId(dormId);
        pkg.setPackageCount(packageCount);
        pkg.setArrivalTime(arrivalTime);
        pkg.setReceiveTime(receiveTime);

        packageService.updatePackage(pkg);
        response.sendRedirect(request.getContextPath() + "/admin/packages");
    }
} 