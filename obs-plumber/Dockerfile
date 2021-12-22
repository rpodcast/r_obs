FROM rocker/r-ver:4.1.0
RUN apt-get update && apt-get install -y libcurl4-openssl-dev libicu-dev libsodium-dev libssl-dev make zlib1g-dev && rm -rf /var/lib/apt/lists/*

RUN echo "options(repos = c(CRAN = 'https://cran.rstudio.com/'), download.file.method = 'libcurl', Ncpus = 4)" >> /usr/local/lib/R/etc/Rprofile.site
RUN R -e 'install.packages("remotes")'
RUN Rscript -e 'remotes::install_version("dplyr",upgrade="never", version = "1.0.7")'
RUN Rscript -e 'remotes::install_version("plumber",upgrade="never", version = "1.1.0")'
RUN Rscript -e 'remotes::install_version("glue",upgrade="never", version = "1.5.1")'
RUN Rscript -e 'remotes::install_version("fs",upgrade="never", version = "1.5.2")'
RUN Rscript -e 'remotes::install_version("crul",upgrade="never", version = "1.2.0")'
RUN Rscript -e 'remotes::install_version("stringr",upgrade="never", version = "1.4.0")'

RUN mkdir /app
COPY plumber.R /app
WORKDIR /app

EXPOSE 1030
ENTRYPOINT ["R", "-e", \
    "r = plumber::plumb('/app/plumber.R'); r$run(port = 1030, host = '0.0.0.0')"]
