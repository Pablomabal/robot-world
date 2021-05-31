#!/bin/bash

bundle exec wheneverize .
whenever --update-crontab --set environment=development
rails s