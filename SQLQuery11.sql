
select * from MVC;

drop table MVC;
--------------------------------------------------Stored Procedure---------------------------------------------
alter PROCEDURE sp_MVC1
    @Id int= null,
    @First_name varchar(30)=null,
    @Last_name varchar(30)=null,
    @Date_of_birth varchar(30)=null,
    @Hobbies varchar(30)=null,
	@Gender varchar (30)=null,
    @States varchar(30)=null,
    @City varchar(30)=null,
	@UploadImage varchar(30)=null,
	@UploadPdf varchar(30)=null,
    @operation varchar(30)=null
AS
BEGIN
    IF @operation = 'Insert' 
    BEGIN
        INSERT INTO MVC (strfirst_name, strlast_name, dtedob, strhobbies, strgender, strstates, strcity, uploadimage, uploadpdf)
        VALUES (@First_name, @Last_name, @Date_of_birth, @Hobbies, @Gender, @States, @City, @UploadImage,@UploadPdf);
    END
    ELSE IF @operation = 'Update'
    BEGIN
        UPDATE MVC
        SET strfirst_name = @First_name,
            strlast_name = @Last_name,
            dtedob = @Date_of_birth,
            strhobbies = @Hobbies,
			strgender = @Gender,
            strstates = @States,
            strcity = @City,
			uploadimage = @UploadImage,
			uploadpdf = @UploadPdf
        WHERE intid = @Id;
    END
    ELSE IF @operation = 'Delete'
    BEGIN
        DELETE FROM MVC WHERE intid = @Id;
    END
    ELSE IF @operation = 'Select'
    BEGIN
        SELECT * FROM MVC 
    END
	ELSE IF @operation ='GetById'
	BEGIN
	  select * from MVC where intid = @Id
END
END

alter table MVC (intid int primary key identity(1,1), strfirst_name varchar(30), 
strlast_name varchar(30), dtedob varchar(30), strhobbies varchar(30),
                  strgender varchar(30), strstates varchar(30), strcity varchar(30))
--------------------------------------------------------------------------------------------------------------------------
 drop table MVC;

 select * from MVC;
 SET IDENTITY_INSERT MVC ON;

 -----------------------------------------SP for pagination---------------------------------------------------------------

 CREATE PROCEDURE GetPagedData
    @PageNumber INT,
    @PageSize INT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @StartRow INT, @EndRow INT;

    
    SET @StartRow = (@PageNumber - 1) * @PageSize + 1;
    SET @EndRow = @PageNumber * @PageSize;

   
    WITH PagedData AS (
        SELECT
            *,
            ROW_NUMBER() OVER (ORDER BY intid) AS RowNum
        FROM
            MVC
        
    )

    
    SELECT * FROM PagedData WHERE RowNum BETWEEN @StartRow AND @EndRow;
END

------------------------------------------SP for search--------------------------------------------------------
alter PROCEDURE SearchItems
    @searchTerm NVARCHAR(50)
AS
BEGIN
    SELECT intid, strfirst_name, strlast_name, dtedob, strhobbies, strgender, strstates, strcity
    FROM MVC
    WHERE strfirst_name  LIKE '%' + @searchTerm + '%'
END

---------------------------------------------------------------------------------------------------------------
delete from MVC where 
intid = 5060;
select * from MVC;
---------------------------------------------------------------------------------------------------------------
CREATE TABLE States (
    StateID INT PRIMARY KEY,
    StateName NVARCHAR(50)
);

CREATE TABLE Cities (
    CityID INT PRIMARY KEY,
    CityName NVARCHAR(50),
    StateID INT FOREIGN KEY REFERENCES States(StateID)
);

ALTER TABLE Cities
DROP CONSTRAINT FK__Cities__StateID__7366C176;

ALTER TABLE MVC DROP CONSTRAINT FK__MVC__StateID__35548064

SELECT name
FROM sys.foreign_keys
WHERE referenced_object_id = OBJECT_ID('States') AND name LIKE '%StateID%';


ALTER TABLE Cities
DROP CONSTRAINT StateID;


CREATE PROCEDURE GetStatesAndCities
AS
BEGIN
    SELECT StateID, StateName FROM States;
    SELECT CityID, CityName, StateID FROM Cities;
END;

----------------------------------------------------------------------------------------------------------------
CREATE TABLE Images
(
    ImageID INT PRIMARY KEY IDENTITY(1,1),
    ImageData VARBINARY(MAX),
    ImageMimeType NVARCHAR(50)
)
---------------------------------------------------------------------------------------------------------------------------
select * from Images;

alter table MVC add uploadimage varchar(30), uploadpdf varchar(30);



alter table MVC drop column uploadimage, uploadpdf;

delete from MVC;


create table Hobbies(Hid int, Hobbiesname varchar(30));
drop table Hobbies;
select * from Hobbies;

insert into Hobbies values('1', 'Travelling');
insert into Hobbies values('2', 'Cooking');
insert into Hobbies values('3', 'Reading');
insert into Hobbies values('4', 'Playing');
insert into Hobbies values('5', 'Net Surfing');



ALTER PROCEDURE sp_MVC1
    @Id INT = NULL,
    @First_name VARCHAR(30) = NULL,
    @Last_name VARCHAR(30) = NULL,
    @Date_of_birth VARCHAR(30) = NULL,
    @Hobbies VARCHAR(30) = NULL,
    @Gender VARCHAR(30) = NULL,
    @States VARCHAR(30) = NULL,
    @City VARCHAR(30) = NULL,
    @UploadImage VARCHAR(30) = NULL,
    @UploadPdf VARCHAR(30) = NULL,
    @operation VARCHAR(30) = NULL
AS
BEGIN
    IF @operation = 'Insert'
    BEGIN
        -- Check for duplicate record before insertion
        IF NOT EXISTS (
            SELECT 1
            FROM MVC
            WHERE strfirst_name = @First_name
              AND strlast_name = @Last_name
              AND dtedob = @Date_of_birth
              AND strhobbies = @Hobbies
              AND strgender = @Gender
              AND strstates = @States
              AND strcity = @City
              AND uploadimage = @UploadImage
              AND uploadpdf = @UploadPdf
        )
        BEGIN
            -- Insert the record
            INSERT INTO MVC (strfirst_name, strlast_name, dtedob, strhobbies, strgender, strstates, strcity, uploadimage, uploadpdf)
            VALUES (@First_name, @Last_name, @Date_of_birth, @Hobbies, @Gender, @States, @City, @UploadImage, @UploadPdf);
        END
        ELSE
        BEGIN
            -- Handle the case of a duplicate record
            -- You can raise an error or return a specific code/message as needed
            RAISEERROR('Duplicate record detected. Insertion aborted.');
        END
    END
    -- Other operation cases (Update, Delete, Select) can remain the same
END



alter PROCEDURE sp_MVC1
    @Id int= null,
    @First_name varchar(30)=null,
    @Last_name varchar(30)=null,
    @Date_of_birth varchar(30)=null,
    @Hobbies varchar(30)=null,
	@Gender varchar (30)=null,
    @States varchar(30)=null,
    @City varchar(30)=null,
	@UploadImage varchar(30)=null,
	@UploadPdf varchar(30)=null,
    @operation varchar(30)=null
AS
BEGIN
    IF @operation = 'Insert' 
    BEGIN
       
        IF NOT EXISTS (
            SELECT 1
            FROM MVC
            WHERE strfirst_name = @First_name
              AND strlast_name = @Last_name
              AND dtedob = @Date_of_birth
              AND strhobbies = @Hobbies
              AND strgender = @Gender
              AND strstates = @States
              AND strcity = @City
              AND uploadimage = @UploadImage
              AND uploadpdf = @UploadPdf
        )
        BEGIN
            -- Insert the record
            INSERT INTO MVC (strfirst_name, strlast_name, dtedob, strhobbies, strgender, strstates, strcity, uploadimage, uploadpdf)
            VALUES (@First_name, @Last_name, @Date_of_birth, @Hobbies, @Gender, @States, @City, @UploadImage, @UploadPdf);
        END
        ELSE
        BEGIN
            -- Handle the case of a duplicate record
            -- You can raise an error or return a specific code/message as needed
            RAISEERROR('Duplicate record detected. Insertion aborted.');
        END
    
    ELSE IF @operation = 'Delete'
    BEGIN
        DELETE FROM MVC WHERE intid = @Id;
    END
    ELSE IF @operation = 'Select'
    BEGIN
        SELECT * FROM MVC 
    END
	ELSE IF @operation ='GetById'
	BEGIN
	  select * from MVC where intid = @Id
END
END