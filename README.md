# crisprVerse Docker image

We offer Docker images of the crisprVerse ecosystem on the [Docker Hub](https://hub.docker.com/r/fortin946/crisprverse). 
The image contains the following conponents:

- R installation (currently 4.2.1)
- crisprVerse R packages and their dependencies
- ViennaRNA 2.5.1
- RNAhybrid 2.1.2

Convienently, all Python conda environments needed for [crisprScore](https://github.com/crisprVerse/crisprScore) are also already installed in the Docker image. 

### Obtaining the Docker image

The Docker image can be pulled directly from the [Docker Hub](https://hub.docker.com/r/fortin946/crisprverse) using the following command

```
docker push fortin946/crisprverse:dev
```

Note that this requires Docker to be installed on your machine. See the [Docker website](https://docs.docker.com/) for instructions. 

### Usage

Once the image is pulled, users can start an R session from the container using the following command:

```
docker run -it fortin946/crisprverse:dev
```

Alternatively, one can access the container within the terminal without starting an R session by typing the following command:

```
docker run -it fortin946/crisprverse:dev /bin/bash
```

Finally, to be able to access and write files to the local file system, users can mount a specific folder using the usual `-v` option. 
For instance, suppose we want to mount a local folder `/Users/fortinj2/crisprIndices` to a folder called `/home/crisprverse/indices` inside of the container, we can use the following command to do so:

```
docker run -it -v '/Users/fortinj2/crisprIndices:/home/crisprverse/indices' fortin946/crisprverse:dev
```

To illustrate this, the following lines

```
docker run -it -v '/Users/fortinj2/crisprIndices:/home/crisprverse/indices' fortin946/crisprverse:dev  /bin/bash
ls indices
```

will list the files available in the `/Users/fortinj2/crisprIndices` folder as it it mounted to the `indices` folder inside of the container.
For more information about volume and mounting, see the [Docker documentation](https://docs.docker.com/get-started/06_bind_mounts/).

### Modifying the Docker image

Users can use our [Dockerfile](https://github.com/crisprVerse/Docker/blob/master/Dockerfile) as a starting point to modify or customize the Docker image. 


