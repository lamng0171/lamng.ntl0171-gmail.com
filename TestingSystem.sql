-- Tạo database
DROP DATABASE IF EXISTS TestingSystem;
CREATE DATABASE TestingSystem;

USE TestingSystem;

-- Tạo bảng Department
CREATE TABLE Department(
	department_id 		SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    department_name 	VARCHAR(50) NOT NULL UNIQUE KEY
);

-- Tạo bảng Position
CREATE TABLE `Position`(
	position_id 		SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    position_name		VARCHAR(50) NOT NULL UNIQUE KEY
);

-- Tạo bảng Account
CREATE TABLE `Account`(
	account_id			MEDIUMINT UNSIGNED AUTO_INCREMENT PRIMARY KEY ,
    email 				VARCHAR(50) UNIQUE KEY,
    username			VARCHAR(20) NOT NULL UNIQUE KEY,
    full_name			VARCHAR(30) NOT NULL,
    department_id		SMALLINT UNSIGNED NOT NULL,
    position_id 		SMALLINT UNSIGNED NOT NULL,
    create_date			DATE,
    FOREIGN KEY (department_id) REFERENCES Department(department_id) ,
    FOREIGN KEY (position_id) REFERENCES `Position`(position_id)
);

-- Tạo bảng Group
CREATE TABLE `Group`(
	group_id			SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    group_name			VARCHAR(50) NOT NULL,
    creator_id			TINYINT UNSIGNED NOT NULL,
    create_date			DATE DEFAULT NOW()
);

-- Tạo bảng Groupaccount
CREATE TABLE Groupaccount(
	group_id			SMALLINT UNSIGNED,
    account_id			MEDIUMINT UNSIGNED,
    join_date			DATE NOT NULL,
    PRIMARY KEY	(group_id,account_id),
    FOREIGN KEY (group_id) REFERENCES `Group`(group_id) ,
    FOREIGN KEY (account_id) REFERENCES `Account`(account_id)
);

-- Tạo bảng Typequestion
CREATE TABLE Typequestion(
	type_id				TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    type_name			VARCHAR(20)
);

-- Tạo bảng Categoryquestion
CREATE TABLE Categoryquestion(
	category_id			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	category_name		VARCHAR(20) 
);

-- Tạo bảng Question
CREATE TABLE Question(
	question_id			MEDIUMINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    content				VARCHAR(500) NOT NULL,
    category_id			TINYINT UNSIGNED NOT NULL,
    type_id				TINYINT UNSIGNED NOT NULL,
    creator_id			TINYINT UNSIGNED NOT NULL,
    create_date			DATE,
    FOREIGN KEY (category_id) REFERENCES Categoryquestion(category_id) ,
    FOREIGN KEY (type_id) REFERENCES Typequestion(type_id) 
);

-- Tạo bảng Answer
CREATE TABLE Answer(
	answer_id			MEDIUMINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    content				VARCHAR(500) NOT NULL,
    question_id			MEDIUMINT UNSIGNED NOT NULL,
    is_correct			BOOLEAN,
    FOREIGN KEY (question_id) REFERENCES Question(question_id) 
);

-- Tạo bảng Exam
CREATE TABLE Exam(
	exam_id				TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `code`				CHAR(5) NOT NULL UNIQUE KEY,
    title				VARCHAR(20) NOT NULL,
    category_id			TINYINT UNSIGNED NOT NULL,
    duration			SMALLINT UNSIGNED NOT NULL,
    creator_id			TINYINT UNSIGNED NOT NULL,
    create_date			DATE ,
    FOREIGN KEY (category_id) REFERENCES Categoryquestion(category_id) ON DELETE CASCADE
);

-- Tạo bảng Examquestion
CREATE TABLE Examquestion(
	exam_id				TINYINT UNSIGNED NOT NULL,
    question_id			MEDIUMINT UNSIGNED NOT NULL,
    PRIMARY KEY (exam_id, question_id),
    FOREIGN KEY (question_id) REFERENCES Question(question_id),
	FOREIGN KEY (exam_id) REFERENCES Exam(exam_id) ON DELETE CASCADE
);

-- Nhập bản ghi cho bảng Department
INSERT INTO Department	(department_name)
	VALUES
						('Finance'),					-- 1
                        ('IT'),							-- 2
                        ('Legal'),						-- 3
                        ('Office Administration'),		-- 4	
                        ('Production'),					-- 5	
                        ('Quality Control'),			-- 6
                        ('Business Development'),		-- 7
                        ('Client Service'),				-- 8
                        ('Sales'),						-- 9
                        ('Marketing');					-- 10
					
-- Nhập bản ghi cho bảng Position
INSERT INTO `Position`	(position_name)
	VALUES
						('Computer Engineeer'),			-- 1
                        ('IT Specialist'),				-- 2
                        ('Department Head'),			-- 3
                        ('Plant Manager'),				-- 4
                        ('Finance Director'),			-- 5
                        ('Managing Director'),			-- 6
                        ('Intership'),					-- 7
                        ('Salesman'),					-- 8
                        ('Consultants'),				-- 9
                        ('Customers Service');			-- 10

-- Nhập bản ghi cho bảng Account
INSERT INTO `Account` 	(email,				username,		full_name,		department_id,		position_id,		create_date)
	VALUES	
						('cd1@gmail.com',	'candidate1',	'Do Van Anh',			8,				10,				'2019-03-22'),
                        ('cd2@gmail.com',	'candidate2',	'Hoang Duc Bach',		2,				2,				'2020-10-12'),
                        ('cd3@gmail.com',	'candidate3',	'Tran Tuan Cao',		1,				3,				'2020-06-15'),
                        ('cd4@gmail.com',	'candidate4',	'Do Thi Dao',			3,				1,				'2019-01-26'),
                        ('cd5@gmail.com',	'candidate5',	'Pham Thu Em',			2,				2,				'2020-03-30'),
                        ('cd6@gmail.com',	'candidate6',	'Do Van Hungo',			4,				6,				'2020-03-21'),
                        ('cd7@gmail.com',	'candidate7',	'Phan Phuoc Gia',		9,				9,				'2019-05-26'),
                        ('cd8@gmail.com',	'candidate8',	'Nguyen Hoang Long',	1,				5,				'2020-07-29'),
                        ('cd9@gmail.com',	'candidate9',	'Ngo Lan Ngoc',			2,				2,				'2020-03-18'),
                        ('cd10@gmail.com',	'candidate10',	'Mai Ngoc Linh',		9,				8,				'2020-01-11');

-- Nhập bản ghi cho bảng Group                        
INSERT INTO `Group`		(group_name,	creator_id,		create_date)
	VALUES
						('A1',			1,				'2020-01-11'),
                        ('B2',			2,				'2020-02-26'),
                        ('AB',			3,				'2019-12-11'),
                        ('12BH',		3,				'2020-01-31'),
                        ('GLHF',		1,				'2020-03-01'),
                        ('SV',			1,				'2020-02-01'),
                        ('AFF',			2,				'2019-10-21'),
                        ('MSI',			2,				'2020-03-26'),
                        ('HO',			3,				'2019-11-20'),
                        ('PS',			1,				'2020-03-26');

-- Nhập bản ghi cho bảng Groupaccount                        
INSERT INTO Groupaccount	(group_id, account_id, join_date)
	VALUES	
                            (1,			2,			'2020-03-29'),
                            (2,			3,			'2020-03-25'),
                            (5,			1,			'2020-03-25'),
                            (3,			9,			'2019-03-25'),
                            (2,			5,			'2018-03-25'),
                            (7,			2,			'2020-03-25'),
                            (10,		4,			'2020-03-25'),
                            (2,			6,			'2020-03-25'),
                            (4,			2,			'2015-03-25'),
                            (8,			3,			'2020-03-25');
 
 -- Nhập bản ghi cho bảng Typequestion
INSERT INTO Typequestion	(type_name)
	VALUES
							('Essay'),
                            ('Multiple-Choice'),
                            ('True or Fail'),
                            ('Yes or No');

-- Nhập bản ghi cho bảng Categoryquestion
INSERT INTO Categoryquestion	(category_name)
	VALUES
								('Java'),
                                ('.NET'),
                                ('SQL'),
                                ('Postman'),
                                ('Ruby');

-- Nhập bản ghi cho bảng Question							
INSERT INTO	Question	(content,													category_id,	type_id,	creator_id,		create_date)
	VALUES	
						('SQL là từ viết tắt của:',									3,				1,			1,				'2020-02-12'),
                        ('Sự khác nhau giữa Error và Exception?',					2,				1,			1,				'2020-03-01'),
                        ('Mục đích của đa hình (poymophism)?',						2,				1,			2,				'2020-01-31'),
						('Cú pháp mặc định của switch luôn luôn được thực thi',		1,				4,			3,				'2020-03-21'),
						('Giá trị NULL được coi là rỗng hoặc bằng 0',				3,				4,			3,				'2020-02-01');

-- Nhập bản ghi cho bảng Answer                        
INSERT INTO Answer	(content,																								question_id,	is_correct)
	VALUES
					('Structured Query Language',																			1,				1),
                    ('Error là lỗi của chương trình, còn exception là lỗi chương trình được phát hiện và có thể xử lý',		1,				0),
                    ('Một hành động có thể xảy ra theo nhiều cách khác nhau',												1,				0),
					('Nhiều hành động có thể xảy ra theo nhiều cách khác nhau',												1,				0),
                    ('Error là ..., Exception là ...',																		2,				1),
                    ('Error có thể là ..., Exception cũng có thể là ...',													2,				0),
                    ('Tương tự nhau',																						2,				0),
                    ('Đáp án 1 và 2 đều đúng',																				2,				0),
					('Đúng',																								3,				1),
					('Sai',																									3,				0),
                    ('Đúng',																								4,				0),
					('Sai',																									4,				1),
                    ('Đúng',																								5,				1),
					('Sai',																									5,				0),
					('Bất kì trường hợp nào cũng có thể xảy ra',															5,				0);

-- Nhập bản ghi bảng exam					
 INSERT INTO Exam	(`code`,	title,		category_id,	duration,	creator_id,		create_date)
	VALUES
					('T1001',	'Java',		1,				180,		1,				'2019-09-12'),
                    ('T1002',	'.NET',		2,				120,		2,				'2018-12-23'),
                    ('T1003',	'SQL',		3,				120,		1,				'2020-01-16'),
                    ('T1004',	'Postman',	4,				120,		1,				'2019-12-19'),
                    ('T1005',	'Ruby',		5,				90,			3,				'2020-03-20');


-- Nhập bản ghi bảng examquestion                    
INSERT INTO Examquestion	(exam_id,	question_id)
	VALUES
							(1,			2),
                            (2,			1),
                            (3,			5),
                            (3,			1),
                            (4,			4),
                            (5,			3);
 
/*
-- Day3
-- lấy ra phòng ban                            
SELECT 	*
FROM	Department;

-- lấy ra id phòng ban Sale
SELECT 	department_id
FROM	Department
WHERE	department_name = 'Sales';

-- lấy ra thông tin account có full name dài nhất và sắp xếp chúng theo thứ tự giảm dần
SELECT		*
FROM		`Account`
WHERE		char_length(full_name) = (SELECT 	MAX(char_length(full_name))
									FROM	`Account`)
ORDER BY	account_id	DESC;

--  Lấy ra thông tin account có full name dài nhất và thuộc phòng ban có id = 3 
SELECT		*
FROM		`Account`
WHERE		char_length(full_name) = (SELECT 	MAX(char_length(full_name))
										FROM	`Account`
                                        WHERE	department_id = 3)
			AND department_id = 3;
            
-- lấy ra tên group đã tham gia trước ngày 20/12/2019 
SELECT	group_name
FROM	`Group`
WHERE	group_id IN (	SELECT 	group_id
						FROM	Groupaccount
                        WHERE	join_date < '2019-12-20');
                        
--  Lấy ra ID của question có >= 4 câu trả lời 
SELECT	question_id
FROM	Question
WHERE	question_id IN ( 	SELECT		question_id
							FROM		Answer
                            GROUP BY	question_id
							HAVING		COUNT(question_id) >= 4);
                            
-- Lấy ra các mã đề thi có thời gian thi >= 60 phút và được tạo trước ngày 20/12/2019
SELECT	exam_id, `code`
FROM	Exam
WHERE	duration >= 60 AND	create_date < '2019-12-20';

-- Lấy ra 5 group được tạo gần đây nhất 
SELECT		group_name, create_date
FROM		`Group`
ORDER BY	create_date	DESC
LIMIT		5;

-- Đếm số nhân viên thuộc department có id = 2 
SELECT		group_concat(full_name	SEPARATOR ', ') AS full_name, count(account_id) AS Soluongnhanvien
FROM		`Account`
WHERE		department_id = 2; 

-- Lấy ra nhân viên có tên bắt đầu bằng chữ "D" và kết thúc bằng chữ "o" 
SELECT	full_name
FROM	`Account`
WHERE	full_name LIKE 'D%o';

-- xóa tất cả các exam được tạo trước ngày 20/12/2019
DELETE
FROM 	Exam
WHERE	create_date < '2019-12-20';

-- xóa tất cả các question có nội dung bắt đầu bằng từ "câu hỏi" 
DELETE
FROM	Question
WHERE	content LIKE 'câu hỏi%';

-- update thông tin của account có id = 5 thành tên "Nguyễn Bá Lộc" và email thành loc.nguyenba@vti.com.vn 
UPDATE	`Account`
SET		full_name 	= 'Nguyễn Bá Lộc',
		email 		= 'loc.nguyenba@vti.com.vn'
WHERE	account_id 	= 5;

-- update account có id = 5 sẽ thuộc group có id = 4 
UPDATE	Groupaccount
SET		group_id = 4
WHERE	account_id = 5;
*/

-- Day4
-- lấy ra danh sách nhân viên và thông tin phòng ban của họ 
SELECT 	a.account_id, a.full_name, d.department_name
FROM	`Account` a
JOIN	Department d ON	a.department_id = d.department_id;

-- lấy ra thông tin các account được tạo sau ngày 31/12/2019  
SELECT 	*
FROM	`Account`
WHERE	create_date >'2019-12-31';

-- lấy ra tất cả các IT Specialist
SELECT 	a.full_name, p.position_name
FROM	`Account` a
JOIN	`Position` p ON	a.position_id = p.position_id
WHERE	position_name = 'IT Specialist';

-- lấy ra danh sách các phòng ban có >=2 nhân viên 
SELECT		d.department_name, count(a.full_name) soluonnhanvien
FROM		Department d
JOIN		`Account` a ON	d.department_id = a.department_id
GROUP BY	department_name
HAVING		count(full_name) >=2;

-- lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất 
SELECT		count(q.content) solanduocsudung, q.content
FROM		Question q
JOIN		Examquestion eq ON	q.question_id = eq.question_id
GROUP BY	q.content
HAVING		count(q.content) = ( SELECT MAX(CountContent)
								FROM 
								(	SELECT		count(q.content) AS CountContent
									FROM		Question q
									JOIN		Examquestion eq ON	q.question_id = eq.question_id
									GROUP BY	q.content) AS Content );
                                  
-- Thông kê mỗi category Question được sử dụng trong bao nhiêu Question
SELECT		GROUP_CONCAT(category_name SEPARATOR ', ') CategoryName, count(q.category_id) solansudung, GROUP_CONCAT(q.content SEPARATOR ', ') Content
FROM		Question q
RIGHT JOIN	Categoryquestion cq ON q.category_id = cq.category_id
GROUP BY	q.category_id ;

-- Thông kê mỗi Question được sử dụng trong bao nhiêu Exam 
SELECT		content, count(eq.question_id) Soluongcauhoi
FROM		Examquestion eq
JOIN		Question q 	ON eq.question_id = q.question_id
GROUP BY	q.question_id;

-- Lấy ra Question có nhiều câu trả lời nhất
SELECT		q.content, count(a.answer_id) Soluongcautraloi
FROM 		Question q
JOIN		Answer a ON q.question_id = a.question_id
GROUP BY	q.content
HAVING		Soluongcautraloi =  (	SELECT	MAX(b)
									FROM	(	SELECT 		count(a.question_id) b 
												FROM		Answer a
                                                GROUP BY	a.question_id) A);
                                    

-- Thống kê số lượng account trong mỗi group  
SELECT 		group_id, count(account_id)
FROM		Groupaccount
GROUP BY	group_id;











