FROM rocker/r-base:4.2.1

RUN apt-get update && apt-get install -y --no-install-recommends \
    sudo \
    libcurl4-openssl-dev \
    libssl-dev \
    libssh2-1-dev \
    libxml2-dev \
    && rm -rf /var/lib/apt/lists/*

RUN addgroup --system crisprverse \
    && adduser --system --ingroup crisprverse crisprverse \
    && mkdir -p /home/crisprverse/usr/local/lib/R/site-library \ 
    && mkdir /home/crisprverse/tmp \
    && mkdir /home/crisprverse/disk

WORKDIR /home/crisprverse

ENV BASILISK_USE_SYSTEM_DIR=1

RUN chown crisprverse:crisprverse -R /home/crisprverse

RUN echo "TMPDIR=/home/crisprverse/tmp" > /home/crisprverse/.Renviron 

RUN R -e ".libPaths(c('/home/crisprverse/usr/local/lib/R/site-library', .libPaths())); install.packages(c('devtools', 'remotes', 'curl', 'RCurl', 'openssl', 'httr', 'graphics', 'knitr', 'methods', 'randomForest', 'readr', 'reticulate', 'rmarkdown', 'stats', 'stringr', 'testthat', 'utils', 'XML', 'restfulr'), dependencies=TRUE, repos='http://cloud.r-project.org/', lib='/home/crisprverse/usr/local/lib/R/site-library')"

RUN R -e ".libPaths(c('/home/crisprverse/usr/local/lib/R/site-library', .libPaths())); install.packages('BiocManager', dependencies=TRUE, repos='http://cloud.r-project.org/', lib='/home/crisprverse/usr/local/lib/R/site-library')"

RUN R -e ".libPaths(c('/home/crisprverse/usr/local/lib/R/site-library', .libPaths())); BiocManager::install(c('AnnotationHub', 'BiocGenerics', 'BiocStyle', 'Biostrings', 'ExperimentHub', 'GenomeInfoDb', 'GenomicRanges', 'IRanges', 'Rbowtie', 'S4Vectors', 'XVector', 'rtracklayer', 'BSgenome', 'BSgenome.Hsapiens.UCSC.hg38'))"

RUN R -e ".libPaths(c('/home/crisprverse/usr/local/lib/R/site-library', .libPaths())); remotes::install_github('LTLA/basilisk', ref='master'); remotes::install_github('LTLA/basilisk.utils', ref='master'); remotes::install_github('crisprVerse/crisprBase', ref='master'); remotes::install_github('crisprVerse/crisprBowtie', ref='master'); remotes::install_github('crisprVerse/crisprScoreData', ref='master'); remotes::install_github('crisprVerse/crisprScore', ref='master'); remotes::install_github('crisprVerse/Rbwa', ref='master'); remotes::install_github('crisprVerse/crisprBwa', ref='master'); remotes::install_github('crisprVerse/crisprDesign', ref='master'); remotes::install_github('crisprVerse/crisprDesignData', ref='master'); remotes::install_github('crisprVerse/crisprViz', ref='master'); remotes::install_github('crisprVerse/crisprVerse', ref='main')"

ENV R_LIBS_USER=/home/crisprverse/usr/local/lib/R/site-library
