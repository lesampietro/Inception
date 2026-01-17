# Inception - User Documentation

This guide explains how to use and manage the centralized infrastructure stack provided by the Inception project.

## 1. Services Overview
This stack deploys a complete web hosting environment using Docker containers. The following services are provided:

*   **WordPress Website**: A fully functional content management system running on PHP-FPM.
*   **MariaDB Database**: The backend database server that stores all WordPress content and user data.
*   **NGINX Web Server**: Segures the connection (HTTPS/TLS) and serves the website to the internet.
*   **Storage (Volumes)**: Persistent storage ensures your website data and database remain safe even if containers are restarted.


## 2. Managing the Project (Start & Stop)
The project is controlled via a `Makefile`. Open your terminal in the root of the project directory.

*   **To start the infrastructure:**
    This command builds the images (if needed), creates the networks/volumes, and starts the containers.
    ```bash
    make
    ```

*   **To stop the infrastructure:**
    This command stops the running containers.
    ```bash
    make down
    ```

*   **To clean everything (Reset):**
    **Warning:** This deletes all containers, images, and data (including the database and website files).
    ```bash
    make fclean
    ```


## 3. Accessing the Website
Once the project is running (`make` command has finished), you can access the services via your web browser.

*   **Main Website:**
    Navigate to: `https://lsampiet.42.fr`
    *(Note: You must accept the security warning because the TLS certificate is self-signed.)*

*   **Administration Panel:**
    To manage posts, themes, and settings, navigate to: `https://lsampiet.42.fr/wp-admin`


## 4. Credentials Management
Sensitive information (passwords for the database and admin users) is not stored directly in the environment variables for security reasons.

*   **Where are they stored?**
    Credentials are managed via **Secrets**. On your host machine, they are generated in the `secrets/` directory.


## 5. Checking Service Status
To ensure everything is running correctly, use the following commands in your terminal:

*   **Check running containers:**
    You should see `nginx`, `mariadb`, and `wordpress` listed with status "Up".
    ```bash
    docker ps
    ```

*   **View logs:**
    If a service isn't working, check its logs for errors. Replace `<container_name>` with `nginx`, `mariadb`, or `wordpress`.
    ```bash
    docker logs <container_name>
    ```