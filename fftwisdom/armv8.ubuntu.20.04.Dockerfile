FROM ubuntu:20.04 AS base
ARG uid

# Create a user with sudo rights
RUN apt-get update && apt-get -y install sudo
RUN useradd -m sdr -u ${uid} && echo "sdr:sdr" | chpasswd \
   && adduser sdr sudo \
   && usermod -a -G audio,dialout,plugdev sdr\
   && sudo usermod --shell /bin/bash sdr
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER sdr

RUN sudo apt-get update && sudo apt-get -y install \
    libfftw3-dev

COPY --chown=sdr fftwisdom.sh /home/sdr/fftwisdom.sh
WORKDIR /home/sdr

CMD /home/sdr/fftwisdom.sh