FROM quay.io/keycloak/keycloak:21.0.0 as builder

FROM quay.io/keycloak/keycloak:20.0.0

ENV LANG en_US.UTF-8

USER root
RUN rm -fr /opt/keycloak
COPY --from=builder /opt/keycloak/ /opt/keycloak/

RUN  microdnf upgrade -y \
  && microdnf install -y gettext \
  && microdnf clean all \
  && rm -rf /var/lib/dnf

WORKDIR /opt/keycloak
USER 10001

ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]
