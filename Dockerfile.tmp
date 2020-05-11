### Deployment stage
FROM elixir:alpine

# Set working dir
WORKDIR /srv/app/coffeetime

COPY /srv/app/coffeetime/_build/prod/rel/coffeetime .

CMD ["bin/coffeetime", "start"]