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

                wget ftp://ftp.cpc.ncep.noaa.gov/wd51we/wgrib2/wgrib2.tgz -O /tmp/wgrib2.tgz && \
                mkdir -p /usr/local/grib2/ && \
                cd /tmp/ && \
                tar -xf /tmp/wgrib2.tgz && \
                rm -r /tmp/wgrib2.tgz && \
                mv /tmp/grib2/ /usr/local/grib2/ &&\
                cd /usr/local/grib2/grib2 && \
                make && \
                ln -s /usr/local/grib2/grib2/wgrib2/wgrib2 /usr/local/bin/wgrib2 && \

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
