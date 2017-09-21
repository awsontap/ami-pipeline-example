def lambda_handler(event, context):
    """The Lambda function handler
    
    If a continuing job then checks the CloudFormation stack status
    and updates the job accordingly.
    
    If a new job then kick of an update or creation of the target
    CloudFormation stack.
    
    Args:
        event: The event passed by Lambda
        context: The context passed by Lambda
        
    """
    try:
        # Extract the Job ID
        job_id = event['CodePipeline.job']['id']
        
        # Extract the Job Data 
        job_data = event['CodePipeline.job']['data']
        
        # Extract the params
        params = get_user_params(job_data)
        
        # Get the list of artifacts passed to the function
        artifacts = job_data['inputArtifacts']
        
        stack = params['stack']
        artifact = params['artifact']
        template_file = params['file']
        
        if 'continuationToken' in job_data:
            # If we're continuing then the create/update has already been triggered
            # we just need to check if it has finished.
            check_stack_update_status(job_id, stack)
        else:
            # Get the artifact details
            artifact_data = find_artifact(artifacts, artifact)
            # Get S3 client to access artifact with
            s3 = setup_s3_client(job_data)
            # Get the JSON template file out of the artifact
            template = get_template(s3, artifact_data, template_file)
            # Kick off a stack update or create
            start_update_or_create(job_id, stack, template)  

    except Exception as e:
        # If any other exceptions which we didn't expect are raised
        # then fail the job and log the exception message.
        print('Function failed due to exception.') 
        print(e)
        traceback.print_exc()
        put_job_failure(job_id, 'Function exception: ' + str(e))
      
    print('Function complete.')   
    return "Complete."
