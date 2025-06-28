#!/bin/bash

/bin/ls ~/.emacs.d/elpa/ | sed 's/-[0-9.]*$//'
