# Description 
This repository show how to setup a basic CICD flow for a spring boot application on github using Jenkins and Docker. When you push a commit, it will automatically deploy spring application to docker.


# Step to Run
- Step 1: Run jenkins container on docker: docker-compose up -d
- Step 2: Jenkins configuration: 
    1. Add credentials (add personal access token on github first)
    2. Add Tool: Maven 3.8.1, JDK 17
    3. Add new item pipeline for https://github.com/kiendo1998/CicdExample
    4. mount to jenkins container and install docker:
       - docker exec -it [container-name] bash
       - apt-get update
       - apt-get install -y docker.io
       - exit

- Step 3: run ngrok for jenkins server (github webhook need https, ex. https://abc.ngrok-free.app/github-webhook/)
- Step 4: Config webhook for ngrok jenkins's url on github
- Step 5: Push a commit
- Step 6: See the result