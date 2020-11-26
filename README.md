<div align="center">
  <a href="https://developer-beta.elementary.io" align="center">
    <center align="center">
      <img src="assets/static/elementary.svg" alt="elementary" align="center">
    </center>
  </a>
  <br>
  <h1 align="center"><center>Houston Server</center></h1>
  <h3 align="center"><center>The elementary OS developer website</center></h3>
  <br>
  <br>
</div>

<p align="center">
  <img src="https://github.com/elementary/houston-server/workflows/Publish/badge.svg" alt="Publish">
  <img src="https://github.com/elementary/houston-server/workflows/Update/badge.svg" alt="Update">
</p>

---

This repository is an elixir website for `https://developer-beta.elementary.io`.
It is responsible for viewing GitHub repositories and building projects.

## Scope

This is a rewrite of the original houston server written in nodejs. While there
are a lot of problems that this should address, the MVP is to duplicate it with
a very few small changes / improvements:

- [ ] Faster fetching of GitHub repositories
- [ ] Using Postgresql instead of Mongodb

In the future, this rewrite should include:

- [ ] Searchable projects
- [ ] Download statistics
- [ ] A better written out review process
- [ ] Support for other services other than GitHub

## Running

This repository contains a `docker-compose.yml` file for easier development.
Make sure you have `docker-compose` installed, then run these commands:

1) `docker-compose build` to build the containers. If you make changes to any
dependencies, or are getting issues where code does not seem to update, re-run
this step.

2) `docker-compose up` to start the server and dependencies. This is your main
command and after you run steps 1 and 2, you should only need to run this
command to get back up and running.

3) **OPTIONAL** If you have alternative configuration credentials (for GitHub)
you can place them in your `config/dev.secret.exs` file like so:

```ex
import Config

config :houston_server, Elementary.HoustonServer.GitHub,
  client_key: "some key here"
```

You will need to restart `docker-compose up` for this to take effect

## Translations

All translations are extracted to the template files when new commits are
pushed to master. If you would like to help translate this site, please see the
[elementary weblate instance](https://l10n.elementary.io/).

## Deploying

This repository is setup with continuous integration and deployment. If you want
to deploy your changes, all you need to do is open a PR to the master branch.
Once your PR is accepted and merged in, it will automatically be deployed.
