# ftb-revelation
Docker for FTB-Revelation 2.3.0 (Stable)
Docker for FTB-Revelation 2.4.1 (Stable)

# Reminder for me next time I need to update the Dockerfile:
1) Update download URLs and filenames
2) Pull latest Dockerfile
3) `docker login`
4) `docker build -t revelation<version>` (verify with `docker images`)
5) `docker tag revelation<version>:latest rangent/ftb-revelation:<version>`
6) `docker push rangent/ftb-revelation:<version>`
