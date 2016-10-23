FROM ubuntu:14.04
MAINTAINER Mikko Piuhola <mikko.piuhola@gmail.com>

#
# Base container
#

# Helper env variables
ENV SWIFT_BRANCH swift-3.0-release
ENV SWIFT_VERSION swift-3.0-RELEASE
ENV SWIFT_PLATFORM ubuntu14.04
ENV SWIFT_ARCHIVE_NAME $SWIFT_VERSION-$SWIFT_PLATFORM

# Install dependencies
RUN apt-get update \
 && apt-get install -y build-essential libedit-dev wget clang libicu-dev libicu52 libxml2 curl \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Download and install the Swift package.
# Install Swift PGP keys
RUN wget -q -O - https://swift.org/keys/all-keys.asc | \
  gpg --import - \
  && gpg --keyserver hkp://pool.sks-keyservers.net --refresh-keys Swift

# Download, verify and install the Swift package.
RUN SWIFT_URL=https://swift.org/builds/$SWIFT_BRANCH/$(echo "$SWIFT_PLATFORM" | tr -d .)/$SWIFT_VERSION/$SWIFT_ARCHIVE_NAME.tar.gz \
 && wget $SWIFT_URL \
 && wget $SWIFT_URL.sig
RUN gpg --verify $SWIFT_ARCHIVE_NAME.tar.gz.sig
RUN tar -xvzf $SWIFT_ARCHIVE_NAME.tar.gz --directory / --strip-components=1 \
 && rm -rf $SWIFT_ARCHIVE_NAME* /tmp/* /var/tmp/*

# Clean out non-runtime dependencies
RUN apt-get remove -y wget

# Swift path
ENV PATH /usr/bin:$PATH

#
# Application specifics
#

# Add source code
RUN mkdir /app
WORKDIR /app
ADD Package.swift ./
ADD Sources ./

# Build it
RUN swift build

CMD .build/debug/RockPaperScissors
