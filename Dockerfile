FROM alpine:3.13

RUN  apk update \
     && apk add --no-cache \
                tini \
                gettext \
                openldap \
                openldap-clients \
                openldap-back-mdb \
                openldap-overlay-memberof \
                openldap-overlay-refint \
                openldap-passwd-pbkdf2 \
                # openldap-overlay-syncprov \
  && rm -rf /var/cache/apk/* \
  && mkdir -p /ldap

EXPOSE 389
EXPOSE 636

COPY ldap/ /ldap/
COPY entrypoint.sh /
RUN chmod +xr /entrypoint.sh

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["/entrypoint.sh"]