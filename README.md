# docker-meteorology
ubuntu with cdo, wgrib, python-netcdf, python-grib, python-gdal installed for meteorology data analysis
    docker pull jinhuanz/docker-meteorology

# Usage:

## build image

```:bash
git clone https://github.com/jinhuanz/docker-meteorology.git
docker build jinhuanz/docker-meteorology
```

## then run it with mounting the data folder
* code or data injection by docker volumn
* tools or library using by docker run command

```:bash
docker run -ti -v /mydata:/opt jinhuanz/docker-meteorology gdal_translate -of ENVI <input_filename.nc> <output_filename>
```

# Contents:
    wgrib2, cdo, netcdf, ncl, pygrib, pandas, matplotlib ... ...
