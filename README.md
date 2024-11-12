# Sagemaker Notebooks for IOOS


This repo holds code and actions to produce containers that are configured to IOOS Conda specs available to users of the cloud sandbox as Sagemaker notebooks  (i.e. JupyterHub notebooks) with the [IOOS conda environment](https://ioos.github.io/ioos_code_lab/content/ioos_installation_conda.html).

This Dockerfile is based on the information found at 
- [Dockerfile Specifications](https://docs.aws.amazon.com/sagemaker/latest/dg/studio-updated-jl-image-specifications.html)
- [Custom SageMaker image specifications](https://docs.aws.amazon.com/sagemaker/latest/dg/studio-byoi-specs.html)

# Initialization

This repository performs releases via GitHub actions.  In order to do so, GitHub Actions must be configured to be able to access appropriate resources within GitHub and within the IOOS AWS account.

The following values need to be set as repository secrets:

- `AWS_REGION`
- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `AWS_ECR_REPOSITORY`

# Configuration

The repository that was initialized as `AWS_ECR_REPOSITORY` must be present and available for the credentials to read from and write to.

# Releases

To make a release of this image, push a tag to AWS with the following format.

`v{MAJOR}.{MINOR}.{PATCH}`

The GitHub Action will launch when that tag is created and produce a versioned entry (and one tied to the SHA sum of the image) in the `AWS_ECR_REPOSITORY`.

# Future Plans

## Alter Means of AWS Credentials

Move to a smoother and more secure means for providing credentials.

See [Security best practices in IAM](https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html) and possibly the [GHA Docs](https://github.com/aws-actions/configure-aws-credentials)

## CI Testing of the Image

Currently, the only action performed is to release and push a tag to ECR.  It would be nice to have some tests in place that ensure that the produced container was valid and valuable.