You have to run it as threaded to prevent some error caused by concurrent issues.
```bash
ghc -threaded Server.hs
ghc -threaded Client.hs
```
