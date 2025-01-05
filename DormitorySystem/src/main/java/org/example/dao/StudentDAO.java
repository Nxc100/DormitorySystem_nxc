package org.example.dao;

import org.example.entity.Student;
import org.example.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

public class StudentDAO {
    
    public Student findByStudentId(String studentId) {
        String sql = "SELECT s.*, d.phone as dorm_phone FROM students s " +
                    "LEFT JOIN dormitories d ON s.dorm_id = d.dorm_id " +
                    "WHERE s.student_id = ?";
                    
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, studentId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                Student student = new Student();
                student.setStudentId(rs.getString("student_id"));
                student.setName(rs.getString("name"));
                student.setGender(rs.getString("gender"));
                student.setMajor(rs.getString("major"));
                student.setDormId(rs.getString("dorm_id"));
                student.setCheckInDate(rs.getDate("check_in_date"));
                student.setDormPhone(rs.getString("dorm_phone"));
                return student;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Student> findAll() {
        List<Student> students = new ArrayList<>();
        String sql = "SELECT s.*, d.phone as dorm_phone, lr.leave_time, lr.return_time " +
                    "FROM students s " +
                    "LEFT JOIN dormitories d ON s.dorm_id = d.dorm_id " +
                    "LEFT JOIN (" +
                    "    SELECT student_id, leave_time, return_time " +
                    "    FROM leave_records l1 " +
                    "    WHERE id = (" +
                    "        SELECT id FROM leave_records l2 " +
                    "        WHERE l2.student_id = l1.student_id " +
                    "        ORDER BY leave_time DESC LIMIT 1" +
                    "    )" +
                    ") lr ON s.student_id = lr.student_id " +
                    "ORDER BY s.student_id";
        
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Student student = extractStudentFromResultSet(rs);
                students.add(student);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return students;
    }

    public List<Student> search(String keyword) {
        List<Student> students = new ArrayList<>();
        String sql = "SELECT s.*, d.phone as dorm_phone FROM students s " +
                    "LEFT JOIN dormitories d ON s.dorm_id = d.dorm_id " +
                    "WHERE s.student_id LIKE ? OR s.name LIKE ? " +
                    "ORDER BY s.student_id";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            String searchPattern = "%" + keyword + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);
            
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                students.add(extractStudentFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return students;
    }

    public List<Student> findByStatus(String status) {
        List<Student> students = new ArrayList<>();
        String sql;
        
        if ("in".equals(status)) {
            // 在校学生：没有离校记录，或最新的离校记录已有返校时间
            sql = "SELECT s.*, d.phone as dorm_phone, lr.leave_time, lr.return_time " +
                  "FROM students s " +
                  "LEFT JOIN dormitories d ON s.dorm_id = d.dorm_id " +
                  "LEFT JOIN (" +
                  "    SELECT student_id, leave_time, return_time " +
                  "    FROM leave_records l1 " +
                  "    WHERE id = (" +
                  "        SELECT id FROM leave_records l2 " +
                  "        WHERE l2.student_id = l1.student_id " +
                  "        ORDER BY leave_time DESC LIMIT 1" +
                  "    )" +
                  ") lr ON s.student_id = lr.student_id " +
                  "WHERE lr.student_id IS NULL OR lr.return_time IS NOT NULL";
        } else if ("out".equals(status)) {
            // 离校学生：最新的离校记录没有返校时间
            sql = "SELECT s.*, d.phone as dorm_phone, lr.leave_time, lr.return_time " +
                  "FROM students s " +
                  "LEFT JOIN dormitories d ON s.dorm_id = d.dorm_id " +
                  "INNER JOIN (" +
                  "    SELECT student_id, leave_time, return_time " +
                  "    FROM leave_records l1 " +
                  "    WHERE id = (" +
                  "        SELECT id FROM leave_records l2 " +
                  "        WHERE l2.student_id = l1.student_id " +
                  "        ORDER BY leave_time DESC LIMIT 1" +
                  "    )" +
                  ") lr ON s.student_id = lr.student_id " +
                  "WHERE lr.return_time IS NULL";
        } else {
            return findAll();
        }
        
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Student student = extractStudentFromResultSet(rs);
                students.add(student);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return students;
    }

    public Map<String, Integer> getStatusCounts() {
        Map<String, Integer> counts = new HashMap<>();
        String sql = "SELECT " +
                    "COUNT(DISTINCT s.student_id) as total, " +
                    "COUNT(DISTINCT CASE WHEN l.return_time IS NULL AND l.id = (" +
                    "    SELECT id FROM leave_records l2 " +
                    "    WHERE l2.student_id = s.student_id " +
                    "    ORDER BY leave_time DESC LIMIT 1) " +
                    "THEN s.student_id END) as out_count " +
                    "FROM students s " +
                    "LEFT JOIN leave_records l ON s.student_id = l.student_id";
        
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            if (rs.next()) {
                int total = rs.getInt("total");
                int outCount = rs.getInt("out_count");
                counts.put("total", total);
                counts.put("out", outCount);
                counts.put("in", total - outCount);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return counts;
    }

    private Student extractStudentFromResultSet(ResultSet rs) throws SQLException {
        Student student = new Student();
        student.setStudentId(rs.getString("student_id"));
        student.setName(rs.getString("name"));
        student.setGender(rs.getString("gender"));
        student.setMajor(rs.getString("major"));
        student.setDormId(rs.getString("dorm_id"));
        student.setCheckInDate(rs.getDate("check_in_date"));
        student.setDormPhone(rs.getString("dorm_phone"));
        
        try {
            Date returnTime = rs.getDate("return_time");
            student.setStatus(returnTime == null && rs.getDate("leave_time") != null ? "out" : "in");
            if ("out".equals(student.getStatus())) {
                student.setLeaveTime(rs.getTimestamp("leave_time"));
                student.setReturnTime(rs.getTimestamp("return_time"));
            }
        } catch (SQLException e) {
            student.setStatus("in");
        }
        
        return student;
    }

    public boolean update(Student student) {
        String sql = "UPDATE students SET name = ?, gender = ?, major = ?, " +
                    "dorm_id = ?, check_in_date = ? WHERE student_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, student.getName());
            stmt.setString(2, student.getGender());
            stmt.setString(3, student.getMajor());
            stmt.setString(4, student.getDormId());
            stmt.setDate(5, new java.sql.Date(student.getCheckInDate().getTime()));
            stmt.setString(6, student.getStudentId());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateStatus(Student student) {
        Connection conn = null;
        PreparedStatement stmt = null;
        
        try {
            conn = DBUtil.getConnection();
            conn.setAutoCommit(false);  // 开启事务
            
            if ("out".equals(student.getStatus())) {
                // 先检查是否有未返校的记录
                String checkSql = "SELECT COUNT(*) FROM leave_records " +
                                "WHERE student_id = ? AND return_time IS NULL";
                stmt = conn.prepareStatement(checkSql);
                stmt.setString(1, student.getStudentId());
                ResultSet rs = stmt.executeQuery();
                if (rs.next() && rs.getInt(1) > 0) {
                    // 如果有未返校的记录，先将其标记为已返校
                    String updateSql = "UPDATE leave_records SET return_time = CURRENT_DATE " +
                                     "WHERE student_id = ? AND return_time IS NULL";
                    stmt = conn.prepareStatement(updateSql);
                    stmt.setString(1, student.getStudentId());
                    stmt.executeUpdate();
                }

                // 插入新的离校记录
                String insertSql = "INSERT INTO leave_records (student_id, dorm_id, leave_time) " +
                                 "SELECT ?, dorm_id, ? FROM students WHERE student_id = ?";
                stmt = conn.prepareStatement(insertSql);
                stmt.setString(1, student.getStudentId());
                stmt.setDate(2, new java.sql.Date(student.getLeaveTime().getTime()));
                stmt.setString(3, student.getStudentId());
                stmt.executeUpdate();
            } else {
                // 将最新的未返校记录标记为已返校
                String sql = "UPDATE leave_records SET return_time = CURRENT_DATE " +
                            "WHERE student_id = ? AND return_time IS NULL " +
                            "AND leave_time = (SELECT max_leave_time FROM (" +
                            "    SELECT MAX(leave_time) as max_leave_time " +
                            "    FROM leave_records " +
                            "    WHERE student_id = ? AND return_time IS NULL" +
                            ") tmp)";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, student.getStudentId());
                stmt.setString(2, student.getStudentId());
                
                int updatedRows = stmt.executeUpdate();
                if (updatedRows == 0) {
                    // 如果没有更新任何记录，可能是因为没有未返校的记录
                    return true;
                }
            }
            
            conn.commit();  // 提交事务
            return true;
        } catch (SQLException e) {
            try {
                if (conn != null) {
                    conn.rollback();  // 发生错误时回滚事务
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.setAutoCommit(true);  // 恢复自动提交
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
} 