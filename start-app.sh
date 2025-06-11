#!/bin/bash
nohup java -jar target/demo-app-1.0.0.jar > app.log 2>&1 &
echo $! > app.pid
sleep 5
if ! ps -p $(cat app.pid) > /dev/null; then
  echo "App failed to start"
  cat app.log
  exit 1
fi
echo "App started successfully"
