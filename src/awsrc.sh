#
# external aliases
alias a53lhz='aws route53 list-hosted-zones --query "HostedZones[*].[Id,Name]" --output text'
alias a53lra='for i in $( aws route53 list-hosted-zones --query "HostedZones[*].[Id]" --output text | sed -e "s/\n/ /g" ); do a53lrr $i; done'
alias a53lrr='aws route53 list-resource-record-sets --query "ResourceRecordSets[*].[Name,Type,ResourceRecords[*].Value]" --hosted-zone-id'
alias a53lhv='aws route53 list-hosted-zones-by-vpc --vpc-region ap-southeast-1 --vpc-id vpc-0bbf3fecc46edc9a4'
# run on squad's account
alias a53cva='aws route53 create-vpc-association-authorization --vpc VPCRegion=ap-southeast-1,VPCId=vpc-0bbf3fecc46edc9a4 --region ap-southeast-1 --hosted-zone-id'
# run on collab account
alias a53avh='aws route53 associate-vpc-with-hosted-zone --vpc VPCRegion=ap-southeast-1,VPCId=vpc-0bbf3fecc46edc9a4 --region ap-southeast-1 --hosted-zone-id'
alias aapgra='aws apigateway get-rest-apis --query "items[*].[id,name,description,tags]"'
alias aapgex='aws apigateway get-export --rest-api-id ezc5bkoc88 --parameters "extensions='apigateway'" --stage-name api --export-type swagger test.json'
alias aapgvl='aws apigateway get-vpc-links --query "items[*].[id,name,description,tags]"'
alias acf='aws cloudformation'
alias acfden='aws cloudformation delete-stack --stack-name'
alias acfdse='aws cloudformation describe-stack-events --stack-name'
alias acfdss='aws cloudformation describe-stacks'
alias acfdsn='aws cloudformation describe-stacks --stack-name'
alias acfls='aws cloudformation list-stacks'
alias acflsn='aws cloudformation list-stacks --query "StackSummaries[*].StackName"'
alias acfutp='aws cloudformation update-termination-protection --no-enable-termination-protection --stack-name'
alias acfvt='acf validate-template --template-body file://'
alias acfvta='for i in $(find . -type f | grep .yml); do acf validate-template --template-body file://$i; done'
alias acmlcs='aws acm list-certificates --query "CertificateSummaryList[*]"'
alias acmrcn='aws acm request-certificate --certificate-authority-arn arn:aws:acm-pca:ap-southeast-1:072784453073:certificate-authority/f1831221-5bed-4b73-8482-8e146495d2d6 --domain-name'
alias adsdds='aws ds describe-directories --query "DirectoryDescriptions[*].[DirectoryId,Name,ShortName,Stage,ShareStatus,Type,SsoEnabled]"'
alias aecall='aws ec2 describe-instances --query "Reservations[*].Instances[*].[ImageId,InstanceId,PrivateDnsName,IamInstanceProfile,Tags[*].Value]"'
alias aecdii='aws ec2 describe-instances --query "Reservations[*].Instances[*].[ImageId,InstanceId,PrivateDnsName,IamInstanceProfile,Tags[*].Value]" --instance-id'
alias aecdia='aws ec2 describe-image-attribute --attribute launchPermission --image-id'
alias aecdis='aws ec2 describe-images --owners self --query "Images[*].[ImageId,ImageLocation,Description,Name]"'
alias aecdiu='aws ec2 describe-images --query "Images[*].[ImageId,ImageLocation,Description,Name]" --executable-users'
alias aecdsu='aws ec2 describe-subnets --query "Subnets[*].[AvailabilityZone,SubnetId,VpcId,Tags]"'
alias aecdve='aws ec2 describe-vpc-endpoints'
alias aeldla='aws elbv2 describe-load-balancers --query "LoadBalancers[*].DNSName" --output text --load-balancer-arn'
alias aeldtg='aws elbv2 describe-target-groups --query "TargetGroups[*].[TargetGroupArn,TargetGroupName,Protocol,Port,LoadBalancerArns,TargetType]"'
alias aeldlr='aws elbv2 describe-listeners --load-balancer-arn'
alias aeldre='aws elbv2 describe-rules --listener-arn'
alias aeldta='aws elbv2 describe-target-groups --query "TargetGroups[*].[TargetGroupArn,TargetGroupName,Protocol,Port,LoadBalancerArns,TargetType]" --target-group-arn'
alias aeldth='aws elbv2 describe-target-health --query "TargetHealthDescriptions[*]" --target-group-arn'
alias aevlr='aws events list-rules'
alias aevprs='aws events put-rule --schedule-expression "cron(0 16 * * ? *)" --name'
alias aimgip='aws iam get-instance-profile --instance-profile-name'
alias aimlrc='aws iam list-roles --query "Roles[*].[RoleName,Arn]" | grep -e reserved -e cross'
alias akgpk='aws kms get-public-key --key-id'
alias akla='aws kms list-aliases'
alias akls='aws kms list-keys'
alias algf='aws lambda get-function --function-name'
alias allf='aws lambda list-functions --function-version ALL --region ap-southeast-1 --output json --query "Functions[*].[FunctionName,Runtime,Role,FunctionArn]"'
alias allfp='aws lambda list-functions --function-version ALL --region ap-southeast-1 --output text --query "Functions[?Runtime=='python3.6'].FunctionArn"'
alias alufc='aws lambda update-function-configuration --runtime "python3.9" --function-name'
alias arddis='aws rds describe-db-instances --query "DBInstances[*].[DBInstanceIdentifier,Endpoint,DomainMemberships,DBInstanceArn,TagList]"'
alias as3cpd='aws s3 cp --recursive'
alias as3gbp='aws s3api get-bucket-policy --output text --bucket'
alias as3gpa='aws s3api get-public-access-block --bucket'
alias as3ls='aws s3 ls'
alias as3ppa='aws s3api put-public-access-block --bucket'
alias asgall='aws ec2 describe-security-groups --query "SecurityGroups[*].[GroupName,GroupId][]"'
alias asmall='for a in $(aws secretsmanager list-secrets --query "SecretList[].ARN" --output text); do aws secretsmanager get-secret-value --secret-id "${a}" --query "{Name: Name, SecretString: SecretString}"; done'
alias asmdsn='aws secretsmanager delete-secret --force-delete-without-recovery --secret-id'
alias asmlsn='aws secretsmanager list-secrets --query "SecretList[*].[ARN,Name,Description,Tags[*].Value]"'
alias asslci='aws ssm list-compliance-items --resource-types "ManagedInstance" --filters "Key=ComplianceType,Values=['Patch']" --resource-id'
alias asslcs='aws ssm list-compliance-summaries'
alias asslna='for a in $( aws ec2 describe-instances --query "Reservations[*].Instances[*].[InstanceId]" --output text | sed -e "s/\n/ /g" ); do asslnc $a; done'
alias asslnc='aws ssm list-compliance-items --resource-types "ManagedInstance" --filters "Key=ComplianceType,Values=['Patch']" "Key=Status,Values=NON_COMPLIANT" --query "ComplianceItems[*].[ResourceId,Id,Severity,ComplianceType,Status,Details.PatchState]" --output text --resource-id'
alias asslpi='aws ssm list-compliance-items --resource-types "ManagedInstance" --filters "Key=ComplianceType,Values=['Patch']" --query "ComplianceItems[*].[ResourceId,Id,Severity,ComplianceType,Status,Details.PatchState]" --output text --resource-id'

acf-cs() {
  if [ -z "${1}" ]; then
    echo "[ERROR]Path not found [SERVICE_NAME/ENV_NAME/JSON_FILE]."
    return
  fi
  # echo ${1#/*/}   ==> path/file.ext
  # echo ${1##*/}   ==> file.ext
  # echo ${1%/*}    ==> path
  # echo ${1%.c}    ==> path/file
  strFile=${1##*/}
  strPath=${1%/*}
  strPrefix=$( echo "${strPath}" | sed "s~/~-~g" )
  if [ -z ${AWS_S3_URL} ]; then
    echo "[ERROR]Environment variables not defined [AWS_S3_URL]."
    return
  fi
  cfJsonName=$(jq -r '.cf_stack_name // empty' ${1})
  if [ -z ${cfJsonName} ]; then
    echo "[ERROR] cf_stack_name key not found, please correct the json array in ${strFile}."
    return
  fi
  cfJsonParams=$(jq -c '.cf_params // empty' ${1})
  if [ -z ${cfJsonParams} ]; then
    echo "[ERROR] cfJsonParams key not found, please correct the json array in ${strFile}."
    return
  fi
  cfJsonTemplate=$(jq -r '.cf_template_path // empty' ${1})
  cfStackName="${strPrefix}-${cfJsonName}-cfStack"
  cfTemplateUrl="${AWS_S3_URL}/${cfJsonTemplate}"
  echo ${cfJsonParams} | jq
  echo "Create stack $cfStackName?"
  confirm=$(inp-confirm)
  if [ ! -z "$confirm" ]; then
    aws cloudformation create-stack --template-url ${cfTemplateUrl} --parameters ${cfJsonParams} --stack-name ${cfStackName}
    echo "done"
  else
    echo "user cancel"
    return
  fi
}

acf-vt() {
  for i in $(find . -type f | grep .yml); do
    echo "Validating $i"
    aws cloudformation validate-template --template-body "file://$i";
    if [ $? -ne 0 ]; then
      return
    fi
  done  
}

acm-rc() {
  echo "Interactive ACM Request Certificate"
  echo "  e.g. DomainName: common-service.book-sit.dflocal.defcloud.gov.sg"
  strDomain=$(inp-value domain-name)
  if [ -z ${strDomain} ]; then
    echo "user cancel"
    return
  fi
  strFile=$(inp-value passphrase-file)
  if [ -z ${strFile} ]; then
    echo "user cancel"
    return
  fi
  if [ ! -f "${strFile}" ]; then
    echo [Error] File not found "${strFile}"
    return
  fi
  echo "You have entered the following information:"
  echo " DomainName: ${strDomain}"
  echo " Passphrase File: ${strFile}"
  confirm=$(inp-confirm)
  if [[ "$confirm" != "y" ]]; then
    echo "user cancel"
    return
  fi
  strCertificateArn=$(aws acm list-certificates --query "CertificateSummaryList[?DomainName=='$strDomain'].CertificateArn" --output text)
  if [ -z ${strCertificateArn} ]; then
    aws acm request-certificate --certificate-authority-arn arn:aws:acm-pca:ap-southeast-1:072784453073:certificate-authority/f1831221-5bed-4b73-8482-8e146495d2d6 --domain-name ${strDomain} > acm-request-certificate-${strDomain}.txt
    strCertificateArn=$(jq -r ".CertificateArn" acm-request-certificate-${strDomain}.txt)
    if [ -z ${strCertificateArn} ]; then
      echo "[Error] Could not request certificate for ${strDomain}"
      return
    fi
    echo "[Success] Requested certificate for ${strDomain}"
  else
    echo "[Found] Skipping request certificate for ${strDomain}"
  fi
  echo "${strCertificateArn}"
  strStatus=$(aws acm describe-certificate --certificate-arn ${strCertificateArn} --query "Certificate.Status" --output text)
  while [ "${strStatus}" != "ISSUED" ]; do
    echo -n "."
    sleep 5
    strStatus=$(aws acm describe-certificate --certificate-arn ${strCertificateArn} --query "Certificate.Status" --output text)
  done
  aws acm export-certificate --certificate-arn ${strCertificateArn} --passphrase "file://${strFile}" > acm-export-certificate-${strDomain}.json
  jq -r ".Certificate" acm-export-certificate-${strDomain}.json > ${strDomain}-certificate.txt
  jq -r ".CertificateChain" acm-export-certificate-${strDomain}.json > ${strDomain}-certificate_chain.txt
  jq -r ".PrivateKey" acm-export-certificate-${strDomain}.json > ${strDomain}-private_key.txt
  echo "done"
}

aec-dit() {
  strTagKey=$(inp-value tag-key)
  if [ -z ${strTagKey} ]; then
    echo "user cancel"
    return
  fi
  strTagValue=$(inp-value tag-value)
  if [ -z ${strTagValue} ]; then
    echo "user cancel"
    return
  fi
  aws ec2 describe-instances --query "Reservations[].Instances[?not_null( Tags[?Key=='${strTagKey}'&&contains(Value,'${strTagValue}')].Value) && State.Name=='running'].InstanceId" | jq -r '.[] | select(length > 0) | .[]'
}

aec-mia() {
  strAmi=$(inp-value image-id)
  if [ -z ${strAmi} ]; then
    echo "user cancel"
    return
  fi
  strAws=$(inp-value aws-account-id)
  if [ -z ${strAws} ]; then
    echo "user cancel"
    return
  fi
  echo Add $strAws to image $strAmi?
  confirm=$(inp-confirm)
  if [ ! -z "$confirm" ]; then
    aws ec2 modify-image-attribute --image-id $strAmi --launch-permission "Add=[{UserId=$strAws}]"
    echo "done"
  else
    echo "user cancel"
    return
  fi
}

ael-find-bff() {
  strEnv=$(inp-value Environment)
  if [ -z "${strEnv}" ]; then
    echo "user cancel"
    return
  fi
  strAppName="nlb-vpclink"
  for strArn in $( aws elbv2 describe-load-balancers | jq '.LoadBalancers[] | select(.DNSName | contains("NLBLo")) | .LoadBalancerArn' -r | sed 's/\\//g' ); do

    strFoundAppName=$(aws elbv2 describe-tags --resource-arns "${strArn}" | jq --arg JQ_APPNAME "${strAppName}" '.TagDescriptions[].Tags[] | select( (.Key | contains("Name")) and (.Value | contains($JQ_APPNAME)) )')
    strFoundEnv=$(aws elbv2 describe-tags --resource-arns ${strArn} | jq --arg JQ_ENV "${strEnv}" '.TagDescriptions[].Tags[] | select( (.Key | contains("Environment")) and (.Value | contains($JQ_ENV)) )')
    if [ -z "${strFoundAppName}" ] || [ -z "${strFoundEnv}" ]; then
      continue
    fi

    strDns=$(aws elbv2 describe-load-balancers --query "LoadBalancers[*].DNSName" --output text --load-balancer-arn "${strArn}")
    echo "done"
    echo "Found load-balancer with ${strAppName} in ${strEnv}."
    echo " (1) Navigate to Route53 > Hosted Zone: ${strEnv}.dflocal.defcloud.gov.sg"
    echo " (2) Create record > Record Name = bff"
    echo " (3) Select Record type = A > Routing policy = Simple routing"
    echo " (4) Select Alias = Yes > Value = ${strDns}"
    echo " (5) Click Create record"
    return
  done
  echo "No load-balancer found."
  return
}

ael-find-by-name() {
  strAppName=$(inp-value AppName)
  if [ -z "${strAppName}" ]; then
    echo "user cancel"
    return
  fi
  strEnv=$(inp-value Environment)
  if [ -z "${strEnv}" ]; then
    echo "user cancel"
    return
  fi
  for strArn in $( aws elbv2 describe-load-balancers | jq '.LoadBalancers[] | select(.DNSName | contains("WebLo")) | .LoadBalancerArn' -r | sed 's/\\//g' ); do

    strFoundAppName=$(aws elbv2 describe-tags --resource-arns "${strArn}" | jq --arg JQ_APPNAME "${strAppName}" '.TagDescriptions[].Tags[] | select( (.Key | contains("AppName")) and (.Value | contains($JQ_APPNAME)) )')
    strFoundEnv=$(aws elbv2 describe-tags --resource-arns ${strArn} | jq --arg JQ_ENV "${strEnv}" '.TagDescriptions[].Tags[] | select( (.Key | contains("Environment")) and (.Value | contains($JQ_ENV)) )')
    if [ -z "${strFoundAppName}" ] || [ -z "${strFoundEnv}" ]; then
      continue
    fi

    strListenerArn=$(aws elbv2 describe-listeners --query "Listeners[*].ListenerArn" --output json --load-balancer-arn "${strArn}" | jq -r .[] | sed 's/\\//g' | tr "\n" " ")
    for strListArn in ${strListenerArn}; do
      strListArn=$(sed -e 's/ //g' <<<${strListArn})
      if [ -z "${strListArn}" ]; then
        echo "No listener found for load balancer [${strArn}]"
        continue
      else
        strTargetArn=$(aws elbv2 describe-rules --query "Rules[*].Actions[0].TargetGroupArn" --output text --listener-arn "${strListArn}")
        if [ -z "${strTargetArn}" ]; then
          echo "No target group found for listener [${strListArn}]"
          continue
        else
          strInstanceId=$(aws elbv2 describe-target-health --query "TargetHealthDescriptions[*].[Target.Id]" --output text --target-group-arn "${strTargetArn}" | sed 's/\n/ /g')
          if [ -z "${strInstanceId}" ]; then
            echo "No instance found for target group [${strTargetArn}]"
            continue
          else 
            for strId in ${strInstanceId}; do
              strId=$(sed -e 's/ //g' <<<${strId})
              strFoundAppName=$(aws ec2 describe-instances --instance-ids "${strId}" | jq --arg JQ_APPNAME "${strAppName}" '.Reservations[].Instances[].Tags[] | select( (.Key | contains("AppName")) and (.Value | contains($JQ_APPNAME)) )')
              strFoundEnv=$(aws ec2 describe-instances --instance-ids "${strId}" | jq --arg JQ_ENV "${strEnv}" '.Reservations[].Instances[].Tags[] | select( (.Key | contains("Environment")) and (.Value | contains($JQ_ENV)) )')
              if [ -z "${strFoundAppName}" ] || [ -z "${strFoundEnv}" ]; then
                echo "No match found for instance [${strId}]"
                continue
              else
                echo "done"
                echo "Found load-balancer with ${strAppName} in ${strEnv}."
                aws elbv2 describe-load-balancers --query "LoadBalancers[*].DNSName" --output text --load-balancer-arn "${strArn}"
                return
              fi
            done
          fi
        fi
      fi
    done
  done
  echo "No load-balancer found."
  return
}

ael-find-frontend() {
  strEnv=$(inp-value Environment)
  if [ -z "${strEnv}" ]; then
    echo "user cancel"
    return
  fi
  strAppName="nlb-vpcendpoint"
  for strArn in $( aws elbv2 describe-load-balancers | jq '.LoadBalancers[] | select(.DNSName | contains("NLBVP")) | .LoadBalancerArn' -r | sed 's/\\//g' ); do

    strFoundAppName=$(aws elbv2 describe-tags --resource-arns "${strArn}" | jq --arg JQ_APPNAME "${strAppName}" '.TagDescriptions[].Tags[] | select( (.Key | contains("Name")) and (.Value | contains($JQ_APPNAME)) )')
    strFoundEnv=$(aws elbv2 describe-tags --resource-arns ${strArn} | jq --arg JQ_ENV "${strEnv}" '.TagDescriptions[].Tags[] | select( (.Key | contains("Environment")) and (.Value | contains($JQ_ENV)) )')
    if [ -z "${strFoundAppName}" ] || [ -z "${strFoundEnv}" ]; then
      continue
    fi

    strListenerArn=$(aws elbv2 describe-listeners --query "Listeners[*].ListenerArn" --output json --load-balancer-arn "${strArn}" | jq -r .[] | sed 's/\\//g' | tr "\n" " ")
    for strListArn in ${strListenerArn}; do
      strListArn=$(sed -e 's/ //g' <<<${strListArn})
      if [ -z "${strListArn}" ]; then
        echo "No listener found for load balancer [${strArn}]"
        continue
      else
        strTargetArn=$(aws elbv2 describe-rules --query "Rules[*].Actions[0].TargetGroupArn" --output text --listener-arn "${strListArn}")
        if [ -z "${strTargetArn}" ]; then
          echo "No target group found for listener [${strListArn}]"
          continue
        else
          strInstanceId=$(aws elbv2 describe-target-health --query "TargetHealthDescriptions[*].[Target.Id]" --output text --target-group-arn "${strTargetArn}" | sed 's/\n/ /g')
          if [ -z "${strInstanceId}" ]; then
            echo "No IPs found for target group [${strTargetArn}]"
            continue
          else
            echo "Found IPs for target group."
            echo "${strInstanceId}"
          fi
        fi
      fi
    done

    strDns=$(aws elbv2 describe-load-balancers --query "LoadBalancers[*].DNSName" --output text --load-balancer-arn "${strArn}")
    echo "Found load-balancer with ${strAppName} in ${strEnv}."
    echo " (1) Navigate to Route53 > Hosted Zone: ${strEnv}.digitalfactory.gov.sg"
    echo " (2) Create record > Record Name = [LEAVE_EMPTY]"
    echo " (3) Select Record type = A > Routing policy = Simple routing"
    echo " (4) Select Alias = Yes > Value = ${strDns}"
    echo " (5) Click Create record"
    echo "done"
    return
  done
  echo "No load-balancer found."
  return
}

akm-find-by-alias() {
  local alias=$1
  local result=$2
  local _keyid
  _keyid=$( aws kms list-aliases | jq -r --arg JQ_NAME "${alias}" '.Aliases[] | select (.AliasName | contains($JQ_NAME)) | .TargetKeyId' )
  eval "$result=$_keyid"
}

akm-rotate-key() {
  local _stackname=$1
  local _keyname=$2
  local _result=$3
  local _stackid
  _stackid=$( aws cloudformation update-stack --stack-name "$_stackname" --use-previous-template --parameters "ParameterKey=KmsKeyName,ParameterValue=$_keyname ParameterKey=ProjectName,UsePreviousValue=true ParameterKey=ProjectName,UsePreviousValue=true ParameterKey=Environment,UsePreviousValue=true ParameterKey=KmsKeyType,UsePreviousValue=true" | jq -r .StackId )
  eval "$result=$_stackid"
}

al-if() {
  strEnv=$(inp-value environment)
  if [ -z ${strEnv} ]; then
    echo "user cancel"
    return
  fi
  strName="sso_relying_party_rotate_key-$strEnv"
  strFile="$lambda-invoke-${strName}.log"
  strPayload='{ "body": "eyJ0ZXN0IjoiYm9keSJ9", "resource": "/rp/rotate-key/signature", "path": "/$strEnv/sso-rp/keys", "httpMethod": "POST" }'

  echo ${strPayload} | jq
  echo "Invoke lambda $strName?"
  confirm=$(inp-confirm)
  if [ ! -z "$confirm" ]; then
    aws lambda invoke --function-name "$strName" --invocation-type "Event" --payload "$strPayload" "$strFile"
    cat "$strFile"
    echo "done"
  else
    echo "user cancel"
    return
  fi
}

asm-gsv() {
  aws secretsmanager list-secrets --query "SecretList[].ARN" --output json
  strArn=$(inp-value secret-arn)
  if [ -z ${strArn} ]; then
    echo "user cancel"
    return
  fi
  strName=$(inp-value secret-name)
  if [ -z ${strName} ]; then
    echo "user cancel"
    return
  fi
  secrets=$(aws secretsmanager get-secret-value --secret-id "${strArn}" --query "{Name: Name, SecretString: SecretString}" | jq -r .SecretString)
  strFile="${strName}-secrets.json"
  echo ${secrets} | jq > "$strFile"
  echo "$strFile"
  echo "done"
}

asm-psv() {
  aws secretsmanager list-secrets --query "SecretList[].ARN" --output json
  strArn=$(inp-value secret-arn)
  if [ -z ${strArn} ]; then
    echo "user cancel"
    return
  fi
  ls -la
  strFile=$(inp-value file)
  if [ -z ${strFile} ]; then
    echo "user cancel"
    return
  fi
  aws secretsmanager put-secret-value --secret-id "${strArn}" --secret-string "file://${strFile}"
}

as3-gbp() {
  strBucket=$(inp-value bucket)
  if [ -z ${strBucket} ]; then
    echo "user cancel"
    return
  fi
  policy=$(aws s3api get-bucket-policy --bucket ${strBucket})
  strFile="${strBucket}-bucket-policy.json"
  echo ${policy} | jq -r '.Policy' | sed 's/\\//g' | jq > "$strFile"
  echo "$strFile"
  echo "done"
}

asn-gta() {
  strArn=$(inp-value topic-arn)
  if [ -z ${strArn} ]; then
    echo "user cancel"
    return
  fi
  strName=$(inp-value topic-name)
  if [ -z ${strName} ]; then
    echo "user cancel"
    return
  fi
  policy=$(aws sns get-topic-attributes --topic-arn ${strArn})
  strFile="${strName}-topic-policy.json"
  echo ${policy} | jq -r '.Attributes.Policy' | sed 's/\\//g' | jq > "$strFile"
  echo "$strFile"
  echo "done"
}

as3-pbp() {
  strBucket=$(inp-value bucket)
  if [ -z ${strBucket} ]; then
    echo "user cancel"
    return
  fi
  strFile=$(inp-value file)
  if [ -z ${strFile} ]; then
    echo "user cancel"
    return
  fi
  aws s3api put-bucket-policy --bucket $strBucket --policy "file://${strFile}"
  echo "done"
}

asn-pta() {
  strArn=$(inp-value topic-arn)
  if [ -z ${strArn} ]; then
    echo "user cancel"
    return
  fi
  strFile=$(inp-value policy-file)
  if [ -z ${strFile} ]; then
    echo "user cancel"
    return
  fi
  aws sns set-topic-attributes --topic-arn $strArn --attribute-name Policy --attribute-value "file://${strFile}"
  echo "done"
}

a53-diagnose-backend() {
  aws route53 list-hosted-zones --query "HostedZones[*].[Id,Name]" --output text | grep dflocal
  strId=$(inp-value hosted-zone-id)
  if [ -z ${strId} ]; then
    echo "user cancel"
    return
  fi
  # Get Route53 
  aws route53 list-resource-record-sets --query "ResourceRecordSets[*].[Name,ResourceRecords[*].Value]" --hosted-zone-id ${strId}
  echo "The load balancer name cannot be longer than '32' characters"
  strName=$(inp-value lb-name)
  if [ -z ${strName} ]; then
    echo "user cancel"
    return
  fi
  strArn=$(aws elbv2 describe-load-balancers --query "LoadBalancers[*].LoadBalancerArn" --output text --names ${strName})
  if [ -z ${strArn} ]; then
    echo "The load balancer name cannot be longer than '32' characters [${strName}]"
    return
  fi
  echo Found LoadBalancer
  echo ${strArn}
  strListenerArn=$(aws elbv2 describe-listeners --query "Listeners[*].ListenerArn" --output text --load-balancer-arn ${strArn})
  if [ -z ${strListenerArn} ]; then
    echo "No listener found for load balancer [${strName}]"
    return
  fi
  echo Found Listener
  echo ${strListenerArn}
  strTargetArn=$(aws elbv2 describe-rules --query "Rules[*].Actions[0].TargetGroupArn" --output text --listener-arn ${strListenerArn})
  if [ -z ${strTargetArn} ]; then
    echo "No target group found for listener [${strListenerArn}]"
    return
  fi
  echo Found Target Group
  echo ${strTargetArn}
  strInstanceId=$(aws elbv2 describe-target-health --query "TargetHealthDescriptions[*].[Target.Id]" --output text --target-group-arn ${strTargetArn})
  if [ -z ${strInstanceId} ]; then
    echo "No instance found for target group [${strTargetArn}]"
    return
  fi
  echo Found Target Instances
  echo ${strInstanceId}
  echo "done"
  aws ec2 describe-instances --query "Reservations[*].Instances[*].[ImageId,InstanceId,PrivateDnsName,IamInstanceProfile,Tags[*].Value]" --instance-ids ${strInstanceId}
}

aws-dec() {
  if [ -z ${DSO_PASSWORD} ]; then
    echo "[ERROR]Environment variables not defined [DSO_PASSWORD]."
    return
  fi
  strDecode=$(inp-value)
  if [ -z ${strDecode} ]; then
    echo "user cancel"
    return
  fi

  echo ${strDecode} | openssl aes-256-cbc -d -a -pbkdf2 -pass pass:${DSO_PASSWORD}
}

aws-enc() {
  if [ -z ${DSO_PASSWORD} ]; then
    echo "[ERROR]Environment variables not defined [DSO_PASSWORD]."
    return
  fi
  strEncode=$(inp-value)
  if [ -z ${strEncode} ]; then
    echo "user cancel"
    return
  fi

  echo ${strEncode} | openssl aes-256-cbc -a -pbkdf2 -pass pass:${DSO_PASSWORD}
}

aws-session() {
  if [ -z ${DSO_PASSWORD} ]; then
    echo "[ERROR]Environment variables not defined [DSO_PASSWORD]."
    return
  fi
  echo -n "[AWS_ACCESS_KEY_ID] "
  strAccessKeyId=$(inp-value)
  if [ -z ${strAccessKeyId} ]; then
    echo "user cancel"
    return
  fi

  echo -n "[AWS_SECRET_ACCESS_KEY] "
  strSecretAccessKey=$(inp-value)
  if [ -z ${strSecretAccessKey} ]; then
    echo "user cancel"
    return
  fi

  echo -n "[AWS_SESSION_TOKEN] "
  strSessionToken=$(inp-value)
  if [ -z ${strSessionToken} ]; then
    echo "user cancel"
    return
  fi

  export AWS_ACCESS_KEY_ID=$( echo ${strAccessKeyId} | aws-dec )
  export AWS_SECRET_ACCESS_KEY=$( echo ${strSecretAccessKey} | aws-dec )
  export AWS_SESSION_TOKEN=${strSessionToken}
  echo "[Info] Before using AWS CLI, disconnect the GlobalProtect VPN."
  echo "done"
}
