package org.example.dao;

import org.example.entity.Package;
import org.example.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PackageDAO {
    
    public List<Package> findByStudentName(String studentName) {
        List<Package> packages = new ArrayList<>();
        String sql = "SELECT * FROM packages WHERE student_name = ? ORDER BY arrival_time DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, studentName);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Package pkg = new Package();
                pkg.setId(rs.getInt("id"));
                pkg.setStudentName(rs.getString("student_name"));
                pkg.setDormId(rs.getString("dorm_id"));
                pkg.setArrivalTime(rs.getTimestamp("arrival_time"));
                pkg.setReceiveTime(rs.getTimestamp("receive_time"));
                pkg.setPackageCount(rs.getInt("package_count"));
                packages.add(pkg);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return packages;
    }

    public List<Package> findByStudentId(String studentId) {
        List<Package> packages = new ArrayList<>();
        String sql = "SELECT p.* FROM packages p " +
                    "JOIN students s ON p.student_name = s.name " +
                    "WHERE s.student_id = ? " +
                    "ORDER BY p.arrival_time DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, studentId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Package pkg = new Package();
                pkg.setId(rs.getInt("id"));
                pkg.setStudentName(rs.getString("student_name"));
                pkg.setDormId(rs.getString("dorm_id"));
                pkg.setArrivalTime(rs.getTimestamp("arrival_time"));
                pkg.setReceiveTime(rs.getTimestamp("receive_time"));
                pkg.setPackageCount(rs.getInt("package_count"));
                packages.add(pkg);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return packages;
    }

    public List<Package> findAll() {
        List<Package> packages = new ArrayList<>();
        String sql = "SELECT * FROM packages ORDER BY arrival_time DESC";
        
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Package pkg = new Package();
                pkg.setId(rs.getInt("id"));
                pkg.setStudentName(rs.getString("student_name"));
                pkg.setDormId(rs.getString("dorm_id"));
                pkg.setArrivalTime(rs.getTimestamp("arrival_time"));
                pkg.setReceiveTime(rs.getTimestamp("receive_time"));
                pkg.setPackageCount(rs.getInt("package_count"));
                packages.add(pkg);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return packages;
    }

    public boolean updateReceiveTime(int id, java.util.Date receiveTime) {
        String sql = "UPDATE packages SET receive_time = ? WHERE id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setTimestamp(1, new Timestamp(receiveTime.getTime()));
            stmt.setInt(2, id);
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean insert(Package pkg) {
        String sql = "INSERT INTO packages (student_name, dorm_id, arrival_time, package_count) " +
                    "VALUES (?, ?, ?, ?)";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, pkg.getStudentName());
            stmt.setString(2, pkg.getDormId());
            stmt.setTimestamp(3, new Timestamp(pkg.getArrivalTime().getTime()));
            stmt.setInt(4, pkg.getPackageCount());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean update(Package pkg) {
        String sql = "UPDATE packages SET student_name = ?, dorm_id = ?, package_count = ?, " +
                    "arrival_time = ?, receive_time = ? WHERE id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, pkg.getStudentName());
            stmt.setString(2, pkg.getDormId());
            stmt.setInt(3, pkg.getPackageCount());
            stmt.setTimestamp(4, new Timestamp(pkg.getArrivalTime().getTime()));
            
            if (pkg.getReceiveTime() != null) {
                stmt.setTimestamp(5, new Timestamp(pkg.getReceiveTime().getTime()));
            } else {
                stmt.setNull(5, Types.TIMESTAMP);
            }
            
            stmt.setInt(6, pkg.getId());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
} 