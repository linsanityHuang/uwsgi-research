### uwsgi部署

从事Python web开发的朋友都知道uWSGI，想必也用uWSGI部署过web项目。可能都注意到uWSGI提供的若干部署选项，其中有三个选项
--http、--socket和--http-socket。如果没有仔细阅读其文档还真容易把它们给搞混。

#### --http
官方文档中有这么一句话来介绍在何种情况下使用此选项
```
If you plan to expose your app to the world with uWSGI only, use the http option instead, 
as the router/proxy/load-balancer will then be your shield.
```
如果你打算只用uWSGI来接收客户端发送过来的请求的话，就可以使用这个选项。
一般情况下我们会在web容器前在加一个HTTP服务器或者反向代理服务器，
但是如果你打算直接裸跑uWSGI的话，那就可以使用--http这个选项来部署你的web应用。

如果你打算把uWSGI放在完整的HTTP服务器（比如Nginx）之后，你有两种选择，--socket和--http-socket。
这取决于你的HTTP服务器使用何种协议与uWSGI沟通。下文中以Nginx为例

#### --socket
如果你的Nginx使用uwsgi协议与uWSGI沟通的话，即如下配置
```
location / {
    include uwsgi_params;
    uwsgi_pass 127.0.0.1:3031;
}
```
上面的指令所表示的就是如果Nginx接收到请求后，会把请求以uwsgi协议发送给uWSGI。

#### --http-socket
但是如果你的Nginx使用HTTP协议与uWSGI沟通的话，即如下配置
```
location / {
    include /etc/nginx/proxy_params;
    proxy_pass http://127.0.0.1:3031;
}
```
上面的指令所表示的就是如果Nginx接收到请求后，会把请求以HTTP协议发送给uWSGI。

为什么会有uwsgi协议，因为对uWSGI来说，这个协议处理起来比HTTP协议快。

展示了uwsgi的三种部署方式

#### uwsgi-http
```
docker build . -t uwsgi-http:release
docker run -p 8001:8001 -d uwsgi-http:release
```
#### uWSGI-http-socket
```
docker build . -t uwsgi-http-socket:release
docker run -p 8002:8001 -d uwsgi-http-socket:release
```
#### uWSGI-socket
```
docker build . -t uwsgi-socket:release
docker run -p 8003:8001 -d uwsgi-socket:release
```

#### uWSGI-Flask
```
docker build . -t uwsgi-flask:release
docker run -p 8004:8001 -d uwsgi-flask:release
```

#### uWSGI-Django
```
docker build . -t uwsgi-django:release
docker run -p 8005:8001 -d uwsgi-django:release
```