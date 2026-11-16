FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends openssh-server sudo python3 ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN useradd --create-home --shell /bin/bash automation \
    && echo 'automation:automation' | chpasswd \
    && usermod --append --groups sudo automation \
    && printf 'automation ALL=(ALL) NOPASSWD:ALL\n' > /etc/sudoers.d/automation \
    && chmod 0440 /etc/sudoers.d/automation

RUN mkdir -p /run/sshd \
    && sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config \
    && sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config

EXPOSE 22

CMD ["/bin/bash", "-c", "ssh-keygen -A && /usr/sbin/sshd && tail -f /dev/null"]