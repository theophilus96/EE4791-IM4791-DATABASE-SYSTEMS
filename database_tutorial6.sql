Student (StudentID, StudentName);
Lecturer (LecturerID, LecturerName);
Course (CourseID, CourseName);
Tutorial (TutorialID, CourseID);
IsQualified (LecturerID, CourseID, DateQualified);
IsRegistered (StudentID, TutorialID, Semester);

(a) List all courses (and course details) for which Professor
John Tan is qualified.

SELECT Course.CourseID,Course.CourseName 
FROM Course,IsQualified,Lecturer
WHERE Course.CourseID = IsQualified.CourseID
AND IsQualified.LecturerID = Lecturer.LecturerID
AND Lecturer.LecturerName = "John Tan"

(b) Find the IDs of any lecturers who are qualified to teach
ISM3113 but not qualified to teach ISM3114.

SELECT LecturerID 
FROM IsQualified
WHERE CourseID = "ISM3113"
AND LecturerID NOT IN (
                      SELECT LecturerID
                      FROM IsQualified
                      WHERE CourseID = "ISM3114"
                      );

(c) Find out how many students are enrolled in course
ISM3113 during semester I-98.

SELECT Count(DISTINCT(Student.StudentID))
FROM Student,IsRegistered,Tutorial
WHERE Student.StudentID = IsRegistered.StudentID
AND IsRegistered.TutorialID = Tutorial.TutorialID
AND Semester="I-98"
AND CourseID="ISM3113"


dk what i was doing. lols.

SELECT COUNT (*)
FROM Tutorial, IsRegistered
WHERE Tutorial.TutorialID= IsRegistered.TutorialID
AND CourseID = 'ISM3113'
AND Semester = 'I-98';

(d) Find out which students were not enrolled in any
courses during semester I-98. Show their IDs and names.

SELECT DISTINCT StudentID, StudentName
FROM Student
WHERE StudentID NOT IN (
  SELECT DISTINCT StudentID
  FROM IsRegistered
  WHERE Semester="I-98"
);

(a.1) Create a view RReader to include those readers
(reader IDs and names) who have a rating 2 or less and
those readers who have reserved more than two books with
different ISBN numbers.

CREATE VIEW RReader AS
SELECT ReaderID,ReaderName
FROM Reader
WHERE Rating <= 2
OR ReaderID IN (
                SELECT ReaderID
                FROM Reserve
                GROUP BY ReaderID
                HAVING COUNT(DISTINCT(ISBN_NO)) > 2
                );


(a.2) Create a view RReader to include those readers
(reader IDs and names) who have a rating 2 or less and
 have reserved two books with different
ISBN numbers.

SELECT ReaderID,ReaderName
FROM Reader
WHERE Rating <= 2
AND ReaderID IN (
                SELECT ReaderID
                FROM Reserve
                GROUP BY ReaderID
                HAVING COUNT(DISTINCT(ISBN_NO)) > 2
                );

(b) Add a new column Author to the Book table

ALTER TABLE Book
ADD Author char(30) NOT NULL;

(c) Insert the following records in the Reserve table:
On 1-Mar-02, ReaderID R1 reserved books with ISBN
numbers B5 and B6.

INSERT INTO Reserve
VALUES
("R1","B5","1-Mar-02"),
("R1","B6","1-Mar-02");

(d.1) List the IDs of the readers who have reserved a blue
book.

SELECT DISTINCT Reserve.ReaderID
FROM Reserve,Book
WHERE Reserve.ISBN_NO = Book.ISBN_NO
AND Color ="blue";

(d.2) List the names of the readers who have reserved a
blue book.

SELECT DISTINCT Reader.ReaderName
FROM Reserve,Book,Reader
WHERE Reserve.ISBN_NO = Book.ISBN_NO
AND Reader.ReaderID = Reserve.ReaderID
AND Color ="blue";

(e1) Find the number of blue books.

SELECT COUNT(Color)
FROM Book
WHERE Color = "blue"
GROUP BY Color;

(e2) For each book, find the number of reservations for this
book.

SELECT Book.BookName, COUNT(*)
FROM Book, Reserve
WHERE Reserve.ISBN_NO = Book.ISBN_NO
GROUP BY Book.ISBN_NO;

(e3) For each blue book, find the number of reservations
for this book.

SELECT Book.BookName, COUNT(*)
FROM Book, Reserve
WHERE Reserve.ISBN_NO = Book.ISBN_NO
AND Color = "blue"
GROUP BY Reserve.ISBN_NO;

f) Find the names and ratings of persons who have
reserved two or more books with different ISBN numbers
on the same date.

SELECT ReaderName, Rating
FROM Reader
WHERE ReaderID IN (
                  SELECT ReaderID
                  FROM Reserve
                  GROUP BY ReaderID,Date
                  HAVING COUNT(*)>=2
                  );

(g1) Find the names of readers who have reserved a blue or
a black book.

SELECT Reader.ReaderName
FROM Reader, Book,Reserve
WHERE Reserve.ISBN_NO = Book.ISBN_NO
AND Reserve.ReaderID = Reader.ReaderID
AND Color IN ("blue","black");

(g2) Find the names of readers who have reserved both a
blue and a black book.

SELECT Reader.ReaderName
FROM Reader, Book,Reserve
WHERE Reserve.ISBN_NO = Book.ISBN_NO
AND Reserve.ReaderID = Reader.ReaderID
AND Color IN ("blue")
AND Reader.ReaderID IN (
                  SELECT Reader.ReaderID
                  FROM Reader, Book,Reserve
                  WHERE Reserve.ISBN_NO = Book.ISBN_NO
                  AND Reserve.ReaderID = Reader.ReaderID
                  AND Color IN ("black")
                  );

(h) Remove those reserve records older than 31-Jan-02.

DELETE FROM Reserve
WHERE Date < "31-Jan-02";

(i) Update Author column to ‘****’ for those books 

UPDATE Book
SET Author ="****"
WHERE ISBN_NO IN (
  SELECT ISBN_NO
  FROM Reserve
  WHERE Date < "31-Jan-02"
);