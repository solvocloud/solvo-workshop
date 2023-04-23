#!/bin/bash

# Get the secret name from the first command line argument
secret_name=$APP_SECRET_NAME

# Use the AWS CLI to get the value of the secret
secret_value=$(aws secretsmanager get-secret-value --secret-id $secret_name --query SecretString --output text)

echo "The value of $secret_name is: $secret_value"

# Replace <bucket-name> and <object-key> with the S3 bucket and object key of the file you want to download
bucket_name=$APP_BUCKET_NAME
object_key="tenant/54ab556f-9270-4057-9f9b-e28c7eac0ea2/user/2f01d261-0f9c-4e5d-b8b3-b3926c4c2b3c/data.json"
output_file="downloaded_file.txt"

# Use the AWS CLI to download the file from the S3 bucket
aws s3 cp s3://$bucket_name/$object_key $output_file

echo "File downloaded to $output_file"

# Replace <table-name> with the name of your DynamoDB table
table_name=$APP_TABLE_NAME
key_name="id"
key_value="123"

# Use the AWS CLI to get the item from the DynamoDB table
item=$(aws dynamodb get-item --table-name $table_name --key "{\"$key_name\":{\"S\":\"$key_value\"}}" --query Item)

echo "The item with $key_name=$key_value in $table_name is: $item"