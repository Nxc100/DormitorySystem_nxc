package org.example.servlet.admin;

import org.example.entity.NightRecord;
import org.example.entity.User;
import org.example.service.NightRecordService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

@WebServlet("/admin/night-records")
public class NightRecordServlet extends HttpServlet {
    private NightRecordService nightRecordService = new NightRecordService();

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
        List<NightRecord> records;
        
        if (keyword != null && !keyword.trim().isEmpty()) {
            records = nightRecordService.searchNightRecords(keyword.trim());
        } else {
            records = nightRecordService.getAllNightRecords();
        }
        
        request.setAttribute("nightRecords", records);
        request.getRequestDispatcher("/admin/night-records.jsp").forward(request, response);
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

        try {
            String studentId = request.getParameter("studentId");
            String returnTimeStr = request.getParameter("returnTime");
            String reason = request.getParameter("reason");

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            
            NightRecord record = new NightRecord();
            record.setStudentId(studentId);
            record.setReturnTime(sdf.parse(returnTimeStr));
            record.setReason(reason);
            
            if (nightRecordService.addNightRecord(record)) {
                response.sendRedirect(request.getContextPath() + "/admin/night-records?success=true");
            } else {
                request.setAttribute("error", "添加失败，请确认学号是否正确");
                request.getRequestDispatcher("/admin/night-records.jsp").forward(request, response);
            }
        } catch (ParseException e) {
            e.printStackTrace();
            request.setAttribute("error", "日期格式错误");
            request.getRequestDispatcher("/admin/night-records.jsp").forward(request, response);
        }
    }
} 