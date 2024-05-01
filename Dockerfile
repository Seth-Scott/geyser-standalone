FROM debian:bullseye

# Update package lists and install curl, wget, and any other necessary packages
RUN apt-get update && \
    apt-get -y install --no-install-recommends curl wget && \
    rm -rf /var/lib/apt/lists/*

# Download and extract OpenJDK 21
RUN wget --no-check-certificate -O openjdk-21.tar.gz https://download.java.net/java/GA/jdk21.0.2/f2283984656d49d69e91c558476027ac/13/GPL/openjdk-21.0.2_linux-x64_bin.tar.gz && \
    mkdir -p /opt/openjdk-21 && \
    tar -xzvf openjdk-21.tar.gz -C /opt/openjdk-21 --strip-components=1 && \
    rm openjdk-21.tar.gz

# Set JAVA_HOME environment variable
ENV JAVA_HOME=/opt/openjdk-21
ENV PATH=$JAVA_HOME/bin:$PATH

# Download Geyser-Standalone.jar
RUN wget --no-check-certificate -O /opt/Geyser-Standalone.jar https://download.geysermc.org/v2/projects/geyser/versions/latest/builds/latest/downloads/standalone


# Set the working directory
WORKDIR /opt

# Run Geyser-Standalone.jar
CMD ["java", "-jar", "Geyser-Standalone.jar"]
