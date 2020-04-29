-- Exercise 1
-- Tạo data Freshermanagement
DROP DATABASE IF EXISTS Freshermanagement;
CREATE DATABASE Freshermanagement;
USE Freshermanagement;

-- Tạo bảng Trainee
CREATE TABLE Trainee(
	trainee_id			SMALLINT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    full_name			NVARCHAR(50) NOT NULL,
    birth_date			DATE,
    gender				ENUM('Male','Female','Unknown'),
    et_iq				TINYINT UNSIGNED CHECK(et_iq<=20) DEFAULT 0,
    et_gmath			TINYINT UNSIGNED CHECK(et_gmath<=20) DEFAULT 0,
    et_english			TINYINT UNSIGNED CHECK(et_english<=50) DEFAULT 0,
    training_class		CHAR(4),
    evaluation_notes	TEXT
);

-- Thêm cột vti_account vào bảng Trainee
ALTER TABLE Trainee	ADD	vti_account	VARCHAR(50) UNIQUE KEY;	
    
/* Exercise2
CREATE TABLE data_types(
	id				MEDIUMINT AUTO_INCREMENT PRIMARY KEY,
    `name`			VARCHAR(30),
    `code`			TEXT,
    modified_date	DATETIME
); */

/* Exercise3 
CREATE TABLE data_types2(
	id					MEDIUMINT AUTO_INCREMENT PRIMARY KEY,
    `name`				VARCHAR(30),
    birth_date			DATE,
    gender				ENUM('0','1','null'),
	is_deleted_flag		BOOLEAN
); */

-- Nhập dữ liệu vào bảng
INSERT INTO Trainee (full_name, 				birth_date, 	gender, 	et_iq, 	et_gmath, 	et_english,  	training_class, 	evaluation_notes, 							vti_account)
	VALUES
					('Hoàng Văn Hưng',			'1998-02-02',	'Male',		8,		12,			25,				'S001',				'Chăm chỉ,đúng giờ,thái độ tốt',			'hunghoang.1998@vti.com.vn'),
					('Ngô Lan Ngọc',			'1998-03-02',	'Female',	10,		11,			15,				'S001',				'Làm việc hiệu quả',						'nln.ngoc98@vti.com.vn'),
                    ('Nguyễn Hà Việt Chinh',	'1999-12-11',	'Female',	10,		8,			18,				'S001',				'Có kinh nghiệm làm việc',					'chinh1999@vti.com.vn'),
                    ('Phan Phước Anh',			'1996-09-25',	'Male',		15,		16,			19,				'A001',				'Có cố gắng trong công việc',				'phananh@vti.com.vn'),
					('Dương Tuấn',				'1995-10-30',	'Male',		7,		12,			14,				'A001',				'Học việc nhanh, xử lí công việc tốt',		'tuan.ttt@vti.com.vn'),
					('Nguyễn Linh Trang',		'1996-01-17',	'Female',	12,		20,			18,				'A002',				'Kĩ năng giao tiếp tốt, hòa đông',			'linhtrang.ng@vti.com.vn'),
                    ('Đặng Kim Long',			'1996-05-15',	'Male',		9,		18,			10,				'A002',				'Làm việc nhóm hiệu quả',					'dkl.long@vti.com.vn'),
					('Vương Kiến Toàn',			'1996-12-06',	'Male',		10,		9,			29,				'S002',				'Làm việc hiệu quả',						'toanvuong1221@vti.com.vn'),
					('Nguyễn Thị Huế',			'1997-11-25',	'Female',	16,		12,			13,				'S002',				'Làm việc đạt yêu cầu',						'hueng.001@vti.com.vn'),
					('Doãn Ngọc Biên',			'1999-07-12',	'Male',		18,		18,			22,				'A002',				'Đúng giờ,thái độ tốt',						'ngbien.915@vti.com.vn');
                    
-- Lấy ra tất cả các thực tập sinh đã vượt qua bài test đầu vào, nhóm chúng thành các tháng sinh khác nhau
SELECT		group_concat(full_name SEPARATOR ', ') AS full_name, month(birth_date)
FROM		Trainee
GROUP BY	month(birth_date);

-- lấy ra thực tập sinh có tên dài nhất, lấy ra các thông tin sau: tên, tuổi, các thông tin cơ bản
SELECT	full_name, CHAR_LENGTH(full_name) AS char_numbers, birth_date, gender, vti_account
FROM	Trainee
HAVING	char_numbers = (SELECT 	MAX(CHAR_LENGTH(full_name))
							FROM 	Trainee);
                            
-- lấy ra tất cả các thực tập sinh là ET
SELECT	full_name
FROM	Trainee
WHERE	et_iq + et_gmath >= 20	AND	et_iq >= 8	AND	et_gmath >= 8	AND	et_english >= 18;

--  xóa thực tập sinh có TraineeID = 3
DELETE
FROM	Trainee
WHERE	trainee_id = 3;

--  Thực tập sinh có TraineeID = 5 được chuyển sang lớp "2". 
UPDATE	Trainee
SET		training_class = 'S002'
WHERE	trainee_id = 5;


SELECT	*
FROM	Trainee;