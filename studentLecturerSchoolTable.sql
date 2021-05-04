CREATE TABLE Student (
StudentID int(8) NOT NULL,
StudentName char(30) NOT NULL,
CONSTRAINT Student PRIMARY KEY (StudentID)
);

INSERT INTO Student(StudentID,StudentName) 
VALUES
(101,"adam"),
(102,"eve"),
(103,"rick");

CREATE TABLE Course(
CourseID char(8) NOT NULL,
CourseName Char(30) NOT NULL,
CONSTRAINT Course PRIMARY KEY (CourseID)
);

INSERT INTO Course (CourseID,CourseName)
VALUES 
("ISM3113","a"),
("ISM3114","b"),
("ABS201","g");
 
CREATE TABLE Tutorial(
TutorialID int(8) NOT NULL,
CourseID char(30) NOT NULL,
CONSTRAINT Tutorial PRIMARY KEY (TutorialID),
CONSTRAINT Tutorial_FK FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);
INSERT INTO Tutorial 
VALUES
(3113,"ISM3113"),
(3114,"ISM3114");


CREATE TABLE Lecturer(
LecturerID int(8) NOT NULL,
LecturerName Char(30) NOT NULL,
CONSTRAINT Lecturer PRIMARY KEY (LecturerID)
);


INSERT INTO Lecturer 
VALUES
(101, "Joe"),
(102, "larry"),
(103, "borry"),
(104, "Jasdoe"),
(105, "laosf")
;


CREATE TABLE IsQualified(
LecturerID int(8) NOT NULL,
CourseID char(30) NOT NULL,
DateQualified char(10),
CONSTRAINT IsQualified_PK PRIMARY KEY (LecturerID, CourseID),
CONSTRAINT IsQualified_FK1 FOREIGN KEY (LecturerID) REFERENCES Lecturer(LecturerID),  
CONSTRAINT IsQualified_FK2 FOREIGN KEY (CourseID) REFERENCES Course(CourseID)  
);



CREATE TABLE IsRegistered(
StudentID int(8) NOT NULL,
TutorialID int(8) NOT NULL,
Semester char(7),
CONSTRAINT IsRegistered_PK PRIMARY KEY (StudentID, TutorialID),
CONSTRAINT IsRegistered_FK1 FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
CONSTRAINT IsRegistered_FK2 FOREIGN KEY (TutorialID) REFERENCES Tutorial(TutorialID)  
);


INSERT INTO Student 
VALUES (98765, "Joe Sun");


INSERT INTO IsQualified(LecturerID,CourseID,DateQualified)
VALUES 
(101, "ISM3113","01-JAN-200"),
(101, "ISM3114", "03-JAN-200"),
(102 , "ISM3113","11-JAN-200"),
(103 , "ISM3113","21-JAN-200"),
(103 , "ISM3114","21-JAN-200"),
(104 , "ISM3114","23-FEB-201"),
(105 , "ABS201","23-FEB-201");

INSERT INTO IsRegistered
VALUES 
(101,3113,"I-98"),
(101,3114,"I-97"),
(102,3113,"I-98"),
(103,3113,"I-97"),
(103,3114,"I-98");