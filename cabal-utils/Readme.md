Usage 1 git pull the repository for a hackage pacakge

```
sh getRepo.sh lens
Warning: The package list for 'hackage.haskell.org' is 52 days old.
Run 'cabal update' to get the latest list of available packages.
Unpacking to lens-4.15.1/
Cloning into 'lens_repo'...
remote: Counting objects: 32801, done.
remote: Total 32801 (delta 0), reused 0 (delta 0), pack-reused 32801
Receiving objects: 100% (32801/32801), 26.25 MiB | 3.13 MiB/s, done.
Resolving deltas: 100% (24637/24637), done.
Checking connectivity... done.
```

Usage 2 update a hackage package with its repository
```
sh getRepo.sh <GITHUB-USER> <GITHUB-REPO-NAME>
sh getRepo.sh xpika multifile
```
