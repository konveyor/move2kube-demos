[![License](https://img.shields.io/:license-apache-blue.svg)](https://www.apache.org/licenses/LICENSE-2.0.html)
[![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/konveyor/move2kube-demos/pulls)
[<img src="https://img.shields.io/badge/slack-konveyor/move2kube-green.svg?logo=slack">](https://kubernetes.slack.com/archives/CR85S82A2)

# Move2Kube - Demos

This repository contains data related to tutorials in https://move2kube.konveyor.io/docs/tutorial related to [Move2Kube](https://github.com/konveyor/move2kube).

## To bring up the UI

1. Change directory to an empty directory using say, `mkdir -p workspace && cd workspace`
1. Run `docker run -p 8080:8080 -v $PWD:/workspace -v /var/run/docker.sock:/var/run/docker.sock -it quay.io/konveyor/move2kube-aio:v0.2.0-alpha.4`
1. Access the UI in http://localhost:8080/.

## Discussion

* For any questions reach out to us on any of the communication channels given on our website https://move2kube.konveyor.io/
