# docker-meteorology
ubuntu with cdo, wgrib, python-netcdf, python-grib, python-gdal installed for meteorology data analysis
    docker pull jinhuanz/docker-meteorology

# Usage:
## build Dockerfile
    docker build jinhuanz/docker-meteorology
## then run it with mounting the data folder
    docker run -ti -v /mydata:/opt jinhuanz/docker-meteorology /bin/bash

# contents:
     wgrib2, cdo, netcdf, ncl, pygrib, pandas, matplotlib ... ...
