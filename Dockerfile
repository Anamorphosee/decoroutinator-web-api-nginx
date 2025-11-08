FROM nginx:1.29.3

COPY utils /utils
COPY nginx.conf nginx.conf
COPY entry.sh entry.sh

EXPOSE 80
EXPOSE 443
ENTRYPOINT ["./entry.sh"]
