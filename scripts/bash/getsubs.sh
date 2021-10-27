#!/bin/bash

domain=$1
amass enum -dir ~/amass -active -brute -src -d $domain

