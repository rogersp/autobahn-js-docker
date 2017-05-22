FROM python:2

# autobahn build ref, although seemingly out-of-date/overcomplicated: https://github.com/crossbario/autobahn-js/blob/master/doc/building.md
# autobahn make file, where some of this was inferred: https://github.com/crossbario/autobahn-js/blob/master/Makefile

ENV JAVA_HOME=/usr/lib/jvm/default-java \
    NODE_PATH=/usr/local/lib/node_modules/

# needed to install later version of nodejs... "npm install bufferutil" would not work on older version
# from: https://nodejs.org/en/download/package-manager/
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -

# install node and java jre (for closure compiler?)
RUN apt-get install -y nodejs default-jre

# install python packages
RUN pip install -U scons boto scour taschenmesser

# install node packages
# explicitly say where to install packages, since these locations are required by scons build
RUN npm install --prefix /usr/local/lib \
    browserify \
    nodeunit \
    google-closure-compiler \
    ws \
    when \
    crypto-js \
    tweetnacl \
    msgpack-lite \
    int64-buffer \
    bufferutil \
    utf-8-validate

# clone source and build
RUN cd ~ && git clone https://github.com/rogersp/autobahn-js.git && cd autobahn-js && scons