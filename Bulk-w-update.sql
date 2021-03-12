USE [DSFCU]
GO
/****** Object:  StoredProcedure [dbo].[Adverse_WF_Import]    Script Date: 3/12/2021 9:56:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROC [dbo].[Adverse_WF_Import]
AS
IF OBJECT_ID('DSFCU.dbo.Adverse_Temp_WF') IS NOT NULL 
BEGIN
    DROP TABLE DSFCU.dbo.Adverse_Temp_WF;
END 

CREATE TABLE DSFCU.dbo.Adverse_Temp_WF (document_handle int, doc_date date, SSN nvarchar(9)); -- but see below
BULK insert DSFCU.dbo.Adverse_Temp_WF
FROM '\\phx.dsfcu.local\Nautilus\import$\workflow\Prod\Adverse\Adverse_workflow.csv'
WITH
(
    FIRSTROW = 1,
    FIELDTERMINATOR = '|',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    TABLOCK
)

UPDATE DSFCU.dbo.Adverse_from_DW
SET    DSFCU.dbo.Adverse_from_DW.document_handle = DSFCU.dbo.Adverse_Temp_WF.document_handle
FROM   DSFCU.dbo.Adverse_Temp_WF
WHERE  DSFCU.dbo.Adverse_from_DW.create_date = DSFCU.dbo.Adverse_Temp_WF.doc_date and DSFCU.dbo.Adverse_from_DW.SSN = DSFCU.dbo.Adverse_Temp_WF.SSN;

Insert into DSFCU.dbo.Adverse_from_DW (create_date,decision_date,member_name,SSN,branch,username,document_handle)select doc_date,null as decision_date,null as member_name,SSN,null as branch,null as username,document_handle from DSFCU.dbo.Adverse_Temp_WF t3
where CONCAT(t3.doc_date, t3.SSN) in (
select CONCAT(t2.doc_date, t2.SSN) from DSFCU.dbo.Adverse_Temp_WF t2
EXCEPT
select CONCAT(t1.create_date, t1.SSN)  from DSFCU.dbo.Adverse_from_DW t1)

DROP TABLE DSFCU.dbo.Adverse_Temp_WF;
