#!/bin/bash

# 命令只执行最后一个,所以用 &&
python manage.py collectstatic --noinput &&
python manage.py makemigrations &&
python manage.py migrate &&
#echo "from django.contrib.auth import get_user_model; User = get_user_model(); User.objects.create_superuser('admin', 'admin@example.com', 'yuyuan123')" | python manage.py shell &&
uwsgi --yaml /uwsgi-django/uwsgi.yaml
