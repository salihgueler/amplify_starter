# AWS Amplify Starter Project

[![Powered by Mason][mason_badge]][mason_link]

A highly opinionated AWS Amplify starter project. Based on Very Good Core. 

## Requirements 🚀

Before you move forward, be sure to have 
- your AWS Account created
- Amplify CLI is installed.

If you do not know how to do it, you can check the [official documentation](https://docs.amplify.aws/start/getting-started/installation/q/integration/flutter/) or this [blog post](https://medium.com/p/ef748798fdbf) for detailed guide.

## How to use 🚀

First create your mason project by running `mason init` on any folder that you want.

Afterwards, add the library to your project.

```shell
mason add amplify_starter
```

Now generate the files. 

You can either fill in the variables on your CLI:

```shell
mason make amplify_starter --project_name "AWS Amplify Starter" --project_organization "com.example"
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


[mason_badge]: https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge
[mason_link]: https://github.com/felangel/mason