-- Day3
USE TestingSystem;

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