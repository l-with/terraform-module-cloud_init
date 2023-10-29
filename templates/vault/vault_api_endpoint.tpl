#! /bin/bash

curl --no-progress-meter http://${vault_helper_cmd_http_address}/v1/sys/${vault_endpoint} | jq