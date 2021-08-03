Adventure with minikube and docker :) </br></br>
<b>Prerequisites:</br></br></b>
-Minikube installed </br> 
-Ngnix ingress addon installed </br>
-Yq installed </br>

<b>How to run: </br> </br></b>
1. Fork the repository.</br>
2. Navigate to .../Docker-kubernetes/Project</br>
3. Run the start.sh script.</br>
4. If you want to see how the script works, make a change in .../Docker-kubernetes/Project/static/index.html file and save it.</br></br>

The main purpose of this project is to watch for changes in index.html file. Start.sh script saves shasum of index.html file to a checksum variable. 
The script periodically compares current shasum of index.html with saved checksum variable. 
If any change is observed script applies load balncer file (lb.yml), then starts to build a new docker image and then changes variable of tag version by use yq command. 
After updated manifest.yaml file script applies manifest.yaml and opens app website.
