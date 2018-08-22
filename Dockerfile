FROM ubuntu:16.06

# Install script dependance avaible on apt source
RUN /bin/bash -c "apt-get update && apt-get install -y --allow-unauthenticated \
                wget \
                zip \
                bzip2 \
                vim \
                gcc \
                g++ \
                gfortran \
                tesseract-ocr \
                build-essential && \

                wget ftp://ftp.cpc.ncep.noaa.gov/wd51we/wgrib2/wgrib2.tgz.v2.0.4 -O /tmp/wgrib2.tgz && \
                mkdir -p /usr/local/grib2/ && \
                cd /tmp/ && \
                tar -xf /tmp/wgrib2.tgz && \
                rm -r /tmp/wgrib2.tgz && \
                mv /tmp/grib2/ /usr/local/grib2/ &&\
                cd /usr/local/grib2/grib2 && \
                make && \
                ln -s /usr/local/grib2/grib2/wgrib2/wgrib2 /usr/local/bin/wgrib2 && \

                wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/Miniconda3-latest-Linux-x86_64.sh && \
                rm -rf /root/miniconda3 && \
                bash /tmp/Miniconda3-latest-Linux-x86_64.sh  -b && \
                export PATH="/root/miniconda3/bin/:$PATH" && \
                rm  -rf /tmp/Miniconda3-latest-Linux-x86_64.sh && \
                conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/ && \
                conda config --set show_channel_urls yes && \
                conda create -y -n py35_gdal python=3.5 gdal pandas basemap matplotlib pymysql sqlalchemy && \
                conda create -y -n py_downloader pandas basemap matplotlib pymysql sqlalchemy && \
                source activate py_downloader && \
                conda install -y pillow \
                                 pandas \
                                 requests \
                                 BeautifulSoup4 && \
                pip install pytesseract &&\
                source deactivate py_downloader && \
                conda create -y -n py_nc_grib python=3 numpy hdf4 hdf5 netcdf4 pandas basemap matplotlib pymysql sqlalchemy &&\
                source activate py_nc_grib  &&\
                conda install -y -c conda-forge pygrib &&\
                conda install -y -c conda-forge ncl && \
                source deactivate py_nc_grib  &&\

                wget https://code.zmaw.de/attachments/download/14387/cdo-current.tar.gz -O /tmp/cdo-current.tar.gz && \
                cd /tmp && \
                mkdir -p cdo && \
                tar -xvf cdo-current.tar.gz -C ./cdo  && \
                cd cdo/cdo* && \
                ./configure && \
                make && make install && \
                cd ../.. && \
                rm -r cdo* && \

                apt-get -y autoremove build-essential && \
                apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* "


WORKDIR /opt/
VOLUME /opt/
