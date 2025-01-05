package org.example.servlet.student;

import org.example.entity.Repair;
import org.example.entity.Student;
import org.example.entity.User;
import org.example.service.RepairService;
import org.example.service.StudentService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Date;
import java.util.List;

@WebServlet("/student/repairs/*")
public class RepairServlet extends HttpServlet {
    private RepairService repairService = new RepairService();
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
            List<Repair> repairs = repairService.getRepairsByDormId(student.getDormId());
            request.setAttribute("repairs", repairs);
        }
        
        request.getRequestDispatcher("/student/repairs.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null || user.getUserType() != 0) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        Student student = studentService.getStudentInfo(user.getUserId());
        if (student != null) {
            String propertyIdStr = request.getParameter("propertyId");
            String reason = request.getParameter("reason");
            
            Repair repair = new Repair();
            repair.setDormId(student.getDormId());
            repair.setPropertyId(Integer.parseInt(propertyIdStr));
            repair.setSubmitDate(new Date());
            repair.setReason(reason);
            
            if (repairService.submitRepair(repair)) {
                response.sendRedirect(request.getContextPath() + "/student/repairs");
            } else {
                request.setAttribute("error", "提交报修失败");
                doGet(request, response);
            }
        }
    }
} 