

use master
go
exec sp_configure 'show advanced options', 1
reconfigure
exec sp_configure 'Database Mail XPs', 1
reconfigure

