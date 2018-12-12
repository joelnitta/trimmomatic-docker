FROM debian:stretch

MAINTAINER Joel Nitta <joelnitta@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

####################################################################
# Application: Trimmomatic
# Version: 0.38
# Description: A flexible read trimming tool for Illumina NGS data
####################################################################

ENV APPS_HOME=/apps
ENV APP_NAME=Trimmomatic
ENV VERSION=0.38
ENV DEST=$APPS_HOME/$APP_NAME

RUN apt-get update && apt-get install -y \
  default-jre \
  unzip \
  wget \
  && apt-get clean && apt-get purge

RUN mkdir $APPS_HOME

RUN wget http://www.usadellab.org/cms/uploads/supplementary/Trimmomatic/$APP_NAME-$VERSION.zip \
  && unzip $APP_NAME-$VERSION.zip \
  && rm $APP_NAME-$VERSION.zip \
  && mkdir -p $DEST \
  && mv $APP_NAME-$VERSION $DEST/$VERSION \
  && printf '#!/bin/bash\njava -Xmx6g -jar ' > trimmomatic \
  && echo $APPS_HOME/$APP_NAME/$VERSION/trimmomatic-$VERSION.jar' $*' >> trimmomatic \
  && chmod +x trimmomatic \
  && mv trimmomatic /bin

WORKDIR /home

ENTRYPOINT ["trimmomatic"]
