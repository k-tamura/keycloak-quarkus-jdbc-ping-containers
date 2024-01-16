FROM quay.io/keycloak/keycloak:21.0.0 as builder

FROM quay.io/keycloak/keycloak:20.0.0

USER root
RUN rm -fr /opt/keycloak
RUN  microdnf upgrade -y && microdnf install -y java-17-openjdk-devel vi net-tools && microdnf clean all
COPY --from=builder /opt/keycloak/ /opt/keycloak/

USER 10001

ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]
