# Thoth Action

This action allows you to run Thoth against your project, from within a GitHub Actions workflow.

To learn more about [Thoth](https://github.com/FuzzingLabs/thoth) itself, visit
its [GitHub repository](https://github.com/FuzzingLabs/thoth).

- [Thoth Action](#thoth-action)
- [How to use](#how-to-use)
  - [Options](#options)
- [Github Code Scanning integration](#github-code-scanning-integration)
  - [How to use](#how-to-use-1)

# How to use

Create `.github/workflows/thoth.yml`:

```yaml
name: Thoth Analysis
on: [push]
jobs:
  analyze:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: EvolveArt/thoth-action@v0.1.2
```

## Options

| Key          | Description                                                                                                            |
| ------------ | ---------------------------------------------------------------------------------------------------------------------- |
| `thoth-args` | Extra arguments to pass to Thoth.                                                                                      |
| `target`     | The path to the root of the project to be analyzed by Amarna. Can be a directory or a file. Defaults to the repo root. |

# Github Code Scanning integration

The action supports the Github Code Scanning integration, which will push Amarna's alerts to the Security tab of the Github project (see [About code scanning](https://docs.github.com/en/code-security/code-scanning/automatically-scanning-your-code-for-vulnerabilities-and-errors/about-code-scanning)). This integration eases the triaging of findings and improves the continious integration.

## How to use

```yaml
name: Thoth Analysis
on: [push]
jobs:
  analyze:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Run Thoth
        uses: EvolveArt/thoth-action@v0.1.2
        id: thoth
        continue-on-error: true
        with:
          target: "src/"
```

Here:

- `target: 'src/'` means Thoth will analyze the `src/` directory
