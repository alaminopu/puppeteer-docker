FROM alaminopu/puppeteer-docker:latest

# Add and run everything after as non-privileged user.
RUN useradd --home-dir /opt/hello --create-home --user-group hello
USER hello
WORKDIR /opt/hello

COPY --chown=hello:hello . .

RUN yarn

# Dump init (base image) is used to handle signals and reap zombie processes (we could have zombie chrome processes)
CMD ["yarn", "start"]
