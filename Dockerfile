FROM ubuntu:16.04

# Install script dependance avaible on apt source
RUN /bin/bash -c "apt-get update && apt-get install -y --allow-unauthenticated \
                wget \
                zip \
                bzip2 \
                vim \
                gcc \
                g++ \
                gfortran && \

                wget https://code.mpimet.mpg.de/attachments/download/17374/cdo-1.9.4.tar.gz -O /tmp/cdo.tar.gz && \
                cd /tmp && \
                mkdir -p cdo && \
                tar -xvf cdo.tar.gz -C ./cdo  && \
                cd cdo/cdo* && \
                ./configure && \
                make && make install && \
                cd ../.. && \
                rm -r cdo* && \
                
                wget https://confluence.ecmwf.int/download/attachments/3473437/grib_api-1.27.0-Source.tar.gz?api=v2 -O /tmp/gribapi.tar.gz && \
                cd /tmp && \
                mkdir -p gribapi && \
                tar -xvf gribapi.tar.gz  -C ./gribapi && \
                cd ./gribapi/grib_api* && \
                /configure && \
                make && make check &&  make install && \
                cd ../.. && \
                rm -r cdo* && \

                apt-get -y autoremove build-essential && \
                apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* "


WORKDIR /opt/
VOLUME /opt/
