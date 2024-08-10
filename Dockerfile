#
# Statsd Dockerfile
#
# https://github.com/
#

# Pull base image.
FROM debian:latest

LABEL org.opencontainers.image.authors="hihouhou < hihouhou@hihouhou.com >"

ENV STATSD_VERSION v0.10.2

# Update & install packages for fetching statsd
RUN apt-get update && \
    apt-get install -y git curl wget gnupg2

#fetch last version of nodejs
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -

# Update & install packages for installing statsd
RUN apt-get update && \
    apt-get install -y git nodejs

# Fetch statsd
RUN mkdir statsd && \
    cd statsd && \
    wget https://api.github.com/repos/etsy/statsd/tarball/${STATSD_VERSION} -O ${STATSD_VERSION}.tar.gz && \
    tar xf  ${STATSD_VERSION}.tar.gz --strip-components=1

#Configure statsd
COPY exampleConfig.js /statsd/exampleConfig.js
WORKDIR /statsd

EXPOSE 8125

# Run statsd
CMD ["node", "stats.js", "exampleConfig.js"]
