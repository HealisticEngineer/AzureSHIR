# Azure SHIR Chocolatey Package

This is a Chocolatey package for installing Azure SHIR (Self-Hosted Integration Runtime).

## Installation

To install Azure SHIR using Chocolatey, run the following command:

```
choco install self-hosted-integration-runtime
```

### Optional: Register Integration Runtime with Data Factory

You can provide your Data Factory authentication key at install time to automatically register the integration runtime node:

```
choco install self-hosted-integration-runtime --params "'/key:YOUR_AUTH_KEY'"
```

If the key is not provided, the integration runtime will install but not perform the registration step.

## Uninstallation

```
choco uninstall self-hosted-integration-runtime
```

## Supported Operating Systems

- Windows 11
- Windows Server 2019, 2022, 2025

> **Note:** Windows 10 and Windows Server 2016 are no longer supported by this package.

## Additional Information

- The integration runtime requires a 64-bit OS with .NET Framework 4.7.2 or above.
- Installation on a domain controller is not supported.
- For more details, see the [self-hosted-integration-runtime.nuspec](self-hosted-integration-runtime/self-hosted-integration-runtime.nuspec) file.