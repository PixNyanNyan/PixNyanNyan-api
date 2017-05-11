# PixNyanNyan Backend API

[![Build Status](https://travis-ci.org/PixNyanNyan/PixNyanNyan-api.svg?branch=master)](https://travis-ci.org/PixNyanNyan/PixNyanNyan-api) [![Code Climate](https://codeclimate.com/github/PixNyanNyan/PixNyanNyan-api/badges/gpa.svg)](https://codeclimate.com/github/PixNyanNyan/PixNyanNyan-api) [![Test Coverage](https://codeclimate.com/github/PixNyanNyan/PixNyanNyan-api/badges/coverage.svg)](https://codeclimate.com/github/PixNyanNyan/PixNyanNyan-api/coverage)

## Get started with Docker

Check out files in `deploy` folder for example docker-compose configuration.

If you had permission problem mounting local files into containers, it's usually related to SELinux enforcement.

Try `setenforce 0` to see if problem solved. If it did, use `chcon -t svirt_sandbox_file_t *.conf` to fix the context.

## Usage

See wiki for detailed API usage.
