FROM ubuntu:16.04

# Install script dependance avaible on apt source
RUN /bin/bash -c "apt-get update && apt-get install -y --allow-unauthenticated \
                wget vim \
                zip bzip2 \
                gcc g++ gfortran \
                build-essential && \
 
                # install miniconda
                wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/Miniconda3-latest-Linux-x86_64.sh && \
                rm -rf /root/miniconda3 && \
                bash /tmp/Miniconda3-latest-Linux-x86_64.sh  -b && \
                export PATH="/root/miniconda3/bin/:$PATH" && \
                rm  -rf /tmp/Miniconda3-latest-Linux-x86_64.sh && \

                # install package for meteorologist
                conda create -y -n py_meteo && \
                source activate py_meteo && \
                conda install -y -c conda-forge iris && \
                conda install -y -c conda-forge cdo && \
                conda install -y -c conda-forge nco && \
                conda install -y -c conda-forge wgrib2 && \
                conda install -y -c eumetsat wgrib && \
                conda install -y -c conda-forge gdal && \
                conda install -y pymysql sqlalchemy requests BeautifulSoup4 && \
                source deactivate && \

                apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* "

WORKDIR /opt/
VOLUME /opt/
