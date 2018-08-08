##备份与还原数据库 
#不压缩
pg_dump -U postgres -h 192.9.21.117 -w sales>/home/tk/pgsql/backup/1.bak
psql -U postgres -h 192.9.21.117 -w aa < /home/tk/pgsql/backup/1.bak 

#压缩
pg_dump -w -U postgres -Fc -b -f "/data/mctest_20170424.backup" "host=192.9.11.58 dbname=dc user=postgres password=Bearsoft202A"
pg_restore -h 192.9.21.117 -w -U postgres -d dev_eb3_dcr "/data/mctest_20170424.backup"
如果备份表可以加上 -t table1 -t table2
如果只是备份表结构可以加上-s


##导出导入数据
psql "host=192.9.11.58 dbname=dc user=postgres password=Bearsoft202A" --command "\copy (select scripno,iodate,ioflag,iotype,totalmoney,gfrom,gto,totalcount,d_id,c_zuangtm,companyid,ftcompanyid,vipno from g_inouttbl_zmd where d_id > '2018-01-01 00:00:00' and d_id < '2018-01-31 23:59:59' ) to 'g_inouttbl_zmd.csv' csv HEADER;"
psql "host=192.9.11.58 dbname=dc user=postgres password=Bearsoft202A" --command "\copy s_shopid to 's_shopid.csv' csv;"


##查询正在运行的sql语句
SELECT query_start,extract(epoch from (now() - query_start)) AS lap,pid,usename,state,waiting,query 
FROM pg_stat_activity  
where query_start is not NULL 
order by backend_start;


##终止进程
SELECT pg_terminate_backend('5311');
SELECT pg_cancel_backend('14688');
