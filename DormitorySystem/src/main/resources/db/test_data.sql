-- 插入测试用户数据
INSERT INTO users (user_id, password, user_type) VALUES
('admin', 'admin123', 1);  -- 默认管理员账号，密码：admin123
('student1', '123456', 0);
('student2', '123456', 0);

-- 插入测试宿舍数据
INSERT INTO dormitories (dorm_id, phone) VALUES
('A101', '0571-88881111');

-- 插入测试学生数据
INSERT INTO students (student_id, name, gender, major, dorm_id, check_in_date) VALUES
('student1', '张三', '男', '计算机科学', 'A101', '2023-09-01');
('student2', '李四', '女', '软件工程', 'A102', '2023-09-01');

-- 插入测试宿舍财产数据
INSERT INTO properties (property_id, property_name) VALUES
(1, '床'),
(2, '桌子'),
(3, '椅子'),
(4, '空调'),
(5, '灯');

-- 插入测试快递数据
INSERT INTO packages (student_name, dorm_id, arrival_time, receive_time, package_count) VALUES
('张三', 'A101', '2024-01-10 10:00:00', '2024-01-10 14:00:00', 1),
('张三', 'A101', '2024-01-11 09:00:00', NULL, 2);

-- 插入测试报修数据
INSERT INTO repairs (dorm_id, property_id, submit_date, solve_date, reason) VALUES
('A101', 4, '2024-01-09', '2024-01-10', '空调不制冷'),
('A102', 5, '2024-01-11', NULL, '灯泡坏了');

-- 插入测试夜归记录
INSERT INTO night_returns (student_id, dorm_id, return_time, reason) VALUES
('student1', 'A101', '2024-01-10 23:30:00', '自习'),
('student2', 'A102', '2024-01-11 23:45:00', '图书馆学习');

-- 插入测试离校记录
INSERT INTO leave_records (student_id, dorm_id, leave_time, return_time) VALUES
('student1', 'A101', '2024-01-15', '2024-02-20'),
('student2', 'A102', '2024-01-15', NULL); 