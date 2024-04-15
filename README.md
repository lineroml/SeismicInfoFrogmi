# Seismic Data Project - Back End 🗺️🌋

Hello! This is my formal application and practical test as part for my job Application with Frogmi

## 🌐💻 Technolgies used:

- Ruby on Rails framework

- SQL

## ⚡🏃 Requirements:

This project was developed using Ruby on WSL. It is recommended to have your ruby installation managed in WSL.

The setups steps expect following tools installed on the system.

1. Git

2. Ruby 3.0.2

3. Rails 7.1.3.2

## Run Project

To run this project, you should consider the following:

- If running locally, the project will have **NO DATA** whatsoever. There is a task configured using [whenever](https://github.com/javan/whenever), however, as this utilises a cronjob to run, it is recommended to execute the task manually to force the database to populate. You can do it by running the following command:

```bash

rake seismic_data:fetch

```

When ready to execute the project. You may use the following command:

```bash

rails s

```

**NOTE**: The project will run on port 3000 by default. If you wish to run on a different port, you may use the `-p` flag followed by the port number. This is **NECESSARY** if you´re running the companion front-end project, as that runs by default on port 3000.

The frontend project can be found [here](https://github.com/lineroml/seismic-front). (The frontend project is not required tun run this project, but it is recommended to run both projects together to see the full functionality of the technical test)

Also, if running the frontend project, you should know that by default, it expects to find the API on located on `http://localhost:8000`. You can run the project on port 8000 by using the following command:

```bash
rails s -p 8000
```
