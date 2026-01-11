_This project has been created as part of the 42 curriculum by lsampiet._

# Inception
My very first Docker setup

## Description

This project aims to broaden knowledge of system administration by using **Docker**. The goal is to virtualize several Docker images, creating them in a personal virtual machine.

The infrastructure consists of different services running in separate Docker containers:
- **NGINX** with TLSv1.2 or TLSv1.3 only
- **WordPress** with php-fpm (without nginx)
- **MariaDB** database
- **Volumes** for WordPress database and website files
- **Docker network** to establish connection between containers

All services run in dedicated containers built from either the penultimate stable version of Alpine or Debian. Each service has its own Dockerfile, and the entire infrastructure is set up using docker-compose.

## Instructions

### Prerequisites
- Docker and Docker Compose installed
- A virtual machine or Linux environment
- Domain name configured to point to your local IP (typically `login.42.fr`)

### Setup

1. Clone the repository:
```bash
git clone <repository-url>
cd Inception-github
```

2. Configure your environment variables in the `secrets/` directory (create `.env` file with database credentials, passwords, etc.)

3. Update your `/etc/hosts` file to point your domain to localhost:
```bash
echo "127.0.0.1 lsampiet.42.fr" | sudo tee -a /etc/hosts
```

4. Build and launch the infrastructure:
```bash
make
```

## Resources

- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [NGINX Documentation](https://nginx.org/en/docs/)
- [WordPress with Docker](https://hub.docker.com/_/wordpress)
- [MariaDB Documentation](https://mariadb.org/documentation/)
- [Docker Networking](https://docs.docker.com/network/)
- [SSL/TLS Configuration](https://ssl-config.mozilla.org/)

## Usage

### Build and Start
```bash
make                  # Build and start all containers
make up              # Start containers without rebuilding
make down            # Stop all containers
make clean           # Stop containers and remove volumes
make fclean          # Complete cleanup including images
make re              # Rebuild everything from scratch
```

### Access Services
- WordPress site: `https://lsampiet.42.fr`
- WordPress admin: `https://lsampiet.42.fr/wp-admin`

### Useful Commands
```bash
docker ps                                    # List running containers
docker logs <container_name>                 # View container logs
docker exec -it <container_name> /bin/sh    # Access container shell
docker-compose ps                            # View compose services status
```
