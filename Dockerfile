FROM ubuntu:14.04
MAINTAINER Tran Hoang Tung <tran-hoang.tung@usth.edu.vn>

# Build is based on image svponomarev/qtcreator_gui, thanks to Svyatoslav Ponomarev
# https://github.com/svponomarev/dockerfiles/tree/master/qtcreator_gui
# Main difference: install openFrameworks 0.8.4

# 1. Install NVIDIA drivers for OpenGL support in Qt
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y nvidia-384 && \
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# 2. Install Qt and QtCreator with dependencies
RUN apt-get update && apt-get install -y qt-sdk qtcreator && \
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# 3. Install openFrameworks with dependencies
WORKDIR /root
RUN curl -L http://www.openframeworks.cc/versions/v0.8.4/of_v0.8.4_linux64_release.tar.gz | tar xz && \
cd of_v0.8.4_linux64_release/scripts/linux/ubuntu && sed -i 's/apt-get install/apt-get install -y/g' *.sh &&./install_dependencies.sh && \
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install ofxCv addon
RUN cd of_v0.8.4_linux64_release/addons && curl -L https://github.com/kylemcdonald/ofxCv/archive/0.8.4.tar.gz | tar xz && \
mv ofxCv-0.8.4 ofxCv && cd ../scripts/linux && ./compileOF.sh -j $(($(nproc) - 1))

# Install project generator
RUN cd of_v0.8.4_linux64_release/scripts/linux && ./compilePG.sh
