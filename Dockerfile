# Use reference image to start
FROM atlassian/default-image:2

# Setup CLI exports
ENV SFDX_AUTOUPDATE_DISABLE=false \
    SFDX_USE_GENERIC_UNIX_KEYCHAIN=true \
    SFDX_DOMAIN_RETRY=300 \
    SFDX_DISABLE_APP_HUB=true \
    SFDX_LOG_LEVEL=DEBUG \
    TERM=xterm-256color \
    CLIURL=https://developer.salesforce.com/media/salesforce-cli/sfdx-linux-amd64.tar.xz 

# Configure base image
RUN apt-get update && apt-get install --assume-yes \
    wget \
    xz-utils \
    ant \
    jq \
    && mkdir ~/.sfdx-cli \
    && wget -qO- ${CLIURL} | tar xJ -C ~/.sfdx-cli --strip-components 1 \
    && ~/.sfdx-cli/install

RUN apt-get autoremove --assume-yes \
    && apt-get clean --assume-yes \
    && rm -rf /var/lib/apt/lists/*

RUN npm i -g dotnet-3.1
#RUN npm install -g sfdc-generate-package
#RUN npm install -g sfdx-codescan-plugin