### uwsgi部署

docker build . -t uwsgi-http:release
docker run -p 8001:8001 -d uwsgi-http:release

docker build . -t uwsgi-http-socket:release
docker run -p 8002:8001 -d uwsgi-http-socket:release

docker build . -t uwsgi-socket:release
docker run -p 8003:8001 -d uwsgi-socket:release
