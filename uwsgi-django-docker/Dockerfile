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

RUN mkdir /uwsgi-django

# 设置工作目录
WORKDIR /uwsgi-django

# 将当前目录加入到工作目录中
ADD ./uwsgi-django /uwsgi-django
RUN pip install -i http://pypi.douban.com/simple --trusted-host pypi.douban.com --upgrade pip
RUN pip install -i http://pypi.douban.com/simple --trusted-host pypi.douban.com -r requirements.txt

# 设置环境变量
ENV TZ=Asia/Shanghai

# django 初始化脚本
RUN chmod +x /uwsgi-django/mysite/start.sh

# 对外暴露端口
EXPOSE 8001

CMD ["supervisord", "-n"]
