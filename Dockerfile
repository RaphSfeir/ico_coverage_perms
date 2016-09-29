FROM elixir:1.3.2

RUN apt-get upgrade && apt-get update && apt-get install -qy \
	nodejs \
	libwww-perl \
	python2.7 \
	postgresql-client \
	sqlite3 \
	python-pip \
	--no-install-recommends && rm -rf /var/lib/apt/lists/*

ENV VERSION 0.0.1
ENV MIX_HOST 8000
EXPOSE $MIX_HOST

RUN mkdir /phoenixapp
WORKDIR /phoenixapp

RUN pip install --upgrade requests

COPY ./ /phoenixapp

RUN mix local.hex --force
RUN MIX_ENV=prod mix release --env=prod

CMD ["/bin/bash", "start_service.sh", "admin-gateway.pow.tf"]
