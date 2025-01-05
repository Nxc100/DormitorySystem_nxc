package org.example.service;

import org.example.dao.RepairDAO;
import org.example.entity.Repair;

import java.util.List;

public class RepairService {
    private RepairDAO repairDAO = new RepairDAO();
    
    public List<Repair> getRepairsByDormId(String dormId) {
        return repairDAO.findByDormId(dormId);
    }
    
    public boolean submitRepair(Repair repair) {
        return repairDAO.insert(repair);
    }
    
    public List<Repair> getAllRepairs() {
        return repairDAO.findAll();
    }
    
    public boolean solveRepair(int repairId) {
        return repairDAO.updateSolveDate(repairId, new java.util.Date());
    }

    public boolean addRepair(Repair repair) {
        return repairDAO.insert(repair);
    }
} 