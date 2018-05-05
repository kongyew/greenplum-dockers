
## Hortonworks sandbox

### How to start services on Hortonworks sandbox

https://github.com/hortonworks/data-tutorials/blob/master/tutorials/hdp/sandbox-port-forwarding-guide/assets/start-sandbox-hdp.sh
```
/etc/init.d/startup_script start
```

## Troubleshooting

Error message: ERROR:  external table gphdfs protocol command ended with error. Error: A JNI error has occurred, please check your installation and try again  (seg0 slice1 172.20.0.2:40000 pid=1758)
DETAIL:

Exception in thread "main" java.lang.NoClassDefFoundError: org/apache/hadoop/mapreduce/TaskAttemptContext
	at java.lang.Class.getDeclaredMethods0(Native Method)
	at java.lang.Class.privateGetDeclaredMethods(Class.java:2701)
	at java.lang.Class.privateGetMethodRecursive(Class.java:3048)
	at java.lang.Class.getMethod0(Class.java:3018)
	at java.lang.Class.getMethod(Class.java:1784)
	at sun.launcher.LauncherHelper.validateMain
Command: execute:source $GPHOME/lib//hadoop/hadoop_env.sh;java $GP_JAVA_OPT -classpath $CLASSPATH com.emc.greenplum.gpdb.hdfsconnector.HDFSReader $GP_SEGMENT_ID $GP_SEGMENT_COUNT TEXT hdp-gnet-1.2.0.0 'gphdfs://sandbox.hortonworks.com:8020/data/pxf_examples/pxf_hdfs_simple.txt' '000000002500044000000002500044000000002300044000000070100044' 'location,month,num_orders,total_sales,'
External table pxf_hdfs_textsimple, file gphdfs://sandbox.hortonworks.com:8020/data/pxf_examples/pxf_hdfs_simple.txt
