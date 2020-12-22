FROM debian:buster

# Add debian backports repo for wireguard packages
RUN echo "deb http://deb.debian.org/debian/ buster-backports main" > /etc/apt/sources.list.d/buster-backports.list

# Install wireguard packges
RUN apt-get update && \
 apt-get install -y --no-install-recommends openvpn wireguard-tools iptables nano net-tools procps openresolv inotify-tools git ca-certificates curl jq && \
 apt-get clean

COPY run.sh /

RUN chmod -x run.sh

RUN git clone https://github.com/pia-foss/manual-connections.git

CMD ["sh", "run.sh"]