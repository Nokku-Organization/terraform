## IAM
### Data Sources:
      aws_iam_account_alias
      aws_iam_group
      aws_iam_instance_profile
      aws_iam_policy
      aws_iam_policy_document
      aws_iam_role
      aws_iam_server_certificate
      aws_iam_user


### Resources:
      aws_iam_access_key
      aws_iam_account_alias
      aws_iam_account_password_policy
      aws_iam_group
      aws_iam_group_membership
      aws_iam_group_policy
      aws_iam_group_policy_attachment
      aws_iam_instance_profile
      aws_iam_openid_connect_provider
      aws_iam_policy
      aws_iam_policy_attachment
      aws_iam_role
      aws_iam_role_policy
      aws_iam_role_policy_attachment
      aws_iam_saml_provider
      aws_iam_server_certificate
      aws_iam_service_linked_role
      aws_iam_user
      aws_iam_user_group_membership
      aws_iam_user_login_profile
      aws_iam_user_policy
      aws_iam_user_policy_attachment
      aws_iam_user_ssh_key


### aws_iam_access_key:
      resource "aws_iam_access_key" "test" {
        user = "<username>"
      }




### aws_iam_account_alias:
      resource "aws_iam_account_alias" "alias" {
        account_alias = "my-account-alias"
      }
- it is checking that account-alias to be unique.(when i tried to create with "my-account-alias" , it hasn't created.but with different name it got created)


### aws_iam_group:
      resource "aws_iam_group" "developers" {
        name = "developers"
        path = "/users/"
      }
- Here path is used to disinguish the groups/users in the organizattions.
- In the arn this path reflects : "arn:aws:iam::419639163435:group/users/developers"
- If we haven't mentioned path in the script default path '/' is been taken, and we can change this path via terraform as a change(instead of deleting and creating iam-group).i.e, via terraform no new iam-group is created if we change the path,it modifies the existing iam-group.

 For more info , click [here](https://stackoverflow.com/questions/46324062/in-aws-iam-what-is-the-purpose-use-of-the-path-variable)

