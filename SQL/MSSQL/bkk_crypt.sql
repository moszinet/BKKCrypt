--------------------------------------------------------
-- MS SQL implementation of the famous BKKCrypt algorithm
--------------------------------------------------------


-- Create BKK schema if not exists
IF NOT EXISTS ( SELECT name FROM sys.schemas WHERE name = N'BKK' ) 
    EXEC('CREATE SCHEMA [BKK]');
GO


------------------------
-- USER DEFINED FUNCTION
------------------------

-- Drop if already exists
IF OBJECT_ID('BKK.ufn_BkkCrypt') IS NOT NULL
  DROP FUNCTION [BKK].[ufn_BkkCrypt]
GO

-- Create UDF
CREATE FUNCTION [BKK].[ufn_BkkCrypt] (@input NVARCHAR(max))
RETURNS NVARCHAR(max)
AS
BEGIN

RETURN @Input

END
GO


-------------------
-- STRORED PROCEDURE
-------------------

-- Drop if already exists
IF OBJECT_ID('BKK.SP_BkkCrypt') IS NOT NULL
  DROP PROCEDURE [BKK].[SP_BkkCrypt]
GO

-- Create Procedure
CREATE PROCEDURE [BKK].[SP_BkkCrypt]
	@Input NVARCHAR(max)
AS
BEGIN

SELECT @Input AS 'CryptedValue'

END
GO
