#
# external aliases
# gc gr cm
# -- -- --
# |  |  |
# |  |  |---> command (at least 1 char)
# |  |------> group (2 chars)
# |---------> gcloud (gc) or gsutil (gs)
alias gcalfa='gcloud alpha functions add-iam-policy-binding gcp-data-drive --member=allUsers --role=roles/cloudfunctions.invoker'
alias gcapbr='gcloud app browse'
alias gcapde='gcloud app describe --format="value(defaultHostname)'
alias gcapdy='gcloud app deploy app.yaml --project $PROJECT_ID -q'
alias gcaul='gcloud auth list'
alias gcbus='gcloud builds submit --config cloudbuild_run.yaml --project $PROJECT_ID --no-source --substitutions=_GIT_SOURCE_BRANCH="master",_GIT_SOURCE_URL="https://github.com/GoogleCloudPlatform/DIY-Tools"'
alias gcceadc='gcloud compute addresses create network-lb-ip-1 --region us-central1'
alias gccefic='gcloud compute firewall-rules create www-firewall-network-lb --target-tags network-lb-tag --allow tcp:80'
alias gccefwc='gcloud compute forwarding-rules create www-rule --region us-central1 --ports 80 --address network-lb-ip-1 --target-pool www-pool'
alias gccefwd='gcloud compute forwarding-rules describe www-rule --region us-central1'
alias gccehhc='gcloud compute http-health-checks create basic-check'
alias gcceinc='gcloud compute instances create privatenet-us-vm --zone=us-central1-c --machine-type=n1-standard-1 --subnet=privatesubnet-us'
alias gcceinch='gcloud compute instances create --help'
alias gcceind='gcloud compute instances describe gcelab2 --zone $ZONE'
alias gcceinl='gcloud compute instances list'
alias gccenec='gcloud compute networks create managementnet --project=qwiklabs-gcp-01-87f1b4cc4729 --subnet-mode=custom --mtu=1460 --bgp-routing-mode=regional'
alias gccenel='gcloud compute networks list'
alias gccenesc='gcloud compute networks subnets create managementsubnet-us --project=qwiklabs-gcp-01-87f1b4cc4729 --range=10.130.0.0/20 --network=managementnet --region=us-central1'
alias gccenesl='gcloud compute networks subnets list --sort-by=NETWORK'
alias gccetpa='gcloud compute target-pools add-instances www-pool --instances-zone=us-central1-a --instances www1,www2,www3'
alias gccetpc='gcloud compute target-pools create www-pool --region us-central1 --http-health-check basic-check'
alias gccmi='gcloud components install app-engine-go'
alias gccml='gcloud components list'
alias gccncc='gcloud container clusters create'
alias gccncd='gcloud container clusters delete'
alias gccncgc='gcloud container clusters get-credentials'
alias gccol='gcloud config list'
alias gccola='gcloud config list --all'
alias gccolp='gcloud config list project'
alias gccogr='gcloud config get-value compute/region'
alias gccogz='gcloud config get-value compute/zone'
alias gccosr='gcloud config set compute/region'
alias gccosz='gcloud config set compute/zone $ZONE'
alias gcin='gcloud info --format="value(config.project)"'
#
# show default zone
alias gccpid='gcloud compute project-info describe --project qwiklabs-gcp-01-dc2a5e7a0576'
#
# firestore
alias gcfiim='gcloud firestore import gs://$PROJECT_ID-firestore/prd-back'
#
# serverless functions
alias gcfnca='gcloud functions call $FUNCTION'
alias gcfnde='gcloud functions describe $FUNCTION'
alias gcfndeg='gcloud functions describe gcp-data-drive --format="value(httpsTrigger.url)"'
alias gcfndl='gcloud functions delete $FUNCTION'
alias gcfndy='gcloud functions deploy $FUNCTION --stage-bucket $BUCKET_NAME --trigger-topic hello_world --runtime nodejs8'
alias gcfnlgr='gcloud functions logs read $FUNCTION'
#
# pubsub
alias gcpssc='gcloud pubsub subscriptions create --topic myTopic mySubscription'
alias gcpssd='gcloud pubsub subscriptions delete Test1'
alias gcpssp='gcloud pubsub subscriptions pull mySubscription --auto-ack --limit=3'
alias gcpstc='gcloud pubsub topics create Test1'
alias gcpstd='gcloud pubsub topics delete Test1'
alias gcpstl='gcloud pubsub topics list'
alias gcpstls='gcloud pubsub topics list-subscriptions myTopic'
alias gcpstp='gcloud pubsub topics publish MyTopic --message "Hello"'

alias gcrus='gcloud run services --platform managed describe gcp-data-drive --region us-central1 --format="value(status.url)"'
alias gcseen='gcloud services enable cloudfunctions.googleapis.com'
#
# sql
alias gcsqc='gcloud sql connect qwiklabs-demo --user=root'
#
# compute instances aka virtual machines aka droplets
alias gc-create-ci='gcloud compute instances create gcelab2 --machine-type n1-standard-2 --zone $ZONE'
alias gc-create-web='gcloud compute instances create www1 \
  --image-family debian-9 \
  --image-project debian-cloud \
  --zone us-central1-a \
  --tags network-lb-tag \
  --metadata startup-script="#! /bin/bash
    sudo apt-get update
    sudo apt-get install apache2 -y
    sudo service apache2 restart
    echo '<!doctype html><html><body><h1>www1</h1></body></html>' | tee /var/www/html/index.html'
alias gc-ssh='gcloud compute ssh gcelab2 --zone $ZONE'

#
# gsutil
alias gsacchd='gsutil acl ch -d AllUsers gs://$YOUR-BUCKET-NAME/$FILE'
alias gsacchu='gsutil acl ch -u AllUsers:R gs://$YOUR-BUCKET-NAME/$FILE'
alias gscp='gsutil cp gs://$YOUR-BUCKET-NAME/$FILE gs://$YOUR-BUCKET-NAME/$FOLDER/'
alias gscpdn='gsutil cp -r gs://$YOUR-BUCKET-NAME/$FILE .'
alias gscpup='gsutil cp $FILE gs://$YOUR-BUCKET-NAME'
alias gsls='gsutil ls gs://$YOUR-BUCKET-NAME'
alias gsmb='gsutil mb gs://$YOUR-BUCKET-NAME/'
alias gsrm='gsutil rm gs://$YOUR-BUCKET-NAME/$FILE'

#
# test load-balancer
alias curl-lb='while true; do curl -m1 $IP_ADDRESS; done'