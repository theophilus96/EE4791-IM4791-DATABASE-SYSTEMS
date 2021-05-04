Consider the database tables below as in Tutorial 5
Question 3. Write SQL commands for the additional

requirements stated below.

Student (StudentID, StudentName);
Lecturer (LecturerID, LecturerName);
Course (CourseID, CourseName);
Tutorial (TutorialID, CourseID);
IsQualified (LecturerID, CourseID, DateQualified);
IsRegistered (StudentID, TutorialID, Semester);

(a) List all courses (and course details) for which Professor
John Tan is qualified.
(b) Find the IDs of any lecturers who are qualified to teach
ISM3113 but not qualified to teach ISM3114.
(c) Find out how many students are enrolled in course
ISM3113 during semester I-98.
(d) Find out which students were not enrolled in any
courses during semester I-98. Show their IDs and names.

1a)
SELECT CourseID, CourseName 
FROM Course,Lecturer,IsQualiifed 
WHERE LecturerName = John Tan (INCORRECT)

SELECT CourseID, CourseName 
FROM Course,Lecturer,IsQualiifed 
WHERE Lecturer.LecturerID = IsQualiifed.LecturerID 
AND Course.CourseID = IsQualiifed.CourseID 
AND LecturerName = 'John Tan'; (correct)

1b)

SELECT DISTINCT LecturerID 
FROM isQualified
WHERE CourseID = 'ISM3113'
AND LecturerID IN (
    SELECT DISTINCT LecturerID 
    FROM isQualified
    WHERE CourseID NOT IN (ISM3114)
); (INCORRECT)

SELECT DISTINCT LecturerID 
FROM isQualified
WHERE CourseID = 'ISM3113'
AND LecturerID NOT IN (
    SELECT DISTINCT LecturerID 
    FROM isQualified
    WHERE CourseID = 'ISM3114'
); (correct)

1c)

SELECT COUNT (DISTNCT StudentID)
FROM IsRegistered
WHERE CourseID = 'ISM3113'
AND Semester ='I-98'; (INCORRECT) Careless

SELECT COUNT (DISTNCT StudentID)
FROM IsRegistered,Tutorial
WHERE Tutorial.TutorialID = IsRegistered.TutorialID
And Tutorial.CourseID = 'ISM3113'
AND Semester ='I-98'; (correct)

1d)

SELECT StudentName, StudentID
FROM Student
WHERE StudentID NOT IN (
    SELECT DISTINCT StudentID
    FROM IsRegistered
    WHERE Semester ='I-98'
);
(correct)


2. Given a library database with the following relations:
Reader (ReaderID, ReaderName, Rating)
Book (ISBN_NO, BookName, Color)
Reserve (ReaderID, ISBN_NO, Date)
Provide SQL statements to:
(a.1) Create a view RReader to include those readers
(reader IDs and names) who have a rating 2 or less and
those readers who have reserved more than two books with
different ISBN numbers.
(a.2) Create a view RReader to include those readers
(reader IDs and names) who have a rating 2 or less and 
who have reserved two books with different
ISBN numbers.
(b) Add a new column Author to the Book table.
(c) Record the following reservations in the database.
On 1-Mar-02, ReaderID R1 reserved books with ISBN
numbers B5 and B6.
(d.1) List the IDs of the readers who have reserved a blue
book.
(d.2) List the names of the readers who have reserved a
blue book.
(e1) Find the number of blue books.
(e2) For each book, find the number of reservations for this
book.
(e3) For each blue book, find the number of reservations for
this book.
(f) Find the names and ratings of persons who have
reserved two or more books with different ISBN numbers
on the same date.
(g1) Find the names of readers who have reserved a blue or
a black book.
(g2) Find the names of readers who have reserved both a
blue and a black book.
(h) Remove those reserve records older than 31-Jan-02.
(i) Update Author column to ‘****’ for those books 

(a.1)
CREATE VIEW RReader AS
SELECT ReaderID, ReaderName
FROM Reader
WHERE Rating <= 2
AND ReaderID IN (
    SELECT DISTINCT ReaderID
    FROM Reserve
    WHERE COUNT(ISBN_NO) > 2
); (INCORRECT)

CREATE VIEW RReader AS
SELECT ReaderID, ReaderName
FROM Reader
WHERE Rating <= 2
OR ReaderID IN (
    SELECT DISTINCT ReaderID
    FROM Reserve
    GROUP BY ReaderID
    HAVING COUNT(DISTINCT ISBN_NO) > 2
); (CORRECT)

(a.2)

CREATE VIEW RReader AS
SELECT ReaderID, ReaderName
FROM Reader
WHERE Rating <= 2
AND ReaderID IN (
    SELECT DISTINCT ReaderID
    FROM Reserve
    GROUP BY ReaderID
    HAVING COUNT(DISTINCT ISBN_NO) > 2
); (CORRECT)

b)
ALTER TABLE Book
ADD Author varchar(255) NOT NULL;

c)

INSERT INTO Reserve(ReaderID, ISBN_NO, Date)
VALUES (R1, B5, 1-Mar-02),(R1, B6, 1-Mar-02);

(d.1)

SELECT DISTINCT ReaderID
FROM Book, Reserve
Where Book.ISBN_NO = Reserve.ISBN_NO
AND Color = 'blue';

(d.2)

SELECT ReaderName
FROM Reader
WHERE ReaderID IN (
    SELECT DISTINCT ReaderID
    FROM Book, Reserve
    WHERE Book.ISBN_NO = Reserve.ISBN_NO
    AND Color = 'blue');

(e1)

SELECT COUNT(ISBN_NO)
FROM Book
WHERE Color = 'blue';

(e2)

SELECT ISBN_NO, COUNT(ISBN_NO)
FROM Reserve
GROUP BY ISBN_NO;

(e3)

SELECT Reserve.ISBN_NO, COUNT(Reserve.ISBN_NO)
FROM Reserve,Book
WHERE Reserve.ISBN_NO = Book.ISBN_NO
AND Color = 'blue'
GROUP BY Reserve.ISBN_NO;

f)

SELECT ReaderName,Rating
FROM Reader, Reserve
WHERE Reserve.ReaderID = Reader.ReaderID
GROUP BY Date, Reserve.ReaderID
HAVING COUNT(DISTINCT ISBN_NO) > 2;
 
(g1)

SELECT ReaderName, ReaderID
FROM Reader
WHERE ReaderID IN (
    SELECT ReaderID 
    FROM Reserve,Book
    WHERE Book.ISBN_NO = Reserve.ISBN_NO
    AND Color IN ('blue','black')
);

OR

SELECT DISTINCT (ReaderName, Reader.ReaderID)
FROM Reader, Book, Reserve
WHERE Book.ISBN_NO = Reserve.ISBN_NO
AND Reserve.ReaderID = Reader.ReaderID
AND Color IN ('blue','black');

(g2)

SELECT DISTINCT (ReaderName,Reader.ReaderID)
FROM Reader, Book, Reserve
WHERE Book.ISBN_NO = Reserve.ISBN_NO
AND Reserve.ReaderID = Reader.ReaderID
AND Color = 'blue'
AND Reader.ReaderID IN (
    SELECT DISTINCT (Reserve.ReaderID)
    FROM Book, Reserve
    WHERE Book.ISBN_NO = Reserve.ISBN_NO
    AND Color = 'black'
);

(h) Remove those reserve records older than 31-Jan-02.

Reader (ReaderID, ReaderName, Rating)
Book (ISBN_NO, BookName, Color)
Reserve (ReaderID, ISBN_NO, Date)


DELETE FROM Reserve
WHERE Date < '31-Jan-02';

(i) Update Author column to ‘****’ for those books 

UPDATE Book SET Author='****'
WHERE ISBN_NO IN (
    SELECT ISBN_NO
    FROM Reserve
    WHERE Date < '31-Jan-02'
);