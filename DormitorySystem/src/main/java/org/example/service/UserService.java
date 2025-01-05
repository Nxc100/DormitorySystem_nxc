package org.example.service;

import org.example.dao.UserDAO;
import org.example.entity.User;

public class UserService {
    private UserDAO userDAO = new UserDAO();
    
    public User login(String userId, String password) {
        User user = userDAO.findByUserId(userId);
        if (user != null && user.getPassword().equals(password)) {
            return user;
        }
        return null;
    }
    
    public boolean register(String userId, String password, int userType) {
        // 检查用户是否已存在
        if (userDAO.findByUserId(userId) != null) {
            return false;
        }
        
        User user = new User(userId, password, userType);
        return userDAO.insert(user);
    }
    
    public boolean updatePassword(String userId, String oldPassword, String newPassword) {
        return userDAO.updatePassword(userId, oldPassword, newPassword);
    }
    
    // 为了保持兼容性，保留这个方法
    public boolean changePassword(String userId, String oldPassword, String newPassword) {
        return updatePassword(userId, oldPassword, newPassword);
    }
} 