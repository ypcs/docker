# systemd

Custom systemd image for running init system inside Docker. This allows apps to start using systemd service files etc.

To start,

    docker run -d --tmpfs /tmp --tmpfs /run --tmpfs /run/lock -v /sys/fs/cgroup:/sys/fs/cgroup:ro ypcs/systemd

See <https://developers.redhat.com/blog/2016/09/13/running-systemd-in-a-non-privileged-container/> for more details.
