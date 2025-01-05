package org.example.dao;

import org.example.entity.Repair;
import org.example.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RepairDAO {
    
    public List<Repair> findByDormId(String dormId) {
        List<Repair> repairs = new ArrayList<>();
        String sql = "SELECT r.*, p.property_name FROM repairs r " +
                    "JOIN properties p ON r.property_id = p.property_id " +
                    "WHERE r.dorm_id = ? ORDER BY r.submit_date DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, dormId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Repair repair = new Repair();
                repair.setId(rs.getInt("id"));
                repair.setDormId(rs.getString("dorm_id"));
                repair.setPropertyId(rs.getInt("property_id"));
                repair.setPropertyName(rs.getString("property_name"));
                repair.setSubmitDate(rs.getDate("submit_date"));
                repair.setSolveDate(rs.getDate("solve_date"));
                repair.setReason(rs.getString("reason"));
                repairs.add(repair);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return repairs;
    }
    
    public boolean insert(Repair repair) {
        String sql = "INSERT INTO repairs (dorm_id, property_id, submit_date, reason) " +
                    "VALUES (?, ?, ?, ?)";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, repair.getDormId());
            stmt.setInt(2, repair.getPropertyId());
            stmt.setDate(3, new java.sql.Date(repair.getSubmitDate().getTime()));
            stmt.setString(4, repair.getReason());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Repair> findAll() {
        List<Repair> repairs = new ArrayList<>();
        String sql = "SELECT r.*, p.property_name FROM repairs r " +
                    "JOIN properties p ON r.property_id = p.property_id " +
                    "ORDER BY r.submit_date DESC";
        
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                repairs.add(extractRepairFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return repairs;
    }

    public boolean updateSolveDate(int repairId, java.util.Date solveDate) {
        String sql = "UPDATE repairs SET solve_date = ? WHERE id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            java.sql.Date sqlDate = new java.sql.Date(solveDate.getTime());
            stmt.setDate(1, sqlDate);
            stmt.setInt(2, repairId);
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private Repair extractRepairFromResultSet(ResultSet rs) throws SQLException {
        Repair repair = new Repair();
        repair.setId(rs.getInt("id"));
        repair.setDormId(rs.getString("dorm_id"));
        repair.setPropertyId(rs.getInt("property_id"));
        repair.setPropertyName(rs.getString("property_name"));
        repair.setSubmitDate(rs.getDate("submit_date"));
        repair.setSolveDate(rs.getDate("solve_date"));
        repair.setReason(rs.getString("reason"));
        return repair;
    }
} 