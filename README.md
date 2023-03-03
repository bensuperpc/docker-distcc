# docker-distcc

Distcc (and ccache) in docker !

## Features

- Support for multiple systems (Ubuntu, Debian, Arch, Fedora, Alpine)
- Distcc (and ccache)
- Easy to use and configure

## Requirements

- [Docker](https://www.docker.com/)
- [GNU Make](https://www.gnu.org/software/make/)
- [GCC](https://gcc.gnu.org/)
- [Distcc](https://distcc.github.io/)
- [CMake](https://cmake.org/)
- [Ninja](https://ninja-build.org/)
- [ccache](https://ccache.dev/)

## Usage

### Run

First, you need to run the container. You can use the following command:

__Note:__ You can replace `debian-11` with `ubuntu-20.04`, `archlinux-rolling`, `fedora-34` or `alpine-3.14` ect...

```bash
docker run -d -p 3632:3632 -p 3633:3633 bensuperpc/distcc:debian-11 --allow 0.0.0.0/0
```

Second, you need to configure your environment to use the container. You can use the following command:

__Note:__ You need to replace `X` with the number of cores you want to use, and if you want, localhost with the IP of the container.

```bash
export DISTCC_HOSTS='localhost/X localhost:3632/X'
```

For Cmake, you can use the following command:

__Note:__ We use `Ninja` as a generator for build speed but you can use `Make` or other generators.

```bash
cmake -DCMAKE_C_COMPILER_LAUNCHER="ccache;distcc" -DCMAKE_CXX_COMPILER_LAUNCHER="ccache;distcc" -S . -B build -G Ninja && cmake --build build
```

For Make, you can use the following command:

__Note:__ You can replace `X` with the number of cores you want to use.

```bash
make -jX CC="distcc gcc" CXX="distcc g++"
```

### Build

You can build the image using the following command:

__Note:__ You can replace `debian` with `ubuntu`, `archlinux` or `alpine`.

```bash
make debian
```

With tests:
__Note:__ Currently, the tests doesn't return an error code if the tests failed.

```bash
make debian.test
```

## Supported systems (Table)


| System | Version | Image |
| --- | --- | --- |
| Debian | 11 | bensuperpc/distcc:debian-11 |
| Debian | 10 | bensuperpc/distcc:debian-10 |   
| Debian | 9 | bensuperpc/distcc:debian-9 |
| Ubuntu | 22.04 | bensuperpc/distcc:ubuntu-22.04 |
| Ubuntu | 20.04 | bensuperpc/distcc:ubuntu-20.04 |
| Ubuntu | 18.04 | bensuperpc/distcc:ubuntu-18.04 |
| Archlinux | base-devel | bensuperpc/distcc:archlinux-base-devel |
| Alpine | 3.17 | bensuperpc/distcc:alpine-3.17 |
| Alpine | 3.16 | bensuperpc/distcc:alpine-3.16 |
| Alpine | 3.15 | Not supported |
| Fedora | 37 | bensuperpc/distcc:fedora-37 |
| Fedora | 36 | bensuperpc/distcc:fedora-36 |
| Fedora | 35 | bensuperpc/distcc:fedora-35 |
| Manjaro | rolling | bensuperpc/distcc:manjaro-latest |
| CentOS | 8 | Not supported |



## Contributing

If you want to contribute to this project, you can do it by opening a pull request or an issue.

## Open source projects used

- [buildroot](https://github.com/buildroot/buildroot)
- [CMake](https://github.com/Kitware/CMake)
- [Make](https://www.gnu.org/software/make/)
- [llvm-project](https://github.com/llvm/llvm-project)
- [gcc](https://github.com/gcc-mirror/gcc)
- [docker](https://github.com/docker/docker)
- [actions](https://github.com/actions/virtual-environments)

## Sources

- [redhat.com](https://developers.redhat.com/blog/2019/05/15/2-tips-to-make-your-c-projects-compile-3-times-faster/)
- [medium.com](https://link.medium.com/cfhBeb298V)
- [linux.die.net](https://linux.die.net/man/1/distccd)

## Licensing

See the [LICENSE](LICENSE) document.
