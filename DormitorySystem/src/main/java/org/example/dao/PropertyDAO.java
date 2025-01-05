package org.example.dao;

import org.example.entity.Property;
import org.example.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PropertyDAO {
    
    public List<Property> findAll() {
        List<Property> properties = new ArrayList<>();
        String sql = "SELECT * FROM properties ORDER BY property_id";
        
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Property property = new Property();
                property.setId(rs.getInt("property_id"));
                property.setName(rs.getString("property_name"));
                properties.add(property);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return properties;
    }
} 