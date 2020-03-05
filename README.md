# Yarn Command Github Action

This is a simple action to allow you to run any command defined in your package.json e.g. `yarn test` or `npm test`. This command will install packages if that has not been done first, then run the supplied command.

# Examples

## Test - Create React App

If you are using the default create react app, ensure that you pass in the flag `--watchAll=false` so that jest doesn't enter interactive mode, otherwise the action will never finish.

```yaml
on: [pull_request]

jobs:
  tests:
    name: run tests
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: Adzz/jest_test_action@v0.0.2-alpha
        with:
          command: test --watchAll=false
```

This will default to using `yarn` and the `test` command specified in your `package.json`. Alternatively you can define a specific script there:

```json
 "scripts": {
    ...
    "test:ci": "react-scripts test --watchAll=false",
  },
```

Then do this:

```yaml
on: [pull_request]

jobs:
  tests:
    name: run tests
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: Adzz/jest_test_action@v0.0.2-alpha
        with:
          command: test:ci
```

### Using NPM instead of yarn

```yaml
on: [pull_request]

jobs:
  tests:
    name: run tests
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: Adzz/jest_test_action@v0.0.2-alpha
        with:
          package-manager: npm
          command: test:ci
```

### Lint then test

In the `package.json`

```json
 "scripts": {
    ...
    "test:ci": "react-scripts test --watchAll=false",
    "eslint": "eslint . --ext .js --ext .jsx --ext .gql --ext .graphql",
  },
```

```yaml
on: [pull_request]

jobs:
  eslint:
    name: run linter
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: Adzz/jest_test_action@v0.0.2-alpha
        with:
          command: eslint
  tests:
    name: run tests
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: Adzz/jest_test_action@v0.0.2-alpha
        with:
          command: test:ci
```

