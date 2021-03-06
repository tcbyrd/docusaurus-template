workflow "Docusaurus deploy" {
  on = "push"
  resolves = ["Deploy"]
}

action "Build site" {
  uses = "actions/npm@59b64a598378f31e49cb76f27d6f3312b582f680"
  args = "ci --prefix website && npm run build --prefix website"
}

action "Deploy" {
  uses = "actions/npm@59b64a598378f31e49cb76f27d6f3312b582f680"
  needs = ["Build site"]
  args = "run publish-gh-pages --prefix website"
  secrets = ["GITHUB_TOKEN"]
  env = {
    CURRENT_BRANCH = "master"
    GIT_USER = "x-access-token:${GITHUB_TOKEN}"
    GIT_CONFIG = "${GITHUB_WORKSPACE}/.gitshared"
  }
}
