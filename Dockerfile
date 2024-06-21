FROM python:3.11-alpine AS base
COPY ./pyproject.toml ./
RUN apk add --no-cache --update build-base git python3-dev
RUN pip install poetry
RUN poetry config virtualenvs.create false
RUN poetry install --no-dev

FROM python:3.11-alpine
ARG APP_VERSION
ENV APP_VERSION=${APP_VERSION}
LABEL MAINTAINER=Silen-Mobius VERSION=${APP_VERSION}
WORKDIR /home/app
RUN apk add git
COPY --from=base /usr/local/lib/python3.11/site-packages /usr/local/lib/python3.11/site-packages 
COPY --from=base /usr/local/bin /usr/local/bin
COPY . /home/app/
EXPOSE 8000
EXPOSE 465
CMD [ "gunicorn", "--config", "/home/app/gunicorn_conf.py", "src.details:app" ]
