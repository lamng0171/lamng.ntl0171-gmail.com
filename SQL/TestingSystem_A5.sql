USE TestingSystem;

-- Question 1: Tao view ra thong tin nhan vien thuoc phong ban sale
DROP VIEW IF EXISTS NhanvienSales;
CREATE VIEW	NhanvienSales AS
	SELECT	d.department_name, a.full_name
    FROM	Department d
	JOIN	`Account` a ON d.department_id = a.department_id
    WHERE	d.department_name = (	SELECT 	d1.department_name
									FROM	Department d1
                                    WHERE	d1.department_name = 'Sales');
                                    




