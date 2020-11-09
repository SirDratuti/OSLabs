#!/bin/bash

ps -eao command,pid | grep -E '^/sbin/' | awk '{print($NF)}' > ans2.lst
