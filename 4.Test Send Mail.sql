


--Send mail
EXEC msdb.dbo.sp_send_dbmail
    @recipients=N'test@gmail.com',
    @body= 'Test Email Body',
    @subject = 'Test Email Subject',
    @profile_name = 'Test_Email_Profile'
    
    
--Send mail with attachment
EXEC msdb.dbo.sp_send_dbmail
     @profile_name = 'Test_Email_Profile'
    ,@recipients = 'test@gmail.com'
    --,@copy_recipients = 'testcc1@gmail.com;testcc2@gmail.com' --> cc
    --,@blind_copy_recipients = 'testbcc1@gmail.com;testbcc2@gmail.com' --> bcc
    --,@from_address = 'test@gmail.com'
    ,@subject = 'Exclusive Locks'
    ,@body_format = 'TEXT' -- or 'HTML' // default 'TEXT'
    ,@file_attachments = 'D:\temp\blog.jpg;D:\temp\long folder\sample.txt' -->  limits file attachments to 1 MB per file
    

--Send mail with HTML    
DECLARE @tableHTML  NVARCHAR(MAX) ;
SET @tableHTML =
    N'<H1>Work Order Report</H1>' +
    N'<table border="1">' +
    N'<tr><th>Work Order ID</th><th>Product ID</th>' +
    N'<th>Name</th><th>Order Qty</th><th>Due Date</th>' +
    N'<th>Expected Revenue</th></tr>' +
    CAST ( ( SELECT td = wo.WorkOrderID,       '',
                    td = p.ProductID, '',
                    td = p.Name, '',
                    td = wo.OrderQty, '',
                    td = wo.DueDate, '',
                    td = (p.ListPrice - p.StandardCost) * wo.OrderQty
              FROM AdventureWorks.Production.WorkOrder as wo
              JOIN AdventureWorks.Production.Product AS p
              ON wo.ProductID = p.ProductID
              WHERE DueDate > '2004-04-30'
                AND DATEDIFF(dd, '2004-04-30', DueDate) < 2 
              ORDER BY DueDate ASC,
                       (p.ListPrice - p.StandardCost) * wo.OrderQty DESC
              FOR XML PATH('tr'), TYPE 
    ) AS NVARCHAR(MAX) ) +
    N'</table>' ;

EXEC msdb.dbo.sp_send_dbmail @recipients='yourfriend@gmail.com',
    @subject = 'Work Order List',
    @body = @tableHTML,
    @body_format = 'HTML' ;
    
    
