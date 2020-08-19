
### R api server


api_server.R => main of this project
api_test.R => api function

just run api_server.R

you can test api on localhost/"api_address"


## Docker setting with own plumber.R
# docker run --name "name" -p "port:port"-v `pwd`/plumber.R:/plumber.R rstudio/plumber /plumber.R

ex) docker run --name plumber_api -p 8000:8000 -v `pwd`/api_test.R:/plumber.R rstudio/plumber /plumber.R

## Docker r-base set
docker run -ti --name r-base -p 8787:8787 r-base
