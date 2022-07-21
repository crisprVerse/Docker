FROM rocker/r-base:4.2.1

RUN apt-get update && apt-get install -y --no-install-recommends \
    sudo \
    libcurl4-openssl-dev \
    libssl-dev \
    libssh2-1-dev \
    libxml2-dev \
    && rm -rf /var/lib/apt/lists/*

RUN addgroup --system crisprdesign \
    && adduser --system --ingroup crisprdesign crisprdesign \
    && mkdir -p /home/crisprdesign/usr/local/lib/R/site-library \ 
    && mkdir /home/crisprdesign/tmp \
    && mkdir /home/crisprdesign/disk

WORKDIR /home/crisprdesign

RUN chown crisprdesign:crisprdesign -R /home/crisprdesign

RUN echo "TMPDIR=/home/crisprdesign/tmp" > /home/crisprdesign/.Renviron 

RUN R -e ".libPaths(c('/home/crisprdesign/usr/local/lib/R/site-library', .libPaths())); install.packages(c('devtools', 'remotes', 'curl', 'RCurl', 'openssl', 'httr', 'graphics', 'knitr', 'methods', 'randomForest', 'readr', 'reticulate', 'rmarkdown', 'stats', 'stringr', 'testthat', 'utils', 'XML', 'restfulr'), dependencies=TRUE, repos='http://cloud.r-project.org/', lib='/home/crisprdesign/usr/local/lib/R/site-library')"

RUN R -e ".libPaths(c('/home/crisprdesign/usr/local/lib/R/site-library', .libPaths())); install.packages('BiocManager', dependencies=TRUE, repos='http://cloud.r-project.org/', lib='/home/crisprdesign/usr/local/lib/R/site-library')"

RUN R -e ".libPaths(c('/home/crisprdesign/usr/local/lib/R/site-library', .libPaths())); BiocManager::install(c('AnnotationHub', 'BiocGenerics', 'BiocStyle', 'Biostrings', 'ExperimentHub', 'GenomeInfoDb', 'GenomicRanges', 'IRanges', 'Rbowtie', 'S4Vectors', 'XVector', 'rtracklayer', 'BSgenome', 'BSgenome.Hsapiens.UCSC.hg38'))"

RUN R -e ".libPaths(c('/home/crisprdesign/usr/local/lib/R/site-library', .libPaths())); remotes::install_github('LTLA/basilisk', ref='master'); remotes::install_github('LTLA/basilisk.utils', ref='master'); remotes::install_github('Jfortin1/crisprBase', ref='master'); remotes::install_github('Jfortin1/crisprBowtie', ref='master'); remotes::install_github('Jfortin1/crisprScoreData', ref='main'); remotes::install_github('Jfortin1/crisprScore', ref='main'); remotes::install_github('Jfortin1/Rbwa', ref='master'); remotes::install_github('Jfortin1/crisprBwa', ref='master'); remotes::install_github('Jfortin1/crisprDesign', ref='master'); remotes::install_github('Jfortin1/crisprDesignData', ref='main')"

ENV R_LIBS_USER=/home/crisprdesign/usr/local/lib/R/site-library