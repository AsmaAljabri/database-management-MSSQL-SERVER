-- Create the COLLEGE table
CREATE TABLE COLLEGE (
    Col_Code char(3) constraint C_collid_PK PRIMARY KEY,
    Col_Name char (40) not null,
    Col_Dean CHAR(30)
);

-- Create the DEPARTMENT table
CREATE TABLE DEPARTMENT (
    Dp_Code char(4) constraint Dept_PK PRIMARY KEY,
    Dp_Name CHAR(40) not null,
    Dp_Col char (3),
    Dp_HoD char(30),
    FOREIGN KEY (Dp_Col) REFERENCES COLLEGE(Col_Code),
);

-- Create the BOOK table
CREATE TABLE BOOK (
    Bk_ID numeric(6) constraint book_PK PRIMARY KEY,
    Bk_Title CHAR(50),
    Bk_Edition numeric(2),
    Bk_NumPages numeric(4) constraint Book_check_P check (Bk_NumPages > 0 ) ,
    Bk_TotalCopies numeric (5),
    Bk_RemCopies numeric (5)
);

-- Create the BOOKTOPIC table
CREATE TABLE BOOKTOPIC (
    Tp_Desc char(30),
    Tp_BkID numeric (6) not null,
 constraint Tp_BkID_FK FOREIGN KEY (Tp_BkID) REFERENCES BOOK(Bk_ID)
);

-- Create the BORROWER table
CREATE TABLE BORROWER (
    Br_ID numeric(6) constraint borr_PK PRIMARY KEY constraint borr_posi check(  Br_ID >0),
    Br_Name CHAR(30 ) not null,
    Br_Dept char(4) ,
    Br_Mobile CHAR(8) constraint borr_num check(  Br_Mobile >= 90000000),
    Br_City CHAR(20),
    Br_HouseNo CHAR(4),
    Br_Type CHAR(1)constraint borr_Type check(  Br_Type in ('s','E'))  ,
    FOREIGN KEY (Br_Dept) REFERENCES DEPARTMENT(Dp_Code)
);

-- Create the EMPLOYEE table
CREATE TABLE EMPLOYEE (
    Em_ID numeric (6) constraint Em_ID_PK PRIMARY KEY constraint Em_ID_CH check(Em_ID >0),
	Em_OfficeNo CHAR(4) not null,
    Em_ExtNo CHAR(4) constraint Em_ExtNo_ch check(Em_ExtNo > 1000)
);

-- Create the STUDENT table
CREATE TABLE STUDENT (
    St_ID numeric (6)PRIMARY KEY constraint St_ID_ch check( St_ID >0),
	St_Cohort numeric (4) not null,
    St_Major CHAR(30),
);

-- Create the COURSE table
CREATE TABLE COURSE (
    Cr_Code CHAR(8) PRIMARY KEY,
    Cr_Title CHAR(40)  not null,
    Cr_CH numeric (2) constraint Cr_CH_ch check( Cr_CH >0),
    Cr_NumSections numeric (2) constraint Cr_NumSections_ch check( 0 < Cr_NumSections),
    Cr_Dept char (4),
    constraint Cr_Dept_FK FOREIGN KEY (Cr_Dept) REFERENCES DEPARTMENT(Dp_Code)
);
-- Create the CBLink table
CREATE TABLE CBLink (
    Li_CrCode CHAR(8),
    Li_BkID numeric(6),
    Li_Usage CHAR(1) constraint Li_Usage_ch  CHECK (Li_Usage IN ('T', 'R')),
    constraint Li_CrCode_FK   FOREIGN KEY (Li_CrCode) REFERENCES COURSE(Cr_Code),
    constraint  Li_BkID_FK  FOREIGN KEY (Li_BkID) REFERENCES BOOK(Bk_ID)
);

-- Create the REGIST table
CREATE TABLE REGIST (
    Re_BrID numeric(6),
    Re_CrCode CHAR(8),
    Re_Semester CHAR(6) NOT NULL,
  
    constraint Re_BrID_FK FOREIGN KEY (Re_BrID) REFERENCES BORROWER(Br_ID),
    constraint Re_CrCode_FK FOREIGN KEY (Re_CrCode) REFERENCES COURSE(Cr_Code)
);

-- Create the ISSUING table
CREATE TABLE ISSUING (
    Is_BrID numeric(6),
    Is_BkID numeric(6),
    Is_DateTaken DATE NOT NULL,
    Is_DateReturn DATE,
    constraint Is_BrID_FK FOREIGN KEY (Is_BrID) REFERENCES BORROWER(Br_ID),
    constraint Is_BkID_FK FOREIGN KEY (Is_BkID) REFERENCES BOOK(Bk_ID),
    constraint Is_DateReturn_takenCH CHECK (Is_DateReturn > Is_DateTaken)
);
insert into COLLEGE  (Col_Code,Col_Name,Col_Dean)values ("COM", "ECONOMY","Prof.Fahim");