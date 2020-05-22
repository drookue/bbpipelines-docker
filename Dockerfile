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
    apt-utils \
    wget \
    xz-utils \
    ant \
    jq \
    apt-transport-https \
    && mkdir ~/.sfdx-cli \
    && wget -qO- ${CLIURL} | tar xJ -C ~/.sfdx-cli --strip-components 1 \
    && ~/.sfdx-cli/install

# Install the dotnet sdk
#RUN for url in \
#    'https://download.visualstudio.microsoft.com/download/pr/e5e70860-a6d4-48cf-b0d1-eeba32657d80/2da3c605aaa65c7e4ac2ad0507a2e429/dotnet-sdk-3.1.300-linux-arm64.tar.gz' \
#    'https://download.visualstudio.microsoft.com/download/pr/adb3ed49-26af-40a2-8df3-1460b178e55e/01187433dc24decf562d90d4bb2ce058/dotnet-sdk-5.0.100-preview.4.20258.7-linux-arm64.tar.gz'; \
#    do \
#    echo "Downloading and installing from $url" \
#    && curl -SL $url --output /tmp/dotnet.tar.gz \
#    && mkdir -p /usr/share/dotnet \
#    && tar -zxf /tmp/dotnet.tar.gz -C /usr/share/dotnet \
#    && rm /tmp/dotnet.tar.gz; \
#    done

RUN apt-get autoremove --assume-yes \
    && apt-get clean --assume-yes \
    && rm -rf /var/lib/apt/lists/*