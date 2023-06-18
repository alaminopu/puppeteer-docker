FROM node:16-bullseye-slim

ENV DEBIAN_FRONTEND noninteractive


# default arch to amd64
ARG ARCH=amd64


# Install latest chromium dev package and fonts to support major charsets (Chinese, Japanese, Arabic, Hebrew, Thai and a few others)
# Note: this installs the necessary libs to make the bundled version of Chromium that Puppeteer installs, work.
RUN apt-get update \
    && apt-get install -y wget gnupg libxshmfence1 libglu1 libxrender1 \
    && apt-get update \
    && apt-get install -y chromium fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-kacst fonts-freefont-ttf libxss1 \
      xfonts-75dpi xfonts-base libgtk2.0-0 ca-certificates fonts-liberation libappindicator3-1 libasound2 libatk-bridge2.0-0 libatk1.0-0 \
      libc6 libcairo2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgbm1 libgcc1 libglib2.0-0 libgtk-3-0 libnspr4 libnss3 libpango-1.0-0 \
      libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 \
      libdrm2 libxkbcommon0 \
      libxrender1 libxss1 libxtst6 lsb-release wget xdg-utils \
      --no-install-recommends

# install dumb-init
ADD https://github.com/Yelp/dumb-init/releases/download/v1.2.2/dumb-init_1.2.2_x86_64 /usr/local/bin/dumb-init
RUN chmod +x /usr/local/bin/dumb-init
ENTRYPOINT ["dumb-init", "--"]

# Install wkhtmltopdf and wkhtmltoimage.
# More details here: https://wkhtmltopdf.org/downloads.html
RUN wget https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6.1-2/wkhtmltox_0.12.6.1-2.bullseye_$ARCH.deb && \
    dpkg -i wkhtmltox_0.12.6.1-2.bullseye_$ARCH.deb

