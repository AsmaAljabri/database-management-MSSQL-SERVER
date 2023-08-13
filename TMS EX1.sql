

 SELECT DISTINCT b.bk_title AS "Book Title", c.cr_title AS "Course Title"
FROM book AS b,CBlink AS cb,course AS c
WHERE  b.bk_id = cb.li_bkID
AND  cb.li_crCode = c.cr_code;

SELECT bk_title
FROM book
WHERE bk_totalCopies > 50 AND bk_totalCopies <= 100;

SELECT DISTINCT br_dept
FROM borrower
WHERE br_city = 'Seeb'
ORDER BY br_dept DESC;

