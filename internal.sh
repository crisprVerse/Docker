docker build -t crisprverse .
docker tag crisprverse fortin946/crisprverse:dev
docker push fortin946/crisprverse:dev

# To enter the container:
docker run -it fortin946/crisprverse:dev /bin/bash

# To start R directly from the container:
docker run -it fortin946/crisprverse:dev

# To mount a local directory:
docker run -it -v '/Users/fortinj2/crisprIndices:/home/crisprverse/indices' fortin946/crisprverse:dev
