# Init Project 
```bash

pip install meltano

```
```bash

meltano init meltano-test

```
# Google Analytics To CSV
```bash

cd meltano-test
meltano add extractor tap-google-analytics
```
```bash
meltano config tap-google-analytics list
```
```
key_file_location [env: TAP_GOOGLE_ANALYTICS_KEY_FILE_LOCATION] current value: '/media/brehelin/0FECCBDE10E4BE99/PycharmProjects/meltano-projects/meltano-test/client_secrets.json' (default: '$MELTANO_PROJECT_ROOT/client_secrets.json')
        Client Secrets File Location: A file that contains the Google Analytics client secrets json.
client_secrets [env: TAP_GOOGLE_ANALYTICS_CLIENT_SECRETS] current value: None (default)
        Client Secrets JSON: An object that contains the Google Analytics client secrets.
oauth_credentials.client_id [env: TAP_GOOGLE_ANALYTICS_OAUTH_CREDENTIALS_CLIENT_ID] current value: None (default)
        OAuth Client ID: The Google Analytics oauth client ID.
oauth_credentials.client_secret [env: TAP_GOOGLE_ANALYTICS_OAUTH_CREDENTIALS_CLIENT_SECRET] current value: None (default)
        OAuth Client Secret: The Google Analytics oauth client secret.
oauth_credentials.access_token [env: TAP_GOOGLE_ANALYTICS_OAUTH_CREDENTIALS_ACCESS_TOKEN] current value: None (default)
        OAuth Access Token: The Google Analytics oauth access token.
oauth_credentials.refresh_token [env: TAP_GOOGLE_ANALYTICS_OAUTH_CREDENTIALS_REFRESH_TOKEN] current value: None (default)
        OAuth Refresh Token: The Google Analytics oauth refresh token.
view_id [env: TAP_GOOGLE_ANALYTICS_VIEW_ID] current value: None (default)
        View ID: The ID for the view to fetch data from.
reports [env: TAP_GOOGLE_ANALYTICS_REPORTS] current value: None (default)
        Reports: The reports definition of which fields to retrieve from the view.
start_date [env: TAP_GOOGLE_ANALYTICS_START_DATE] current value: None (default)
        Start Date: This property determines how much historical data will be extracted. Please be aware that the larger the time period and amount of data, the longer the initial extraction can be expected to take.
end_date [env: TAP_GOOGLE_ANALYTICS_END_DATE] current value: None (default)
        End Date: Date up to when historical data will be extracted.
```
```bash
 meltano add loader target-csv
```
```
destination_path [env: TARGET_CSV_DESTINATION_PATH] current value: 'output' (default)
        Sets the destination path the CSV files are written to, relative to the project root. The directory needs to exist already, it will not be created automatically. To write CSV files to the project root, set an empty string (`""`).
delimiter [env: TARGET_CSV_DELIMITER] current value: ',' (default)
        A one-character string used to separate fields. It defaults to a comma (,).
quotechar [env: TARGET_CSV_QUOTECHAR] current value: "'" (default)
        A one-character string used to quote fields containing special characters, such as the delimiter or quotechar, or which contain new-line characters. It defaults to single quote (').
```
# Postgres To Postgres
```bash
meltano add extractor tap-postgres
```
```bash
meltano --log-level=debug  elt tap-postgres target-csv --job_id=postgrescsv
```
```bash
meltano add loader target-postgres
```
```bash
meltano elt tap-postgres target-postgres --job_id=postgressql
```

**dbt**
```bash
meltano add transformer dbt
```
```bash
meltano elt tap-postgres target-postgres --transform run --job_id=postgressqldbt
```

*run dbt test*  
Set env variables PG_PASSWORD, PG_ADDRESS, PG_PORT, PG_USERNAME, PG_DATABASE  
```bash
meltano invoke dbt:test
```