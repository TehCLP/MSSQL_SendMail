

--Profiles
SELECT * FROM msdb.dbo.sysmail_profile
 
--Accounts
SELECT * FROM msdb.dbo.sysmail_account
 
--Profile Accounts
select * from msdb.dbo.sysmail_profileaccount
 
--Principal Profile
select * from msdb.dbo.sysmail_principalprofile
 
--Mail Server
SELECT * FROM msdb.dbo.sysmail_server
SELECT * FROM msdb.dbo.sysmail_servertype
SELECT * FROM msdb.dbo.sysmail_configuration
 
--Email Sent Status
SELECT * FROM msdb.dbo.sysmail_allitems
SELECT * FROM msdb.dbo.sysmail_sentitems
SELECT * FROM msdb.dbo.sysmail_unsentitems
SELECT * FROM msdb.dbo.sysmail_faileditems
 
--Email Status
SELECT SUBSTRING(fail.subject,1,25) AS 'Subject',
       fail.mailitem_id,
       LOG.description
FROM msdb.dbo.sysmail_event_log LOG
join msdb.dbo.sysmail_faileditems fail
ON fail.mailitem_id = LOG.mailitem_id
WHERE event_type = 'error'
 
--Mail Queues
EXEC msdb.dbo.sysmail_help_queue_sp
 
--DB Mail Status
EXEC msdb.dbo.sysmail_help_status_sp