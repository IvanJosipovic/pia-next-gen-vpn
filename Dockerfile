FROM alpine

# Install wireguard packges
RUN apk update && \
 apk add openvpn wireguard-tools git curl jq iptables

RUN git clone https://github.com/pia-foss/manual-connections.git

#openvpn
RUN echo "sh /vpn/up.sh & \n" >> /manual-connections/openvpn_config/openvpn_up_dnsoverwrite.sh
RUN echo "sh /vpn/up.sh & \n" >> /manual-connections/openvpn_config/openvpn_up.sh
RUN echo "sh /vpn/down.sh & \n" >> /manual-connections/openvpn_config/openvpn_down_dnsoverwrite.sh
RUN echo "sh /vpn/down.sh & \n" >> /manual-connections/openvpn_config/openvpn_down.sh
RUN sed -i '/^port=.*/a echo $port > /shared/vpnport' /manual-connections/port_forwarding.sh

#wireguard
RUN sed -i '/.*wg-quick up pia.*/a sh /vpn/up.sh &' /manual-connections/connect_to_wireguard_with_token.sh

WORKDIR /manual-connections
CMD sh ./run_setup.sh
