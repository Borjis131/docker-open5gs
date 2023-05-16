# Docker Open5GS backwards compatibility between versions

After downloading the project, you probably want to checkout to an specific Open5GS version. It is advised to use the commit id where each release tag points to. That release tag points to the version used to build the images that are published in DockerHub and GitHub Container Registry.

>Example: To build Open5GS Release v2.5.6 just checkout to the docker-open5gs tag v2.5.6.

In other obscure cases, you want to checkout to a commit where release has been published but build the containers using a different Open5GS release by changing the `OPEN5GS_VERSION` environment variable in the `.env` file. That is not advised, because between releases some build dependencies change and some the paths to the generated files can change too, causing the project to crash.

>Example: Checkout to docker-open5gs tag v2.5.8 but build Open5GS Release v2.5.6.

Why would you want that? Because the docker-open5gs could have a release feature that you want to apply to an older Open5GS Release.

Sometimes it will work, sometimes it will not.
