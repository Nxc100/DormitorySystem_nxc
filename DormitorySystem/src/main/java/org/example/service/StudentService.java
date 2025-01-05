package org.example.service;

import org.example.dao.StudentDAO;
import org.example.entity.Student;

import java.util.List;
import java.util.Map;

public class StudentService {
    private StudentDAO studentDAO = new StudentDAO();
    
    public Student getStudentInfo(String studentId) {
        return studentDAO.findByStudentId(studentId);
    }

    public List<Student> getAllStudents() {
        return studentDAO.findAll();
    }

    public List<Student> searchStudents(String keyword) {
        return studentDAO.search(keyword);
    }

    public boolean updateStudent(Student student) {
        return studentDAO.update(student);
    }

    public List<Student> getStudentsByStatus(String status) {
        if ("all".equals(status)) {
            return getAllStudents();
        }
        return studentDAO.findByStatus(status);
    }

    public Map<String, Integer> getStudentStatusCounts() {
        return studentDAO.getStatusCounts();
    }

    public boolean updateStudentStatus(Student student) {
        return studentDAO.updateStatus(student);
    }
} 