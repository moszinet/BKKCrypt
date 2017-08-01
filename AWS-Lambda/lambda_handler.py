def lambda_handler(event, context):

    password = ""
    try:
        password = event['queryStringParameters']['password']
    except:
        pass

    response = {
        "statusCode": 200,
        "headers": {},
        "body": password
    }

    return response
