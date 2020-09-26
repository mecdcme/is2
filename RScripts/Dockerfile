FROM rocker/r-base

COPY libraries.R /usr/app/is2/RScripts/libraries.R
COPY Rserv.cfg /usr/app/is2/RScripts/Rserv.cfg
COPY start.R /usr/app/is2/RScripts/start.R
COPY selemix/IS2_selemix.R /usr/app/is2/RScripts/selemix/IS2_selemix.R
WORKDIR /usr/app/is2/RScripts

CMD ["Rscript", "start.R"]
