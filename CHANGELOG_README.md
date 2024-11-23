# Changelog Scheme

This project changelog mixed the [Semantic Versioning](https://semver.org/) guidelines with the time-based versioning.

## Versioning Scheme

**Approach:**

It is a hybrid approach that combines the benefits of both time-based versioning and Semantic Versioning (SemVer). Timestamp or date act as part of the version string is used to indicate the release date attached as build number. This approach allows for a clear and concise versioning scheme while also providing a way to track the release date. Please noted that after the `+` sign, the timestamp is used to indicate the release date.

*Version format:*

```text
MAJOR.MINOR.PATCH+TIMESTAMP
```

*Where:*

- `MAJOR`, `MINOR`, and `PATCH` follows `SemVer` guidelines. That is,
  - `MAJOR` is non-negative integer that incremented when there are incompatible API changes,
  - `MINOR` is non-negative integer that incremented when new functionality is added in a backwards-compatible manner, and
  - `PATCH` is non-negative integer that incremented when backwards-compatible bug fixes are made.
- `TIMESTAMP`: Indicates the release date in which the format is `YYYYMMDD`.

For example, a version string might look like this:

```text
2.0.0+20241128
```

In this example, version number is `2.0.0` with release date is November 28, 2024.

**Note:**

- **Version string** is full version details, including the release date. For example, `2.0.0+20241128`
- **Version number** is the version string without the release date. For example, `2.0.0`
- **Release date** is only the release date that sits after the `+` sign of the version string. For example, `20241128`

## Release Stage

**Note:**

- `Release stage` is the stage of the release. For example, `Alpha Release`, `Beta Release`, `Release Candidate`, `Stable Release`, etc.
- If the release stage is not specified, it is assumed to be `Stable Release`.

| Key Features | `Alpha` Release Stage | `Beta` Release Stage | `Release Candidate` (RC) Release Stage | `Stable` Release Stage | `Hotfix` Release Stage | `Maintenance` Release Stage |
|---|---|---|---|---|---|---|
| **Purpose** | Initial internal testing and bug identification | Wider testing with external users to identify usability issues | Final testing before general release to identify remaining bugs | General availability and production use | Address critical bugs or security vulnerabilities | Add new features, improve performance, and fix minor bugs |
| **Audience** | Developers and internal testers | Beta testers and a wider audience | Public beta testers | General public | All users of the current stable release | All users of the current stable release |
| **Stability** | Unstable, frequent bugs and crashes expected | More stable than alpha, but still may have bugs | Highly stable, with minimal known bugs | Stable and reliable | Focused on fixing a specific issue | Generally stable, but may introduce new features or changes |
| **Features** | Core functionality may be incomplete | Most core features should be implemented | Nearly complete feature set | Complete feature set | Minimal changes to the existing feature set | May include new features or enhancements |
| **Release Cycle** | Frequent releases for quick bug fixes and feature iterations | Less frequent releases as the software matures | Infrequent releases to address critical issues or prepare for a major release | Once, but may have subsequent maintenance releases | Immediate release to address urgent problems | Scheduled releases based on a predefined roadmap or maintenance plan |

## Marking Scheme

- The history is sorted by release date in descending order.

*Marking format:*

```text
- (**Release stage**) `Major.Minor.Patch+Timestamp` **By Author**: version notes/details/what's changed/etc./...
```

example:

```text
- (**Stable Release**) `1.0.0+20241128` **By LukeCreated**: Initial release
```
