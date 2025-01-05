-- 创建数据库
CREATE DATABASE IF NOT EXISTS dormitory_system DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE dormitory_system;

-- 用户表
CREATE TABLE users (
    user_id VARCHAR(20) PRIMARY KEY,
    password VARCHAR(64) NOT NULL,
    user_type TINYINT NOT NULL COMMENT '0:学生,1:管理员'
);

-- 住宿学生表
CREATE TABLE students (
    student_id VARCHAR(20) PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    gender VARCHAR(4) NOT NULL,
    major VARCHAR(40) NOT NULL,
    dorm_id VARCHAR(6) NOT NULL,
    check_in_date DATE NOT NULL
);

-- 宿舍表
CREATE TABLE dormitories (
    dorm_id VARCHAR(6) PRIMARY KEY,
    phone VARCHAR(15)
);

-- 宿舍财产表
CREATE TABLE properties (
    property_id INT PRIMARY KEY,
    property_name VARCHAR(20) NOT NULL
);

-- 邮件快递表
CREATE TABLE packages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_name VARCHAR(20) NOT NULL,
    dorm_id VARCHAR(6) NOT NULL,
    arrival_time DATETIME NOT NULL,
    receive_time DATETIME,
    package_count TINYINT NOT NULL
);

-- 报修表
CREATE TABLE repairs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    dorm_id VARCHAR(6) NOT NULL,
    property_id INT NOT NULL,
    submit_date DATE NOT NULL,
    solve_date DATE,
    reason VARCHAR(50) NOT NULL,
    FOREIGN KEY (property_id) REFERENCES properties(property_id)
);

-- 夜归记录表
CREATE TABLE night_returns (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id VARCHAR(20) NOT NULL,
    dorm_id VARCHAR(6) NOT NULL,
    return_time TIMESTAMP NOT NULL,
    reason VARCHAR(50) NOT NULL,
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

-- 离校记录表
CREATE TABLE leave_records (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id VARCHAR(20) NOT NULL,
    dorm_id VARCHAR(6) NOT NULL,
    leave_time DATE NOT NULL,
    return_time DATE,
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

-- 创建视图
CREATE VIEW student_info_view AS
SELECT s.student_id, s.name, s.gender, s.major, s.dorm_id, d.phone
FROM students s
JOIN dormitories d ON s.dorm_id = d.dorm_id;

CREATE VIEW repair_view AS
SELECT r.dorm_id, p.property_name, r.submit_date, r.solve_date, r.reason
FROM repairs r
JOIN properties p ON r.property_id = p.property_id;

CREATE VIEW night_return_view AS
SELECT n.student_id, s.name, s.gender, s.major, n.dorm_id, n.return_time, n.reason
FROM night_returns n
JOIN students s ON n.student_id = s.student_id;

CREATE VIEW leave_record_view AS
SELECT l.student_id, s.name, s.gender, s.major, l.dorm_id, l.leave_time, l.return_time
FROM leave_records l
JOIN students s ON l.student_id = s.student_id;

CREATE VIEW present_student_view AS
SELECT s.student_id, s.name, s.gender, s.major, s.dorm_id, d.phone
FROM students s
JOIN dormitories d ON s.dorm_id = d.dorm_id
LEFT JOIN leave_records l ON s.student_id = l.student_id
WHERE l.student_id IS NULL OR l.return_time IS NOT NULL; 

ALTER DATABASE dormitory_system CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

ALTER TABLE users CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE students CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci; 