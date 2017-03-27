---
modulename: Spacechecker
title: /run/
giturl: gitlab.com/space-sh/spacechecker
weight: 200
---
# Spacechecker module: Run

Performs analysis check on a given directory path and its contents.


## Example

Run _Spacechecker_ in `my-module`:
```sh
cd my-module
space -m spacechecker /run/ -- .
```

Exit status code is expected to be 0 on success.
