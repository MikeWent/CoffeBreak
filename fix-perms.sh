#!/bin/bash

sudo chown -R $1:$2 $3
sudo find $3 -type d -exec chmod 775 {} +
sudo find $3 -type f -exec chmod 664 {} +

