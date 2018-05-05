[gpadmin@gpdbsne ~]$ gpcheckcloud -c "s3://minio1:9000/testbucket config=/home/gpadmin/s3.conf"
File: read_stocks.sql, Size: 586
File: stocks.csv, Size: 12246
File: testdata.csv, Size: 138


[gpadmin@gpdbsne ~]$ cat s3.conf
[default]
secret = "minio123"
accessid = "minio"
threadnum = 4
chunksize = 67108864
low_speed_limit = 10240
low_speed_time = 60
encryption = false
# true
version = 2
proxy = ""
autocompress = true
verifycert = false
# true
server_side_encryption = ""
# gpcheckcloud config
gpcheckcloud_newline = "\n"
