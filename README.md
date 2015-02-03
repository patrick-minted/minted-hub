Hub Puppet Module
=================

This puppet module installs the CLI Utility Hub.

Also by dependency resolution, installs wget and git both from the forge.

```
"dependencies": [
  {"name":"puppetlabs/stdlib","version_requirement":">= 4.3.2"},
  {"name":"maestrodev/wget","version_requirement":">= 1.5.5"},
  {"name":"puppetlabs/git","version_requirement":">= 0.3.0"},
]
```

This module has puppetlabs-spec tests written and beaker acceptance tests written to fully cover the extent of the module.

To test:
```bash
bundle install
rake spec               # For RSpec Unit Tests
rake spec_clean         # To clean out fixtures directory
rspec spec/acceptance   # To Launch, Test, and Destroy a new Vagrant VM w/ Beaker
```

(c) 2015 Minted.com
