package org.example.dao;

import org.example.entity.LeaveRecord;
import org.example.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class LeaveRecordDAO {
    
    public List<LeaveRecord> findByStudentId(String studentId) {
        List<LeaveRecord> records = new ArrayList<>();
        String sql = "SELECT * FROM leave_records WHERE student_id = ? ORDER BY leave_time DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, studentId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                LeaveRecord record = new LeaveRecord();
                record.setId(rs.getInt("id"));
                record.setStudentId(rs.getString("student_id"));
                record.setDormId(rs.getString("dorm_id"));
                Date sqlLeaveTime = rs.getDate("leave_time");
                if (sqlLeaveTime != null) {
                    record.setLeaveTime(new java.util.Date(sqlLeaveTime.getTime()));
                }
                Date sqlReturnTime = rs.getDate("return_time");
                if (sqlReturnTime != null) {
                    record.setReturnTime(new java.util.Date(sqlReturnTime.getTime()));
                }
                records.add(record);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return records;
    }
    
    public boolean insert(LeaveRecord record) {
        String sql = "INSERT INTO leave_records (student_id, dorm_id, leave_time) VALUES (?, ?, ?)";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, record.getStudentId());
            stmt.setString(2, record.getDormId());
            stmt.setDate(3, new java.sql.Date(record.getLeaveTime().getTime()));
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean delete(int id, String studentId) {
        String sql = "DELETE FROM leave_records WHERE id = ? AND student_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            stmt.setString(2, studentId);
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean updateReturnTime(int id, String studentId, java.util.Date returnTime) {
        String sql = "UPDATE leave_records SET return_time = ? WHERE id = ? AND student_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setDate(1, new java.sql.Date(returnTime.getTime()));
            stmt.setInt(2, id);
            stmt.setString(3, studentId);
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
} 