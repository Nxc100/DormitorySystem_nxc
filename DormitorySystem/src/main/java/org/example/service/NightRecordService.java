package org.example.service;

import org.example.dao.NightRecordDAO;
import org.example.dao.StudentDAO;
import org.example.entity.NightRecord;
import org.example.entity.Student;

import java.util.List;

public class NightRecordService {
    private NightRecordDAO nightRecordDAO = new NightRecordDAO();
    private StudentDAO studentDAO = new StudentDAO();
    
    public List<NightRecord> getAllNightRecords() {
        return nightRecordDAO.findAll();
    }
    
    public List<NightRecord> searchNightRecords(String keyword) {
        return nightRecordDAO.search(keyword);
    }
    
    public boolean addNightRecord(NightRecord record) {
        // 先检查学生是否存在
        Student student = studentDAO.findByStudentId(record.getStudentId());
        if (student == null) {
            return false;
        }
        // 设置学生姓名和宿舍号
        record.setStudentName(student.getName());
        record.setDormId(student.getDormId());
        return nightRecordDAO.insert(record);
    }
} 