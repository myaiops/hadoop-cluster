FROM myaiops/hadoopbase

LABEL maintainer="akumar261089@gmail.com>"

RUN curl -O https://dist.apache.org/repos/dist/release/spark/KEYS

RUN gpg --import KEYS

ENV SPARK_VERSION 3.0.0-preview2
ENV SPARK_HADOOP_VERSION hadoop3.2
ENV SPARK_URL http://apachemirror.wuchna.com/spark/spark-$SPARK_VERSION/spark-$SPARK_VERSION-bin-$SPARK_HADOOP_VERSION.tgz

RUN set -x \
    && curl -fSL "$SPARK_URL" -o /tmp/spark.tar.gz \
#    && curl -fSL "$SPARK_URL.asc" -o /tmp/spark.tar.gz.asc \
#    && gpg --verify /tmp/spark.tar.gz.asc \
    && tar -xvf /tmp/spark.tar.gz -C /opt/ \
    && rm /tmp/spark.tar.gz*


ENV SPARK_HOME=/opt/spark-$SPARK_VERSION-bin-$SPARK_HADOOP_VERSION
ENV PATH $SPARK_HOME/bin/:$PATH


RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      python \
    && rm -rf /var/lib/apt/lists/*

RUN echo  "spark.master    yarn\nspark.yarn.jars hdfs://namenode:9000/user/spark/share/lib/*.jar" > $SPARK_HOME/conf/spark-defaults.conf
