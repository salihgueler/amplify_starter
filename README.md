# AWS Amplify Starter Project

[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)

A highly opinionated AWS Amplify starter project. It will work as a Todo application. 

The project uses:
- [Amplify Authenticator](https://pub.dev/packages/amplify_authenticator), for authentication
- [Amplify Datastore](https://pub.dev/packages/amplify_datastore) for saving data and real time updates
- [bloc](https://pub.dev/packages/bloc) for state management.

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

-----

> This project creates the base project for you. You are still expected to configure AWS Amplify afterwards. 
> 
> Once the project is created go to the [README.md](https://github.com/salihgueler/amplify_starter/blob/main/__brick__/%7B%7Bproject_name%7D%7D/README.md) file of the generated project and follow the steps described there.

## Variables ✨

| Variable               | Description                  | Default         | Type     |
|------------------------|------------------------------|-----------------|----------|
| `project_name`         | Name of your project         | Amplify Starter | `string` |
| `project_organization` | Organization of your project | com.example     | `string` |


