-- this is used to update batches in OnBase that will not autocommit
-- You need permission from Hyland before running updates against the OnBase DB or they can drop your support


Update hsi.parsedqueue 
Set processflag=132    --this is the actual change that needs to be made for OnBase will autocommit the batches
Where parsefilenum = 673   --first piece to help narrow down the update
and parsefilename = 'Keystone Teller Receipt'   --this one is vital as it will help narrow down the query a lot
and processflag = 4   --current process flag that is preventing autocommit
and status = 2   --this is the status of a batch in Awaiting Commit
