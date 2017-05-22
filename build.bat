@echo off

docker build . --tag autopy
docker run -itd --name autopy autopy bash
docker cp autopy:/root/autobahn-js/build ./build
docker stop autopy
docker rm autopy
docker rmi autopy