### Builder stage
FROM arm32v7/elixir:alpine AS builder

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
FROM arm32v7/elixir:alpine

# Set working dir
WORKDIR /srv/app/coffeetime

# Copy and extract .tar.gz Release file from the previous stage
COPY --from=builder /srv/app/coffeetime/_build/prod/rel/coffeetime .

CMD ["bin/coffeetime", "start"]