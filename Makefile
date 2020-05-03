DOCKER_NETWORK = hadoop-cluster_default
ENV_FILE = hadoop.env

sparkjars:
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} myaiops/hadoopbase:latest hdfs dfs -mkdir -p /user/spark/share/lib/
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} myaiops/spark:latest hdfs dfs -put /opt/spark*/jars/*.jar /user/spark/share/lib

mpwordcount:
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} myaiops/hadoopbase:latest hdfs dfs -mkdir -p /input/
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} -v /Users/Abhinav_Kumar/bigdata/hadoop-cluster/job:/tmp/job myaiops/hadoopbase:latest hdfs dfs -copyFromLocal -f /tmp/job/test.txt /input/
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} -v /Users/Abhinav_Kumar/bigdata/hadoop-cluster/job:/tmp/job  myaiops/hadoopbase:latest  /opt/hadoop-3.2.1/bin/hadoop jar /tmp/job/WordCount.jar  WordCount /input /output 
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} myaiops/hadoopbase:latest hdfs dfs -cat /output/*
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} myaiops/hadoopbase:latest hdfs dfs -rm -r /output
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} myaiops/hadoopbase:latest hdfs dfs -rm -r /input

sparkcodeclient:
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} myaiops/hadoopbase:latest hdfs dfs -mkdir -p /input/
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} -v /Users/Abhinav_Kumar/bigdata/hadoop-cluster/job:/tmp/job myaiops/hadoopbase:latest hdfs dfs -copyFromLocal -f /tmp/job/test.txt /input/
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} -v /Users/Abhinav_Kumar/bigdata/hadoop-cluster/job:/tmp/job myaiops/spark:latest spark-submit --deploy-mode client --class org.apache.spark.examples.SparkPi /opt/spark-3.0.0-preview2-bin-hadoop3.2/examples/jars/spark-examples_2.12-3.0.0-preview2.jar 
sparkcodecluster:
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} myaiops/hadoopbase:latest hdfs dfs -mkdir -p /input/
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} -v /Users/Abhinav_Kumar/bigdata/hadoop-cluster/job:/tmp/job myaiops/hadoopbase:latest hdfs dfs -copyFromLocal -f /tmp/job/test.txt /input/
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} -v /Users/Abhinav_Kumar/bigdata/hadoop-cluster/job:/tmp/job myaiops/spark:latest spark-submit --deploy-mode cluster --class org.apache.spark.examples.SparkPi /opt/spark-3.0.0-preview2-bin-hadoop3.2/examples/jars/spark-examples_2.12-3.0.0-preview2.jar 
