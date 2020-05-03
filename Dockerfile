FROM ubuntu:16.04 AS build
# TODO: build step..

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y wget unzip xz-utils

# Server
WORKDIR /bf1942
RUN wget https://seanwittmeyer.com/store/bf1942/bf1942_lnxded-1.6-rc2.run
RUN offset=$(head -n 340 bf1942_lnxded-1.6-rc2.run | wc -c | tr -d " ") && \
    tail -c +$((offset+1)) bf1942_lnxded-1.6-rc2.run | tar -xvzf -
RUN rm bf1942_lnxded-1.6-rc2.run

# Patch 1
WORKDIR /
RUN wget https://seanwittmeyer.com/store/bf1942/bf1942_update1.61.tar.gz
RUN tar -xvf bf1942_update1.61.tar.gz
RUN rm bf1942_update1.61.tar.gz

# Patch 2
WORKDIR /bf1942
RUN wget https://seanwittmeyer.com/store/bf1942/bf1942_lnxded.1.612.static.tar.xz
RUN tar -xvf bf1942_lnxded.1.612.static.tar.xz

# Fix installation
WORKDIR /bf1942
RUN ln -s bf1942_lnxded.static bf1942_lnxded

# BFSM
WORKDIR /bfsmd
RUN wget https://seanwittmeyer.com/store/bf1942/BFServerManager201.tgz
RUN tar -xvf BFServerManager201.tgz
RUN cp bfsmd /bf1942/bfsmd
RUN cp *.con /bf1942/mods/bf1942/settings/

FROM ubuntu:16.04

COPY --from=build /bf1942/ /bf1942

RUN dpkg --add-architecture i386
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libc6:i386 libncurses5:i386 libstdc++5:i386

# Use bf1942.sk master server
RUN echo "109.71.69.254 master.gamespy.com # bf1942.sk" >> /etc/hosts

WORKDIR /
ADD start.sh /start.sh
RUN chmod +x start.sh

CMD ["/start.sh"]
