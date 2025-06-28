#!/bin/bash

## Explicitly mark packages not-manually installed as such
#sudo apt-mark minimize-manual


apt list --manual-installed | cut -d'/' -f1 | tail -n +2
