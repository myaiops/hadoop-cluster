# hadoop-cluster
This Repo helps you to setup hadoop yarn cluster on your local system using docker-compose.

##Start hadoop Cluster

<code>make init</code>

<code> docker-compose up </code>

## Run your code on hadoop cluster using map reduce

Copy your jar and data in job dir and make required changes in Makefile and execute

<code> make mpwordcount  </code>

## To run Spark cluster first we need to copy spark jars to HDFS

<code> make sparkjars </code>

## Spark in client mode 

<code>make sparkcodeclient</code>

## Spark in cluster mode 

<code>make sparkcodecluster</code>
