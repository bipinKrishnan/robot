FROM ivydl/ivy:latest-copsim

# Install Ivy
RUN rm -rf ivy && \
    git clone https://github.com/ivy-dl/ivy && \
    cd ivy && \
    cat requirements.txt | grep -v "ivy-" | pip3 install --no-cache-dir -r /dev/stdin && \
    cat optional.txt | grep -v "ivy-" | pip3 install --no-cache-dir -r /dev/stdin && \
    python3 setup.py develop --no-deps

# Install Ivy Demo Utils
RUN git clone https://github.com/ivy-dl/demo-utils && \
    cd demo-utils && \
    cat requirements.txt | grep -v "ivy-" | pip3 install --no-cache-dir -r /dev/stdin && \
    python3 setup.py develop --no-deps

# Install Ivy Mech
RUN git clone https://github.com/ivy-dl/mech && \
    cd mech && \
    cat requirements.txt | grep -v "ivy-" | pip3 install --no-cache-dir -r /dev/stdin && \
    python3 setup.py develop --no-deps

# Install Ivy Vision
RUN git clone https://github.com/ivy-dl/vision && \
    cd vision && \
    cat requirements.txt | grep -v "ivy-" | pip3 install --no-cache-dir -r /dev/stdin && \
    python3 setup.py develop --no-deps

# Install Ivy Robot
RUN git clone https://github.com/ivy-dl/robot && \
    cd robot && \
    cat requirements.txt | grep -v "ivy-" | pip3 install --no-cache-dir -r /dev/stdin && \
    python3 setup.py develop --no-deps

COPY requirements.txt /
RUN cat requirements.txt | grep -v "ivy-" | pip3 install --no-cache-dir -r /dev/stdin

COPY ivy_robot_demos/requirements.txt /demo_requirements.txt
RUN cat demo_requirements.txt | grep -v "ivy-" | pip3 install --no-cache-dir -r /dev/stdin

RUN python3 test_dependencies.py -fp requirements.txt,demo_requirements.txt && \
    rm -rf requirements.txt && \
    rm -rf demo_requirements.txt

WORKDIR /robot