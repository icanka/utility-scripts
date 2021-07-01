#! /bin/bash



function print_if_success {
	if [[ $? -eq 0 ]];then
		printf "%25s\n" "SUCCESS"
		return 0
	else		
		return 1
	fi
}


echo "---------------------------------------------------"
echo "Stopping and Removing all containers..."
sleep 0.25
docker container stop $(docker ps -aq) 2>/dev/null && docker container rm $(docker ps -aq)
print_if_success

if [[ $? -ne 0 ]];then
	if [[ $(docker ps -aq) = "" ]];then
		echo "There is no container to stop"
		print_if_success
	fi
fi


echo "---------------------------------------------------"
echo "Removing unused  images..."
sleep 0.25
echo "y" | docker image prune -af 2>/dev/null
print_if_success


echo "---------------------------------------------------"
echo "Removing images..."
sleep 0.25
docker rmi $(docker images -aq) -f 2>/dev/null
print_if_success

if [[ $? -ne 0 ]];then
	if [[ $(docker images -aq) = "" ]];then
		echo "There is no image to delete"
		print_if_success
	fi
fi


echo "---------------------------------------------------"
echo "Removing all networks"
sleep 0.25
docker network rm $(docker network ls | awk '{print $1,$2}'  | grep -v 'bridge\|host\|none' | awk '{print $1}' | tail -n +2) 2>/dev/null
print_if_success

if [[ $? -ne 0 ]];then
	if [[ $(docker network ls | tail -n +2 | awk '{print $2}' | grep -v 'bridge\|host\|none') = "" ]];then
		echo "There is no network to remove"
		print_if_success
		
	fi
fi


echo "---------------------------------------------------"
echo "Removing build cache..."
sleep 0.25
printf "y\n" | docker builder prune >/dev/null
print_if_success
echo "---------------------------------------------------"
