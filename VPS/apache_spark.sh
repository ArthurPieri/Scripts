#! /bin/bash
#
# /HEADER/
# Install Apache Spark
# This script is currently on v1
# Author: Arthur Pieri
# Tutorial: https://computingforgeeks.com/how-to-install-apache-spark-on-ubuntu-debian/

echo "Download and install Java, scala and Git"
    sudo apt install default-jdk scala git tar -y
echo "Testing versions"
    java -version; javac -version; scala -version; git --version
echo "Getting the files"
    wget https://dlcdn.apache.org/spark/spark-3.0.3/spark-3.0.3-bin-hadoop2.7.tgz
echo "Unpacking"
    tar -zxvf spark-3.0.3-bin-hadoop2.7/
echo "Creating folder ando moving spark into it"
    cd spark-3.0.3-bin-hadoop2.7/
    sudo mkdir /opt/spark
    sudo chmod +rwx /opt/spark
    mv * /opt/spark
echo "Setting up the variables"
    echo "export SPARK_HOME=/opt/spark" >> ~/.bashrc
    echo "export PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin" >> ~/.bashrc
    echo "export PYSPARK_PYTHON=/usr/bin/python3" >> ~/.bashrc


