## Installation

### Move2Kube Command Line Tool:

**Linux / macOS / Windows WSL:**
```
$ curl -L https://raw.githubusercontent.com/konveyor/move2kube/master/scripts/install.sh | bash -
```

**Go**

Installing using `go get` pulls from the master branch of [Move2Kube](https://github.com/konveyor/move2kube) with the latest development changes.
```
$ go get –u github.com/konveyor/move2kube
```

**Github release**

* **Prerequisites**: Docker [(MAC](https://docs.docker.com/desktop/)[/Ubuntu](https://docs.docker.com/engine/install/ubuntu/)[/Windows WSL)](https://docs.docker.com/docker-for-windows/wsl/) - If Cloud Native Buildpack (CNB) support is required.

1. Obtain a recent version of [`golang`](https://golang.org/doc/install#download). Known to work with `1.15`.
1. Ensure `$GOPATH` is set. If it's not set:
   1. `mkdir ~/go`
   1. `export GOPATH=~/go`
1. Obtain this repo:
   1. `mkdir -p $GOPATH/src/`
   1. Clone the [Move2Kube](https://github.com/konveyor/move2kube) repo into the above directory. `git clone https://github.com/konveyor/move2kube`
   1. `cd $GOPATH/src/move2kube`
1. Build: `make build`
1. Run unit tests: `make test`

### Move2Kube Web Interface:
```
$ git clone https://github.com/konveyor/move2kube-ui
```
```
$ docker-compose up
```
Move2Kube UI will now be accessible in http://localhost:8080.
