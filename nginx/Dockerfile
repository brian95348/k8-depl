FROM nginx

WORKDIR /home
COPY . .
RUN mv ./nginx.conf /etc/nginx &&\
      mkdir staticdir 

ENTRYPOINT ["nginx", "-g", "daemon off;"]