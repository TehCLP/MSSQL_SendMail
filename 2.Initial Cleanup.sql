
declare @ProfileName varchar(200),
		@AccountName varchar(200)

set @ProfileName = 'Test_Email_Profile'
set @AccountName = 'Test_Email_Account'

IF EXISTS(
SELECT * FROM msdb.dbo.sysmail_profileaccount pa
      JOIN msdb.dbo.sysmail_profile p ON pa.profile_id = p.profile_id
      JOIN msdb.dbo.sysmail_account a ON pa.account_id = a.account_id
WHERE
      p.name = @ProfileName AND
      a.name = @AccountName)
BEGIN
      PRINT 'Deleting Profile Account'
      EXECUTE sysmail_delete_profileaccount_sp
      @profile_name = @ProfileName,
      @account_name = @AccountName
END
 
IF EXISTS(
SELECT * FROM msdb.dbo.sysmail_profile p
WHERE p.name = @ProfileName)
BEGIN
      PRINT 'Deleting Profile.'
      EXECUTE sysmail_delete_profile_sp
      @profile_name = @ProfileName
END
 
IF EXISTS(
SELECT * FROM msdb.dbo.sysmail_account a
WHERE a.name = @AccountName)
BEGIN
      PRINT 'Deleting Account.'
      EXECUTE sysmail_delete_account_sp
      @account_name = @AccountName
END