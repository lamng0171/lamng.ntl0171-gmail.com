-- Day4
USE TestingSystem;

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
SELECT		d.department_name, count(a.full_name) soluonnhanvien, group_concat(a.full_name) Fullname
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
                                    
-- Question 9: Thống kê số lượng account trong mỗi group
SELECT 		g.group_name, count(account_id) So_luong_acc
FROM		`Group` g
JOIN		Groupaccount g1 ON g.group_id = g1.group_id
GROUP BY	g.group_id;

-- Question 10: Tìm chức vụ có ít người nhất 
SELECT		p.position_name, count(a.account_id) So_nhan_vien
FROM 		`Position` p 
JOIN 		`Account` a ON p.position_id = a.position_id
GROUP BY 	p.position_id
HAVING 		So_nhan_vien = (	SELECT	min(ca)
								FROM	( 	SELECT   	count(a1.account_id) ca
											FROM 		`Position` p1 
											JOIN 		`Account` a1 ON p1.position_id=a1.position_id
											GROUP BY 	p1.position_id 	) P );

-- Question 11: thống kê mỗi phòng ban có bao nhiêu dev, test, scrum master, PM 
SELECT 		d.department_name, p.position_name, group_concat(a.full_name) Fullname, count(p.position_id) Soluongnhanvien 
FROM		Department d 
JOIN		`Account` a  ON	 d.department_id = a.department_id
JOIN		`Position`p  ON  a.position_id = p.position_id
GROUP BY  	d.department_id, p.position_name ;

-- Question 12: Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của question, loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì
SELECT		q.question_id, q.content, tq.type_name, group_concat(aw.content) answer, a.full_name nguoi_tao
FROM		Question q
JOIN 		Typequestion tq 	ON	q.type_id = tq.type_id
JOIN		Answer aw    		ON 	aw.question_id = q.question_id
JOIN		`Account` a			ON	a.account_id = 	q.creator_id
GROUP BY	q.question_id;	

-- Question 13: lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm 
SELECT 		tq.type_name, count(q.question_id) Soluongcauhoi  
FROM		Typequestion tq
LEFT JOIN	Question q 	ON	tq.type_id = q.type_id
WHERE		tq.type_name IN ('Essay', 'Multiple-Choice')
GROUP BY 	tq.type_name ;

-- Question 14: lấy ra group không có account nào 
SELECT 			g.group_name, ga.account_id
FROM			`Group` g
LEFT JOIN		Groupaccount ga	ON  g.group_id = ga.group_id
WHERE      		ga.account_id  IS NULL ;

-- Question 16: lấy ra question không có answer nào 
SELECT		   	q.question_id, q.content, a.answer_id
FROM			Question q
LEFT JOIN		Answer a    ON  q.question_id = a.question_id
WHERE			a.answer_id IS NULL ;

-- Question 17: a) Lấy các account thuộc nhóm thứ 1 
-- 				b) Lấy các account thuộc nhóm thứ 2 
--              c) Ghép 2 kết quả từ câu a) và câu b) sao cho không có record nào trùng nhau
SELECT			ga.group_id, a.full_name, a.email, a.account_id	 
FROM			`Account` a 
JOIN			Groupaccount  ga  ON  a.account_id = ga.account_id
WHERE           ga.group_id = 1
GROUP BY 		a.full_name
UNION  
SELECT			ga.group_id, a.full_name, a.email, a.account_id	 
FROM			`Account` a 
JOIN			Groupaccount  ga  ON  a.account_id = ga.account_id
WHERE           ga.group_id = 2
GROUP BY 		a.full_name ;

-- Question 18: a) Lấy các group có lớn hơn 5 thành viên 
-- 				b) Lấy các group có nhỏ hơn 7 thành viên 
-- 				c) Ghép 2 kết quả từ câu a) và câu b)
SELECT     	g.group_name, count(ga.account_id) so_luong_thanh_vien
FROM		`Group` g 
JOIN		Groupaccount ga   ON  g.group_id = ga.group_id 
GROUP BY  	g.group_name 
HAVING      so_luong_thanh_vien > 5
UNION ALL
SELECT     	g.group_name, count(ga.account_id) so_luong_thanh_vien
FROM		`Group` g 
JOIN		Groupaccount ga   ON  g.group_id = ga.group_id 
GROUP BY  	g.group_name 
HAVING      so_luong_thanh_vien  < 7 ;

