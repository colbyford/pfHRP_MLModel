devtools::install_github('https://github.com/Azure/azureml-sdk-for-r')
azuremlsdk::install_azureml()

library(azuremlsdk)


ws <- get_workspace(name = 'dsba6190-amls',
                    subscription_id = '0bb59590-d012-407d-a545-7513aae8c4a7', 
                    resource_group = 'DSBA6190-Class')

pfhrp2through24_exp <- experiment(ws, name = 'automl-pfHRP2')

pfhrp2through24_run <- get_run(experiment = pfhrp2through24_exp,
                           run_id = 'AutoML_217f4a22-5141-4c51-9f1c-543416fef430')
get_run_details(pfhrp2through24_run)
get_run_metrics(pfhrp2through24_run)
get_run_file_names(pfhrp2through24_run)
view_run_details(pfhrp2through24_run)
