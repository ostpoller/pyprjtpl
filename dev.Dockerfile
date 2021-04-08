FROM python:3.8.5-buster AS builder
RUN python3 -m venv /venv && /venv/bin/pip install --upgrade pip

FROM builder AS builder-venv

COPY requirements.txt /requirements.txt
RUN /venv/bin/pip install -r /requirements.txt

FROM builder-venv AS tester

COPY . /app
WORKDIR /app
RUN /venv/bin/pytest

FROM python:3.8.5-buster AS runner
COPY --from=tester /venv /venv
COPY --from=tester /app /app

WORKDIR /app

ENTRYPOINT ["/venv/bin/python3", "-m", "package_name"]

LABEL name={NAME}
LABEL version={VERSION}