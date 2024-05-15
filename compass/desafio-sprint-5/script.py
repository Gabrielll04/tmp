import pandas as pd
import boto3

bucket = "arrecadacao-ir-ipi"
file_name = "arrecadacao-ir-ipi.csv"

boto3.setup_default_session(profile_name='AdministratorAccess-533267010372')

s3 = boto3.client('s3')

obj = s3.get_object(Bucket= bucket, Key= file_name)

initial_df = pd.read_csv(obj['Body'])

print(initial_df)
