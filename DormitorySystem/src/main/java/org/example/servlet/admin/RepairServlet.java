package org.example.servlet.admin;

import org.example.entity.Repair;
import org.example.entity.User;
import org.example.entity.Property;
import org.example.service.RepairService;
import org.example.service.PropertyService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/repairs/*")
public class RepairServlet extends HttpServlet {
    private RepairService repairService = new RepairService();
    private PropertyService propertyService = new PropertyService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null || user.getUserType() != 1) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        List<Repair> repairs = repairService.getAllRepairs();
        List<Property> properties = propertyService.getAllProperties();
        
        request.setAttribute("repairs", repairs);
        request.setAttribute("properties", properties);
        request.getRequestDispatcher("/admin/repairs.jsp").forward(request, response);
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

        String action = request.getParameter("action");
        if ("solve".equals(action)) {
            handleSolveRepair(request, response);
        } else {
            handleAddRepair(request, response);
        }
    }

    private void handleAddRepair(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        String dormId = request.getParameter("dormId");
        int propertyId = Integer.parseInt(request.getParameter("propertyId"));
        String reason = request.getParameter("reason");

        Repair repair = new Repair();
        repair.setDormId(dormId);
        repair.setPropertyId(propertyId);
        repair.setReason(reason);
        repair.setSubmitDate(new java.util.Date());

        if (repairService.submitRepair(repair)) {
            response.sendRedirect(request.getContextPath() + "/admin/repairs?success=true");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/repairs?error=true");
        }
    }

    private void handleSolveRepair(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        int repairId = Integer.parseInt(request.getParameter("id"));
        
        if (repairService.solveRepair(repairId)) {
            response.sendRedirect(request.getContextPath() + "/admin/repairs?success=true");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/repairs?error=true");
        }
    }
} 