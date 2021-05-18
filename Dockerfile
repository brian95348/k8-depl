FROM python
RUN apt-get update && apt-get upgrade -y &&\
      apt-get --yes --force-yes install python3-dev libpq-dev
SHELL ["/bin/bash", "-c"]
RUN mkdir  /code /staticdir
COPY . /code/
WORKDIR /code/chatproject/
RUN mv /code/django_config.json /etc && python -m pip install --upgrade pip &&\        
      pip install virtualenv && virtualenv ./venv && source ./venv/bin/activate &&\
        pip install -r requirements.txt 
ENV DJANGO_SETTINGS_MODULE=chatproject.settings
CMD source ./venv/bin/activate && export PYTHONPATH=$PYTHONPATH:/code/chatproject/ &&\
      python manage.py makemigrations && python manage.py migrate &&\
        gunicorn chatproject.asgi:application -w 4 -k uvicorn.workers.UvicornWorker
