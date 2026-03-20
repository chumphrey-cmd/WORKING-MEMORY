# Essential Docker Commands for Local Development

> Standard workflow for managing your PostgreSQL database (and any other containers) using docker-compose.

## 1. Lifecycle Commands (Starting and Stopping)´

* **`docker-compose up -d`**
  * Starts your containers in the background ("detached" mode). This is the most common way to run containers because it frees up your terminal so you can continue typing commands while the database runs silently.


* **`docker-compose up --build`**
  * Forces Docker to rebuild your images before starting. Use this if you change configuration files (like a `Dockerfile`) and need the container to reflect those new changes.


* **`docker-compose down`**
  * Gracefully stops and removes the containers and networks. Crucially, it **keeps** your named volumes (like your database data) safe.


* **`docker-compose down -v`**
  * Stops containers AND **deletes your volumes**.
  * This is incredibly useful in Test-Driven Development (TDD) when you want to completely wipe your database clean and start completely fresh

```bash
docker stop name_of_container
```

## 2. Monitoring & Debugging Commands

* **`docker-compose ps`**
  * Lists your currently running containers. It shows you their status (e.g., "Up") and exactly which ports they are using to communicate.


* **`docker-compose logs -f`**
  * "Follows" the live logs of your containers. If you started your app in detached mode (`-d`), this command lets you watch the console output in real-time to spot errors or confirm things are booting up correctly. Hit `Ctrl + C` to exit the log view.



## 3. Interacting Directly with the Container

* **`docker exec -it CONTAINER_NAME bash`**
  * Opens a live, interactive terminal *inside* your running container. It allows you to poke around the Linux file system of the container itself.

* **`docker exec -it CONTAINER_NAME psql -U YOUR_NAME -d APP_DB_NAME`**
  * A massive time-saver! This command logs you directly into the PostgreSQL command-line interface inside the running container. You can use this to manually run SQL queries or check if your Flyway migrations successfully created your tables. (Type `\q` to exit).

