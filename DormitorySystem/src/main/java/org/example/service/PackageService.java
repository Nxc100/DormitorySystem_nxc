package org.example.service;

import org.example.dao.PackageDAO;
import org.example.entity.Package;

import java.util.Date;
import java.util.List;

public class PackageService {
    private PackageDAO packageDAO = new PackageDAO();
    
    public List<Package> getStudentPackages(String studentId) {
        return packageDAO.findByStudentId(studentId);
    }

    public List<Package> getAllPackages() {
        return packageDAO.findAll();
    }

    public boolean addPackage(Package pkg) {
        return packageDAO.insert(pkg);
    }

    public boolean receivePackage(int id) {
        return packageDAO.updateReceiveTime(id, new Date());
    }

    public boolean updatePackage(Package pkg) {
        return packageDAO.update(pkg);
    }
} 