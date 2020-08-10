FROM centos:7
RUN yum install openssh-server -y --nogpgcheck 
RUN echo "666666"|passwd root --stdin
RUN ssh-keygen -t rsa -P "" -f /etc/ssh/ssh_host_rsa_key
RUN ssh-keygen -t ecdsa -P "" -f /etc/ssh/ssh_host_ecdsa_key
RUN ssh-keygen -t ed25519 -P "" -f /etc/ssh/ssh_host_ed25519_key
ENTRYPOINT ["/usr/sbin/sshd","-D"]

