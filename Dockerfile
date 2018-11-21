FROM ubuntu:16.04

LABEL Author="Jinhuan Zhu"
LABEL Description="Ubuntu docker with CDO, wgrib2, python-gdal, python-netcdf, python-grib installed for meteorology data analysis"

RUN apt-get update && apt-get install -y --allow-unauthenticated wget vim zip bzip2 gcc g++ gfortran build-essential && apt-get clean

RUN wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/Miniconda3-latest-Linux-x86_64.sh && \
    rm -rf /root/miniconda3 && \
    /bin/bash /tmp/Miniconda3-latest-Linux-x86_64.sh -b && \
    rm  -rf /tmp/Miniconda3-latest-Linux-x86_64.sh

ENV PATH="/root/miniconda3/bin/:$PATH"

RUN /bin/bash -c "conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge/ && \
    conda config --set show_channel_urls yes && \
    conda config --set ssl_verify no && \
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
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* "

WORKDIR /opt/

VOLUME /opt/

CMD /bin/sh --help

# RUN /bin/bash -c "apt-get update && apt-get install -y --allow-unauthenticated \
#                 wget vim \
#                 zip bzip2 \
#                 gcc g++ gfortran \
#                 build-essential && \
 
#                 # install miniconda
#                 wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/Miniconda3-latest-Linux-x86_64.sh && \
#                 rm -rf /root/miniconda3 && \
#                 bash /tmp/Miniconda3-latest-Linux-x86_64.sh  -b && \
#                 export PATH="/root/miniconda3/bin/:$PATH" && \
#                 rm  -rf /tmp/Miniconda3-latest-Linux-x86_64.sh && \

#                 # install package for meteorologist
#                 conda create -y -n py_meteo && \
#                 source activate py_meteo && \
#                 conda install -y -c conda-forge iris && \
#                 conda install -y -c conda-forge cdo && \
#                 conda install -y -c conda-forge nco && \
#                 conda install -y -c conda-forge wgrib2 && \
#                 conda install -y -c eumetsat wgrib && \
#                 conda install -y -c conda-forge gdal && \
#                 conda install -y pymysql sqlalchemy requests BeautifulSoup4 && \
#                 source deactivate && \

#                 apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* "
# ENV PATH="/root/miniconda3/bin/:$PATH"

