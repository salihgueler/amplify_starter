# {{project_name.sentenceCase()}}

[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)

An opinionated Flutter project for starting with AWS Amplify.

The project uses:
- [Amplify Authenticator](https://pub.dev/packages/amplify_authenticator), for authentication
- [Amplify Datastore](https://pub.dev/packages/amplify_datastore) for saving data and real time updates
- [bloc](https://pub.dev/packages/bloc) for state management.
- 
## Getting Started

> Before you move forward, be sure to have your AWS Account created and Amplify CLI is installed.
> 
> If you do not know how to do it, you can check the [official documentation](https://docs.amplify.aws/start/getting-started/installation/q/integration/flutter/) or this [blog post](https://medium.com/p/ef748798fdbf) for detailed guide.

Once the project is created, open your terminal on the generated project path. Afterwards write the following command:
```shell
amplify init
```

This will initialize AWS Amplify for your application. 

```shell
msalihg@ AWS TODO % amplify init
Note: It is recommended to run this command from the root of your app directory
? Enter a name for the project AWSTODO
The following configuration will be applied:

Project information
| Name: AWSTODO
| Environment: dev
| Default editor: Visual Studio Code
| App type: flutter
| Configuration file location: ./lib/

? Initialize the project with the above configuration? Yes
Using default provider  awscloudformation
? Select the authentication method you want to use: AWS profile

For more information on AWS Profiles, see:
https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html

? Please choose the profile you want to use default
Adding backend environment dev to AWS Amplify app: 
⠼ Initializing project in the cloud...
...
✅ Initialized your environment successfully
```

At above, you have chosen the default configuration for your project, it is more than enough to start with. But, you can always have your own version of the settings as well. 

Once you see the success message, you are ready to add libraries. First, add Amplify Authentication library:

```shell
amplify add auth
```

This will take you to select couple of options: 
```
msalihg@ AWS TODO % amplify add auth
Using service: Cognito, provided by: awscloudformation
 
The current configured provider is Amazon Cognito. 

Do you want to use the default authentication and security configuration? Default configuration
Warning: you will not be able to edit these selections. 
How do you want users to be able to sign in? Username
Do you want to configure advanced settings? No, I am done.
✅ Successfully added auth resource locally
```

Just select the default ones and username as a sign in method. That is enough for Authentication.

Next step is adding the Amplify DataStore. 

```shell
amplify add api
```

This is a tricky one. You need to select GraphQL if you would like to work with real time updates.

```shell
msalihg@ AWS TODO % amplify add api
? Select from one of the below mentioned services: GraphQL
? Here is the GraphQL API that we will create. Select a setting to edit or continue 
? Choose the default authorization type for the API Amazon Cognito User Pool
Use a Cognito user pool configured as a part of this project.
? Configure additional auth types? No
? Here is the GraphQL API that we will create. Select a setting to edit or continue Conflict detection (required for DataStore): Disabled
? Enable conflict detection? Yes
? Select the default resolution strategy Auto Merge
? Here is the GraphQL API that we will create. Select a setting to edit or continue Continue
? Choose a schema template: Single object with fields (e.g., “Todo” with ID, name, description)
```

You can pick any option from above **but for the sake of the starter project, do the selections as seen like above.**

Now open the `schema.graphql` file from `amplify/backend/api/<{{project_name}}>/schema.graphql` path. Remove everything and paste the following there:

```graphql
type Todo @model @auth(rules: [{ allow: owner }]) {
    id: ID!
    name: String!
    description: String
    isComplete: Boolean!
}
```

This will create a Todo object that will be available only for the owner to read/create/update.

Amplify has a tool to help you generate models out of the GraphQL reference. 

```shell
amplify codegen models
```

Once you create the models, now you are set to push your changes to cloud. But before write `amplify status` command. It should show you the state of your application and your setup for AWS Amplify.

```shell
msalihg@ {{project_name}} % amplify status

    Current Environment: dev
    
┌──────────┬────────────────────────┬───────────┬───────────────────┐
│ Category │ Resource name          │ Operation │ Provider plugin   │
├──────────┼────────────────────────┼───────────┼───────────────────┤
│ Auth     │ {{project_name}}       │ Create    │ awscloudformation │
├──────────┼────────────────────────┼───────────┼───────────────────┤
│ Api      │ {{project_name}}       │ Create    │ awscloudformation │
└──────────┴────────────────────────┴───────────┴───────────────────┘

GraphQL transformer version: 2
```

You can see that, two categories have been created for your project and now ready to be pushed.

```shell
amplify push
```

With this command, you are pushing your changes to the cloud. These changes will take a couple of minutes so in the meantime enjoy your coffee.

Once it is done, get the Flutter packages as follows:

```shell
flutter pub get
```

and run your application! 