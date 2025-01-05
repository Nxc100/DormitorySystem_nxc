package org.example.service;

import org.example.dao.LeaveRecordDAO;
import org.example.entity.LeaveRecord;

import java.util.Date;
import java.util.List;

public class LeaveRecordService {
    private LeaveRecordDAO leaveRecordDAO = new LeaveRecordDAO();
    
    public List<LeaveRecord> getStudentLeaveRecords(String studentId) {
        return leaveRecordDAO.findByStudentId(studentId);
    }
    
    public boolean addLeaveRecord(LeaveRecord record) {
        return leaveRecordDAO.insert(record);
    }
    
    public boolean deleteLeaveRecord(int id, String studentId) {
        return leaveRecordDAO.delete(id, studentId);
    }
    
    public boolean updateReturnTime(int id, String studentId, Date returnTime) {
        return leaveRecordDAO.updateReturnTime(id, studentId, returnTime);
    }
} 