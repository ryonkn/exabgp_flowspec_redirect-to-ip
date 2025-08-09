FROM python:3-slim

RUN pip install --upgrade pip setuptools \
  && pip install exabgp \
  && mkfifo /run/exabgp.in \
  && mkfifo /run/exabgp.out \
  && chmod 600 /run/exabgp.in /run/exabgp.out

CMD ["/usr/local/bin/exabgp", "/etc/exabgp/exabgp.conf"]
