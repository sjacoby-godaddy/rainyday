# AWS Okta Authenticate GitHub Action

Please see our [Contributing](./CONTRIBUTING.md) for how to contribute to the project.

This GitHub Action uses [aws-okta-processor](https://github.com/godaddy/aws-okta-processor) to authenticate on behalf of a Jomax User and assumes a specified role. The assumed role credentials (`AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY` and `AWS_SESSION_TOKEN`) are exported to environment variables and are available to downstream actions in the workflow.

## Inputs

### `aws-okta-user`

**Required:** Jomax user to use to assume temporary role.

### `aws-okta-pass`

**Required:** Jomax pass to use to assume temporary role.

### `aws-okta-organization`

**Optional:** Okta organization. Defaults to standard GoDaddy AWS Okta organization

### `aws-okta-application`

**Optional:** Okta application. Defaults to standard GoDaddy AWS Okta application (non-PCI)

### `aws-okta-role`

**Required:** ARN of AWS Role to assume

### `aws-region`

**Optional:** AWS Region to put in `AWS_DEFAULT_REGION` in session. Defaults to us-west-2 if not provided.

## Example usage

From a workflow, use like described below. Please make sure the gd-actions repo is checked out to your workflow workspace already, as [described in the guidelines](https://github.com/gdcorp-cp/gd-actions/blob/master/GUIDELINES.md):

```yaml
uses: ./gdcorp-actions/aws-okta-authenticate
with:
  aws-okta-user: {{ secrets.AWS_DEV_PRIVATE_JOMAX_USER}}
  aws-okta-pass: {{ secrets.AWS_DEV_PRIVATE_JOMAX_PASS}}
  aws-okta-organization: godaddy.okta.com
  aws-okta-application: https://godaddy.okta.com/home/amazon_aws/0oakmpp1rkb2ZuZsQ0x7/272 # non-pci
  aws-okta-role: full-arn-to-dev-private-deploy-role
  aws-region: us-west-2
```

The action can be tested locally by building the docker image and passing the inputs to it:

```sh
git clone git@github.com/gdcorp-actions/gd-actions.git
cd aws-okta-authenticate
docker build aws-okta-authenticate .
docker run aws-okta-authenticate $USER $PASS $ORG $APP $ROLE
```
