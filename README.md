# JNLP Build Slave for PHP Projects

You want to use your Jenkins CI environment to test PHP apps? Here is the Docker image for that!

## Usage
Simply pull the image

```
docker pull daincredibleholg/jenkins-php-build-slave:<TAG>
```

and run it.

Here are the environment variables you should use:


| Variable       | Description                                                          | Example                                                          |
| -------------- | -------------------------------------------------------------------- | ---------------------------------------------------------------- |
| JENKINS_MASTER | URL to your Jenkins master node                                      | https://ci.company.com                                           |
| COMPUTER_NAME  | The node name, you want to use                                       | php5.3-build                                                     |
| JENKINS_SECRET | The secret this node needs to use to authenticate at the master node | b8c80148ce36de10c9358384fac9e28fbba941055a9a6ab2277e75ddc29a8744 |
| WORK_DIR       | Where to store the nodes working files. _Defaults_ to _/var/jenkins_ | /var/jenkins

So, a run command could look like this:

```
docker run -tdi --name jenkins-php-slave -e JENKINS_MASTER=https://ci.company.com -e COMPUTER_NAME=php5.3-build -e JENKINS_SECRET=b8c80148ce36de10c9358384fac9e28fbba941055a9a6ab2277e75ddc29a8744 -v ~/jenkins/work:/var/jenkins daincredibleholg/jenkins-php-build-slave:php5.3-build
```

## Tags
At the moment, there is only the tag *_php5.3_*. This uses an Ubuntu 12.04 base image to provide PHP 5.3. I sadly need
this for one of my projects.

Later, the tag `latest` will use the latest stable PHP version. Possibly in Ubuntu, but might be Alpine as well.

## Java Version
This build uses OpenJDK 10.0.1 as JDK to run the Jenkins slave.
