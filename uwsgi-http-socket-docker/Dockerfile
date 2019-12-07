FROM python:3.7.4
ENV PYTHONUNBUFFERED 1

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
    git \
    supervisor \
	nginx \
    net-tools \
    vim \
    tcpdump \
    sqlite3 && \
   rm -rf /var/lib/apt/lists/*

COPY supervisord.conf /etc/supervisor/supervisord.conf
COPY supervisor-app.conf /etc/supervisor/conf.d/

RUN mkdir /uwsgi-http

# 设置工作目录
WORKDIR /uwsgi-http

# 将当前目录加入到工作目录中
ADD ./uwsgi-http /uwsgi-http
RUN pip install -i http://pypi.douban.com/simple --trusted-host pypi.douban.com --upgrade pip
RUN pip install -i http://pypi.douban.com/simple --trusted-host pypi.douban.com -r requirements.txt

COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY nginx/nginx-app.conf /etc/nginx/sites-available/
# /etc/nginx/sites-available/default
# 注释listen [::]:80 default_server;
# 覆盖文件/etc/nginx/sites-available/default
COPY nginx/default /etc/nginx/sites-available/default

# 设置环境变量
ENV TZ=Asia/Shanghai

# 对外暴露端口
EXPOSE 8001

CMD ["supervisord", "-n"]
