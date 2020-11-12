USE [DSFCU]
GO
/****** Object:  StoredProcedure [dbo].[Keystone_acct_af]    Script Date: 11/12/2020 4:26:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROC [dbo].[Keystone_acct_af]
AS
IF OBJECT_ID('DSFCU.dbo.Keystone_acct_af') IS NOT NULL 
BEGIN
    DROP TABLE DSFCU.dbo.Keystone_acct_full;
END 
CREATE TABLE DSFCU.dbo.Keystone_acct_full (KeystoneAcct nvarchar(10), ShareID nvarchar(4), MemberName nvarchar(75), SSN nvarchar(9)); -- but see below

BULK insert DSFCU.dbo.Keystone_acct_full
FROM '\\phx.dsfcu.local\Nautilus\import$\workflow\Prod\Autofill\KeystoneAutofill.txt'
WITH
(
    FIRSTROW = 1,
    FIELDTERMINATOR = '|',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    TABLOCK
)
