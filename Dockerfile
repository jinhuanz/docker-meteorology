FROM ubuntu:16.04

# Install script dependance avaible on apt source
RUN /bin/bash -c "apt-get update && apt-get install -y --allow-unauthenticated \
                wget \
                zip \
                bzip2 \
                vim \
                gcc \
                g++ \
                gfortran \
                build-essential && \

                wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/Miniconda3-latest-Linux-x86_64.sh && \
                rm -rf /root/miniconda3 && \
                bash /tmp/Miniconda3-latest-Linux-x86_64.sh  -b && \
                export PATH="/root/miniconda3/bin/:$PATH" && \
                rm  -rf /tmp/Miniconda3-latest-Linux-x86_64.sh && \

                conda create -y -n py_meteo \
                                   pymysql sqlalchemy \
                                   requests \
                                   BeautifulSoup4 && \
                source activate py_meteo && \
                conda install -y -c conda-forge cdo && \
                conda install -y -c conda-forge nco && \
                conda install -y -c conda-forge wgrib2 && \
                conda install -y -c eumetsat wgrib && \
                conda install -y -c conda-forge gdal && \
                conda install -y -c conda-forge iris && \
                source deactivate && \

                apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* "

WORKDIR /opt/
VOLUME /opt/
