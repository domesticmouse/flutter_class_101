[![Gitpod Ready-to-Code](https://img.shields.io/badge/Gitpod-Ready--to--Code-blue?logo=gitpod)](https://gitpod.io/#https://github.com/domesticmouse/flutter_class_101) 

# flutter_class_101

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Using this code on Gitpod.io

It is possible to check out this code and play with it using the 
[gitpod.io](https://gitpod.io) link above. I strongly suggest you fork this 
repo, and grant gitpod access to write to your public repositories. That way
you can store your changes between gitpod sessions in your github fork.

Currently you cannot use the `flutter run -d web` workflow from gitpod, as 
`flutter run` will create a new random high port, bound to localhost, which gitpod
will refuse to expose [flutter/flutter #53978](https://github.com/flutter/flutter/issues/53978). 

Here is a partial work around:

```
$ flutter build web
Compiling lib/main.dart for the Web...
$ (cd build/web && python3 -m http.server 8080)
Serving HTTP on 0.0.0.0 port 8080 (http://0.0.0.0:8080/) ...
```

After this, Gitpod will notice that there is an open port, and offer to 
open it either in a preview window, or in a new tab. 