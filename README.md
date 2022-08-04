# AWS Amplify Starter Project

[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)

A highly opinionated AWS Amplify starter project. It will work as a Todo application. 

The project uses:
- [Amplify Authenticator](https://pub.dev/packages/amplify_authenticator), for authentication
- [Amplify Datastore](https://pub.dev/packages/amplify_datastore) for saving data and real time updates
- [bloc](https://pub.dev/packages/bloc) for state management.

## Requirements 🚀

Before you move forward, be sure to have 
- your AWS Account created
- Amplify CLI is installed.

If you do not know how to do it, you can check the [official documentation](https://docs.amplify.aws/start/getting-started/installation/q/integration/flutter/) or this [blog post](https://medium.com/p/ef748798fdbf) for detailed guide.

## How to use 🚀

You can either fill in the variables on your CLI:

```shell
mason make amplify_starter --project_name "AWS Amplify Todo" --project_organization "com.example"
```

**OR**

let CLI guide you through the process

```shell
mason make amplify_starter
```

## Variables ✨

| Variable               | Description                  | Default         | Type     |
|------------------------|------------------------------|-----------------|----------|
| `project_name`         | Name of your project         | Amplify Starter | `string` |
| `project_organization` | Organization of your project | com.example     | `string` |


