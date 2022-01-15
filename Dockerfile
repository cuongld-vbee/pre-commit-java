FROM openjdk:13-alpine

RUN apk add --update --no-cache wget unzip curl bash jq
RUN mkdir -p /opt

COPY run_checkstyle.sh /opt
COPY checkstyle.xml /opt

RUN cd /opt \
      && export CS_URL=$(curl --silent https://api.github.com/repos/checkstyle/checkstyle/releases/latest | jq '.assets[] | select(.name | contains("checkstyle-") and contains(".jar")) | .browser_download_url' | sed -e 's/^"//' -e 's/"$//') \
      && wget -nc -O checkstyle.jar ${CS_URL}