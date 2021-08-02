#!/usr/bin/env bash
eval $(minikube docker-env)
checksum=$(sha1sum static/index.html | awk '{print $1}')
version=$(yq r manifest.yaml "spec.template.spec.containers[0].image" | cut -f2 -d":")
echo "Aktualna wersja deploymentu to: $version"

while :
do
    
    if [ $(sha1sum static/index.html | awk '{print $1}') != "${checksum}" ]
    then  
    kubectl apply -f lb.yml 
    sleep 5
    version=$((version+=1))
    docker build -t apka:$version .
    checksum=$(sha1sum static/index.html | awk '{print $1}')
    yq w -i manifest.yaml "spec.template.spec.containers[0].image" "apka:$version"
    kubectl apply -f manifest.yaml
    sleep 5
    minikube service apka 
    else
    sleep 5
    echo "Nie wprowadzono zmian na stronie"
    fi
done

