FROM		debian:oldstable

RUN			apt update -y && \
			apt upgrade -y && \
			apt install \
				mariadb-server \
				-y && \
			apt clean && \
			rm -rf /var/lib/apt/lists/*

COPY		config/entrypoint.sh /usr/local/bin/entrypoint.sh

# COPY		config/my.cnf /etc/mysql/my.cnf

RUN			chmod +x /usr/local/bin/entrypoint.sh && \
			chown -R mysql:mysql /usr/local/bin/entrypoint.sh

EXPOSE		3306

ENTRYPOINT	["/usr/local/bin/entrypoint.sh"]