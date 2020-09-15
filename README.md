# cpp_template

## Build docker images

```pwsh
> powershell -ExecutionPolicy Unrestricted .\script\build_docker_images.ps1
```

## Enter docker container

```pwsh
> docker run -i -v "${PWD}:/cpp_template" -t clang bash
```
