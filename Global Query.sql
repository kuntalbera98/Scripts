DECLARE @DB_Name nvarchar(100) 
DECLARE @Command nvarchar(max) 
DECLARE database_cursor CURSOR FOR 
SELECT name 
FROM MASTER.sys.sysdatabases where name not in('master','tempdb','model','msdb','ContactDB','EXPANDSMERP','PracticalTestDB','baseline','CTI','ErpTest',
'DB_InvoiceDetails','DB_PracticalTest','Airports','BulkyBookDb','formS','MVCTEST','student','TestDB','TestEmp','db_Test','ORAS_Recovered','PREMIUM') order by name

OPEN database_cursor 

FETCH NEXT FROM database_cursor INTO @DB_Name 

WHILE @@FETCH_STATUS = 0 
BEGIN 

	
     
	 --ProdTrans-Without-Store
	 SELECT @Command = 'Update EXPANDSMERP.dbo.ErpUsers Set EXPANDSMERP.dbo.ErpUsers.UserPersonName=Users.UserPersonName from '+ @DB_Name +'.dbo.Users As Users 
inner join EXPANDSMERP.dbo.ErpUsers on Users.UserID=EXPANDSMERP.dbo.ErpUsers.UserID
inner join EXPANDSMERP.dbo.MPDetails on EXPANDSMERP.dbo.ErpUsers.MPID=EXPANDSMERP.dbo.MPDetails.MPID and EXPANDSMERP.dbo.MPDetails.DatabaseName='''+ @DB_Name +'''
 '

	--Select ClientsDb.*,Users.UserPersonName,'Acura' As 'DBName' from Acura.dbo.NotificationTokens ClientsDb Inner Join Acura.dbo.Users Users On ClientsDb.UserId = Users.UserId And ClientsDb.IsDeactivated = 0 And ClientsDb.DeviceType = 2 Order By CreatedDate DESC
	 --DocTrans-Store
	--	 SELECT @Command = 'select '+ @DB_Name +'.dbo.Channels.CHannelName,'+ @DB_Name +'.dbo.documenttypes.DocTypeName,'+ @DB_Name +'.dbo.Stores.StoreName 
	--From '+ @DB_Name +'.dbo.Productstoretransaction
	--inner join '+ @DB_Name +'.dbo.documents on '+ @DB_Name +'.dbo.Productstoretransaction.DocID='+ @DB_Name +'.dbo.documents.DOcID
	--and '+ @DB_Name +'.dbo.Productstoretransaction.ChannelID='+ @DB_Name +'.dbo.documents.ChannelID
	--inner join '+ @DB_Name +'.dbo.Channels on '+ @DB_Name +'.dbo.Channels.ChannelID='+ @DB_Name +'.dbo.documents.ChannelID
	--inner join '+ @DB_Name +'.dbo.documenttypes on '+ @DB_Name +'.dbo.documenttypes.DocTypeID='+ @DB_Name +'.dbo.documents.DocTypeID
	--inner join '+ @DB_Name +'.dbo.Stores on '+ @DB_Name +'.dbo.Productstoretransaction.StoreID='+ @DB_Name +'.dbo.Stores.StoreID
	--group by '+ @DB_Name +'.dbo.Channels.CHannelName,'+ @DB_Name +'.dbo.documenttypes.DocTypeName,'+ @DB_Name +'.dbo.Stores.StoreName
	--order by '+ @DB_Name +'.dbo.Channels.CHannelName,'+ @DB_Name +'.dbo.documenttypes.DocTypeName,'+ @DB_Name +'.dbo.Stores.StoreName'	 
	 
			--Transaction CHannelID <> STore ChannelID
	--	 SELECT @Command = 'select Stores.StoreName,ChannelsTrans.CHannelName as TransChannel,ChannelsStores.ChannelName as StoreChannel 
	--from '+ @DB_Name +'.dbo.ProductStoreTransaction
	--inner join '+ @DB_Name +'.dbo.Channels as ChannelsTrans on  '+ @DB_Name +'.dbo.ProductStoreTransaction.ChannelID=ChannelsTrans.ChannelID
	--inner join '+ @DB_Name +'.dbo.Stores on  '+ @DB_Name +'.dbo.ProductStoreTransaction.StoreID=Stores.StoreID
	--inner join '+ @DB_Name +'.dbo.Channels as ChannelsStores on  '+ @DB_Name +'.dbo.Stores.ChannelID=ChannelsStores.ChannelID
	--where ProductStoreTransaction.ChannelID<>Stores.ChannelID
	--group by Stores.StoreName,ChannelsTrans.CHannelName ,ChannelsStores.ChannelName '

	--select @Command ='select DocNum,DocOpenDate,DocTypeName,ChannelName from '+ @DB_Name +'.dbo.DocProdOtherCHarges 
	--inner join '+ @DB_Name +'.dbo.Documents on  '+ @DB_Name +'.dbo.DocProdOtherCHarges.DocID=Documents.DocID
	--inner join '+ @DB_Name +'.dbo.DocumentTypes on  '+ @DB_Name +'.dbo.DocumentTypes.DocTypeID=Documents.DocTypeID
	--inner join '+ @DB_Name +'.dbo.Channels on  '+ @DB_Name +'.dbo.Channels.ChannelID=Documents.ChannelID
	--where isnull(PostingToMainAcc,0)=1 union all
	--select VoucherNumber,VoucherDate,VoucherTypeName,ChannelName from '+ @DB_Name +'.dbo.DocProdOtherCHarges 
	--inner join '+ @DB_Name +'.dbo.Vouchers on  '+ @DB_Name +'.dbo.DocProdOtherCHarges.VoucherID=Vouchers.VoucherID
	--inner join '+ @DB_Name +'.dbo.VoucherTypes on  '+ @DB_Name +'.dbo.VoucherTypes.VoucherTypeIndex=Vouchers.VoucherTypeIndex
	--inner join '+ @DB_Name +'.dbo.Channels on  '+ @DB_Name +'.dbo.Channels.ChannelID=Vouchers.ChannelID
	--where isnull(PostingToMainAcc,0)=1'

	--SELECT @Command ='select * from '+ @DB_Name +'.dbo.documenttypes where isnull(HideFieldsInDocCentre,'''')!='''''
	--update users set UserPassword = 'wE9zCl36iXgA', UserMACAddress=null where username !='scheduler'
	--SELECT @Command ='update '+ @DB_Name +'.dbo.users set UserPassword = ''wE9zCl36iXgA'', UserMACAddress=null where username !=''scheduler'''

	-- Get All Table Row Counts
	--SELECT @Command ='SELECT QUOTENAME(SCHEMA_NAME(sOBJ.schema_id)) + ''.'' + QUOTENAME(sOBJ.name) AS [TableName] '+
	--', SUM(sPTN.Rows) AS [RowCount] FROM '+ @DB_Name +'.sys.objects AS sOBJ INNER JOIN '+ @DB_Name +'.sys.partitions AS sPTN '+
	--'ON sOBJ.object_id = sPTN.object_id WHERE sOBJ.type = ''U'' AND sOBJ.is_ms_shipped = 0x0 AND index_id < 2 '+
	--'GROUP BY sOBJ.schema_id, sOBJ.name having SUM(sPTN.Rows)>0 ORDER BY SUM(sPTN.Rows) desc '

	--select @command='select ''Update '+ @DB_Name +'.dbo.reports set ReportIndex = ''+convert(nvarchar,(10000 - 1 + Row_number() over(order by db1.ReportIndex)))+''  where ReportID = ''+convert(nvarchar,db1.ReportID)+'''' as UpdateScript'+
	--				' from '+ @DB_Name +'.dbo.reports  db1 left join BLANK.dbo.reports db2 on db1.reportid = db2.reportid  where db2.ReportIndex is NULL order by db1.ReportIndex asc'
	--				--and db1.reportname = db2.reportname

	--select @command='select * from '+ @DB_Name +'.dbo.REPORTALTERNATEPATH where isnull(ReportIndex,0)>0 and isnull(ReportIndex,0)=0'
	--select @command='select * from '+ @DB_Name +'.dbo.REPORTPATH'
	--select @command='Update '+ @DB_Name +'.dbo.DashBoardData set DashBoardData.ReportIndex =Reports.ReportIndex From '+ @DB_Name +'.dbo.Reports inner join DashBoardData.ReportIndex=Reports.OldReportIndex'

	--select @command='select '''+@DB_Name +''' as DBName,* from '+ @DB_Name +'.dbo.erpconfig where ErpConfigIndex=50 and ERPConfigText not in(''1015,1022'')'

	--select @command ='update '+ @DB_Name +'.dbo.erpconfig set ERPConfigText=''137,144'' where ErpConfigIndex=50'	

	--select @command='select '''+@DB_Name +''' as DBName,* from '+ @DB_Name +'.dbo.erpconfig where erpconfigindex in(18,29)'

	--select @command='update '+ @DB_Name +'.dbo.erpconfig set ERPConfigText=REPLACE(ERPConfigText,''C:'',''D:'')  where erpconfigindex in(18,29)'
	--select @command='select count(*) StoreTransCount,ChannelName,'''+@DB_Name +''' as DBName,Store.ChannelStore, 
	--stuff((select '';'' + u.DocTypeName from '+ @DB_Name +'.dbo.DocumentTypes u where u.ShowStoresColumn=1
	--order by u.DocTypeName for xml path('''') ),1,1,'''') as StoreApplicable
	--from '+ @DB_Name +'.dbo.ProductStoreTransaction 
	--Inner join '+ @DB_Name +'.dbo.Channels on ProductStoreTransaction.ChannelID=Channels.ChannelID 
	--left join(select ChannelID,count(*) as ChannelStore from '+ @DB_Name +'.dbo.Stores group  by ChannelID) as Store on Channels.ChannelID=Store.ChannelID  group by ChannelName,Store.ChannelStore having count(*)>0'
	 
	 --select @command='Select AdditionalEmails, ChannelID, AlertRuleCondition from AlertRulesMetaTables INNER JOIN AlertRules On AlertRules.AlertRuleID = AlertRulesMetaTables.AlertRuleID 
		--				where IsActive = 1 And AlertRuleActive = 1 And AlertRuleIndex = 95'
	 
	 --select @command='select '''+@DB_Name +''' as DBName,* from Reports where ReportIndex=247'
	 --select @command='SELECT compatibility_level  FROM sys.databases'

	 --select @command='select isnull(ERPConfigText,'''') ERPConfigText,isnull(convert(varchar,ChannelID),'''') ChannelID from '+ @DB_Name +'.dbo.ERPCONFIG where ERPConfigIndex = 58 and isnull(ERPConfigText,'''') !='''''

	 --select @command='delete from '+ @DB_Name +'.dbo.REPORTCENTERPAGE where ReportLinkID=6628574169836589857 ; delete from '+ @DB_Name +'.dbo.REPORTLINKS where ReportLinkIndex=11176; delete from '+ @DB_Name +'.dbo.REPORTPATH where ReportIndex=11176'

	 --select @command='drop table '+ @DB_Name +'.dbo.bookingdetails; drop table '+ @DB_Name +'.dbo.booking; drop table '+ @DB_Name +'.dbo.bookingstatus '
	 --print '--' + @DB_Name
     --EXEC sp_executesql @Command 
	 print @Command
	 

     FETCH NEXT FROM database_cursor INTO @DB_Name 
END 

CLOSE database_cursor 
DEALLOCATE database_cursor 
