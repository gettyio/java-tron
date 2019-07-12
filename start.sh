#!/bin/bash
APP=$1
APP=${APP:-"FullNode"}
START_OPT=`echo ${@:2}`
JAR_NAME="$APP.jar"

java -Xmx6g -XX:+UseConcMarkSweepGC -XX:+CMSParallelRemarkEnabled \
  -XX:ReservedCodeCacheSize=256m -XX:+CMSScavengeBeforeRemark \
  -jar $JAR_NAME $START_OPT -c main_net_config.conf