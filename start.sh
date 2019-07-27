#!/bin/bash
START_OPT=`echo ${@:1}`

if [ -z "${JVM_ARGUMENTS}" ]; then
    JVM_ARGUMENTS="-Xmx6g -XX:+UseConcMarkSweepGC -XX:+CMSParallelRemarkEnabled -XX:ReservedCodeCacheSize=256m -XX:+CMSScavengeBeforeRemark"
    echo "Using default JVM arguments: ${JVM_ARGUMENTS}"
fi

echo "Starting with command:\n java ${JVM_ARGUMENTS} -jar FullNode.jar ${START_OPT} -c main_net_config.conf\n"

java $JVM_ARGUMENTS -jar FullNode.jar $START_OPT -c main_net_config.conf