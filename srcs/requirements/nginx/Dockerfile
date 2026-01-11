FROM		debian:oldstable

RUN			apt update -y && \
			apt upgrade -y && \
			apt install \
				nginx \
				openssl \
				vim \
				curl \
				-y && \
			apt clean && \
			rm -rf /var/lib/apt/lists/*
# docker best practice: clean up apt cache to reduce image size (for example: .deb files downloaded during apt install). 
# rm -rf /var/lib/apt/lists/* forcefully removes all files in the APT package lists directory that contains metadata about available packages that APT downloads during apt update


RUN         mkdir -p /etc/nginx/ssl \
			&& openssl req -x509 -nodes -days 365 \
			# -newkey rsa:2048 \
			-out /etc/nginx/ssl/lsampiet.crt \
			-keyout /etc/nginx/ssl/lsampiet.key \
			-subj "/C=BR/ST=SP/L=SaoPaulo/O=42/OU=42SaoPaulo/CN=lsampiet.42.fr/UID=lsampiet"

COPY		config/nginx.conf /etc/nginx/nginx.conf

RUN			mkdir -p /var/run/nginx

RUN			mkdir -p /var/www/wordpress

RUN 		chmod 755 /var/www/wordpress

RUN 		chown -R www-data:www-data /var/www/wordpress
# basic syntax = chown user:group filename
# www-data user is the standard user on debian/ubuntu based systems for nginx/apache
# this ensures the web server (nginx) process has proper permissions to read, write, and serve WordPress files

EXPOSE		443

CMD			["nginx", "-g", "daemon off;"]
