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


## Data Resources:
### aws_iam_policy_document:
      data "aws_iam_policy_document" "example" {
        statement {
          sid = "1"

          actions = [
            "s3:ListAllMyBuckets",
            "s3:GetBucketLocation",
          ]

          resources = [
            "arn:aws:s3:::*",
          ]
        }

        statement {
          actions = [
            "s3:*",
          ]

          resources = [
            "arn:aws:s3:::${var.s3_bucket_name}/home/&{aws:username}",
            "arn:aws:s3:::${var.s3_bucket_name}/home/&{aws:username}/*",
          ]
        }
      }

      resource "aws_iam_policy" "example" {
        name   = "example_policy"
        path   = "/"
        policy = "${data.aws_iam_policy_document.example.json}"
      }
      
- This data source is important and used in place of resouce ("aws_iam_policy"), for creating iam-policy and attach to role.

- Remaining Data sources are only used for collecting data.

- Important thing about data sources is , they run during plan, which we can make use of in sentinel-policies.

### aws_iam_account_alias:
      data "aws_iam_account_alias" "current" {}

      output "account_id" {
        value = "${data.aws_iam_account_alias.current.account_alias}"
      }
- The IAM Account Alias data source allows access to the account alias for the effective account in which Terraform is working.



## Resources:
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




### aws_iam_group_policy:
      resource "aws_iam_group_policy" "my_developer_policy" {
        name  = "my_developer_policy"
        group = "${aws_iam_group.my_developers.id}"

        policy = <<EOF
      {
        "Version": "2012-10-17",
        "Statement": [
          {
            "Action": [
              "ec2:Describe*"
            ],
            "Effect": "Allow",
            "Resource": "*"
          }
        ]
      }
      EOF
      }

      resource "aws_iam_group" "my_developers" {
        name = "developers"
        path = "/users/"
      }
      

 - This is used to create iam-group-inline-policy
 
 ### aws_iam_group_policy_attachment:
 - This is used to attach Managed policy to the iam-group
 
 
 
 ## IAM Permissions : 
      aws_iam_access_key
      aws_iam_account_alias
      aws_iam_account_password_policy
      aws_iam_group
      aws_iam_group_membership
      aws_iam_group_policy
      aws_iam_group_policy_attachment      
      aws_iam_openid_connect_provider      
      aws_iam_server_certificate      
      aws_iam_user
      aws_iam_user_group_membership
      aws_iam_user_login_profile      
      aws_iam_user_ssh_key      
      aws_iam_user_policy
      aws_iam_user_policy_attachment
      aws_iam_instance_profile --> create instance-profile(iam:CreateInstanceProfile)
      aws_iam_role  --> createRole(iam:CreateRole)
      aws_iam_service_linked_role   -->(iam:CreateServiceLinkedRole)
      aws_iam_policy
      aws_iam_policy_attachment --> warning in using it (WARNING: The aws_iam_policy_attachment resource creates exclusive attachments of IAM policies. Across the entire AWS account, all of the users/roles/groups to which a single policy is attached must be declared by a single aws_iam_policy_attachment resource. This means that even any users/roles/groups that have the attached policy via any other mechanism (including other Terraform resources) will have that attached policy revoked by this resource. )
      aws_iam_role_policy
      aws_iam_role_policy_attachment
      aws_iam_saml_provider
      
      
      
 ### Adding and deleting instance profiles:
      $ aws iam add-role-to-instance-profile --role-name ecsInstanceRole --instance-profile-name Webserver
      $ aws iam remove-role-from-instance-profile --instance-profile-name ecsInstanceRole --role-name ecsInstanceRole
      $ aws iam remove-role-from-instance-profile --instance-profile-name Webserver --role-name ecsInstanceRole
 - An instance profile is a container for an IAM role that you can use to pass role information to an EC2 instance when the instance starts.
 - An instance profile can contain only one IAM role, although a role can be included in multiple instance profiles. This limit of one role per instance profile cannot be increased. 
 - You can remove the existing role and then add a different role to an instance profile. You must then wait for the change to appear across all of AWS because of eventual consistency.To force the change, you must disassociate the instance profile and then associate the instance profile, or you can stop your instance and then restart it.
 
 More info, click [here](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use_switch-role-ec2_instance-profiles.html)
 
