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

### Design Choices & Concepts

This project uses Docker to ensure portability and consistency across environments. By containerizing services, we eliminate "it works on my machine" issues and create a lightweight, modular infrastructure. The source code includes Dockerfiles for building custom images based on **Debian** for efficiency, and a Makefile for automation.

#### Technical Comparisons

- **Virtual Machines vs Docker**: While VMs emulate entire hardware systems and run full operating systems (heavy and slow to boot), Docker containers share the host's Linux kernel and isolate only the application level. This makes containers significantly lighter, faster to start, and more efficient resource-wise.

- **Secrets vs Environment Variables**: Environment variables are standard for configuration settings but can be insecure for sensitive data as they appear in potentially unsecured logs. **Docker Secrets** are designed to manage sensitive data properly; in this project, they are mounted as files into `/run/secrets/` only for the specific containers that need them, preventing passwords from being exposed anywhere else out of the project directory.

- **Docker Network vs Host Network**: In the default Bridge network (used here), containers are isolated on a private internal network and only expose specific ports. Host networking removes network isolation, making the container share the host's IP directly. The isolated network approach is chosen for better security and separation of concerns.

- **Docker Volumes vs Bind Mounts**: Bind mounts link a specific file or directory on the host machine to the container, often dependent on the host's specific file structure. **Docker Volumes** are managed by Docker and are generally preferred for persistent data (like databases) as they are easier to migrate and manage.

## Instructions

### Prerequisites
- Docker and Docker Compose installed
- A virtual machine or Linux environment
- Domain name configured to point to your local IP (typically `login.42.fr`)

### Setup

1. Clone the repository:
```bash
git clone <repository-url>
cd Inception
```

3. Update your `/etc/hosts` file to point your domain to localhost:
```bash
echo "127.0.0.1 lsampiet.42.fr" | sudo tee -a /etc/hosts
```

4. Build and launch the infrastructure, where environment variables and credentials will be automatically created (and properly stored in the `secrets/` directory, in the case of sensitive information) by hitting:
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
make                 # Build and start all containers
make up              # Start containers without rebuilding
make down            # Stop all containers
make clean           # Stop containers and remove volumes
make fclean          # Complete cleanup including images
make prune           # Clean even cached information
make re              # Rebuild everything from scratch
```

### Access Services
- WordPress site: `https://lsampiet.42.fr`
- WordPress admin: `https://lsampiet.42.fr/wp-admin`

### Useful Commands
```bash
docker ps                                    # List running containers
docker logs <container_name>                 # View container logs
docker exec -it <container_name> /bin/sh     # Access container shell
docker-compose ps                            # View compose services status
```
