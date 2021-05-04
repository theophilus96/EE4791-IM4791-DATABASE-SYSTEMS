CREATE TABLE Reader (
ReaderID int(8) NOT NULL,
ReaderName char(30) NOT NULL,
Rating int(2),
CONSTRAINT Reader PRIMARY KEY (ReaderID)
);

CREATE TABLE Book (
ISBN_NO int(8) NOT NULL,
BookName char(30) NOT NULL,
Color char(30),
CONSTRAINT Book PRIMARY KEY (ISBN_NO)
);

CREATE TABLE Reserve (
ReaderID int(8) NOT NULL,
ISBN_NO int(8) NOT NULL,
Date char(30),
CONSTRAINT Book PRIMARY KEY (ReaderID, ISBN_NO, Date),
CONSTRAINT Book_FK1 FOREIGN KEY (ReaderID) REFERENCES Reader(ReaderID),
CONSTRAINT Book_FK2 FOREIGN KEY (ISBN_NO) REFERENCES Book(ISBN_NO)
);

INSERT INTO Reader
VALUES
(101,"adam",5),
(102,"eve",4),
(103,"rick",3);

INSERT INTO Book
VALUES
(3113,"adam book","blue"),
(3114,"eve book","black"),
(3115,"Rick book","blue"),
(3116,"new book","black");

INSERT INTO Reserve
VALUES
(101,3113,"01-JAN-200"),
(101,3116,"01-JAN-200"),
(102,3114,"03-JAN-200"),
(103,3115,"11-JAN-200");

ALTER TABLE Book
ADD Author char(30) NOT NULL;

UPDATE Book
SET Author ="****"
WHERE ISBN_NO IN (
  SELECT ISBN_NO
  FROM Reserve
  WHERE Date < "31-Jan-02"
);