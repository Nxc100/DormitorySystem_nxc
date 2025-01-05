package org.example.servlet.student;

import org.example.entity.LeaveRecord;
import org.example.entity.Student;
import org.example.entity.User;
import org.example.service.LeaveRecordService;
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

@WebServlet("/student/leave-records/*")
public class LeaveRecordServlet extends HttpServlet {
    private LeaveRecordService leaveRecordService = new LeaveRecordService();
    private StudentService studentService = new StudentService();
    private SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null || user.getUserType() != 0) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        List<LeaveRecord> records = leaveRecordService.getStudentLeaveRecords(user.getUserId());
        request.setAttribute("records", records);
        request.getRequestDispatcher("/student/leave-records.jsp").forward(request, response);
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

        String action = request.getParameter("action");
        if ("add".equals(action)) {
            handleAdd(request, response, user);
        } else if ("delete".equals(action)) {
            handleDelete(request, response, user);
        } else if ("return".equals(action)) {
            handleReturn(request, response, user);
        }
    }

    private void handleAdd(HttpServletRequest request, HttpServletResponse response, User user) 
            throws IOException, ServletException {
        try {
            Student student = studentService.getStudentInfo(user.getUserId());
            if (student != null) {
                String leaveDateStr = request.getParameter("leaveDate");
                Date leaveDate = dateFormat.parse(leaveDateStr);

                LeaveRecord record = new LeaveRecord();
                record.setStudentId(user.getUserId());
                record.setDormId(student.getDormId());
                record.setLeaveTime(leaveDate);

                if (leaveRecordService.addLeaveRecord(record)) {
                    response.sendRedirect(request.getContextPath() + "/student/leave-records");
                } else {
                    request.setAttribute("error", "添加离校记录失败");
                    doGet(request, response);
                }
            }
        } catch (ParseException e) {
            request.setAttribute("error", "日期格式错误");
            doGet(request, response);
        }
    }

    private void handleDelete(HttpServletRequest request, HttpServletResponse response, User user) 
            throws IOException, ServletException {
        String idStr = request.getParameter("id");
        int id = Integer.parseInt(idStr);

        if (leaveRecordService.deleteLeaveRecord(id, user.getUserId())) {
            response.sendRedirect(request.getContextPath() + "/student/leave-records");
        } else {
            request.setAttribute("error", "删除离校记录失败");
            doGet(request, response);
        }
    }

    private void handleReturn(HttpServletRequest request, HttpServletResponse response, User user) 
            throws IOException, ServletException {
        try {
            String idStr = request.getParameter("id");
            String returnDateStr = request.getParameter("returnDate");
            int id = Integer.parseInt(idStr);
            Date returnDate = dateFormat.parse(returnDateStr);

            if (leaveRecordService.updateReturnTime(id, user.getUserId(), returnDate)) {
                response.sendRedirect(request.getContextPath() + "/student/leave-records");
            } else {
                request.setAttribute("error", "更新返校时间失败");
                doGet(request, response);
            }
        } catch (ParseException e) {
            request.setAttribute("error", "日期格式错误");
            doGet(request, response);
        }
    }
} 