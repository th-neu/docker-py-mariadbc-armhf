# 1. Base image
FROM python:3.10-slim-bullseye

# 2. Copy files

RUN apt-get update

RUN apt-get install git gcc make cmake libssl-dev -y

RUN git clone https://github.com/MariaDB/mariadb-connector-c.git

RUN mkdir build && cd build

RUN cmake ../mariadb-connector-c/ -DCMAKE_INSTALL_PREFIX=/usr

RUN make

RUN make install

RUN touch /etc/ld.so.conf.d/libmariadb.conf

RUN echo "/usr/lib/mariadb/" >> /etc/ld.so.conf.d/libmariadb.conf

#RUN LD_LIBRARY_PATH=/usr/lib/mariadb/

RUN ldconfig

# 3. Install dependencies
#RUN pip install -r /src/requirements.txt

# command to run on container start
#CMD [ "python", "./src/app.py" ] 
