### Docker for xen-orchestra

Based on instructions [https://xen-orchestra.com/docs/installation.html#from-the-sources](https://xen-orchestra.com/docs/installation.html#from-the-sources)

#### Build docker locally

```bash
docker build -f Dockerfile context --rm --tag xo-docker:latest 
```

#### Run docker

```bash
XO_PORT=88
docker run -p 127.0.0.1:8080:${XO_PORT} -e XO_PORT:${XO_PORT} xo-docker:latest 
```

#### TODO
- Add more env to drive config inside

#### Misc

Some good resources on building efficient containers

- [https://www.redhat.com/sysadmin/tiny-containers](https://www.redhat.com/sysadmin/tiny-containers)
