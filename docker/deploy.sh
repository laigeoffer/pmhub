#!/bin/sh

# 使用说明，用来提示输入参数
usage() {
	echo "Usage: sh deploy.sh [port|base|modules|stop|rm]"
	exit 1
}

# 开启所需端口（服务器是centos系统）
#port(){
#  # Nginx
#	firewall-cmd --add-port=80/tcp --permanent
#	# Gateway
#	firewall-cmd --add-port=6880/tcp --permanent
#	# Auth
#	firewall-cmd --add-port=6800/tcp --permanent
#	# System
#	firewall-cmd --add-port=6801/tcp --permanent
#	# gen
#	firewall-cmd --add-port=6802/tcp --permanent
#	# job
#	firewall-cmd --add-port=6803/tcp --permanent
#	# project
#	firewall-cmd --add-port=6806/tcp --permanent
#	# workflow
#	firewall-cmd --add-port=6808/tcp --permanent
#	# monitor
#	firewall-cmd --add-port=6888/tcp --permanent
#	# MySQL
#	firewall-cmd --add-port=33706/tcp --permanent
#	# Redis
#	firewall-cmd --add-port=6379/tcp --permanent
#	# Nacos
#	firewall-cmd --add-port=8848/tcp --permanent
#	firewall-cmd --add-port=9848/tcp --permanent
#	firewall-cmd --add-port=9849/tcp --permanent
#	service firewalld restart
#}

# 开启所需端口（服务器是Debian系统）
port(){
  # Nginx
	ufw allow 80/tcp
	# Gateway
	ufw allow 6880/tcp
	# Auth
	ufw allow 6800/tcp
	# System
	ufw allow 6801/tcp
	# gen
	ufw allow 6802/tcp
	# job
	ufw allow 6803/tcp
	# project
	ufw allow 6806/tcp
	# workflow
	ufw allow 6808/tcp
	# monitor
	ufw allow 6888/tcp
	# MySQL
	ufw allow 33706/tcp
	# Redis
	ufw allow 6379/tcp
	# Nacos
	ufw allow 8848/tcp
	ufw allow 9848/tcp
	ufw allow 9849/tcp

	# 重启防火墙
	service ufw restart

	# 必须：在云后台开启安全组对应端口
}


# 启动基础环境（必须）
base(){
	docker-compose up -d pmhub-mysql pmhub-redis pmhub-nacos
}


# 启动重要服务（必须）
important(){
  docker-compose up -d pmhub-gateway pmhub-auth
}


# 启动程序模块（必须）
modules(){
	docker-compose up -d pmhub-system pmhub-project pmhub-workflow
}

# 启动不重要服务（非必须）
unimportant(){
  docker-compose up -d pmhub-gen pmhub-job pmhub-monitor
}

# 关闭所有环境/模块
stop(){
	docker-compose stop
}

# 重新构建镜像
build(){
  docker-compose up --build -d
}

# 删除所有环境/模块
rm(){
	docker-compose rm
}

# 根据输入参数，选择执行对应方法，不输入则执行使用说明
case "$1" in
"port")
	port
;;
"base")
	base
;;
"important")
  important
;;
"modules")
	modules
;;
"unimportant")
  unimportant
;;
"stop")
	stop
;;
"stop")
	build
;;
"rm")
	rm
;;
*)
	usage
;;
esac
