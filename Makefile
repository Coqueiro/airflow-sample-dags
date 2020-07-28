VERSION=`cat VERSION`

install:
	@helm repo add stable https://kubernetes-charts.storage.googleapis.com
	@helm repo update
	@helm install airflow stable/airflow --namespace airflow --values ./default-values.yaml
	@kubectl create secret generic airflow-git-keys \
 		 --from-file=id_rsa=${HOME}/.ssh/id_rsa \
  	 	 --from-file=id_rsa.pub=${HOME}/.ssh/id_rsa.pub \
 		 --from-file=known_hosts=${HOME}/.ssh/known_hosts \
		  --namespace airflow

upgrade:
	@helm upgrade airflow stable/airflow --namespace airflow -f ./default-values.yaml