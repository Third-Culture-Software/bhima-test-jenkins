// For usage, see https://github.com/jenkinsci/docker/blob/master/README.md#setting-the-number-of-executors

import jenkins.model.*
Jenkins.instance.setNumExecutors(0) // Recommended to not run builds on the built-in node

