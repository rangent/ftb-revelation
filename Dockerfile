FROM java:8-jre

MAINTAINER Brian Esserlieu (https://github.com/rangent)
# Original 2.2.0 file from Jonas Bonno Mikkelsen (https://github.com/JonasBonno)

# Updating container
RUN apt-get update && \
	apt-get upgrade --yes --force-yes && \
	apt-get install -y vim && \
	apt-get clean && \ 
	rm -rf /var/lib/apt/lists/* 

# Setting workdir
WORKDIR /minecraft

# Changing user to root
USER root

# Creating user and downloading files
RUN useradd -m -U minecraft && \
	mkdir -p /minecraft/world && \
	wget --no-check-certificate https://www.feed-the-beast.com/projects/ftb-revelation/files/2610841/download -O FTBRevelation-2.3.0-1.12.2.zip && \
	unzip FTBRevelation-2.3.0-1.12.2.zip && \
	rm FTBRevelation-2.3.0-1.12.2.zip && \
	wget --no-check-certificate https://www.feed-the-beast.com/projects/ftb-revelation/files/2610843/download -O FTBRevelationServer_2.3.0.zip && \
	unzip FTBRevelationServer_2.3.0.zip && \
	rm FTBRevelationServer_2.3.0.zip && \
	chmod u+x FTBInstall.sh ServerStart.sh && \
	echo "#By changing the setting below to TRUE you are indicating your agreement to our EULA (https://account.mojang.com/documents/minecraft_eula)." > eula.txt && \
	echo "$(date)" >> eula.txt && \
	echo "eula=TRUE" >> eula.txt && \
	chown -R minecraft:minecraft /minecraft
USER minecraft

# Running install
RUN /minecraft/FTBInstall.sh

# Expose port 25565
EXPOSE 25565

# Expose volume
VOLUME ["/minecraft/world"]

# Start server
CMD ["/bin/bash", "/minecraft/ServerStart.sh"]
