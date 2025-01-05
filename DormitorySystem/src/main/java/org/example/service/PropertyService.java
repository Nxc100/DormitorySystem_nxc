package org.example.service;

import org.example.dao.PropertyDAO;
import org.example.entity.Property;

import java.util.List;

public class PropertyService {
    private PropertyDAO propertyDAO = new PropertyDAO();
    
    public List<Property> getAllProperties() {
        return propertyDAO.findAll();
    }
} 