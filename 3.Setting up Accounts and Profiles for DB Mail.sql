

--// Create a Database Mail account
EXECUTE msdb.dbo.sysmail_add_account_sp
    @account_name = 'Test_Email_Account',
    @description = 'Mail account for administrative e-mail.',
    @email_address = 'test.smtp@gmail.com',
    @replyto_address = 'test.smtp@gmail.com',
    @display_name = 'Test',
    @mailserver_name = 'smtp.gmail.com',
    @port = 587,
    @username = 'test.smtp@gmail.com',
    @password = 'password',
    @enable_ssl = 1
 
-- Create a Database Mail profile
EXECUTE msdb.dbo.sysmail_add_profile_sp
    @profile_name = 'Test_Email_Profile',
    @description = 'Profile used for administrative mail.'
 
-- Add the account to the profile
EXECUTE msdb.dbo.sysmail_add_profileaccount_sp
    @profile_name = 'Test_Email_Profile',
    @account_name = 'Test_Email_Account',
    @sequence_number =1
 
-- Grant access to the profile to the DBMailUsers role
EXECUTE msdb.dbo.sysmail_add_principalprofile_sp
    @profile_name = 'Test_Email_Profile',
    @principal_name = 'public',
    @is_default = 1