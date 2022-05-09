# 镜像来源
FROM registry.cn-hangzhou.aliyuncs.com/sunbl/sunbl_basic

# 拷贝当前目录的应用到镜像
COPY cmd/PROJECT_NAME /application/
COPY configs/app.yaml /application/configs/

# 声明工作目录,不然找不到依赖包，如果有的话
WORKDIR /application

# 声明动态容器卷
VOLUME /application/log

# 指定部署环境
# ENV SPRING_ENV test

# 指定容器需要映射到宿主机器的端口
# 服务端口,后期可以用同一个,映射出去不同端口
# EXPOSE VAR_CONTAINER_PORT1


# 启动命令
# 设置时区
# ENTRYPOINT ["java","-Duser.timezone=Asia/Shanghai","-Djava.security.egd=file:/dev/./urandom"]
CMD ["/application/PROJECT_NAME","-config","/application/configs/app.yaml","-appid","PROJECT_NAME","-log.dir","/application/log","-deploy.env","SPRING_ENV"]