package org.example.dao;

import org.example.entity.NightRecord;
import org.example.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NightRecordDAO {
    
    public List<NightRecord> findAll() {
        List<NightRecord> records = new ArrayList<>();
        String sql = "SELECT n.*, s.name as student_name FROM night_returns n " +
                    "JOIN students s ON n.student_id = s.student_id " +
                    "ORDER BY n.return_time DESC";
        
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                records.add(extractNightRecordFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return records;
    }
    
    public List<NightRecord> search(String keyword) {
        List<NightRecord> records = new ArrayList<>();
        String sql = "SELECT n.*, s.name as student_name FROM night_returns n " +
                    "JOIN students s ON n.student_id = s.student_id " +
                    "WHERE n.student_id LIKE ? OR s.name LIKE ? " +
                    "ORDER BY n.return_time DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            String searchPattern = "%" + keyword + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);
            
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                records.add(extractNightRecordFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return records;
    }
    
    public boolean insert(NightRecord record) {
        String sql = "INSERT INTO night_returns (student_id, dorm_id, return_time, reason) " +
                    "VALUES (?, ?, ?, ?)";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, record.getStudentId());
            stmt.setString(2, record.getDormId());
            stmt.setTimestamp(3, new Timestamp(record.getReturnTime().getTime()));
            stmt.setString(4, record.getReason());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    private NightRecord extractNightRecordFromResultSet(ResultSet rs) throws SQLException {
        NightRecord record = new NightRecord();
        record.setId(rs.getInt("id"));
        record.setStudentId(rs.getString("student_id"));
        record.setStudentName(rs.getString("student_name"));
        record.setDormId(rs.getString("dorm_id"));
        record.setReturnTime(rs.getTimestamp("return_time"));
        record.setReason(rs.getString("reason"));
        return record;
    }
} 