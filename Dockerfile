# 使用 Nginx 的 latest 版本作为基础镜像
FROM nginx:latest

# 维护者信息
LABEL maintainer="mikeylay@126.com"

# 创建存放 SSL 证书的目录结构
RUN mkdir -p /etc/nginx/cert/home-cert

# 将 SSL 证书复制到容器中
COPY nginx/config.d/home-cert/dakkk.top.key /etc/nginx/cert/home-cert/dakkk.top.key
COPY nginx/config.d/home-cert/dakkk.top_bundle.pem /etc/nginx/cert/home-cert/dakkk.top_bundle.pem

# 将 Nginx 配置文件复制到容器中
COPY nginx/config.d/home.conf /etc/nginx/conf.d/home.conf

# 将 dist 目录复制到容器的网页根目录下
COPY dist /usr/share/nginx/html/home

# 对外暴露 80 和 443 端口
EXPOSE 80 443

# 使用 exec 格式启动 Nginx 以优化接收 UNIX 信号
CMD ["nginx", "-g", "daemon off;"]

# 测试