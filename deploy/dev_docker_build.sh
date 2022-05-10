#!/bin/bash

# 模块名称
PROJECT_NAME=$1

#名称空间目录
WORKSPACE="/home/jenkins/workspace"

#模块目录
PROJECT_PATH=$WORKSPACE/dev_$PROJECT_NAME

#选择部署环境
#SPRING_ENV=$2

#dockerfile目录
DOCKERFILE_PATH="/$PROJECT_PATH/dockerfile"


#sed -i "s/VAR_CONTAINER_PORT1/$PROJECT_PORT/g" $PROJECT_PATH/dockerfile
sed -i "s/PROJECT_NAME/$PROJECT_NAME/g" $PROJECT_PATH/dockerfile
sed -i "s/SPRING_ENV/prod/g" $PROJECT_PATH/dockerfile



cd $PROJECT_PATH

#登录阿里云仓库
cat dev_docker_password docker login registry.cn-hangzhou.aliyuncs.com --username 531161805@qq.com --password-stdin

#获取镜像版本号
#count=`cat $WORKSPACE/test_images.log |grep $PROJECT_NAME |tail -1 |awk -F : '{print $4}'`
#image_version=$(($count +1))

BUILD_NUMBER = sh(returnStdout: true,script:'git rev-parse --short')

#构建模块镜像
docker build -t $PROJECT_NAME  .
docker tag $PROJECT_NAME registry.cn-hangzhou.aliyuncs.com/sunbl/sunbl_basic:$BUILD_NUMBER
#推送到阿里云仓库
docker push registry.cn-hangzhou.aliyuncs.com/sunbl/sunbl_basic:$BUILD_NUMBER

#将镜像版本记录日志
#logdate=`date '+%Y-%m-%d %H:%M:%S'`

#echo "${logdate} test_$PROJECT_NAME:$BUILD_NUMBER" >>$WORKSPACE/prod_images.log



