#!/bin/sh

# 复制项目的文件到对应docker路径，便于一键生成镜像。
usage() {
	echo "Usage: sh copy.sh"
	exit 1
}


# copy sql
echo "begin copy sql "
cp ../sql/pmhub_20240305.sql ./mysql/db
cp ../sql/pmhub_nacos_20240423.sql ./mysql/db

# copy html
echo "begin copy html "
cp -r ../pmhub-ui/dist/** ./nginx/html/dist


# copy jar
echo "begin copy pmhub-gateway "
cp ../pmhub-gateway/target/pmhub-gateway.jar ./pmhub/gateway/jar

echo "begin copy pmhub-auth "
cp ../pmhub-auth/target/pmhub-auth.jar ./pmhub/auth/jar

echo "begin copy pmhub-monitor "
cp ../pmhub-monitor/target/pmhub-monitor.jar  ./pmhub/monitor/jar

echo "begin copy pmhub-system "
cp ../pmhub-modules/pmhub-system/target/pmhub-system.jar ./pmhub/modules/system/jar

echo "begin copy pmhub-job "
cp ../pmhub-modules/pmhub-job/target/pmhub-job.jar ./pmhub/modules/job/jar

echo "begin copy pmhub-gen "
cp ../pmhub-modules/pmhub-gen/target/pmhub-gen.jar ./pmhub/modules/gen/jar

echo "begin copy pmhub-project "
cp ../pmhub-modules/pmhub-project/target/pmhub-project.jar ./pmhub/modules/project/jar

echo "begin copy pmhub-workflow "
cp ../pmhub-modules/pmhub-workflow/target/pmhub-workflow.jar ./pmhub/modules/workflow/jar

