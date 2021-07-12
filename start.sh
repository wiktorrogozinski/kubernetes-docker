#!/usr/bin/env bash
eval $(minikube docker-env)
checksum=$(sha1sum static/index.html | awk '{print $1}')
version=$(yq r manifest.yaml "spec.template.spec.containers[0].image" | cut -f2 -d":")
echo "Aktualna wersja deploymentu to: $version"


while :
do
    kubectl apply -f lb.yml
    echo "Nie wprowadzono zmian na stronie"
    sleep 5
    if [ $(sha1sum static/index.html | awk '{print $1}') != "${checksum}" ]
    then  
    version=$((version+=1))
    docker build -t apka:$version .
    checksum=$(sha1sum static/index.html | awk '{print $1}')
    sleep 3
    yq w -i manifest.yaml "spec.template.spec.containers[0].image" "apka:$version"
    kubectl apply -f manifest.yaml
    sleep 5
    minikube service apka
    fi      
done




