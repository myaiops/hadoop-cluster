DOCKER_NETWORK = hadoop-cluster_default
ENV_FILE = hadoop.env


wordcount:
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} myaiops/hadoopbase:latest hdfs dfs -mkdir -p /input/
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} -v /Users/Abhinav_Kumar/bigdata/hadoop-cluster/job:/tmp/job myaiops/hadoopbase:latest hdfs dfs -copyFromLocal -f /tmp/job/test.txt /input/
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} -v /Users/Abhinav_Kumar/bigdata/hadoop-cluster/job:/tmp/job  myaiops/hadoopbase:latest  /opt/hadoop-3.2.1/bin/hadoop jar /tmp/job/WordCount.jar  WordCount /input /output 
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} myaiops/hadoopbase:latest hdfs dfs -cat /output/*
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} myaiops/hadoopbase:latest hdfs dfs -rm -r /output
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} myaiops/hadoopbase:latest hdfs dfs -rm -r /input
