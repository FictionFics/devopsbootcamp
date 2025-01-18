FROM jenkins/jenkins:lts-jdk11

USER root

# Update the system and install required packages
RUN apt update && apt install -y curl unzip && apt clean

# Gradle version
ARG GRADLE_VERSION=6.6.1

# Define the URL where Gradle can be downloaded
ARG GRADLE_BASE_URL=https://services.gradle.org/distributions

# Define the SHA key to validate the Gradle download
ARG GRADLE_SHA=7873ed5287f47ca03549ab8dcb6dc877ac7f0e3d7b1eb12685161d10080910ac

# Download, verify, and install Gradle
RUN mkdir -p /usr/share/gradle /usr/share/gradle/ref \
  && echo "Downloading Gradle..." \
  && curl -fsSL -o /tmp/gradle.zip ${GRADLE_BASE_URL}/gradle-${GRADLE_VERSION}-bin.zip \
  && echo "Verifying Gradle download..." \
  && echo "${GRADLE_SHA}  /tmp/gradle.zip" | sha256sum -c - \
  && echo "Unzipping Gradle..." \
  && unzip -d /usr/share/gradle /tmp/gradle.zip \
  && rm -f /tmp/gradle.zip \
  && ln -s /usr/share/gradle/gradle-${GRADLE_VERSION}/bin/gradle /usr/bin/gradle

# Validate Gradle installation
RUN gradle --version

# Switch back to the Jenkins user
USER jenkins
