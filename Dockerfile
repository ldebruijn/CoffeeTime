### Builder stage
FROM elixir:alpine AS builder

# Copy the source folder into the Docker image
COPY . /srv/app/coffeetime

# Set working dir
WORKDIR /srv/app/coffeetime

# Configure required environment
ENV MIX_ENV prod

# Install dependencies and build Release
RUN rm -rf _build && \
    mix local.hex --force && \
    mix local.rebar --force && \
    mix deps.get --only prod && \
    mix release

### Deployment stage
FROM elixir:alpine

# Set working dir
WORKDIR /srv/app/coffeetime

# Copy and extract .tar.gz Release file from the previous stage
COPY --from=builder /srv/app/coffeetime/_build/prod/rel/coffeetime/bin/coffeetime .

# Change user
USER default

# Set default entrypoint and command
ENTRYPOINT ["/opt/app/bin/MY_APP_NAME"]
CMD ["foreground"]