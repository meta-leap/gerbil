# The Gerbil Release Process

Congratulations, you are now a Gerbil maintainer,
tasked with making a new release.
Here is a checklist of all the steps you have to go through
to make a successful release.

## Get All the Changes Merged
First, make sure your have all the features and bug fixes in that you need to be.
Check the [PR queue](https://github.com/mighty-gerbils/gerbil/pulls) and the
[Open Issues](https://github.com/mighty-gerbils/gerbil/issues) for any release blocker.

## Regenerate the Bootstrap If Needed
If there were any changes to the core language, [regenerate the bootstrap code](bootstrap).
Include all the parts that have changed (runtime, prelude, expander, compiler).
Make a dedicated PR just for this bootstrap upgrade.

## Make Sure Gerbil Works on all Supported Targets
Before you commit the above PR, build and test it at least on the following targets:
Linux x86-64, macOS ARM64.
[Ask for help on gitter](https://app.element.io/#/room/#gerbil-scheme_community:gitter.im)
regarding platforms you can't support yourself.

## Merge Pre-Release PRs
- Update release scripts and release documentation
- Update homebrew (macOS) recipe (except exact commit) - ask @drewc for help
- Update Guix (Linux) recipe (except exact commit) - ask @drewc for help
- Update to Nix (Linux, macOS) recipe (except exact commit) - ask @fare for help
  (the recipe is currently in a fork of nixpkgs, not in the gerbil repository)

## Merge a PR for the Release itself
- Update the version everywhere in documentation
- Include a high-level summary of changes in the
  [CHANGELOG.md](https://github.com/mighty-gerbils/gerbil/blob/master/CHANGELOG.md)
- Generate a `MANIFEST` for the release with the following shell command
  from the Gerbil repository top directory,
  where the argument is the desired release name:
  `./manifest.sh v0.19`

Note that:
- The release PR should not contain anything but this version bump.
  Make any other necessary change in the pre-release PRs.
- The website will be automatically re-generated from the PR. No action needed.

## Create Official Announcements
Once the release PR is merged:
- Create a release announcement on
  [GitHub discussions](https://github.com/mighty-gerbils/gerbil/discussions),
  with a `release` label, a one-paragraph blurb introduction,
  and the contents of the CHANGELOG.md entry above.
  See e.g. [this previous announcement](https://github.com/mighty-gerbils/gerbil/discussions/1009)
- Create [a release on GitHub](https://github.com/mighty-gerbils/gerbil/releases).
  GitHub will automatically generate a template summarizing the PRs included / bugs fixed.
  Use that as the basis for the GitHub release note page.
  See e.g. [this previous release](https://github.com/mighty-gerbils/gerbil/releases/tag/v0.18).

Note that creating the release on GitHub should create a git tag,
that you can pull in your local repository with: `git pull --tags`

## Update Tarballs
- Generate tarball for the Gerbil source code,
  *including the Gambit submodule at the correct version* in `src/gambit`.
  Mind that the tarball autogenerated by GitHub does not include Gambit.
- Generate a binary tarball for Linux x86-64. - ask @fare or @ober for help
- Generate a binary tarball for the shared objects that the above uses (e.g. `sqlite.so`),
  so that e.g. the previous tarball can be deployed on Heroku. - ask @fare for help
- Generate rpm and deb packages for Linux x86-64. - ask @ober for help
- Publish each of these tarballs as artifacts on GitHub on the
  [release page](https://github.com/mighty-gerbils/gerbil/releases/)

## Merge Post-Release PRs
- Remove the `MANIFEST` file.
- Update to homebrew (macOS) recipe - ask @drewc for help
- Update to Guix (Linux) recipe - ask @drewc for help
- Update to Nixpkgs (Linux, macOS) recipe - ask @fare for help

## Announce the Release to the World
Point to the announcement page on GitHub.
- Announce [on gitter](https://app.element.io/#/room/#gerbil-scheme_community:gitter.im).
- Announce on reddit: [r/scheme](https://www.reddit.com/r/scheme/).
  See e.g. [this previous announcement](https://www.reddit.com/r/scheme/comments/18buf4g/gerbil_v0181_nimzolarsen_released/).
- Announce on [Hacker News](https://news.ycombinator.com/).
  See e.g. [this previous announcement](https://news.ycombinator.com/item?id=38540155).
- Announce on [Lobsters](https://lobste.rs/).
  See e.g. [this previous announcement](https://lobste.rs/s/lydbxm/gerbil_v0_18_1_nimzolarsen_released).
- Announce on [twitter](https://twitter.com).
  See e.g. [this previous announcement](https://twitter.com/Ngnghm/status/1732234985845796879).