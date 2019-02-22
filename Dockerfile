#
# Statsd Dockerfile
#
# https://github.com/
#

# Pull base image.
FROM debian:latest

MAINTAINER hihouhou < hihouhou@hihouhou.com >

ENV STATSD_VERSION v0.8.0

# Update & install packages for fetching statsd
RUN apt-get update && \
    apt-get install -y git

#fetch last version of nodejs
RUN curl -sL https://deb.nodesource.com/setup_7.x | bash -

# Update & install packages for installing statsd
RUN apt-get update && \
    apt-get install -y git nodejs nodejs-legacy

# Fetch statsd
RUN git clone https://github.com/etsy/statsd.git

#Configure statsd
COPY exampleConfig.js /statsd/exampleConfig.js
WORKDIR /statsd

EXPOSE 8125

# Run statsd
CMD ["node", "stats.js", "exampleConfig.js"]
