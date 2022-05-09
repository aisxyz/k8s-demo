FROM ubuntu:latest
#RUN apt-get update && apt-get install -y fortune-mod
WORKDIR /games
COPY myfortune.sh /games/fortune
COPY fortunes /games/
ADD fortuneloop.sh /bin/fortuneloop.sh
RUN chmod u+x /bin/fortuneloop.sh
ENTRYPOINT ["/bin/fortuneloop.sh"]
